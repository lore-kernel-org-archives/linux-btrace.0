From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 27 Jan 2009 22:01:51 +0000
Subject: [RFC] blktrace 2.0
Message-Id: <497F844F.4010402@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010409010608010906040409"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------010409010608010906040409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I've been having some issues with blktrace on large(-ish) systems that
are primarily due to the N(devs) X N(cpus) nature of blktrace: we fire
off 1 thread for each device on each CPU. With (say) 32 cores and (say)
100 devices, we're seeing 3,200 threads competing for cores just to
handle the data transfer from the relay interface out to long-term storage.

Today I whipped up a prototype new implementation of blktrace (only
handles the "standard" read-from-relay and write-to-file mode, *not*
network or piped modes). This implementation fires off a single thread
per CPU only - each thread than manages all the relay files for its CPU
(opens them all, and uses poll() to determine which ones need
processing). This cuts down a lot on the scheduling issue, and hopefully
will cause less of an impact on the overall system.

I've down some testing on a small-ish machine - using valgrind to ensure
proper handling of all memory, as well as a 16-way w/ >100 disks and
things are working as expected. (At least blkrawverify, blkparse, btt,
... are all working fine for some test cases.)

I've attached the current sources - a lot of this is just ripped out of
blktrace.c in the tree currently, some of it is reformatted... Comments?

Thanks,
Alan


--------------010409010608010906040409
Content-Type: text/x-csrc;
 name="blktrace.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blktrace.c"

/*
 * block queue tracing application
 *
 * Copyright (C) 2005 Jens Axboe <axboe@suse.de>
 * Copyright (C) 2006 Jens Axboe <axboe@kernel.dk>
 *
 * Rewrite to have a single thread per CPU (managing all devices on that CPU)
 *	Alan D. Brunelle <alan.brunelle@hp.com> - January 2009
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

#include <assert.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <getopt.h>
#include <sched.h>
#include <unistd.h>
#include <poll.h>
#include <signal.h>
#include <pthread.h>
#include <locale.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/vfs.h>
#include <sys/mman.h>
#include <sys/param.h>
#include <sys/time.h>
#include <sys/resource.h>

#include "btt/list.h"
#include "blktrace.h"

/*
 * You may want to increase this even more, if you are logging at a high
 * rate and see skipped/missed events
 */
#define BUF_SIZE	(512 * 1024)
#define BUF_NR		(4)

#define DEBUGFS_TYPE	0x64626720

static char blktrace_version[] = "2.0.0";

static int ncpus;
static int pagesize;
static int act_mask = ~0U;
static char *debugfs_path = "/sys/kernel/debug";
static char *output_name;
static char *output_dir;
static int kill_running_trace;
static int stop_watch = 0;
static unsigned long buf_size = BUF_SIZE;
static unsigned long buf_nr = BUF_NR;
static LIST_HEAD(devpaths);
static LIST_HEAD(tracers);
static int ndevs;

struct devpath {
	struct list_head head;
	char *path;			/* path to device special file */
	char *buts_name;		/* name returned from bt kernel code */
	int fd, idx;
};

struct io_info {
	struct devpath *devpath;

	char ifn[MAXPATHLEN + 64];
	int ifd;

	char ofn[MAXPATHLEN + 64];
	int ofd;
	FILE *ofp;

	/*
	 * mmap controlled output files
	 */
	unsigned long long fs_size;
	unsigned long long fs_max_size;
	unsigned long fs_off;
	void *fs_buf;
	unsigned long fs_buf_len;
};

struct perdev_stats {
	unsigned long long data_read;
	unsigned long long events_processed;
	unsigned long long dropped_count;
};

struct tracer {
	struct list_head head;
	struct io_info *ios;
	struct pollfd *pfds;
	struct perdev_stats *perdev_stats;
	pthread_t thread;
	pthread_mutex_t mutex;
	pthread_cond_t cond;
	volatile int running, status, is_done;
	int cpu, nios;
};

