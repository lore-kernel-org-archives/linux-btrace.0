From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 05 Feb 2009 19:34:56 +0000
Subject: blktrace2: patch to fix resource limits issue
Message-Id: <498B3F60.1020400@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030001060006020701040801"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------030001060006020701040801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jens: I'll need to format something like this up for blktrace as well...


--------------030001060006020701040801
Content-Type: text/x-diff;
 name="0001-Some-clean-up-and-better-fix-for-resource-limit-is.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Some-clean-up-and-better-fix-for-resource-limit-is.patc";
 filename*1="h"

From d9081e016acdf93ce03eca0910aad4950f595c95 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Thu, 5 Feb 2009 14:31:54 -0500
Subject: [PATCH] Some clean up - and better fix for resource limit issues

For network stuff we don't *know* how many CPUs and devices early on
(not until the client connects) so the early increase of the resource
limits wasn't sufficent. This pushes all the pertinent system calls (I
could think of) into wrappers that increase the limits as we hit them.
Seems to be working ok...

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blktrace2.c |  228 +++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 136 insertions(+), 92 deletions(-)

diff --git a/blktrace2.c b/blktrace2.c
index 558aff8..96e89a7 100644
--- a/blktrace2.c
+++ b/blktrace2.c
@@ -60,6 +60,8 @@
 #define BUF_SIZE		(512 * 1024)
 #define BUF_NR			(4)
 
+#define FILE_VBUF_SIZE		(128 * 1024)
+
 #define DEBUGFS_TYPE		(0x64626720)
 #define TRACE_NET_PORT		(8462)
 
@@ -72,6 +74,8 @@ enum {
 /*
  * Generic stats collected: nevents can be _roughly_ estimated by data_read
  * (discounting pdu...)
+ *
+ * These fields are updated w/ pdc_dr_update & pdc_nev_update below.
  */
 struct pdc_stats {
 	unsigned long long data_read;
@@ -305,7 +309,7 @@ static int net_use_sendfile = 1;
 static int net_mode;
 static int *cl_fds;
 
-static int (*handle_pfds)(struct tracer *, int);
+static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
 #define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
@@ -459,14 +463,12 @@ static inline int in_addr_eq(struct in_addr a, struct in_addr b)
 
 static inline void pdc_dr_update(struct devpath *dpp, int cpu, int data_read)
 {
-	if (dpp->stats && cpu < dpp->ncpus)
-		dpp->stats[cpu].data_read += data_read;
+	dpp->stats[cpu].data_read += data_read;
 }
 
 static inline void pdc_nev_update(struct devpath *dpp, int cpu, int nevents)
 {
-	if (dpp->stats && cpu < dpp->ncpus)
-		dpp->stats[cpu].nevents += nevents;
+	dpp->stats[cpu].nevents += nevents;
 }
 
 static void show_usage(char *prog)
@@ -526,59 +528,94 @@ static inline void make_timespec(struct timespec *tsp, long delta_msec)
 	}
 }
 
-/*
- * For large(-ish) systems, we run into real issues in our
- * N(devs) X N(cpus) algorithms if we are being limited by arbitrary
- * resource constraints.
- *
- * We try to set our limits to infinity, if that fails, we guestimate a max
- * needed and try that.
- */
-static int increase_limit(int r, rlim_t val)
+static int increase_limit(int resource, rlim_t increase)
 {
 	struct rlimit rlim;
+	int save_errno = errno;
 
-	/*
-	 * Try to set to infinity...
-	 */
-	rlim.rlim_cur = RLIM_INFINITY;
-	rlim.rlim_max = RLIM_INFINITY;
-	if (setrlimit(r, &rlim) == 0)
-		return 0;
+	if (!getrlimit(resource, &rlim)) {
+		rlim.rlim_cur += increase;
+		if (rlim.rlim_cur >= rlim.rlim_max)
+			rlim.rlim_max = rlim.rlim_cur + increase;
 
-	/*
-	 * Try to bump it to at least the value passed in
-	 */
-	rlim.rlim_cur = val;
-	rlim.rlim_max = val;
-	if (setrlimit(r, &rlim) == 0)
-		return 0;
+		if (!setrlimit(resource, &rlim))
+			return 1;
+	}
 
-	/*
-	 * Nothing worked, may exceed limits...
-	 */
-	return 1;
+	errno = save_errno;
+	return 0;
 }
 