#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
static struct option l_opts[] = {
	{
		.name = "dev",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'd'
	},
	{
		.name = "input-devs",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'I'
	},
	{
		.name = "act-mask",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'a'
	},
	{
		.name = "set-mask",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'A'
	},
	{
		.name = "relay",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'r'
	},
	{
		.name = "output",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'o'
	},
	{
		.name = "kill",
		.has_arg = no_argument,
		.flag = NULL,
		.val = 'k'
	},
	{
		.name = "stopwatch",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'w'
	},
	{
		.name = "version",
		.has_arg = no_argument,
		.flag = NULL,
		.val = 'v'
	},
	{
		.name = "version",
		.has_arg = no_argument,
		.flag = NULL,
		.val = 'V'
	},
	{
		.name = "buffer-size",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'b'
	},
	{
		.name = "num-sub-buffers",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'n'
	},
	{
		.name = "output-dir",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'D'
	},
	{
		.name = "listen",
		.has_arg = no_argument,
		.flag = NULL,
		.val = 'l'
	},
	{
		.name = "host",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'h'
	},
	{
		.name = "port",
		.has_arg = required_argument,
		.flag = NULL,
		.val = 'p'
	},
	{
		.name = "no-sendfile",
		.has_arg = no_argument,
		.flag = NULL,
		.val = 's'
	},
	{
		.name = NULL,
	}
};

static char usage_str[] = \
	"-d <dev> [ -r debugfs path ] [ -o <output> ] [-k ] [ -w time ]\n" \
	"[ -a action ] [ -A action mask ] [ -I  <devs file> ] [ -v ]\n\n" \
	"\t-d Use specified device. May also be given last after options\n" \
	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
	"\t-o File(s) to send output to\n" \
	"\t-D Directory to prepend to output file names\n" \
	"\t-k Kill a running trace\n" \
	"\t-w Stop after defined time, in seconds\n" \
	"\t-a Only trace specified actions. See documentation\n" \
	"\t-A Give trace mask as a single value. See documentation\n" \
	"\t-b Sub buffer size in KiB\n" \
	"\t-n Number of sub buffers\n" \
	"\t-l Run in network listen mode (blktrace server)\n" \
	"\t-h Run in network client mode, connecting to the given host\n" \
	"\t-p Network port to use (default 8462)\n" \
	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
	"\t-I Add devices found in <devs file>\n" \
	"\t-V Print program version info\n\n";

/*
 * For large(-ish) systems, we run into real issues in our
 * N(devs) X N(cpus) algorithms if we are being limited by arbitrary
 * resource constraints.
 *
 * We try to set our limits to infinity, if that fails, we guestimate a max
 * needed and try that.
 */
static int increase_limit(int r, rlim_t val)
{
	struct rlimit rlim;

	rlim.rlim_cur = rlim.rlim_max = RLIM_INFINITY;
	if (setrlimit(r, &rlim) < 0) {
		rlim.rlim_cur = rlim.rlim_max = val;
		if (setrlimit(r, &rlim) < 0) {
			perror(r == RLIMIT_NOFILE ? "NOFILE" : "MEMLOCK");
			return 1;
		}
	}

	return 0;
}

/*
 *
 * For the number of files: we need N(devs) X N(cpus) for:
 *	o  ioctl's
 *	o  read from /sys/kernel/debug/...
 *	o  write to blktrace output file
 *	o  Add some misc. extras - we'll muliply by 4 instead of 3
 *
 * For the memory locked, we know we need at least
 *		N(devs) X N(cpus) X N(buffers) X buffer-size
 * 	we double that for misc. extras
 */
static int increase_limits(void)
{
	rlim_t nofile_lim = 4 * ndevs * ncpus;
	rlim_t memlock_lim = 2 * ndevs * ncpus * buf_nr * buf_size;

	return increase_limit(RLIMIT_NOFILE, nofile_lim) != 0 ||
	       increase_limit(RLIMIT_MEMLOCK, memlock_lim) != 0;
}

static int __stop_trace(int fd)
{
	assert(0 <= fd);

	/*
	 * Should be stopped, don't complain if it isn't
	 */
	ioctl(fd, BLKTRACESTOP);
	return ioctl(fd, BLKTRACETEARDOWN);
}

static int add_devpath(char *path)
{
	int fd;
	struct devpath *dpp;
	struct blk_user_trace_setup buts;

	assert(path != NULL);

	/*
	 * Verify device is valid before going too far
	 */
	fd = open(path, O_RDONLY | O_NONBLOCK);
	if (fd < 0) {
		fprintf(stderr, "Invalid path %s specified: %d/%s\n",
			path, errno, strerror(errno));
		return 1;
	}

	memset(&buts, 0, sizeof(buts));
	buts.buf_size = BUF_SIZE;
	buts.buf_nr = BUF_NR;
	if (ioctl(fd, BLKTRACESETUP, &buts) < 0) {
		fprintf(stderr, "BLKTRACESETUP failed on %s: %d/%s\n",
			path, errno, strerror(errno));
		close(fd);
		return 1;
	}
	ioctl(fd, BLKTRACETEARDOWN);

	dpp = malloc(sizeof(*dpp));
	assert(dpp);

	list_add_tail(&dpp->head, &devpaths);
	dpp->path = strdup(path);
	dpp->buts_name = strdup(buts.name);
	dpp->fd = fd;
	dpp->idx = ndevs++;

	return 0;
}

static void setup_buts(void)
{
	struct list_head *p;

	__list_for_each(p, &devpaths) {
		struct blk_user_trace_setup buts;
		struct devpath *dpp = list_entry(p, struct devpath, head);

		memset(&buts, 0, sizeof(buts));
		buts.buf_size = buf_size;
		buts.buf_nr = buf_nr;
		buts.act_mask = act_mask;

		assert(dpp->fd >= 0);
		if (ioctl(dpp->fd, BLKTRACESETUP, &buts) < 0) {
			fprintf(stderr, "BLKTRACESETUP(2) %s failed: %d/%s\n",
				dpp->path, errno, strerror(errno));
		}
		else if (ioctl(dpp->fd, BLKTRACESTART) < 0) {
			fprintf(stderr, "BLKTRACESTART %s failed: %d/%s\n",
				dpp->path, errno, strerror(errno));
		}
	}
}

static void rel_devpaths(void)
{
	struct list_head *p, *q;

	list_for_each_safe(p, q, &devpaths) {
		struct devpath *dpp = list_entry(p, struct devpath, head);

		assert(dpp->fd >= 0);

		(void)ioctl(dpp->fd, BLKTRACESTOP);
		(void)ioctl(dpp->fd, BLKTRACETEARDOWN);
		close(dpp->fd);

		list_del(&dpp->head);
		free(dpp->path);
		free(dpp->buts_name);
		free(dpp);
		ndevs--;
	}
}

static void kill_running_traces(void)
{
	struct list_head *p;

	__list_for_each(p, &devpaths) {
		struct devpath *dpp = list_entry(p, struct devpath, head);

		assert(dpp->fd >= 0);
		if (__stop_trace(dpp->fd))
			fprintf(stderr,
				"BLKTRACETEARDOWN %s failed: %d/%s\n",
				dpp->path, errno, strerror(errno));
	}

	rel_devpaths();
}

static void show_usage(char *program)
{
	fprintf(stderr, "Usage: %s %s %s",program, blktrace_version, usage_str);
}