-/*
- *
- * For the number of files: we need N(devs) X N(cpus) for:
- *	o  ioctl's
- *	o  read from /sys/kernel/debug/...
- *	o  write to blktrace output file
- *	o  Add some misc. extras - we'll muliply by 4 instead of 3
- *
- * For the memory locked, we know we need at least
- *		N(devs) X N(cpus) X N(buffers) X buffer-size
- * 	we double that for misc. extras
- */
-static int increase_limits(void)
+static int handle_open_failure(void)
 {
-	rlim_t nofile_lim = 4 * ndevs * ncpus;
-	rlim_t memlock_lim = 2 * ndevs * ncpus * buf_nr * buf_size;
+	if (errno == ENFILE || errno == EMFILE)
+		return increase_limit(RLIMIT_NOFILE, 16);
+	return 0;
+}
 
-	return increase_limit(RLIMIT_NOFILE, nofile_lim) != 0 ||
-	       increase_limit(RLIMIT_MEMLOCK, memlock_lim) != 0;
+static int handle_mem_failure(size_t length)
+{
+	if (errno == ENFILE)
+		return handle_open_failure();
+	else if (errno == ENOMEM)
+		return increase_limit(RLIMIT_MEMLOCK, 2 * length);
+	return 0;
+}
+
+static FILE *my_fopen(const char *path, const char *mode)
+{
+	FILE *fp;
+
+	do {
+		fp = fopen(path, mode);
+	} while (fp == NULL && handle_open_failure());
+
+	return fp;
+}
+
+static int my_open(const char *path, int flags)
+{
+	int fd;
+
+	do {
+		fd = open(path, flags);
+	} while (fd < 0 && handle_open_failure());
+
+	return fd;
+}
+
+static int my_socket(int domain, int type, int protocol)
+{
+	int fd;
+
+	do {
+		fd = socket(domain, type, protocol);
+	} while (fd < 0 && handle_open_failure());
+
+	return fd;
+}
+
+static void *my_mmap(void *addr, size_t length, int prot, int flags, int fd,
+		     off_t offset)
+{
+	void *new;
+
+	do {
+		new = mmap(addr, length, prot, flags, fd, offset);
+	} while (new == MAP_FAILED && handle_mem_failure(length));
+
+	return new;
+}
+
+static int my_mlock(const void *addr, size_t len)
+{
+	int ret;
+
+	do {
+		ret = mlock(addr, len);
+	} while (ret < 0 && handle_mem_failure(len));
+
+	return ret;
 }
 
 static int __stop_trace(int fd)
@@ -627,7 +664,7 @@ rewrite:
 			/*
 			 * Writes are failing: switch to /dev/null...
 			 */
-			pfp = fopen("/dev/null", "w");
+			pfp = my_fopen("/dev/null", "w");
 		}
 		goto rewrite;
 	}
@@ -739,7 +776,7 @@ static int net_setup_client(void)
 		strcpy(hostname, hent->h_name);
 	}
 