static int handle_args(int argc, char *argv[])
{
	int c, i;
	struct statfs st;
	int act_mask_tmp = 0;

	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) >= 0) {
		switch (c) {
		case 'a':
			i = find_mask_map(optarg);
			if (i < 0) {
				fprintf(stderr,"Invalid action mask %s\n",
					optarg);
				return 1;
			}
			act_mask_tmp |= i;
			break;

		case 'A':
			if ((sscanf(optarg, "%x", &i) != 1) ||
							!valid_act_opt(i)) {
				fprintf(stderr,
					"Invalid set action mask %s/0x%x\n",
					optarg, i);
				return 1;
			}
			act_mask_tmp = i;
			break;

		case 'd':
			if (add_devpath(optarg) != 0)
				return 1;
			break;

		case 'I': {
			char dev_line[256];
			FILE *ifp = fopen(optarg, "r");

			if (!ifp) {
				fprintf(stderr,
				        "Invalid file for devices %s\n",
					optarg);
				return 1;
			}

			while (fscanf(ifp, "%s\n", dev_line) == 1)
				if (add_devpath(dev_line) != 0)
					return 1;
			break;
		}

		case 'r':
			debugfs_path = optarg;
			break;

		case 'o':
			output_name = optarg;
			break;
		case 'k':
			kill_running_trace = 1;
			break;
		case 'w':
			stop_watch = atoi(optarg);
			if (stop_watch <= 0) {
				fprintf(stderr,
					"Invalid stopwatch value (%d secs)\n",
					stop_watch);
				return 1;
			}
			break;
		case 'V':
		case 'v':
			printf("%s version %s\n", argv[0], blktrace_version);
			exit(0);
			/*NOTREACHED*/
		case 'b':
			buf_size = strtoul(optarg, NULL, 10);
			if (buf_size <= 0 || buf_size > 16*1024) {
				fprintf(stderr,
					"Invalid buffer size (%lu)\n",buf_size);
				return 1;
			}
			buf_size <<= 10;
			break;
		case 'n':
			buf_nr = strtoul(optarg, NULL, 10);
			if (buf_nr <= 0) {
				fprintf(stderr,
					"Invalid buffer nr (%lu)\n", buf_nr);
				return 1;
			}
			break;
		case 'D':
			output_dir = optarg;
			break;
		case 'h':
		case 'l':
		case 'p':
		case 's':
			fprintf(stderr, "Network mode not supported\n");
			exit(1);
			/*NOTREACHED*/
		default:
			show_usage(argv[0]);
			exit(1);
			/*NOTREACHED*/
		}
	}

	while (optind < argc)
		if (add_devpath(argv[optind++]) != 0)
			return 1;

	if (ndevs == 0) {
		show_usage(argv[0]);
		return 1;
	}

	if (statfs(debugfs_path, &st) < 0 || st.f_type != (long)DEBUGFS_TYPE) {
		fprintf(stderr, "Invalid debug path %s: %d/%s\n",
			debugfs_path, errno, strerror(errno));
		return 1;
	}

	if (act_mask_tmp != 0)
		act_mask = act_mask_tmp;

	return 0;
}

static int cpu_lock(int cpu)
{
	cpu_set_t cpu_mask;

	assert(0 <= cpu && cpu < sysconf(_SC_NPROCESSORS_ONLN));

	CPU_ZERO(&cpu_mask);
	CPU_SET(cpu, &cpu_mask);
	if (sched_setaffinity(getpid(), sizeof(cpu_mask), &cpu_mask) < 0)
		return errno;

	return 0;
}

static int fill_ofname(struct tracer *tp, struct io_info *iop)
{
	int len;
	struct stat sb;

	if (output_dir)
		len = snprintf(iop->ofn, sizeof(iop->ofn), "%s/", output_dir);
	else
		len = snprintf(iop->ofn, sizeof(iop->ofn), "./");
	assert(0 < len && len < (int)sizeof(iop->ofn));

	if (stat(iop->ofn, &sb) < 0) {
		if (errno != ENOENT) {
			fprintf(stderr,
				"Destination dir %s stat failed: %d/%s\n",
				iop->ofn, errno, strerror(errno));
			return 1;
		}
		if (mkdir(iop->ofn, 0755) < 0) {
			fprintf(stderr,
				"Destination dir %s can't be made: %d/%s\n",
				iop->ofn, errno, strerror(errno));
			return 1;
		}
	}

	if (output_name)
		len += snprintf(iop->ofn + len, sizeof(iop->ofn),
				"%s.blktrace.%d", output_name, tp->cpu);
	else
		len += snprintf(iop->ofn + len, sizeof(iop->ofn),
				"%s.blktrace.%d", iop->devpath->buts_name,
				tp->cpu);
	assert(0 < len && len < (int)sizeof(iop->ofn));

	return 0;
}

static int open_ios(struct tracer *tp)
{
	int i;
	struct io_info *iop;
	struct list_head *p;

	i = 0;
	tp->ios = calloc(ndevs, sizeof(struct io_info));
	tp->pfds = calloc(ndevs, sizeof(struct pollfd));
	assert(tp->ios && tp->pfds);

	memset(tp->ios, 0, ndevs * sizeof(struct io_info));
	memset(tp->pfds, 0, ndevs * sizeof(struct pollfd));

	tp->nios = 0;
	iop = tp->ios;
	__list_for_each(p, &devpaths) {
		struct devpath *dpp = list_entry(p, struct devpath, head);

		iop->devpath = dpp;
		snprintf(iop->ifn, sizeof(iop->ifn), "%s/block/%s/trace%d",
			debugfs_path, dpp->buts_name, tp->cpu);

		iop->ifd = open(iop->ifn, O_RDONLY);
		if (iop->ifd < 0) {
			fprintf(stderr, "Thread %d failed open %s: %d/%s\n",
				tp->cpu, iop->ifn, errno, strerror(errno));
			return 1;
		}

		if (fill_ofname(tp, iop)) {
			close(iop->ifd);	/* tp->nios _not_ bumped */
			return 1;
		}

		iop->ofp = fopen(iop->ofn, "w+");
		if (iop->ofp == NULL) {
			fprintf(stderr, "Open output file %s failed: %d/%s\n",
				iop->ofn, errno, strerror(errno));
			close(iop->ifd);	/* tp->nios _not_ bumped */
			return 1;
		}
		iop->ofd = fileno(iop->ofp);

		iop++;
		tp->nios++;
	}

	return 0;
}

static void close_ios(struct tracer *tp)
{
	while (tp->nios > 0) {
		struct io_info *iop = &tp->ios[--tp->nios];

		if (iop->ifd >= 0)
			close(iop->ifd);

		if (iop->ofp) {
			if (iop->fs_buf)
				munmap(iop->fs_buf, iop->fs_buf_len);

			if (ftruncate(fileno(iop->ofp), iop->fs_size) < 0)
				fprintf(stderr,
					"Ignoring err: ftruncate(%s): %d/%s\n",
					iop->ofn, errno, strerror(errno));

			fclose(iop->ofp);
		}
	}

	free(tp->ios);
	free(tp->pfds);
}

static int setup_mmap(struct tracer *tp, struct io_info *iop)
{
	if (iop->fs_off + buf_size > iop->fs_buf_len) {
		if (iop->fs_buf) {
			munlock(iop->fs_buf, iop->fs_buf_len);
			munmap(iop->fs_buf, iop->fs_buf_len);
			iop->fs_buf = NULL;
		}

		iop->fs_off = iop->fs_size & (pagesize - 1);
		iop->fs_buf_len = (max(16, buf_nr) * buf_size) - iop->fs_off;
		iop->fs_max_size += iop->fs_buf_len;

		if (ftruncate(iop->ofd, iop->fs_max_size) < 0) {
			fprintf(stderr, "Thread %d trunc %s failed: %d/%s\n",
				tp->cpu, iop->ofn, errno, strerror(errno));
			return 1;
		}

		iop->fs_buf = mmap(NULL, iop->fs_buf_len, PROT_WRITE,
					MAP_SHARED, iop->ofd,
					iop->fs_size - iop->fs_off);
		if (iop->fs_buf == MAP_FAILED) {
			fprintf(stderr, "Thread %d mmap %s failed: %d/%s\n",
				tp->cpu, iop->ofn, errno, strerror(errno));
			return 1;
		}
		mlock(iop->fs_buf, iop->fs_buf_len);
	}

	return 0;
}

static int handle_pfds(struct tracer *tp, int force_read)
{
	int i, ret, ndone = 0;
	struct pollfd *pfd = tp->pfds;
	struct io_info *iop = tp->ios;

	for (i = 0; i < ndevs; i++, pfd++, iop++) {
		if (pfd->revents & POLLIN || force_read) {
			ret = setup_mmap(tp, iop);
			if (ret < 0) {
				pfd->events = 0;/* Stop using this beast */
				continue;
			}

			ret = read(iop->ifd, iop->fs_buf+iop->fs_off, buf_size);
			if (ret == 0)
				continue;
			else if ((ret < 0) && (errno != EAGAIN)) {
				fprintf(stderr,
					"Thread %d failed read of %s: %d/%s\n",
					tp->cpu, iop->ifn, errno,
					strerror(errno));
				pfd->events = 0;/* Stop using this beast */
				continue;
			}

			tp->perdev_stats[i].data_read += ret;

			iop->fs_size += ret;
			iop->fs_off += ret;
			ndone++;
		}
	}

	return ndone;
}