-	fd = socket(AF_INET, SOCK_STREAM, 0);
+	fd = my_socket(AF_INET, SOCK_STREAM, 0);
 	if (fd < 0) {
 		perror("client: socket");
 		return -1;
@@ -842,7 +879,7 @@ static int get_drops(struct devpath *dpp)
 	snprintf(fn, sizeof(fn), "%s/block/%s/dropped", debugfs_path,
 		 dpp->buts_name);
 
-	fd = open(fn, O_RDONLY);
+	fd = my_open(fn, O_RDONLY);
 	if (fd < 0) {
 		/*
 		 * This may be ok: the kernel may not support
@@ -966,7 +1003,7 @@ static int add_devpath(char *path)
 	/*
 	 * Verify device is valid before going too far
 	 */
-	fd = open(path, O_RDONLY | O_NONBLOCK);
+	fd = my_open(path, O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
 		fprintf(stderr, "Invalid path %s specified: %d/%s\n",
 			path, errno, strerror(errno));
@@ -1209,7 +1246,7 @@ static inline int net_send_data(struct tracer *tp, struct io_info *iop)
 	return net_sendfile(iop);
 }
 
-static int handle_pfds_netclient(struct tracer *tp, int force_read)
+static int handle_pfds_netclient(struct tracer *tp, int nevs, int force_read)
 {
 	struct stat sb;
 	int i, nentries = 0;
@@ -1217,24 +1254,24 @@ static int handle_pfds_netclient(struct tracer *tp, int force_read)
 	struct pollfd *pfd = tp->pfds;
 	struct io_info *iop = tp->ios;
 
-	for (i = 0; i < ndevs; i++, pfd++, iop++, sp++) {
-		if ((pfd->events & POLLIN) &&
-					(pfd->revents & POLLIN || force_read)) {
-
+	for (i = 0; nevs > 0 && i < ndevs; i++, pfd++, iop++, sp++) {
+		if (pfd->revents & POLLIN || force_read) {
 			if (fstat(iop->ifd, &sb) < 0) {
 				perror(iop->ifn);
 				pfd->events = 0;
 			} else if (sb.st_size > (off_t)iop->data_queued) {
 				iop->ready = sb.st_size - iop->data_queued;
 				iop->data_queued = sb.st_size;
-				if (net_send_data(tp, iop))
+				if (net_send_data(tp, iop)) {
 					pfd->events = 0;
-				else {
+					pfd->revents = 0;
+				} else {
 					pdc_dr_update(iop->dpp, tp->cpu,
 						      iop->ready);
 					nentries++;
 				}
 			}
+			nevs--;
 		}
 	}
 
@@ -1244,7 +1281,7 @@ static int handle_pfds_netclient(struct tracer *tp, int force_read)
 	return nentries;
 }
 
-static int handle_pfds_entries(struct tracer *tp, int force_read)
+static int handle_pfds_entries(struct tracer *tp, int nevs, int force_read)
 {
 	int i, nentries = 0;
 	struct trace_buf *tbp;
@@ -1252,10 +1289,8 @@ static int handle_pfds_entries(struct tracer *tp, int force_read)
 	struct io_info *iop = tp->ios;
 
 	tbp = alloc_trace_buf(iop->dpp, tp->cpu, buf_size);
-	for (i = 0; i < ndevs; i++, pfd++, iop++) {
-		if ((pfd->events & POLLIN) &&
-					(pfd->revents & POLLIN || force_read)) {
-
+	for (i = 0; nevs > 0 && i < ndevs; i++, pfd++, iop++) {
+		if (pfd->revents & POLLIN || force_read) {
 			tbp->len = read(iop->ifd, tbp->buf, buf_size);
 			if (tbp->len > 0) {
 				pdc_dr_update(iop->dpp, tp->cpu, tbp->len);
@@ -1267,12 +1302,16 @@ static int handle_pfds_entries(struct tracer *tp, int force_read)
 				 * from trying reads.
 				 */
 				if (tp->is_done)
-					pfd->events = 0;
+					goto clear_events;
 			} else {
 				read_err(tp->cpu, iop->ifn);
-				if (errno != EAGAIN || tp->is_done)
+				if (errno != EAGAIN || tp->is_done) {
+clear_events:
 					pfd->events = 0;
+					pfd->revents = 0;
+				}
 			}
+			nevs--;
 		}
 	}
 	free_trace_buf(tbp);
@@ -1347,13 +1386,13 @@ static int iop_open(struct io_info *iop, int cpu)
 	if (fill_ofname(iop, cpu))
 		return 1;
 
-	iop->ofp = fopen(iop->ofn, "w+");
+	iop->ofp = my_fopen(iop->ofn, "w+");
 	if (iop->ofp == NULL) {
 		fprintf(stderr, "Open output file %s failed: %d/%s\n",
 			iop->ofn, errno, strerror(errno));
 		return 1;
 	}
-	if (set_vbuf(iop, _IOLBF, 128 * 1024)) {
+	if (set_vbuf(iop, _IOLBF, FILE_VBUF_SIZE)) {
 		fprintf(stderr, "set_vbuf for file %s failed: %d/%s\n",
 			iop->ofn, errno, strerror(errno));
 		fclose(iop->ofp);
@@ -1389,7 +1428,7 @@ static int open_ios(struct tracer *tp)
 		snprintf(iop->ifn, sizeof(iop->ifn), "%s/block/%s/trace%d",
 			debugfs_path, dpp->buts_name, tp->cpu);
 
-		iop->ifd = open(iop->ifn, O_RDONLY | O_NONBLOCK);
+		iop->ifd = my_open(iop->ifn, O_RDONLY | O_NONBLOCK);
 		if (iop->ifd < 0) {
 			fprintf(stderr, "Thread %d failed open %s: %d/%s\n",
 				tp->cpu, iop->ifn, errno, strerror(errno));
@@ -1503,30 +1542,28 @@ static int setup_mmap(int fd, unsigned int maxlen, struct mmap_info *mip)
 			return 1;
 		}
 
-		mip->fs_buf = mmap(NULL, mip->fs_buf_len, PROT_WRITE,
-					MAP_SHARED, fd,
-					mip->fs_size - mip->fs_off);
+		mip->fs_buf = my_mmap(NULL, mip->fs_buf_len, PROT_WRITE,
+				      MAP_SHARED, fd,
+				      mip->fs_size - mip->fs_off);
 		if (mip->fs_buf == MAP_FAILED) {
 			perror("__setup_mmap: mmap");
 			return 1;
 		}
-		mlock(mip->fs_buf, mip->fs_buf_len);
+		my_mlock(mip->fs_buf, mip->fs_buf_len);
 	}
 
 	return 0;
 }
 
-static int handle_pfds_file(struct tracer *tp, int force_read)
+static int handle_pfds_file(struct tracer *tp, int nevs, int force_read)
 {
 	struct mmap_info *mip;
 	int i, ret, nentries = 0;
 	struct pollfd *pfd = tp->pfds;
 	struct io_info *iop = tp->ios;
 
-	for (i = 0; i < ndevs; i++, pfd++, iop++) {
-		if ((pfd->events & POLLIN) &&
-					(pfd->revents & POLLIN || force_read)) {
-
+	for (i = 0; nevs > 0 && i < ndevs; i++, pfd++, iop++) {
+		if (pfd->revents & POLLIN || force_read) {
 			mip = &iop->mmap_info;
 
 			ret = setup_mmap(iop->ofd, buf_size, mip);
@@ -1548,12 +1585,16 @@ static int handle_pfds_file(struct tracer *tp, int force_read)
 				 * from trying reads.
 				 */
 				if (tp->is_done)
-					pfd->events = 0;
+					goto clear_events;
 			} else {
 				read_err(tp->cpu, iop->ifn);
-				if (errno != EAGAIN || tp->is_done)
+				if (errno != EAGAIN || tp->is_done) {
+clear_events:
 					pfd->events = 0;
+					pfd->revents = 0;
+				}
 			}
+			nevs--;
 		}
 	}
 
@@ -1564,6 +1605,7 @@ static void *thread_main(void *arg)
 {
 	int ret, ndone;
 	int last_th = 0;
+	int to_val;
 
 	struct tracer *tp = arg;
 
@@ -1589,19 +1631,24 @@ static void *thread_main(void *arg)
 	pthread_cond_signal(&tp->cond);
 	pthread_mutex_unlock(&tp->mutex);
 
+	if (piped_output)
+		to_val = 50;		/* Frequent partial handles */
+	else
+		to_val = 500;		/* 1/2 second intervals */
+
 	while (!tp->is_done) {
-		ndone = poll(tp->pfds, ndevs, 50);
-		if (ndone < 0 && errno != EINTR)
+		ndone = poll(tp->pfds, ndevs, to_val);
+		if (ndone || piped_output)
+			(void)handle_pfds(tp, ndone, piped_output);
+		else if (ndone < 0 && errno != EINTR)
 			fprintf(stderr, "Thread %d poll failed: %d/%s\n",
 				tp->cpu, errno, strerror(errno));
-		else if (ndone || piped_output)
-			(void)handle_pfds(tp, piped_output);
 	}
 
 	/*
 	 * Trace is stopped, pull data until we get a short read
 	 */
-	while (handle_pfds(tp, 1) > 0)
+	while (handle_pfds(tp, ndevs, 1) > 0)
 		;
 
 	/*
@@ -1776,7 +1823,7 @@ static void show_stats(struct list_head *devpaths)
 	unsigned long long total_events = 0;
 
 	if (piped_output)
-		ofp = fopen("/dev/null", "w");
+		ofp = my_fopen("/dev/null", "w");
 	else
 		ofp = stdout;
 
@@ -1867,7 +1914,7 @@ static int handle_args(int argc, char *argv[])
 
 		case 'I': {
 			char dev_line[256];
-			FILE *ifp = fopen(optarg, "r");
+			FILE *ifp = my_fopen(optarg, "r");
 
 			if (!ifp) {
 				fprintf(stderr,
@@ -2332,7 +2379,7 @@ static int net_server(void)
 	INIT_LIST_HEAD(&ns->conn_list);
 	ns->pfds = malloc(sizeof(struct pollfd));
 
-	fd = socket(AF_INET, SOCK_STREAM, 0);
+	fd = my_socket(AF_INET, SOCK_STREAM, 0);
 	if (fd < 0) {
 		perror("server: socket");
 		goto out;
@@ -2397,9 +2444,6 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
-	if (increase_limits())
-		fprintf(stderr, "WARNING: may exceed FS or MEM limits\n");
-
 	signal(SIGINT, handle_sigint);
 	signal(SIGHUP, handle_sigint);
 	signal(SIGTERM, handle_sigint);
-- 
1.5.6.3


--------------030001060006020701040801--