static void get_dropped_counts(struct tracer *tp)
{
	struct list_head *p;

	__list_for_each(p, &devpaths) {
		int fd;
		char fn[MAXPATHLEN + 64], tmp[256];
		struct devpath *dpp = list_entry(p, struct devpath, head);

		snprintf(fn, sizeof(fn), "%s/block/%s/dropped",
			debugfs_path, dpp->buts_name);
		fd = open(fn, O_RDONLY);
		if (fd < 0) {
			/*
			 * This may be ok: the kernel may not support
			 * dropped counts.
			 */
			if (errno != ENOENT)
				fprintf(stderr,
					"Thread %d could not open %s: %d/%s\n",
					tp->cpu, fn, errno, strerror(errno));
			continue;
		}
		else if (read(fd, tmp, sizeof(tmp)) < 0) {
			fprintf(stderr, "Thread %d could not read %s: %d/%s\n",
				tp->cpu, fn, errno, strerror(errno));
		}
		else
			tp->perdev_stats[dpp->idx].dropped_count = atoi(tmp);
		close(fd);
	}
}

static void setup_pfds(struct tracer *tp)
{
	int i;
	struct pollfd *pfd;
	struct io_info *iop;

	for (i = 0, pfd = tp->pfds, iop = tp->ios; i < ndevs; i++,pfd++,iop++) {
		pfd->fd = iop->ifd;
		pfd->events = POLLIN;
		pfd->revents = 0;
	}
}

static void *thread_main(void *arg)
{
	int ret, ndone;
	struct tracer *tp = arg;

	ret = cpu_lock(tp->cpu);
	if (ret)
		goto out;

	ret = open_ios(tp);
	if (ret)
		goto out;

	tp->perdev_stats = calloc(ndevs, sizeof(struct perdev_stats));
	memset(tp->perdev_stats, 0, ndevs * sizeof(struct perdev_stats));

	pthread_mutex_lock(&tp->mutex);
	tp->running = 1;
	pthread_cond_signal(&tp->cond);
	pthread_mutex_unlock(&tp->mutex);

	while (!tp->is_done) {
		setup_pfds(tp);
		ndone = poll(tp->pfds, ndevs, 1000);
		if (ndone < 0 && errno != EINTR)
			fprintf(stderr, "Thread %d poll failed: %d/%s\n",
				tp->cpu, errno, strerror(errno));
		else if (ndone > 0)
			(void)handle_pfds(tp, 0);
	}

	/*
	 * Trace is stopped, pull data until we get a short read
	 */
	while (handle_pfds(tp, 1) > 0)
		;

	get_dropped_counts(tp);
	ret = 0;

out:
	close_ios(tp);

	pthread_mutex_lock(&tp->mutex);
	tp->running = 0;
	tp->status = ret;
	pthread_cond_signal(&tp->cond);
	pthread_mutex_unlock(&tp->mutex);
	return NULL;
}

static int start_tracer(int cpu)
{
	struct tracer *tp;

	tp = malloc(sizeof(*tp));
	memset(tp, 0, sizeof(*tp));

	INIT_LIST_HEAD(&tp->head);
	pthread_mutex_init(&tp->mutex, NULL);
	pthread_cond_init(&tp->cond, NULL);
	tp->running = tp->status = 0;
	tp->cpu = cpu;

	if (pthread_create(&tp->thread, NULL, thread_main, tp)) {
		fprintf(stderr, "FAILED to start thread on CPU %d: %d/%s\n",
			cpu, errno, strerror(errno));
		pthread_mutex_unlock(&tp->mutex);
		goto err;
	}

	pthread_mutex_lock(&tp->mutex);
	while (!tp->running && (tp->status == 0))
		pthread_cond_wait(&tp->cond, &tp->mutex);
	pthread_mutex_unlock(&tp->mutex);

	if (tp->status == 0) {
		list_add_tail(&tp->head, &tracers);
		return 0;
	}

	fprintf(stderr, "FAILED to start thread on CPU %d: %d/%s\n",
		tp->cpu, tp->status, strerror(tp->status));

err:
	pthread_mutex_destroy(&tp->mutex);
	pthread_cond_destroy(&tp->cond);
	if (tp->perdev_stats)
		free(tp->perdev_stats);
	free(tp);
	return 1;
}

static int start_tracers(void)
{
	int i;

	for (i = 0; i < ncpus; i++)
		if (start_tracer(i))
			break;

	return i;
}

static void stop_tracers(void)
{
	struct list_head *p;

	__list_for_each(p, &tracers) {
		struct tracer *tp = list_entry(p, struct tracer, head);
		tp->is_done = 1;
	}
}

static void handle_sigint(__attribute__((__unused__)) int sig)
{
	stop_tracers();
}

static void wait_tracers(void)
{
	struct list_head *p;

	__list_for_each(p, &tracers) {
		int ret;
		struct tracer *tp = list_entry(p, struct tracer, head);

		pthread_mutex_lock(&tp->mutex);
		while (tp->running)
			pthread_cond_wait(&tp->cond, &tp->mutex);
		pthread_mutex_unlock(&tp->mutex);

		ret = pthread_join(tp->thread, NULL);
		if (ret)
			fprintf(stderr, "Thread join %d failed %d\n",
				tp->cpu, ret);
	}
}

static void del_tracers(void)
{
	struct list_head *p, *q;

	list_for_each_safe(p, q, &tracers) {
		struct tracer *tp = list_entry(p, struct tracer, head);

		list_del(&tp->head);
		if (tp->perdev_stats)
			free(tp->perdev_stats);
		free(tp);
	}
}

static void exit_tracing(void)
{
	signal(SIGINT, SIG_IGN);
	signal(SIGHUP, SIG_IGN);
	signal(SIGTERM, SIG_IGN);
	signal(SIGALRM, SIG_IGN);

	stop_tracers();
	wait_tracers();
	del_tracers();
	rel_devpaths();
}

static void show_stats(void)
{
	FILE *ofp;
	struct list_head *p;
	unsigned long long events_processed, data_read, dev_drops;
	unsigned long long total_drops = 0;
	static volatile int stats_shown = 0;

	if (stats_shown++)
		return;

	if (output_name && !strcmp(output_name, "-"))
		ofp = fopen("/dev/null", "w");
	else
		ofp = stdout;

	__list_for_each(p, &devpaths) {
		struct list_head *q;
		struct devpath *dpp = list_entry(p, struct devpath, head);

		data_read = 0;
		events_processed = 0;
		dev_drops = 0;
		__list_for_each(q, &tracers) {
			struct tracer *tp = list_entry(q, struct tracer, head);
			struct perdev_stats *sp = &tp->perdev_stats[dpp->idx];

			fprintf(ofp,
				"  CPU%3d: %20llu events, %8llu KiB data\n",
				tp->cpu, sp->events_processed,
				(sp->data_read + 1023) >> 10);

			data_read += sp->data_read;
			events_processed += sp->events_processed;
			dev_drops += sp->dropped_count;
		}
		fprintf(ofp, "  Total:  %20llu events (dropped %llu),"
			     " %8llu KiB data\n", events_processed,
			     dev_drops, (data_read + 1024) >> 10);

		total_drops += dev_drops;
	}

	if (total_drops)
		fprintf(stderr, "You have %llu dropped events,"
			"consider using a larger buffer size (-b)\n",
			total_drops);
}

int main(int argc, char *argv[])
{
	int ntracers, ret = 0;

	setlocale(LC_NUMERIC, "en_US");
	pagesize = getpagesize();
	if (handle_args(argc, argv)) {
		ret = 1;
		goto out;
	}

	if (increase_limits()) {
		ret = 1;
		goto out;
	}

	if (kill_running_trace) {
		kill_running_traces();
		goto out;
	}

	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
	if (ncpus < 0) {
		fprintf(stderr, "sysconf(_SC_NPROCESSORS_ONLN) failed %d/%s\n",
			errno, strerror(errno));
		ret = 1;
		goto out;
	}

	signal(SIGINT, handle_sigint);
	signal(SIGHUP, handle_sigint);
	signal(SIGTERM, handle_sigint);
	signal(SIGALRM, handle_sigint);
	signal(SIGPIPE, SIG_IGN);

	atexit(exit_tracing);

	setup_buts();
	ntracers = start_tracers();
	if (ntracers != ncpus)
		stop_tracers();
	else if (stop_watch)
		alarm(stop_watch);
	wait_tracers();
	show_stats();
	del_tracers();

out:
	rel_devpaths();
	return ret;
}

--------------010409010608010906040409--
