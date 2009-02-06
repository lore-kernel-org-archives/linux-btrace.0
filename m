From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 06 Feb 2009 19:11:37 +0000
Subject: [PATCH] blktrace version 2.0:  Proposed update for blktrace
Message-Id: <498C8B69.9090606@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080006020508010104090108"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------080006020508010104090108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jens had said to replace blktrace.c when I felt confident in it. I've
fixed a couple of nagging issues today, and so far all my testing has
gone very well. Successful runs are definitely valgrind clean, and my
networking tests (both with and without sendfile) have gone very well.
Doing some sample "standard" local disk runs - doing the default 4X512
test I've posted results on recently - are coming up clean without any
drops (as opposed to the 4.4% drop rate seen with version 1.0 of blktrace).

I'm posting this version, in case anyone has some time to review things.
Note: as opposed to the other ones I posted this one overwrites
blktrace.c - the diffs make no real sense, so it's best to review a
patched version of blktrace.c

If my testing continues to go well, and no comments come in from the
field, I'll slap this on top of blktrace.c Monday or Tuesday next week
(9 or 10 February 2009).

--------------080006020508010104090108
Content-Type: text/x-diff;
 name="0001-Rewrote-blktrace-to-have-a-single-thread-per-CPU.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Rewrote-blktrace-to-have-a-single-thread-per-CPU.patch"

From 0094985e8d34e773f908dfd3a6da8fbdb37a798c Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Fri, 6 Feb 2009 13:29:55 -0500
Subject: [PATCH] Rewrote blktrace to have a single thread per CPU

Massive changes: mostly around the notion of having much fewer threads
(instead of N(devs) X N(cpus) threads, we'll have just N(cpus)). This
is very important for larger systems (with lots of devices to
trace). A lot of the code was stolen from the original blktrace code,
major changes include:

o  On the client side we only have a single thread per client CPU. Each
thread will then open all device files for that CPU, and use poll to
determine which file needs processing.

o  For network client mode w/ sendfile, this means that a single socket
will carry all data to the remote network server. The network server
side will then distribute its reads off that one socket onto different
trace files.

o  For network client mode w/out sendfile, we fall back to doing things
like piped mode: keep buffers of tracers read in, and then the main
thread will issue these on sockets to the server. In this case, the main
thread will still have a single socket per CPU.

o  For networked mode we added an OPEN concept on the client side: as
soon as the connection to the server is set up, a "header" is sent
signifying that this connection will handle a <cpu, device> tuple. For
each socket opened on the client side, it will send a header per device
being managed. The server side will handle utilize opens to set up
appropriate data structures to handle incoming data streams.

o  For both the OPEN and CLOSE headers the server will acknowledge with
a short write back to the client. This allows the client & server sides
to gracefully close socket connections.

o  I also re-did the resource limitiation issue a bit differently: for
open calls (including socket) or for memory map/lock calls I have
provided a wrapper function that will try to increase specific limits as
needed. The previous method (attempting to do it at the beginning of the
run) fails for network server mode - you don't know at initialization
how many devices and CPUs will be handled.

o  The standard output is slightly different in a few places, if this is
a problem w/ compatibility we can work to rectify that. The command line
argument handling is identical though.

o  Using code stolen from Linux to manipulate doubly-linked lists. I've
found that this makes the code easier to read/write (but may be a bit of
overkill here...)

o  The code passes valgrind quite well (at least for my tests so far).
The only nit has to do with inet_ntoa - but that is out of our control.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blktrace.c | 3217 ++++++++++++++++++++++++++++++++++--------------------------
 btt/list.h |   23 +
 2 files changed, 1862 insertions(+), 1378 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index afcc42f..cbe0273 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -4,6 +4,9 @@
  * Copyright (C) 2005 Jens Axboe <axboe@suse.de>
  * Copyright (C) 2006 Jens Axboe <axboe@kernel.dk>
  *
+ * Rewrite to have a single thread per CPU (managing all devices on that CPU)
+ *	Alan D. Brunelle <alan.brunelle@hp.com> - January 2009
+ *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -19,47 +22,286 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
  */
-#include <pthread.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <sched.h>
 #include <unistd.h>
-#include <locale.h>
+#include <poll.h>
 #include <signal.h>
-#include <fcntl.h>
-#include <string.h>
+#include <pthread.h>
+#include <locale.h>
 #include <sys/ioctl.h>
-#include <sys/param.h>
-#include <sys/statfs.h>
-#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
 #include <sys/mman.h>
+#include <sys/param.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 #include <sys/socket.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sched.h>
-#include <ctype.h>
-#include <getopt.h>
-#include <errno.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <sys/sendfile.h>
-#include <sys/resource.h>
 
+#include "btt/list.h"
 #include "blktrace.h"
-#include "barrier.h"
-
-static char blktrace_version[] = "1.0.0";
 
 /*
  * You may want to increase this even more, if you are logging at a high
  * rate and see skipped/missed events
  */
-#define BUF_SIZE	(512 * 1024)
-#define BUF_NR		(4)
+#define BUF_SIZE		(512 * 1024)
+#define BUF_NR			(4)
+
+#define FILE_VBUF_SIZE		(128 * 1024)
+
+#define DEBUGFS_TYPE		(0x64626720)
+#define TRACE_NET_PORT		(8462)
+
+enum {
+	Net_none = 0,
+	Net_server,
+	Net_client,
+};
+
+/*
+ * Generic stats collected: nevents can be _roughly_ estimated by data_read
+ * (discounting pdu...)
+ *
+ * These fields are updated w/ pdc_dr_update & pdc_nev_update below.
+ */
+struct pdc_stats {
+	unsigned long long data_read;
+	unsigned long long nevents;
+};
+
+struct devpath {
+	struct list_head head;
+	char *path;			/* path to device special file */
+	char *buts_name;		/* name returned from bt kernel code */
+	struct pdc_stats *stats;
+	int fd, idx, ncpus;
+	unsigned long long drops;
+
+	/*
+	 * For piped output only:
+	 *
+	 * Each tracer will have a tracer_devpath_head that it will add new
+	 * data onto. It's list is protected above (tracer_devpath_head.mutex)
+	 * and it will signal the processing thread using the dp_cond,
+	 * dp_mutex & dp_entries variables above.
+	 */
+	struct tracer_devpath_head *heads;
+
+	/*
+	 * For network server mode only:
+	 */
+	struct cl_host *ch;
+	u32 cl_id;
+	time_t cl_connect_time;
+	struct io_info *ios;
+};
+
+/*
+ * For piped output to stdout we will have each tracer thread (one per dev)
+ * tack buffers read from the relay queues on a per-device list.
+ *
+ * The main thread will then collect trace buffers from each of lists in turn.
+ *
+ * We will use a mutex to guard each of the trace_buf list. The tracers
+ * can then signal the main thread using <dp_cond,dp_mutex> and
+ * dp_entries. (When dp_entries is 0, and a tracer adds an entry it will
+ * signal. When dp_entries is 0, the main thread will wait for that condition
+ * to be signalled.)
+ *
+ * adb: It may be better just to have a large buffer per tracer per dev,
+ * and then use it as a ring-buffer. This would certainly cut down a lot
+ * of malloc/free thrashing, at the cost of more memory movements (potentially).
+ */
+struct trace_buf {
+	struct list_head head;
+	struct devpath *dpp;
+	void *buf;
+	int cpu, len;
+};
+
+struct tracer_devpath_head {
+	pthread_mutex_t mutex;
+	struct list_head head;
+	struct trace_buf *prev;
+};
+
+/*
+ * Used to handle the mmap() interfaces for output file (containing traces)
+ */
+struct mmap_info {
+	void *fs_buf;
+	unsigned long long fs_size, fs_max_size, fs_off, fs_buf_len;
+	unsigned long buf_size, buf_nr;
+	int pagesize;
+};
+
+/*
+ * Each thread doing work on a (client) side of blktrace will have one
+ * of these. The ios array contains input/output information, pfds holds
+ * poll() data. The volatile's provide flags to/from the main executing
+ * thread.
+ */
+struct tracer {
+	struct list_head head;
+	struct io_info *ios;
+	struct pollfd *pfds;
+	pthread_t thread;
+	pthread_mutex_t mutex;
+	pthread_cond_t cond;
+	int cpu, nios;
+	volatile int running, status, is_done;
+};
+
+/*
+ * networking stuff follows. we include a magic number so we know whether
+ * to endianness convert or not.
+ *
+ * The len field is overloaded:
+ *	0 - Indicates an "open" - allowing the server to set up for a dev/cpu
+ *	1 - Indicates a "close" - Shut down connection orderly
+ *
+ * The cpu field is overloaded on close: it will contain the number of drops.
+ */
+struct blktrace_net_hdr {
+	u32 magic;		/* same as trace magic */
+	char buts_name[32];	/* trace name */
+	u32 cpu;		/* for which cpu */
+	u32 max_cpus;
+	u32 len;		/* length of following trace data */
+	u32 cl_id;		/* id for set of client per-cpu connections */
+	u32 buf_size;		/* client buf_size for this trace  */
+	u32 buf_nr;		/* client buf_nr for this trace  */
+	u32 page_size;		/* client page_size for this trace  */
+};
 
-#define OFILE_BUF	(128 * 1024)
+/*
+ * Each host encountered has one of these. The head is used to link this
+ * on to the network server's ch_list. Connections associated with this
+ * host are linked on conn_list, and any devices traced on that host
+ * are connected on the devpaths list.
+ */
+struct cl_host {
+	struct list_head head;
+	struct list_head conn_list;
+	struct list_head devpaths;
+	struct net_server_s *ns;
+	char *hostname;
+	struct in_addr cl_in_addr;
+	int connects, ndevs, cl_opens;
+};
+
+/*
+ * Each connection (client to server socket ('fd')) has one of these. A
+ * back reference to the host ('ch'), and lists headers (for the host
+ * list, and the network server conn_list) are also included.
+ */
+struct cl_conn {
+	struct list_head ch_head, ns_head;
+	struct cl_host *ch;
+	int fd, ncpus;
+	time_t connect_time;
+};
+
+/*
+ * The network server requires some poll structures to be maintained -
+ * one per conection currently on conn_list. The nchs/ch_list values
+ * are for each host connected to this server. The addr field is used
+ * for scratch as new connections are established.
+ */
+struct net_server_s {
+	struct list_head conn_list;
+	struct list_head ch_list;
+	struct pollfd *pfds;
+	int listen_fd, connects, nchs;
+	struct sockaddr_in addr;
+};
+
+/*
+ * This structure is (generically) used to providide information
+ * for a read-to-write set of values.
+ *
+ * ifn & ifd represent input information
+ *
+ * ofn, ofd, ofp, obuf & mmap_info are used for output file (optionally).
+ */
+struct io_info {
+	struct devpath *dpp;
+	FILE *ofp;
+	char *obuf;
+	struct cl_conn *nc;	/* Server network connection */
+
+	/*
+	 * mmap controlled output files
+	 */
+	struct mmap_info mmap_info;
+
+	/*
+	 * Client network fields
+	 */
+	unsigned int ready;
+	unsigned long long data_queued;
+
+	/*
+	 * Input/output file descriptors & names
+	 */
+	int ifd, ofd;
+	char ifn[MAXPATHLEN + 64];
+	char ofn[MAXPATHLEN + 64];
+};
+
+static char blktrace_version[] = "2.0.0";
+
+/*
+ * Linkage to blktrace helper routines (trace conversions)
+ */
+int data_is_native = -1;
+
+static int ncpus;
+static int pagesize;
+static int act_mask = ~0U;
+static char *debugfs_path = "/sys/kernel/debug";
+static char *output_name;
+static char *output_dir;
+static int kill_running_trace;
+static int stop_watch;
+static unsigned long buf_size = BUF_SIZE;
+static unsigned long buf_nr = BUF_NR;
+static LIST_HEAD(devpaths);
+static LIST_HEAD(tracers);
+static int ndevs;
+static volatile int done;
+static FILE *pfp;
+static int piped_output;
+static int ntracers;
+
+static pthread_cond_t dp_cond = PTHREAD_COND_INITIALIZER;
+static pthread_mutex_t dp_mutex = PTHREAD_MUTEX_INITIALIZER;
+static volatile int dp_entries;
+
+/*
+ * network cmd line params
+ */
+static char hostname[MAXHOSTNAMELEN];
+static int net_port = TRACE_NET_PORT;
+static int net_use_sendfile = 1;
+static int net_mode;
+static int *cl_fds;
 
-#define DEBUGFS_TYPE	0x64626720
+static int (*handle_pfds)(struct tracer *, int, int);
+static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
 #define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
 static struct option l_opts[] = {
@@ -170,1675 +412,1450 @@ static struct option l_opts[] = {
 	}
 };
 
-struct tip_subbuf {
-	void *buf;
-	unsigned int len;
-	unsigned int max_len;
-};
-
-#define FIFO_SIZE	(1024)	/* should be plenty big! */
-#define CL_SIZE		(128)	/* cache line, any bigger? */
-
-struct tip_subbuf_fifo {
-	int tail __attribute__((aligned(CL_SIZE)));
-	int head __attribute__((aligned(CL_SIZE)));
-	struct tip_subbuf *q[FIFO_SIZE];
-};
-
-struct thread_information {
-	int cpu;
-	pthread_t thread;
-
-	int fd;
-	void *fd_buf;
-	char fn[MAXPATHLEN + 64];
-
-	FILE *ofile;
-	char *ofile_buffer;
-	off_t ofile_offset;
-	int ofile_stdout;
-	int ofile_mmap;
-
-	int (*get_subbuf)(struct thread_information *, unsigned int);
-	int (*flush_subbuf)(struct thread_information *, struct tip_subbuf *);
-	int (*read_data)(struct thread_information *, void *, unsigned int);
-
-	unsigned long events_processed;
-	unsigned long long data_read;
-	unsigned long long data_queued;
-	struct device_information *device;
-
-	int exited;
-
-	/*
-	 * piped fifo buffers
-	 */
-	struct tip_subbuf_fifo fifo;
-	struct tip_subbuf *leftover_ts;
-
-	/*
-	 * mmap controlled output files
-	 */
-	unsigned long long fs_size;
-	unsigned long long fs_max_size;
-	unsigned long fs_off;
-	void *fs_buf;
-	unsigned long fs_buf_len;
-
-	struct net_connection *nc;
-};
-
-struct device_information {
-	int fd;
-	char *path;
-	char buts_name[32];
-	volatile int trace_started;
-	unsigned long drop_count;
-	struct thread_information *threads;
-	unsigned long buf_size;
-	unsigned long buf_nr;
-	unsigned int page_size;
-
-	struct cl_host *ch;
-	u32 cl_id;
-	time_t cl_connect_time;
-};
+static char usage_str[] = \
+	"-d <dev> [ -r debugfs path ] [ -o <output> ] [-k ] [ -w time ]\n" \
+	"[ -a action ] [ -A action mask ] [ -I  <devs file> ] [ -v ]\n\n" \
+	"\t-d Use specified device. May also be given last after options\n" \
+	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
+	"\t-o File(s) to send output to\n" \
+	"\t-D Directory to prepend to output file names\n" \
+	"\t-k Kill a running trace\n" \
+	"\t-w Stop after defined time, in seconds\n" \
+	"\t-a Only trace specified actions. See documentation\n" \
+	"\t-A Give trace mask as a single value. See documentation\n" \
+	"\t-b Sub buffer size in KiB\n" \
+	"\t-n Number of sub buffers\n" \
+	"\t-l Run in network listen mode (blktrace server)\n" \
+	"\t-h Run in network client mode, connecting to the given host\n" \
+	"\t-p Network port to use (default 8462)\n" \
+	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
+	"\t-I Add devices found in <devs file>\n" \
+	"\t-V Print program version info\n\n";
 
-static int ncpus;
-static struct thread_information *thread_information;
-static int ndevs;
-static struct device_information *device_information;
+static void clear_events(struct pollfd *pfd)
+{
+	pfd->events = 0;
+	pfd->revents = 0;
+}
 
-/* command line option globals */
-static char *debugfs_path;
-static char *output_name;
-static char *output_dir;
-static int act_mask = ~0U;
-static int kill_running_trace;
-static unsigned long buf_size = BUF_SIZE;
-static unsigned long buf_nr = BUF_NR;
-static unsigned int page_size;
+static inline int net_client_use_sendfile(void)
+{
+	return net_mode == Net_client && net_use_sendfile;
+}
 
-#define is_done()	(*(volatile int *)(&done))
-static volatile int done;
+static inline int net_client_use_send(void)
+{
+	return net_mode == Net_client && !net_use_sendfile;
+}
 
-#define is_trace_stopped()	(*(volatile int *)(&trace_stopped))
-static volatile int trace_stopped;
+static inline int use_tracer_devpaths(void)
+{
+	return piped_output || net_client_use_send();
+}
 
-#define is_stat_shown()	(*(volatile int *)(&stat_shown))
-static volatile int stat_shown;
+static inline int in_addr_eq(struct in_addr a, struct in_addr b)
+{
+	return a.s_addr == b.s_addr;
+}
 
-int data_is_native = -1;
+static inline void pdc_dr_update(struct devpath *dpp, int cpu, int data_read)
+{
+	dpp->stats[cpu].data_read += data_read;
+}
 
-static void exit_trace(int status);
+static inline void pdc_nev_update(struct devpath *dpp, int cpu, int nevents)
+{
+	dpp->stats[cpu].nevents += nevents;
+}
 
-#define dip_tracing(dip)	(*(volatile int *)(&(dip)->trace_started))
-#define dip_set_tracing(dip, v)	((dip)->trace_started = (v))
+static void show_usage(char *prog)
+{
+	fprintf(stderr, "Usage: %s %s %s", prog, blktrace_version, usage_str);
+}
 
-#define __for_each_dip(__d, __di, __e, __i)	\
-	for (__i = 0, __d = __di; __i < __e; __i++, __d++)
+static void init_mmap_info(struct mmap_info *mip)
+{
+	mip->buf_size = buf_size;
+	mip->buf_nr = buf_nr;
+	mip->pagesize = pagesize;
+}
 
-#define for_each_dip(__d, __i)		\
-	__for_each_dip(__d, device_information, ndevs, __i)
-#define for_each_nc_dip(__nc, __d, __i)		\
-	__for_each_dip(__d, (__nc)->ch->device_information, (__nc)->ch->ndevs, __i)
+static void net_close_connection(int *fd)
+{
+	shutdown(*fd, SHUT_RDWR);
+	close(*fd);
+	*fd = -1;
+}
 
-#define __for_each_tip(__d, __t, __ncpus, __j)	\
-	for (__j = 0, __t = (__d)->threads; __j < __ncpus; __j++, __t++)
-#define for_each_tip(__d, __t, __j)	\
-	__for_each_tip(__d, __t, ncpus, __j)
-#define for_each_cl_host(__c)	\
-	for (__c = cl_host_list; __c; __c = __c->list_next)
+static void dpp_free(struct devpath *dpp)
+{
+	if (dpp->stats)
+		free(dpp->stats);
+	if (dpp->ios)
+		free(dpp->ios);
+	if (dpp->path)
+		free(dpp->path);
+	if (dpp->buts_name)
+		free(dpp->buts_name);
+	free(dpp);
+}
 
-/*
- * networking stuff follows. we include a magic number so we know whether
- * to endianness convert or not
- */
-struct blktrace_net_hdr {
-	u32 magic;		/* same as trace magic */
-	char buts_name[32];	/* trace name */
-	u32 cpu;		/* for which cpu */
-	u32 max_cpus;
-	u32 len;		/* length of following trace data */
-	u32 cl_id;		/* id for set of client per-cpu connections */
-	u32 buf_size;		/* client buf_size for this trace  */
-	u32 buf_nr;		/* client buf_nr for this trace  */
-	u32 page_size;		/* client page_size for this trace  */
-};
+static int lock_on_cpu(int cpu)
+{
+	cpu_set_t cpu_mask;
 
-#define TRACE_NET_PORT		(8462)
+	CPU_ZERO(&cpu_mask);
+	CPU_SET(cpu, &cpu_mask);
+	if (sched_setaffinity(getpid(), sizeof(cpu_mask), &cpu_mask) < 0)
+		return errno;
 
-enum {
-	Net_none = 0,
-	Net_server,
-	Net_client,
-};
+	return 0;
+}
 
 /*
- * network cmd line params
+ * Create a timespec 'msec' milliseconds into the future
  */
-static char hostname[MAXHOSTNAMELEN];
-static int net_port = TRACE_NET_PORT;
-static int net_mode = 0;
-static int net_use_sendfile = 1;
-
-struct cl_host {
-	struct cl_host *list_next;
-	struct in_addr cl_in_addr;
-	struct net_connection *net_connections;
-	int nconn;
-	struct device_information *device_information;
-	int ndevs;
-	int ncpus;
-	int ndevs_done;
-};
+static inline void make_timespec(struct timespec *tsp, long delta_msec)
+{
+	struct timeval now;
 
-struct net_connection {
-	int in_fd;
-	struct pollfd pfd;
-	time_t connect_time;
-	struct cl_host *ch;
-	int ncpus;
-};
+	gettimeofday(&now, NULL);
+	tsp->tv_sec = now.tv_sec;
+	tsp->tv_nsec = 1000L * now.tv_usec;
 
-#define NET_MAX_CL_HOSTS	(1024)
-static struct cl_host *cl_host_list;
-static int cl_hosts;
-static int net_connects;
+	tsp->tv_nsec += (delta_msec * 1000000L);
+	if (tsp->tv_nsec > 1000000000L) {
+		long secs = tsp->tv_nsec / 1000000000L;
 
-static int *net_out_fd;
+		tsp->tv_sec += secs;
+		tsp->tv_nsec -= (secs * 1000000000L);
+	}
+}
 
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
 
-	rlim.rlim_cur = rlim.rlim_max = RLIM_INFINITY;
-	if (setrlimit(r, &rlim) < 0) {
-		rlim.rlim_cur = rlim.rlim_max = val;
-		if (setrlimit(r, &rlim) < 0) {
-			perror(r == RLIMIT_NOFILE ? "NOFILE" : "MEMLOCK");
+	if (!getrlimit(resource, &rlim)) {
+		rlim.rlim_cur += increase;
+		if (rlim.rlim_cur >= rlim.rlim_max)
+			rlim.rlim_max = rlim.rlim_cur + increase;
+
+		if (!setrlimit(resource, &rlim))
 			return 1;
-		}
 	}
 
+	errno = save_errno;
 	return 0;
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
 }
 
-static void handle_sigint(__attribute__((__unused__)) int sig)
+static FILE *my_fopen(const char *path, const char *mode)
 {
-	struct device_information *dip;
-	int i;
+	FILE *fp;
 
-	/*
-	 * stop trace so we can reap currently produced data
-	 */
-	for_each_dip(dip, i) {
-		if (dip->fd == -1)
-			continue;
-		if (ioctl(dip->fd, BLKTRACESTOP) < 0)
-			perror("BLKTRACESTOP");
-	}
+	do {
+		fp = fopen(path, mode);
+	} while (fp == NULL && handle_open_failure());
 
-	done = 1;
+	return fp;
 }
 
-static int get_dropped_count(const char *buts_name)
+static int my_open(const char *path, int flags)
 {
 	int fd;
-	char tmp[MAXPATHLEN + 64];
-
-	snprintf(tmp, sizeof(tmp), "%s/block/%s/dropped",
-		 debugfs_path, buts_name);
-
-	fd = open(tmp, O_RDONLY);
-	if (fd < 0) {
-		/*
-		 * this may be ok, if the kernel doesn't support dropped counts
-		 */
-		if (errno == ENOENT)
-			return 0;
 
-		fprintf(stderr, "Couldn't open dropped file %s\n", tmp);
-		return -1;
-	}
-
-	if (read(fd, tmp, sizeof(tmp)) < 0) {
-		perror(tmp);
-		close(fd);
-		return -1;
-	}
-
-	close(fd);
+	do {
+		fd = open(path, flags);
+	} while (fd < 0 && handle_open_failure());
 
-	return atoi(tmp);
+	return fd;
 }
 
-static int start_trace(struct device_information *dip)
+static int my_socket(int domain, int type, int protocol)
 {
-	struct blk_user_trace_setup buts;
-
-	memset(&buts, 0, sizeof(buts));
-	buts.buf_size = dip->buf_size;
-	buts.buf_nr = dip->buf_nr;
-	buts.act_mask = act_mask;
-
-	if (ioctl(dip->fd, BLKTRACESETUP, &buts) < 0) {
-		perror("BLKTRACESETUP");
-		return 1;
-	}
+	int fd;
 
-	if (ioctl(dip->fd, BLKTRACESTART) < 0) {
-		perror("BLKTRACESTART");
-		return 1;
-	}
+	do {
+		fd = socket(domain, type, protocol);
+	} while (fd < 0 && handle_open_failure());
 
-	memcpy(dip->buts_name, buts.name, sizeof(dip->buts_name));
-	dip_set_tracing(dip, 1);
-	return 0;
+	return fd;
 }
 
-static void stop_trace(struct device_information *dip)
+static void *my_mmap(void *addr, size_t length, int prot, int flags, int fd,
+		     off_t offset)
 {
-	if (dip_tracing(dip) || kill_running_trace) {
-		dip_set_tracing(dip, 0);
-
-		/*
-		 * should be stopped, just don't complain if it isn't
-		 */
-		ioctl(dip->fd, BLKTRACESTOP);
+	void *new;
 
-		if (ioctl(dip->fd, BLKTRACETEARDOWN) < 0)
-			perror("BLKTRACETEARDOWN");
+	do {
+		new = mmap(addr, length, prot, flags, fd, offset);
+	} while (new == MAP_FAILED && handle_mem_failure(length));
 
-		close(dip->fd);
-		dip->fd = -1;
-	}
+	return new;
 }
 
-static void stop_all_traces(void)
+static int my_mlock(const void *addr, size_t len)
 {
-	struct device_information *dip;
-	int i;
+	int ret;
 
-	for_each_dip(dip, i) {
-		dip->drop_count = get_dropped_count(dip->buts_name);
-		stop_trace(dip);
-	}
+	do {
+		ret = mlock(addr, len);
+	} while (ret < 0 && handle_mem_failure(len));
+
+	return ret;
 }
 
-static void wait_for_data(struct thread_information *tip, int timeout)
+static int __stop_trace(int fd)
 {
-	struct pollfd pfd = { .fd = tip->fd, .events = POLLIN };
-
-	while (!is_done()) {
-		if (poll(&pfd, 1, timeout) < 0) {
-			perror("poll");
-			break;
-		}
-		if (pfd.revents & POLLIN)
-			break;
-		if (tip->ofile_stdout)
-			break;
-	}
+	/*
+	 * Should be stopped, don't complain if it isn't
+	 */
+	ioctl(fd, BLKTRACESTOP);
+	return ioctl(fd, BLKTRACETEARDOWN);
 }
 
-static int read_data_file(struct thread_information *tip, void *buf,
-			  unsigned int len)
+static void write_data(char *buf, int len)
 {
-	int ret = 0;
-
-	do {
-		wait_for_data(tip, 100);
+	int ret;
 
-		ret = read(tip->fd, buf, len);
-		if (!ret)
-			continue;
-		else if (ret > 0)
-			return ret;
-		else {
-			if (errno != EAGAIN) {
-				perror(tip->fn);
-				fprintf(stderr,"Thread %d failed read of %s\n",
-					tip->cpu, tip->fn);
-				break;
-			}
-			continue;
+rewrite:
+	ret = fwrite(buf, len, 1, pfp);
+	if (ferror(pfp) || ret != 1) {
+		fprintf(stderr, "list write(%d) failed: %d/%s\n",
+			len, errno, strerror(errno));
+		clearerr(pfp);
+
+		if (errno != EINTR) {
+			/*
+			 * Writes are failing: switch to /dev/null...
+			 */
+			pfp = my_fopen("/dev/null", "w");
 		}
-	} while (!is_done());
-
-	return ret;
-
+		goto rewrite;
+	}
+	fflush(pfp);
 }
 
-static int read_data_net(struct thread_information *tip, void *buf,
-			 unsigned int len)
+/*
+ * Returns the number of bytes read (successfully)
+ */
+static int __net_recv_data(int fd, void *buf, unsigned int len)
 {
-	struct net_connection *nc = tip->nc;
 	unsigned int bytes_left = len;
-	int ret = 0;
 
-	do {
-		ret = recv(nc->in_fd, buf, bytes_left, MSG_WAITALL);
+	while (bytes_left && !done) {
+		int ret = recv(fd, buf, bytes_left, MSG_WAITALL);
 
-		if (!ret)
-			continue;
+		if (ret == 0)
+			break;
 		else if (ret < 0) {
 			if (errno != EAGAIN) {
-				perror(tip->fn);
-				fprintf(stderr, "server: failed read\n");
-				return 0;
-			}
-			continue;
+				perror("server: net_recv_data: recv failed");
+				break;
+			} else
+				break;
 		} else {
 			buf += ret;
 			bytes_left -= ret;
 		}
-	} while (!is_done() && bytes_left);
+	}
 
 	return len - bytes_left;
 }
 
-static inline struct tip_subbuf *
-subbuf_fifo_dequeue(struct thread_information *tip)
+static int net_recv_data(int fd, void *buf, unsigned int len)
+{
+	return __net_recv_data(fd, buf, len);
+}
+
+/*
+ * Returns number of bytes written
+ */
+static int net_send_data(int fd, void *buf, unsigned int buf_len)
 {
-	const int head = tip->fifo.head;
-	const int next = (head + 1) & (FIFO_SIZE - 1);
+	int ret;
+	unsigned int bytes_left = buf_len;
 
-	if (head != tip->fifo.tail) {
-		struct tip_subbuf *ts = tip->fifo.q[head];
+	while (bytes_left) {
+		ret = send(fd, buf, bytes_left, 0);
+		if (ret < 0) {
+			perror("send");
+			break;
+		}
 
-		store_barrier();
-		tip->fifo.head = next;
-		return ts;
+		buf += ret;
+		bytes_left -= ret;
 	}
 
-	return NULL;
+	return buf_len - bytes_left;
 }
 
-static inline int subbuf_fifo_queue(struct thread_information *tip,
-				    struct tip_subbuf *ts)
+static int net_send_header(int fd, int cpu, char *buts_name, int len)
 {
-	const int tail = tip->fifo.tail;
-	const int next = (tail + 1) & (FIFO_SIZE - 1);
+	struct blktrace_net_hdr hdr;
 
-	if (next != tip->fifo.head) {
-		tip->fifo.q[tail] = ts;
-		store_barrier();
-		tip->fifo.tail = next;
-		return 0;
-	}
+	memset(&hdr, 0, sizeof(hdr));
 
-	fprintf(stderr, "fifo too small!\n");
-	return 1;
+	hdr.magic = BLK_IO_TRACE_MAGIC;
+	strncpy(hdr.buts_name, buts_name, sizeof(hdr.buts_name));
+	hdr.buts_name[sizeof(hdr.buts_name)-1] = '\0';
+	hdr.cpu = cpu;
+	hdr.max_cpus = ncpus;
+	hdr.len = len;
+	hdr.cl_id = getpid();
+	hdr.buf_size = buf_size;
+	hdr.buf_nr = buf_nr;
+	hdr.page_size = pagesize;
+
+	return net_send_data(fd, &hdr, sizeof(hdr)) != sizeof(hdr);
 }
 
-/*
- * For file output, truncate and mmap the file appropriately
- */
-static int mmap_subbuf(struct thread_information *tip, unsigned int maxlen)
+static void net_send_open_close(int fd, int cpu, char *buts_name, int len)
 {
-	int ofd = fileno(tip->ofile);
-	int ret;
-	unsigned long nr;
+	struct blktrace_net_hdr ret_hdr;
+
+	net_send_header(fd, cpu, buts_name, len);
+	net_recv_data(fd, &ret_hdr, sizeof(ret_hdr));
+}
+
+static void net_send_open(int fd, int cpu, char *buts_name)
+{
+	net_send_open_close(fd, cpu, buts_name, 0);
+}
 
+static void net_send_close(int fd, char *buts_name, int drops)
+{
 	/*
-	 * extend file, if we have to. use chunks of 16 subbuffers.
+	 * Overload CPU w/ number of drops
+	 *
+	 * XXX: Need to clear/set done around call - done=1 (which
+	 * is true here) stops reads from happening... :-(
 	 */
-	if (tip->fs_off + maxlen > tip->fs_buf_len) {
-		if (tip->fs_buf) {
-			munlock(tip->fs_buf, tip->fs_buf_len);
-			munmap(tip->fs_buf, tip->fs_buf_len);
-			tip->fs_buf = NULL;
-		}
+	done = 0;
+	net_send_open_close(fd, drops, buts_name, 1);
+	done = 1;
+}
 
-		tip->fs_off = tip->fs_size & (tip->device->page_size - 1);
-		nr = max(16, tip->device->buf_nr);
-		tip->fs_buf_len = (nr * tip->device->buf_size) - tip->fs_off;
-		tip->fs_max_size += tip->fs_buf_len;
+static void ack_open_close(int fd, char *buts_name)
+{
+	net_send_header(fd, 0, buts_name, 2);
+}
 
-		if (ftruncate(ofd, tip->fs_max_size) < 0) {
-			perror("ftruncate");
-			return -1;
-		}
+static void net_send_drops(int fd)
+{
+	struct list_head *p;
 
-		tip->fs_buf = mmap(NULL, tip->fs_buf_len, PROT_WRITE,
-				   MAP_SHARED, ofd, tip->fs_size - tip->fs_off);
-		if (tip->fs_buf == MAP_FAILED) {
-			perror("mmap");
-			return -1;
-		}
-		mlock(tip->fs_buf, tip->fs_buf_len);
-	}
+	__list_for_each(p, &devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
 
-	ret = tip->read_data(tip, tip->fs_buf + tip->fs_off, maxlen);
-	if (ret >= 0) {
-		tip->data_read += ret;
-		tip->fs_size += ret;
-		tip->fs_off += ret;
-		return 0;
+		net_send_close(fd, dpp->buts_name, dpp->drops);
 	}
-
-	return -1;
 }
 
 /*
- * Use the copy approach for pipes and network
+ * Returns:
+ * 	 0: "EOF"
+ * 	 1: OK
+ * 	-1: Error
  */
-static int get_subbuf(struct thread_information *tip, unsigned int maxlen)
+static int net_get_header(struct cl_conn *nc, struct blktrace_net_hdr *bnh)
 {
-	struct tip_subbuf *ts = malloc(sizeof(*ts));
-	int ret;
+	int bytes_read;
+	int fl = fcntl(nc->fd, F_GETFL);
 
-	ts->buf = malloc(tip->device->buf_size);
-	ts->max_len = maxlen;
+	fcntl(nc->fd, F_SETFL, fl | O_NONBLOCK);
+	bytes_read = __net_recv_data(nc->fd, bnh, sizeof(*bnh));
+	fcntl(nc->fd, F_SETFL, fl & ~O_NONBLOCK);
 
-	ret = tip->read_data(tip, ts->buf, ts->max_len);
-	if (ret > 0) {
-		ts->len = ret;
-		tip->data_read += ret;
-		if (subbuf_fifo_queue(tip, ts))
-			ret = -1;
+	if (bytes_read == sizeof(*bnh))
+		return 1;
+	else if (bytes_read == 0)
+		return 0;
+	return -1;
+}
+
+static int net_setup_client(void)
+{
+	int fd;
+	struct sockaddr_in addr;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_port = htons(net_port);
+
+	if (inet_aton(hostname, &addr.sin_addr) != 1) {
+		struct hostent *hent = gethostbyname(hostname);
+		if (!hent) {
+			perror("gethostbyname");
+			return 1;
+		}
+
+		memcpy(&addr.sin_addr, hent->h_addr, 4);
+		strcpy(hostname, hent->h_name);
 	}
 
-	if (ret <= 0) {
-		free(ts->buf);
-		free(ts);
+	fd = my_socket(AF_INET, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("client: socket");
+		return -1;
 	}
 
-	return ret;
+	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("client: connect");
+		close(fd);
+		return -1;
+	}
+
+	return fd;
 }
 
-static void close_thread(struct thread_information *tip)
+static int open_client_connections(void)
 {
-	if (tip->fd != -1)
-		close(tip->fd);
-	if (tip->ofile)
-		fclose(tip->ofile);
-	if (tip->ofile_buffer)
-		free(tip->ofile_buffer);
-	if (tip->fd_buf)
-		free(tip->fd_buf);
+	int cpu;
 
-	tip->fd = -1;
-	tip->ofile = NULL;
-	tip->ofile_buffer = NULL;
-	tip->fd_buf = NULL;
+	cl_fds = calloc(ncpus, sizeof(*cl_fds));
+	for (cpu = 0; cpu < ncpus; cpu++) {
+		cl_fds[cpu] = net_setup_client();
+		if (cl_fds[cpu] < 0)
+			goto err;
+	}
+	return 0;
+
+err:
+	while (cpu > 0)
+		close(cl_fds[cpu--]);
+	free(cl_fds);
+	return 1;
 }
 
-static void tip_ftrunc_final(struct thread_information *tip)
+static void close_client_connections(void)
 {
-	/*
-	 * truncate to right size and cleanup mmap
-	 */
-	if (tip->ofile_mmap && tip->ofile) {
-		int ofd = fileno(tip->ofile);
-
-		if (tip->fs_buf)
-			munmap(tip->fs_buf, tip->fs_buf_len);
+	if (cl_fds) {
+		int cpu, *fdp;
 
-		if (ftruncate(ofd, tip->fs_size) < 0)
-			fprintf(stderr, "Ignoring error: ftruncate:  %d/%s\n",
-				errno, strerror(errno));
+		for (cpu = 0, fdp = cl_fds; cpu < ncpus; cpu++, fdp++) {
+			if (*fdp >= 0) {
+				net_send_drops(*fdp);
+				net_close_connection(fdp);
+			}
+		}
+		free(cl_fds);
 	}
 }
 
-static void *thread_main(void *arg)
+static void setup_buts(void)
 {
-	struct thread_information *tip = arg;
-	pid_t pid = getpid();
-	cpu_set_t cpu_mask;
+	struct list_head *p;
 
-	CPU_ZERO(&cpu_mask);
-	CPU_SET((tip->cpu), &cpu_mask);
+	__list_for_each(p, &devpaths) {
+		struct blk_user_trace_setup buts;
+		struct devpath *dpp = list_entry(p, struct devpath, head);
 
-	if (sched_setaffinity(pid, sizeof(cpu_mask), &cpu_mask) == -1) {
-		perror("sched_setaffinity");
-		exit_trace(1);
-	}
+		memset(&buts, 0, sizeof(buts));
+		buts.buf_size = buf_size;
+		buts.buf_nr = buf_nr;
+		buts.act_mask = act_mask;
 
-	snprintf(tip->fn, sizeof(tip->fn), "%s/block/%s/trace%d",
-			debugfs_path, tip->device->buts_name, tip->cpu);
-	tip->fd = open(tip->fn, O_RDONLY);
-	if (tip->fd < 0) {
-		perror(tip->fn);
-		fprintf(stderr,"Thread %d failed open of %s\n", tip->cpu,
-			tip->fn);
-		exit_trace(1);
-	}
+		if (ioctl(dpp->fd, BLKTRACESETUP, &buts) < 0) {
+			fprintf(stderr, "BLKTRACESETUP(2) %s failed: %d/%s\n",
+				dpp->path, errno, strerror(errno));
+			continue;
+		} else if (ioctl(dpp->fd, BLKTRACESTART) < 0) {
+			fprintf(stderr, "BLKTRACESTART %s failed: %d/%s\n",
+				dpp->path, errno, strerror(errno));
+			continue;
+		}
 
-	while (!is_done()) {
-		if (tip->get_subbuf(tip, tip->device->buf_size) < 0)
-			break;
+		dpp->ncpus = ncpus;
+		dpp->buts_name = strdup(buts.name);
+		if (dpp->stats)
+			free(dpp->stats);
+		dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
+		memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
 	}
+}
 
-	/*
-	 * trace is stopped, pull data until we get a short read
-	 */
-	while (tip->get_subbuf(tip, tip->device->buf_size) > 0)
-		;
+static int get_drops(struct devpath *dpp)
+{
+	int fd, drops = 0;
+	char fn[MAXPATHLEN + 64], tmp[256];
 
-	tip_ftrunc_final(tip);
-	tip->exited = 1;
-	return NULL;
+	snprintf(fn, sizeof(fn), "%s/block/%s/dropped", debugfs_path,
+		 dpp->buts_name);
+
+	fd = my_open(fn, O_RDONLY);
+	if (fd < 0) {
+		/*
+		 * This may be ok: the kernel may not support
+		 * dropped counts.
+		 */
+		if (errno != ENOENT)
+			fprintf(stderr, "Could not open %s: %d/%s\n",
+				fn, errno, strerror(errno));
+		return 0;
+	} else if (read(fd, tmp, sizeof(tmp)) < 0) {
+		fprintf(stderr, "Could not read %s: %d/%s\n",
+			fn, errno, strerror(errno));
+	} else
+		drops = atoi(tmp);
+	close(fd);
+
+	return drops;
 }
 
-static int write_data_net(int fd, void *buf, unsigned int buf_len)
+static void get_all_drops(void)
 {
-	unsigned int bytes_left = buf_len;
-	int ret;
-
-	while (bytes_left) {
-		ret = send(fd, buf, bytes_left, 0);
-		if (ret < 0) {
-			perror("send");
-			return 1;
-		}
+	struct list_head *p;
 
-		buf += ret;
-		bytes_left -= ret;
+	__list_for_each(p, &devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+		dpp->drops = get_drops(dpp);
 	}
+}
 
-	return 0;
+static inline struct trace_buf *alloc_trace_buf(int cpu, int bufsize)
+{
+	struct trace_buf *tbp;
+
+	tbp = malloc(sizeof(*tbp) + bufsize);
+	INIT_LIST_HEAD(&tbp->head);
+	tbp->len = 0;
+	tbp->buf = (void *)(tbp + 1);
+	tbp->cpu = cpu;
+	tbp->dpp = NULL;	/* Will be set when tbp is added */
+
+	return tbp;
 }
 
-static int net_send_header(struct thread_information *tip, unsigned int len)
+static void free_tracer_heads(struct devpath *dpp)
 {
-	struct blktrace_net_hdr hdr;
+	int cpu;
+	struct tracer_devpath_head *hd;
 
-	hdr.magic = BLK_IO_TRACE_MAGIC;
-	strcpy(hdr.buts_name, tip->device->buts_name);
-	hdr.cpu = tip->cpu;
-	hdr.max_cpus = ncpus;
-	hdr.len = len;
-	hdr.cl_id = getpid();
-	hdr.buf_size = tip->device->buf_size;
-	hdr.buf_nr = tip->device->buf_nr;
-	hdr.page_size = tip->device->page_size;
-	
-	return write_data_net(net_out_fd[tip->cpu], &hdr, sizeof(hdr));
+	for (cpu = 0, hd = dpp->heads; cpu < ncpus; cpu++, hd++) {
+		if (hd->prev)
+			free(hd->prev);
+		pthread_mutex_destroy(&hd->mutex);
+	}
+	free(dpp->heads);
 }
 
-/*
- * send header with 0 length to signal end-of-run
- */
-static void net_client_send_close(void)
+static int setup_tracer_devpaths(void)
 {
-	struct device_information *dip;
-	struct blktrace_net_hdr hdr;
-	int i;
+	struct list_head *p;
 
-	for_each_dip(dip, i) {
-		hdr.magic = BLK_IO_TRACE_MAGIC;
-		hdr.max_cpus = ncpus;
-		hdr.len = 0;
-		strcpy(hdr.buts_name, dip->buts_name);
-		hdr.cpu = get_dropped_count(dip->buts_name);
-		hdr.cl_id = getpid();
-		hdr.buf_size = dip->buf_size;
-		hdr.buf_nr = dip->buf_nr;
-		hdr.page_size = dip->page_size;
+	if (net_client_use_send())
+		if (open_client_connections())
+			return 1;
+
+	__list_for_each(p, &devpaths) {
+		int cpu;
+		struct tracer_devpath_head *hd;
+		struct devpath *dpp = list_entry(p, struct devpath, head);
 
-		write_data_net(net_out_fd[0], &hdr, sizeof(hdr));
+		dpp->heads = calloc(ncpus, sizeof(struct tracer_devpath_head));
+		for (cpu = 0, hd = dpp->heads; cpu < ncpus; cpu++, hd++) {
+			INIT_LIST_HEAD(&hd->head);
+			pthread_mutex_init(&hd->mutex, NULL);
+			hd->prev = NULL;
+		}
 	}
 
+	return 0;
 }
 
-static int flush_subbuf_net(struct thread_information *tip,
-			    struct tip_subbuf *ts)
+static inline void add_trace_buf(struct devpath *dpp, int cpu,
+						struct trace_buf **tbpp)
 {
-	if (net_send_header(tip, ts->len))
-		return -1;
-	if (write_data_net(net_out_fd[tip->cpu], ts->buf, ts->len))
-		return -1;
+	struct trace_buf *tbp = *tbpp;
+	struct tracer_devpath_head *hd = &dpp->heads[cpu];
 
-	free(ts->buf);
-	free(ts);
-	return 1;
+	tbp->dpp = dpp;
+
+	pthread_mutex_lock(&hd->mutex);
+	list_add_tail(&tbp->head, &hd->head);
+	pthread_mutex_unlock(&hd->mutex);
+
+	*tbpp = alloc_trace_buf(cpu, buf_size);
 }
 
-static int net_sendfile(struct thread_information *tip, struct tip_subbuf *ts)
+static inline void incr_entries(int entries_handled)
 {
-	int ret = sendfile(net_out_fd[tip->cpu], tip->fd, NULL, ts->len);
+	pthread_mutex_lock(&dp_mutex);
+	if (dp_entries == 0)
+		pthread_cond_signal(&dp_cond);
+	dp_entries += entries_handled;
+	pthread_mutex_unlock(&dp_mutex);
+}
 
-	if (ret < 0) {
-		perror("sendfile");
-		return 1;
-	} else if (ret < (int) ts->len) {
-		fprintf(stderr, "short sendfile send (%d of %d)\n", ret, ts->len);
+static int add_devpath(char *path)
+{
+	int fd;
+	struct devpath *dpp;
+
+	/*
+	 * Verify device is valid before going too far
+	 */
+	fd = my_open(path, O_RDONLY | O_NONBLOCK);
+	if (fd < 0) {
+		fprintf(stderr, "Invalid path %s specified: %d/%s\n",
+			path, errno, strerror(errno));
 		return 1;
 	}
 
+	dpp = malloc(sizeof(*dpp));
+	memset(dpp, 0, sizeof(*dpp));
+	dpp->path = strdup(path);
+	dpp->fd = fd;
+	dpp->idx = ndevs++;
+	list_add_tail(&dpp->head, &devpaths);
+
 	return 0;
 }
 
-static int flush_subbuf_sendfile(struct thread_information *tip,
-				 struct tip_subbuf *ts)
+static void rel_devpaths(void)
 {
-	int ret = -1;
+	struct list_head *p, *q;
 
-	if (net_send_header(tip, ts->len))
-		goto err;
-	if (net_sendfile(tip, ts))
-		goto err;
+	list_for_each_safe(p, q, &devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
 
-	tip->data_read += ts->len;
-	ret = 1;
-err:
-	free(ts);
-	return ret;
-}
+		list_del(&dpp->head);
+		__stop_trace(dpp->fd);
+		close(dpp->fd);
 
-static int get_subbuf_sendfile(struct thread_information *tip,
-			       __attribute__((__unused__)) unsigned int maxlen)
-{
-	struct tip_subbuf *ts;
-	struct stat sb;
-	unsigned int ready;
+		if (dpp->heads)
+			free_tracer_heads(dpp);
 
-	wait_for_data(tip, -1);
-
-	if (fstat(tip->fd, &sb) < 0) {
-		perror("trace stat");
-		return -1;
+		dpp_free(dpp);
+		ndevs--;
 	}
+}
 
-	ready = sb.st_size - tip->data_queued;
-	if (!ready) {
-		usleep(1000);
-		return 0;
-	}
+static int flush_subbuf_net(struct trace_buf *tbp)
+{
+	int fd = cl_fds[tbp->cpu];
+	struct devpath *dpp = tbp->dpp;
 
-	ts = malloc(sizeof(*ts));
-	ts->buf = NULL;
-	ts->max_len = 0;
-	ts->len = ready;
-	tip->data_queued += ready;
+	if (net_send_header(fd, tbp->cpu, dpp->buts_name, tbp->len))
+		return 1;
 
-	if (flush_subbuf_sendfile(tip, ts) < 0)
-		return -1;
+	if (net_send_data(fd, tbp->buf, tbp->len) != tbp->len)
+		return 1;
 
-	return ready;
+	return 0;
 }
 
-static int write_data(struct thread_information *tip, void *buf,
-		      unsigned int buf_len)
+static int
+handle_list_net(__attribute__((__unused__))struct tracer_devpath_head *hd,
+		struct list_head *list)
 {
-	int ret;
+	struct trace_buf *tbp;
+	struct list_head *p, *q;
+	int entries_handled = 0;
 
-	if (!buf_len)
-		return 0;
+	list_for_each_safe(p, q, list) {
+		tbp = list_entry(p, struct trace_buf, head);
 
-	ret = fwrite(buf, buf_len, 1, tip->ofile);
-	if (ferror(tip->ofile) || ret != 1) {
-		perror("fwrite");
-		clearerr(tip->ofile);
-		return 1;
-	}
+		list_del(&tbp->head);
+		entries_handled++;
 
-	if (tip->ofile_stdout)
-		fflush(tip->ofile);
+		if (cl_fds[tbp->cpu] >= 0) {
+			if (flush_subbuf_net(tbp)) {
+				close(cl_fds[tbp->cpu]);
+				cl_fds[tbp->cpu] = -1;
+			}
+		}
 
-	return 0;
+		free(tbp);
+	}
+
+	return entries_handled;
 }
 
-static int flush_subbuf_file(struct thread_information *tip,
-			     struct tip_subbuf *ts)
+static int handle_list_file(struct tracer_devpath_head *hd,
+			    struct list_head *list)
 {
-	unsigned int offset = 0;
+	int off, t_len, nevents;
 	struct blk_io_trace *t;
-	int pdu_len, events = 0;
+	struct list_head *p, *q;
+	int entries_handled = 0;
+	struct trace_buf *tbp, *prev;
 
-	/*
-	 * surplus from last run
-	 */
-	if (tip->leftover_ts) {
-		struct tip_subbuf *prev_ts = tip->leftover_ts;
+	prev = hd->prev;
+	list_for_each_safe(p, q, list) {
+		tbp = list_entry(p, struct trace_buf, head);
+		list_del(&tbp->head);
+		entries_handled++;
+
+		/*
+		 * If there was some leftover before, tack this new
+		 * entry onto the tail of the previous one.
+		 */
+		if (prev) {
+			unsigned long tot_len;
+			struct trace_buf *tmp = tbp;
+
+			tbp = prev;
+			prev = NULL;
+
+			tot_len = tbp->len + tmp->len;
+			if (tot_len > buf_size)
+				tbp->buf = realloc(tbp->buf, tot_len);
+
+			memcpy(tbp->buf + tbp->len, tmp->buf, tmp->len);
+			tbp->len += tmp->len;
 
-		if (prev_ts->len + ts->len > prev_ts->max_len) {
-			prev_ts->max_len += ts->len;
-			prev_ts->buf = realloc(prev_ts->buf, prev_ts->max_len);
+			free(tmp);
 		}
 
-		memcpy(prev_ts->buf + prev_ts->len, ts->buf, ts->len);
-		prev_ts->len += ts->len;
+		/*
+		 * See how many whole traces there are - send them
+		 * all out in one go.
+		 */
+		off = 0;
+		nevents = 0;
+		while (off + (int)sizeof(*t) <= tbp->len) {
+			t = (struct blk_io_trace *)(tbp->buf + off);
+			t_len = sizeof(*t) + t->pdu_len;
+			if (off + t_len > tbp->len)
+				break;
 
-		free(ts->buf);
-		free(ts);
+			off += t_len;
+			nevents++;
+		}
+		if (nevents)
+			pdc_nev_update(tbp->dpp, tbp->cpu, nevents);
 
-		ts = prev_ts;
-		tip->leftover_ts = NULL;
+		/*
+		 * Write any full set of traces, any remaining data is kept
+		 * for the next pass.
+		 */
+		if (off) {
+			write_data(tbp->buf, off);
+			if (off == tbp->len)
+				free(tbp);
+			else {
+				/*
+				 * Move valid data to beginning of buffer
+				 */
+				tbp->len -= off;
+				memmove(tbp->buf, tbp->buf + off, tbp->len);
+				prev = tbp;
+			}
+		} else
+			prev = tbp;
 	}
+	hd->prev = prev;
 
-	while (offset + sizeof(*t) <= ts->len) {
-		t = ts->buf + offset;
+	return entries_handled;
+}
 
-		if (verify_trace(t)) {
-			write_data(tip, ts->buf, offset);
-			return -1;
-		}
+static void __process_trace_bufs(void)
+{
+	int cpu;
+	struct list_head *p;
+	struct list_head list;
+	int handled = 0;
+
+	__list_for_each(p, &devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+		struct tracer_devpath_head *hd = dpp->heads;
+
+		for (cpu = 0; cpu < ncpus; cpu++, hd++) {
+			pthread_mutex_lock(&hd->mutex);
+			if (list_empty(&hd->head)) {
+				pthread_mutex_unlock(&hd->mutex);
+				continue;
+			}
 
-		pdu_len = t->pdu_len;
+			list_replace_init(&hd->head, &list);
+			pthread_mutex_unlock(&hd->mutex);
 
-		if (offset + sizeof(*t) + pdu_len > ts->len)
-			break;
+			handled += handle_list(hd, &list);
+		}
+	}
 
-		offset += sizeof(*t) + pdu_len;
-		tip->events_processed++;
-		tip->data_read += sizeof(*t) + pdu_len;
-		events++;
+	if (handled) {
+		pthread_mutex_lock(&dp_mutex);
+		dp_entries -= handled;
+		pthread_mutex_unlock(&dp_mutex);
 	}
+}
 
-	if (write_data(tip, ts->buf, offset))
-		return -1;
+static void process_trace_bufs(void)
+{
+	while (!done) {
+		pthread_mutex_lock(&dp_mutex);
+		while (!done && dp_entries == 0) {
+			struct timespec ts;
+
+			make_timespec(&ts, 50);
+			pthread_cond_timedwait(&dp_cond, &dp_mutex, &ts);
+		}
+		pthread_mutex_unlock(&dp_mutex);
 
+		__process_trace_bufs();
+	}
+}
+
+static void clean_trace_bufs(void)
+{
 	/*
-	 * leftover bytes, save them for next time
+	 * No mutex needed here: we're only reading from the lists,
+	 * tracers are done
 	 */
-	if (offset != ts->len) {
-		tip->leftover_ts = ts;
-		ts->len -= offset;
-		memmove(ts->buf, ts->buf + offset, ts->len);
-	} else {
-		free(ts->buf);
-		free(ts);
-	}
+	while (dp_entries)
+		__process_trace_bufs();
+}
 
-	return events;
+static inline void read_err(int cpu, char *ifn)
+{
+	if (errno != EAGAIN)
+		fprintf(stderr, "Thread %d failed read of %s: %d/%s\n",
+			cpu, ifn, errno, strerror(errno));
 }
 
-static int write_tip_events(struct thread_information *tip)
+static int net_sendfile(struct io_info *iop)
 {
-	struct tip_subbuf *ts = subbuf_fifo_dequeue(tip);
+	int ret;
 
-	if (ts)
-		return tip->flush_subbuf(tip, ts);
+	ret = sendfile(iop->ofd, iop->ifd, NULL, iop->ready);
+	if (ret < 0) {
+		perror("sendfile");
+		return 1;
+	} else if (ret < (int)iop->ready) {
+		fprintf(stderr, "short sendfile send (%d of %d)\n",
+			ret, iop->ready);
+		return 1;
+	}
 
 	return 0;
 }
 
-/*
- * scans the tips we know and writes out the subbuffers we accumulate
- */
-static void get_and_write_events(void)
+static inline int net_sendfile_data(struct tracer *tp, struct io_info *iop)
 {
-	struct device_information *dip;
-	struct thread_information *tip;
-	int i, j, events, ret, tips_running;
+	struct devpath *dpp = iop->dpp;
 
-	while (!is_done()) {
-		events = 0;
+	if (net_send_header(iop->ofd, tp->cpu, dpp->buts_name, iop->ready))
+		return 1;
+	return net_sendfile(iop);
+}
 
-		for_each_dip(dip, i) {
-			for_each_tip(dip, tip, j) {
-				ret = write_tip_events(tip);
-				if (ret > 0)
-					events += ret;
+static int handle_pfds_netclient(struct tracer *tp, int nevs, int force_read)
+{
+	struct stat sb;
+	int i, nentries = 0;
+	struct pdc_stats *sp;
+	struct pollfd *pfd = tp->pfds;
+	struct io_info *iop = tp->ios;
+
+	for (i = 0; nevs > 0 && i < ndevs; i++, pfd++, iop++, sp++) {
+		if (pfd->revents & POLLIN || force_read) {
+			if (fstat(iop->ifd, &sb) < 0) {
+				perror(iop->ifn);
+				pfd->events = 0;
+			} else if (sb.st_size > (off_t)iop->data_queued) {
+				iop->ready = sb.st_size - iop->data_queued;
+				iop->data_queued = sb.st_size;
+				if (!net_sendfile_data(tp, iop)) {
+					pdc_dr_update(iop->dpp, tp->cpu,
+						      iop->ready);
+					nentries++;
+				}
+				else
+					clear_events(pfd);
 			}
+			nevs--;
 		}
-
-		if (!events)
-			usleep(100000);
 	}
 
-	/*
-	 * reap stored events
-	 */
-	do {
-		events = 0;
-		tips_running = 0;
-		for_each_dip(dip, i) {
-			for_each_tip(dip, tip, j) {
-				ret = write_tip_events(tip);
-				if (ret > 0)
-					events += ret;
-				tips_running += !tip->exited;
-			}
-		}
-		usleep(10);
-	} while (events || tips_running);
+	if (nentries)
+		incr_entries(nentries);
+
+	return nentries;
 }
 
-static void wait_for_threads(void)
+static int handle_pfds_entries(struct tracer *tp, int nevs, int force_read)
 {
-	/*
-	 * for piped or network output, poll and fetch data for writeout.
-	 * for files, we just wait around for trace threads to exit
-	 */
-	if ((output_name && !strcmp(output_name, "-")) ||
-	    ((net_mode == Net_client) && !net_use_sendfile))
-		get_and_write_events();
-	else {
-		struct device_information *dip;
-		struct thread_information *tip;
-		int i, j, tips_running;
-
-		do {
-			tips_running = 0;
-			usleep(100000);
-
-			for_each_dip(dip, i)
-				for_each_tip(dip, tip, j)
-					tips_running += !tip->exited;
-		} while (tips_running);
+	int i, nentries = 0;
+	struct trace_buf *tbp;
+	struct pollfd *pfd = tp->pfds;
+	struct io_info *iop = tp->ios;
+
+	tbp = alloc_trace_buf(tp->cpu, buf_size);
+	for (i = 0; nevs > 0 && i < ndevs; i++, pfd++, iop++) {
+		if (pfd->revents & POLLIN || force_read) {
+			tbp->len = read(iop->ifd, tbp->buf, buf_size);
+			if (tbp->len > 0) {
+				pdc_dr_update(iop->dpp, tp->cpu, tbp->len);
+				add_trace_buf(iop->dpp, tp->cpu, &tbp);
+				nentries++;
+			} else if (tbp->len == 0) {
+				/*
+				 * Short reads after we're done stop us
+				 * from trying reads.
+				 */
+				if (tp->is_done)
+					clear_events(pfd);
+			} else {
+				read_err(tp->cpu, iop->ifn);
+				if (errno != EAGAIN || tp->is_done)
+					clear_events(pfd);
+			}
+			nevs--;
+		}
 	}
+	free(tbp);
+
+	if (nentries)
+		incr_entries(nentries);
 
-	if (net_mode == Net_client)
-		net_client_send_close();
+	return nentries;
 }
 
-static int fill_ofname(struct device_information *dip,
-		       struct thread_information *tip, char *dst,
-		       char *buts_name)
+static int fill_ofname(struct io_info *iop, int cpu)
 {
+	int len;
 	struct stat sb;
-	int len = 0;
+	char *dst = iop->ofn;
 
 	if (output_dir)
-		len = sprintf(dst, "%s/", output_dir);
+		len = snprintf(iop->ofn, sizeof(iop->ofn), "%s/", output_dir);
 	else
-		len = sprintf(dst, "./");
+		len = snprintf(iop->ofn, sizeof(iop->ofn), "./");
 
 	if (net_mode == Net_server) {
-		struct net_connection *nc = tip->nc;
+		struct cl_conn *nc = iop->nc;
 
-		len += sprintf(dst + len, "%s-", inet_ntoa(nc->ch->cl_in_addr));
-		len += strftime(dst + len, 64, "%F-%T/", gmtime(&dip->cl_connect_time));
+		len += sprintf(dst + len, "%s-", nc->ch->hostname);
+		len += strftime(dst + len, 64, "%F-%T/",
+				gmtime(&iop->dpp->cl_connect_time));
 	}
 
-	if (stat(dst, &sb) < 0) {
+	if (stat(iop->ofn, &sb) < 0) {
 		if (errno != ENOENT) {
-			perror("stat");
+			fprintf(stderr,
+				"Destination dir %s stat failed: %d/%s\n",
+				iop->ofn, errno, strerror(errno));
 			return 1;
 		}
-		if (mkdir(dst, 0755) < 0) {
-			perror(dst);
-			fprintf(stderr, "Can't make output dir\n");
+		if (mkdir(iop->ofn, 0755) < 0) {
+			fprintf(stderr,
+				"Destination dir %s can't be made: %d/%s\n",
+				iop->ofn, errno, strerror(errno));
 			return 1;
 		}
 	}
 
 	if (output_name)
-		sprintf(dst + len, "%s.blktrace.%d", output_name, tip->cpu);
+		snprintf(iop->ofn + len, sizeof(iop->ofn), "%s.blktrace.%d",
+			 output_name, cpu);
 	else
-		sprintf(dst + len, "%s.blktrace.%d", buts_name, tip->cpu);
+		snprintf(iop->ofn + len, sizeof(iop->ofn), "%s.blktrace.%d",
+			 iop->dpp->buts_name, cpu);
 
 	return 0;
 }
 
-static void fill_ops(struct thread_information *tip)
+static int set_vbuf(struct io_info *iop, int mode, size_t size)
 {
-	/*
-	 * setup ops
-	 */
-	if (net_mode == Net_client) {
-		if (net_use_sendfile) {
-			tip->get_subbuf = get_subbuf_sendfile;
-			tip->flush_subbuf = NULL;
-		} else {
-			tip->get_subbuf = get_subbuf;
-			tip->flush_subbuf = flush_subbuf_net;
-		}
-	} else {
-		if (tip->ofile_mmap)
-			tip->get_subbuf = mmap_subbuf;
-		else
-			tip->get_subbuf = get_subbuf;
-
-		tip->flush_subbuf = flush_subbuf_file;
-	}
-			
-	if (net_mode == Net_server)
-		tip->read_data = read_data_net;
-	else
-		tip->read_data = read_data_file;
-}
-
-static int tip_open_output(struct device_information *dip,
-			   struct thread_information *tip)
-{
-	int pipeline = output_name && !strcmp(output_name, "-");
-	int mode, vbuf_size;
-	char op[128];
-
-	if (net_mode == Net_client) {
-		tip->ofile = NULL;
-		tip->ofile_stdout = 0;
-		tip->ofile_mmap = 0;
-		goto done;
-	} else if (pipeline) {
-		tip->ofile = fdopen(STDOUT_FILENO, "w");
-		tip->ofile_stdout = 1;
-		tip->ofile_mmap = 0;
-		mode = _IOLBF;
-		vbuf_size = 512;
-	} else {
-		if (fill_ofname(dip, tip, op, dip->buts_name))
-			return 1;
-		tip->ofile = fopen(op, "w+");
-		tip->ofile_stdout = 0;
-		tip->ofile_mmap = 1;
-		mode = _IOFBF;
-		vbuf_size = OFILE_BUF;
-	}
-
-	if (tip->ofile == NULL) {
-		perror(op);
+	iop->obuf = malloc(size);
+	if (setvbuf(iop->ofp, iop->obuf, mode, size) < 0) {
+		fprintf(stderr, "setvbuf(%s, %d) failed: %d/%s\n",
+			iop->dpp->path, (int)size, errno,
+			strerror(errno));
+		free(iop->obuf);
 		return 1;
 	}
 
-	tip->ofile_buffer = malloc(vbuf_size);
-	if (setvbuf(tip->ofile, tip->ofile_buffer, mode, vbuf_size)) {
-		perror("setvbuf");
-		close_thread(tip);
-		return 1;
-	}
-
-done:
-	fill_ops(tip);
 	return 0;
 }
 
-static int start_threads(struct device_information *dip)
+static int iop_open(struct io_info *iop, int cpu)
 {
-	struct thread_information *tip;
-	int j;
-
-	for_each_tip(dip, tip, j) {
-		tip->cpu = j;
-		tip->device = dip;
-		tip->events_processed = 0;
-		tip->fd = -1;
-		memset(&tip->fifo, 0, sizeof(tip->fifo));
-		tip->leftover_ts = NULL;
-
-		if (tip_open_output(dip, tip))
-			return 1;
+	iop->ofd = -1;
+	if (fill_ofname(iop, cpu))
+		return 1;
 
-		if (pthread_create(&tip->thread, NULL, thread_main, tip)) {
-			perror("pthread_create");
-			close_thread(tip);
-			return 1;
-		}
+	iop->ofp = my_fopen(iop->ofn, "w+");
+	if (iop->ofp == NULL) {
+		fprintf(stderr, "Open output file %s failed: %d/%s\n",
+			iop->ofn, errno, strerror(errno));
+		return 1;
+	}
+	if (set_vbuf(iop, _IOLBF, FILE_VBUF_SIZE)) {
+		fprintf(stderr, "set_vbuf for file %s failed: %d/%s\n",
+			iop->ofn, errno, strerror(errno));
+		fclose(iop->ofp);
+		return 1;
 	}
 
+	iop->ofd = fileno(iop->ofp);
 	return 0;
 }
 
-static void stop_threads(struct device_information *dip)
+static int open_ios(struct tracer *tp)
 {
-	struct thread_information *tip;
-	unsigned long ret;
 	int i;
+	struct pollfd *pfd;
+	struct io_info *iop;
+	struct list_head *p;
+
+	i = 0;
+	tp->ios = calloc(ndevs, sizeof(struct io_info));
+	tp->pfds = calloc(ndevs, sizeof(struct pollfd));
+
+	memset(tp->ios, 0, ndevs * sizeof(struct io_info));
+	memset(tp->pfds, 0, ndevs * sizeof(struct pollfd));
+
+	tp->nios = 0;
+	iop = tp->ios;
+	pfd = tp->pfds;
+	__list_for_each(p, &devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+
+		iop->dpp = dpp;
+		iop->ofd = -1;
+		snprintf(iop->ifn, sizeof(iop->ifn), "%s/block/%s/trace%d",
+			debugfs_path, dpp->buts_name, tp->cpu);
+
+		iop->ifd = my_open(iop->ifn, O_RDONLY | O_NONBLOCK);
+		if (iop->ifd < 0) {
+			fprintf(stderr, "Thread %d failed open %s: %d/%s\n",
+				tp->cpu, iop->ifn, errno, strerror(errno));
+			return 1;
+		}
+
+		init_mmap_info(&iop->mmap_info);
+
+		pfd->fd = iop->ifd;
+		pfd->events = POLLIN;
+
+		if (piped_output) {
+			iop->ofp = fdopen(STDOUT_FILENO, "w");
+			if (set_vbuf(iop, _IOLBF, 512))
+				goto err;
+		} else if (net_client_use_sendfile()) {
+			iop->ofd = net_setup_client();
+			if (iop->ofd < 0)
+				goto err;
+			net_send_open(iop->ofd, tp->cpu, dpp->buts_name);
+		} else if (net_mode == Net_none) {
+			if (iop_open(iop, tp->cpu))
+				goto err;
+		} else {
+			/*
+			 * This ensures that the server knows about all
+			 * connections & devices before _any_ closes
+			 */
+			net_send_open(cl_fds[tp->cpu], tp->cpu, dpp->buts_name);
+		}
 
-	for_each_tip(dip, tip, i) {
-		(void) pthread_join(tip->thread, (void *) &ret);
-		close_thread(tip);
+		pfd++;
+		iop++;
+		tp->nios++;
 	}
-}
 
-static void stop_all_threads(void)
-{
-	struct device_information *dip;
-	int i;
+	return 0;
 
-	for_each_dip(dip, i)
-		stop_threads(dip);
+err:
+	close(iop->ifd);	/* tp->nios _not_ bumped */
+	return 1;
 }
 
-static void stop_all_tracing(void)
+static void close_iop(struct io_info *iop)
 {
-	struct device_information *dip;
-	int i;
+	struct mmap_info *mip = &iop->mmap_info;
 
-	for_each_dip(dip, i)
-		stop_trace(dip);
-}
+	if (mip->fs_buf)
+		munmap(mip->fs_buf, mip->fs_buf_len);
 
-static void exit_trace(int status)
-{
-	if (!is_trace_stopped()) {
-		trace_stopped = 1;
-		stop_all_threads();
-		stop_all_tracing();
-	}
+	if (ftruncate(fileno(iop->ofp), mip->fs_size) < 0)
+		fprintf(stderr,
+			"Ignoring err: ftruncate(%s): %d/%s\n",
+			iop->ofn, errno, strerror(errno));
 
-	exit(status);
+	if (!piped_output)
+		fclose(iop->ofp);
+
+	if (iop->obuf)
+		free(iop->obuf);
 }
 
-static int resize_devices(char *path)
+static void close_ios(struct tracer *tp)
 {
-	int size = (ndevs + 1) * sizeof(struct device_information);
+	while (tp->nios > 0) {
+		struct io_info *iop = &tp->ios[--tp->nios];
 
-	device_information = realloc(device_information, size);
-	if (!device_information) {
-		fprintf(stderr, "Out of memory, device %s (%d)\n", path, size);
-		return 1;
-	}
-	device_information[ndevs].path = path;
-	ndevs++;
-	return 0;
-}
+		iop->dpp->drops = get_drops(iop->dpp);
+		if (iop->ifd >= 0)
+			close(iop->ifd);
 
-static int open_devices(void)
-{
-	struct device_information *dip;
-	int i;
+		if (iop->ofp)
+			close_iop(iop);
+		else if (iop->ofd >= 0) {
+			struct devpath *dpp = iop->dpp;
 
-	for_each_dip(dip, i) {
-		dip->fd = open(dip->path, O_RDONLY | O_NONBLOCK);
-		if (dip->fd < 0) {
-			perror(dip->path);
-			return 1;
+			net_send_close(iop->ofd, dpp->buts_name, dpp->drops);
+			net_close_connection(&iop->ofd);
 		}
-		dip->buf_size = buf_size;
-		dip->buf_nr = buf_nr;
-		dip->page_size = page_size;
 	}
 
-	return 0;
+	free(tp->ios);
+	free(tp->pfds);
 }
 
-static int start_devices(void)
+static int setup_mmap(int fd, unsigned int maxlen, struct mmap_info *mip)
 {
-	struct device_information *dip;
-	int i, j, size;
-
-	size = ncpus * sizeof(struct thread_information);
-	thread_information = malloc(size * ndevs);
-	if (!thread_information) {
-		fprintf(stderr, "Out of memory, threads (%d)\n", size * ndevs);
-		return 1;
-	}
-	memset(thread_information, 0, size * ndevs);
+	if (mip->fs_off + maxlen > mip->fs_buf_len) {
+		unsigned long nr = max(16, mip->buf_nr);
 
-	for_each_dip(dip, i) {
-		if (start_trace(dip)) {
-			close(dip->fd);
-			fprintf(stderr, "Failed to start trace on %s\n",
-				dip->path);
-			break;
+		if (mip->fs_buf) {
+			munlock(mip->fs_buf, mip->fs_buf_len);
+			munmap(mip->fs_buf, mip->fs_buf_len);
+			mip->fs_buf = NULL;
 		}
-	}
 
-	if (i != ndevs) {
-		__for_each_dip(dip, device_information, i, j)
-			stop_trace(dip);
+		mip->fs_off = mip->fs_size & (mip->pagesize - 1);
+		mip->fs_buf_len = (nr * mip->buf_size) - mip->fs_off;
+		mip->fs_max_size += mip->fs_buf_len;
 
-		return 1;
-	}
-
-	for_each_dip(dip, i) {
-		dip->threads = thread_information + (i * ncpus);
-		if (start_threads(dip)) {
-			fprintf(stderr, "Failed to start worker threads\n");
-			break;
+		if (ftruncate(fd, mip->fs_max_size) < 0) {
+			perror("__setup_mmap: ftruncate");
+			return 1;
 		}
-	}
-
-	if (i != ndevs) {
-		__for_each_dip(dip, device_information, i, j)
-			stop_threads(dip);
-		for_each_dip(dip, i)
-			stop_trace(dip);
 
-		return 1;
+		mip->fs_buf = my_mmap(NULL, mip->fs_buf_len, PROT_WRITE,
+				      MAP_SHARED, fd,
+				      mip->fs_size - mip->fs_off);
+		if (mip->fs_buf == MAP_FAILED) {
+			perror("__setup_mmap: mmap");
+			return 1;
+		}
+		my_mlock(mip->fs_buf, mip->fs_buf_len);
 	}
 
 	return 0;
 }
 
-static void show_stats(struct device_information *dips, int ndips, int cpus)
+static int handle_pfds_file(struct tracer *tp, int nevs, int force_read)
 {
-	struct device_information *dip;
-	struct thread_information *tip;
-	unsigned long long events_processed, data_read;
-	unsigned long total_drops;
-	int i, j, no_stdout = 0;
-
-	if (is_stat_shown())
-		return;
-
-	if (output_name && !strcmp(output_name, "-"))
-		no_stdout = 1;
-
-	stat_shown = 1;
+	struct mmap_info *mip;
+	int i, ret, nentries = 0;
+	struct pollfd *pfd = tp->pfds;
+	struct io_info *iop = tp->ios;
+
+	for (i = 0; nevs > 0 && i < ndevs; i++, pfd++, iop++) {
+		if (pfd->revents & POLLIN || force_read) {
+			mip = &iop->mmap_info;
+
+			ret = setup_mmap(iop->ofd, buf_size, mip);
+			if (ret < 0) {
+				pfd->events = 0;
+				break;
+			}
 
-	total_drops = 0;
-	__for_each_dip(dip, dips, ndips, i) {
-		if (!no_stdout)
-			printf("Device: %s\n", dip->path);
-		events_processed = 0;
-		data_read = 0;
-		__for_each_tip(dip, tip, cpus, j) {
-			if (!no_stdout)
-				printf("  CPU%3d: %20lu events, %8llu KiB data\n",
-			       		tip->cpu, tip->events_processed,
-					(tip->data_read + 1023) >> 10);
-			events_processed += tip->events_processed;
-			data_read += tip->data_read;
+			ret = read(iop->ifd, mip->fs_buf + mip->fs_off,
+				   buf_size);
+			if (ret > 0) {
+				pdc_dr_update(iop->dpp, tp->cpu, ret);
+				mip->fs_size += ret;
+				mip->fs_off += ret;
+				nentries++;
+			} else if (ret == 0) {
+				/*
+				 * Short reads after we're done stop us
+				 * from trying reads.
+				 */
+				if (tp->is_done)
+					clear_events(pfd);
+			} else {
+				read_err(tp->cpu, iop->ifn);
+				if (errno != EAGAIN || tp->is_done)
+					clear_events(pfd);
+			}
+			nevs--;
 		}
-		total_drops += dip->drop_count;
-		if (!no_stdout)
-			printf("  Total:  %20llu events (dropped %lu), %8llu KiB data\n",
-					events_processed, dip->drop_count,
-					(data_read + 1023) >> 10);
 	}
 
-	if (total_drops)
-		fprintf(stderr, "You have dropped events, consider using a larger buffer size (-b)\n");
+	return nentries;
 }
 
-static struct device_information *net_get_dip(struct net_connection *nc,
-					      struct blktrace_net_hdr *bnh)
+static void *thread_main(void *arg)
 {
-	struct device_information *dip, *cl_dip = NULL;
-	struct cl_host *ch = nc->ch;
-	int i;
+	int ret, ndone;
+	int to_val;
 
-	for (i = 0; i < ch->ndevs; i++) {
-		dip = &ch->device_information[i];
+	struct tracer *tp = arg;
 
-		if (!strcmp(dip->buts_name, bnh->buts_name))
-			return dip;
+	ret = lock_on_cpu(tp->cpu);
+	if (ret)
+		goto err;
 
-		if (dip->cl_id == bnh->cl_id)
-			cl_dip = dip;
+	ret = open_ios(tp);
+	if (ret) {
+		close_ios(tp);
+		goto err;
 	}
 
-	ch->device_information = realloc(ch->device_information, (ch->ndevs + 1) * sizeof(*dip));
-	dip = &ch->device_information[ch->ndevs];
-	memset(dip, 0, sizeof(*dip));
-	dip->fd = -1;
-	dip->ch = ch;
-	dip->cl_id = bnh->cl_id;
-	dip->buf_size = bnh->buf_size;
-	dip->buf_nr = bnh->buf_nr;
-	dip->page_size = bnh->page_size;
+	pthread_mutex_lock(&tp->mutex);
+	tp->running = 1;
+	pthread_cond_signal(&tp->cond);
+	pthread_mutex_unlock(&tp->mutex);
 
-	if (cl_dip)
-		dip->cl_connect_time = cl_dip->cl_connect_time;
+	if (piped_output)
+		to_val = 50;		/* Frequent partial handles */
 	else
-		dip->cl_connect_time = nc->connect_time;
-	strcpy(dip->buts_name, bnh->buts_name);
-	dip->path = strdup(bnh->buts_name);
-	dip->trace_started = 1;
-	ch->ndevs++;
-	dip->threads = malloc(nc->ncpus * sizeof(struct thread_information));
-	memset(dip->threads, 0, nc->ncpus * sizeof(struct thread_information));
+		to_val = 500;		/* 1/2 second intervals */
+
+	while (!tp->is_done) {
+		ndone = poll(tp->pfds, ndevs, to_val);
+		if (ndone || piped_output)
+			(void)handle_pfds(tp, ndone, piped_output);
+		else if (ndone < 0 && errno != EINTR)
+			fprintf(stderr, "Thread %d poll failed: %d/%s\n",
+				tp->cpu, errno, strerror(errno));
+	}
 
 	/*
-	 * open all files
+	 * Trace is stopped, pull data until we get a short read
 	 */
-	for (i = 0; i < nc->ncpus; i++) {
-		struct thread_information *tip = &dip->threads[i];
+	while (handle_pfds(tp, ndevs, 1) > 0)
+		;
 
-		tip->cpu = i;
-		tip->device = dip;
-		tip->fd = -1;
-		tip->nc = nc;
-		
-		if (tip_open_output(dip, tip))
-			return NULL;
+	close_ios(tp);
 
-		tip->nc = NULL;
-	}
-
-	return dip;
+err:
+	pthread_mutex_lock(&tp->mutex);
+	tp->running = 0;
+	tp->status = ret;
+	pthread_cond_signal(&tp->cond);
+	pthread_mutex_unlock(&tp->mutex);
+	return NULL;
 }
 
-static struct thread_information *net_get_tip(struct net_connection *nc,
-					      struct blktrace_net_hdr *bnh)
+static int start_tracer(int cpu)
 {
-	struct device_information *dip;
-	struct thread_information *tip;
+	struct tracer *tp;
 
-	dip = net_get_dip(nc, bnh);
-	if (!dip->trace_started) {
-		fprintf(stderr, "Events for closed devices %s\n", dip->buts_name);
-		return NULL;
-	}
+	tp = malloc(sizeof(*tp));
+	memset(tp, 0, sizeof(*tp));
 
-	tip = &dip->threads[bnh->cpu];
-	if (!tip->nc)
-		tip->nc = nc;
-	
-	return tip;
-}
-
-static int net_get_header(struct net_connection *nc,
-			  struct blktrace_net_hdr *bnh)
-{
-	int fl = fcntl(nc->in_fd, F_GETFL);
-	int bytes_left, ret;
-	void *p = bnh;
+	INIT_LIST_HEAD(&tp->head);
+	pthread_mutex_init(&tp->mutex, NULL);
+	pthread_cond_init(&tp->cond, NULL);
+	tp->running = 0;
+	tp->status = 0;
+	tp->cpu = cpu;
 
-	fcntl(nc->in_fd, F_SETFL, fl | O_NONBLOCK);
-	bytes_left = sizeof(*bnh);
-	while (bytes_left && !is_done()) {
-		ret = recv(nc->in_fd, p, bytes_left, MSG_WAITALL);
-		if (ret < 0) {
-			if (errno != EAGAIN) {
-				perror("recv header");
-				return 1;
-			}
-			usleep(1000);
-			continue;
-		} else if (!ret) {
-			usleep(1000);
-			continue;
-		} else {
-			p += ret;
-			bytes_left -= ret;
-		}
+	if (pthread_create(&tp->thread, NULL, thread_main, tp)) {
+		fprintf(stderr, "FAILED to start thread on CPU %d: %d/%s\n",
+			cpu, errno, strerror(errno));
+		goto err;
 	}
-	fcntl(nc->in_fd, F_SETFL, fl & ~O_NONBLOCK);
-	return bytes_left;
-}
-
-/*
- * finalize a net client: truncate files, show stats, cleanup, etc
- */
-static void device_done(struct net_connection *nc, struct device_information *dip)
-{
-	struct thread_information *tip;
-	int i;
-
-	__for_each_tip(dip, tip, nc->ncpus, i)
-		tip_ftrunc_final(tip);
 
-	show_stats(dip, 1, nc->ncpus);
+	pthread_mutex_lock(&tp->mutex);
+	while (!tp->running && (tp->status == 0))
+		pthread_cond_wait(&tp->cond, &tp->mutex);
+	pthread_mutex_unlock(&tp->mutex);
 
-	/*
-	 * cleanup for next run
-	 */
-	__for_each_tip(dip, tip, nc->ncpus, i) {
-		if (tip->ofile)
-			fclose(tip->ofile);
+	if (tp->status == 0) {
+		list_add_tail(&tp->head, &tracers);
+		return 0;
 	}
 
-	free(dip->threads);
-	free(dip->path);
-
-	close(nc->in_fd);
-	nc->in_fd = -1;
-
-	stat_shown = 0;
-}
-
-static inline int in_addr_eq(struct in_addr a, struct in_addr b)
-{
-	return a.s_addr == b.s_addr;
-}
+	fprintf(stderr, "FAILED to start thread on CPU %d: %d/%s\n",
+		tp->cpu, tp->status, strerror(tp->status));
 
-static void net_add_client_host(struct cl_host *ch)
-{
-	ch->list_next = cl_host_list;
-	cl_host_list = ch;
-	cl_hosts++;
-}
-
-static void net_remove_client_host(struct cl_host *ch)
-{
-	struct cl_host *p, *c;
-	
-	for (p = c = cl_host_list; c; c = c->list_next) {
-		if (c == ch) {
-			if (p == c)
-				cl_host_list = c->list_next;
-			else
-				p->list_next = c->list_next;
-			cl_hosts--;
-			return;
-		}
-		p = c;
-	}
+err:
+	pthread_mutex_destroy(&tp->mutex);
+	pthread_cond_destroy(&tp->cond);
+	free(tp);
+	return 1;
 }
 
-static struct cl_host *net_find_client_host(struct in_addr cl_in_addr)
+static int start_tracers(void)
 {
-	struct cl_host *ch = cl_host_list;
-
-	while (ch) {
-		if (in_addr_eq(ch->cl_in_addr, cl_in_addr))
-			return ch;
-		ch = ch->list_next;
-	}
+	int cpu;
 
-	return NULL;
-}
+	for (cpu = 0; cpu < ncpus; cpu++)
+		if (start_tracer(cpu))
+			break;
 
-static void net_client_host_done(struct cl_host *ch)
-{
-	free(ch->device_information);
-	free(ch->net_connections);
-	net_connects -= ch->nconn;
-	net_remove_client_host(ch);
-	free(ch);
+	return cpu;
 }
 
-/*
- * handle incoming events from a net client
- */
-static int net_client_data(struct net_connection *nc)
+static void stop_tracers(void)
 {
-	struct thread_information *tip;
-	struct blktrace_net_hdr bnh;
-
-	if (net_get_header(nc, &bnh))
-		return 1;
+	struct list_head *p;
 
-	if (data_is_native == -1 && check_data_endianness(bnh.magic)) {
-		fprintf(stderr, "server: received data is bad\n");
-		return 1;
-	}
-
-	if (!data_is_native) {
-		bnh.magic = be32_to_cpu(bnh.magic);
-		bnh.cpu = be32_to_cpu(bnh.cpu);
-		bnh.max_cpus = be32_to_cpu(bnh.max_cpus);
-		bnh.len = be32_to_cpu(bnh.len);
-		bnh.cl_id = be32_to_cpu(bnh.cl_id);
-		bnh.buf_size = be32_to_cpu(bnh.buf_size);
-		bnh.buf_nr = be32_to_cpu(bnh.buf_nr);
-		bnh.page_size = be32_to_cpu(bnh.page_size);
-	}
-
-	if ((bnh.magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
-		fprintf(stderr, "server: bad data magic\n");
-		return 1;
+	/*
+	 * Stop the tracing - makes the tracer threads clean up quicker.
+	 */
+	__list_for_each(p, &devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+		(void)ioctl(dpp->fd, BLKTRACESTOP);
 	}
 
-	if (nc->ncpus == -1)
-		nc->ncpus = bnh.max_cpus;
-
 	/*
-	 * len == 0 means that the other end signalled end-of-run
+	 * Tell each tracer to quit
 	 */
-	if (!bnh.len) {
-		/*
-		 * overload cpu count with dropped events
-		 */
-		struct device_information *dip;
-
-		dip = net_get_dip(nc, &bnh);
-		dip->drop_count = bnh.cpu;
-		dip->trace_started = 0;
-
-		printf("server: end of run for %s\n", dip->buts_name);
-
-		device_done(nc, dip);
-
-		if (++nc->ch->ndevs_done == nc->ch->ndevs)
-			net_client_host_done(nc->ch);
-
-		return 0;
+	__list_for_each(p, &tracers) {
+		struct tracer *tp = list_entry(p, struct tracer, head);
+		tp->is_done = 1;
 	}
-
-	tip = net_get_tip(nc, &bnh);
-	if (!tip)
-		return 1;
-
-	if (mmap_subbuf(tip, bnh.len))
-		return 1;
-
-	return 0;
 }
 
-static void net_add_connection(int listen_fd, struct sockaddr_in *addr)
+static void del_tracers(void)
 {
-	socklen_t socklen = sizeof(*addr);
-	struct net_connection *nc;
-	struct cl_host *ch;
-	int in_fd;
+	struct list_head *p, *q;
 
-	in_fd = accept(listen_fd, (struct sockaddr *) addr, &socklen);
-	if (in_fd < 0) {
-		perror("accept");
-		return;
-	}
+	list_for_each_safe(p, q, &tracers) {
+		struct tracer *tp = list_entry(p, struct tracer, head);
 
-	ch = net_find_client_host(addr->sin_addr);
-	if (!ch) {
-		if (cl_hosts == NET_MAX_CL_HOSTS) {
-			fprintf(stderr, "server: no more clients allowed\n");
-			return;
-		}
-		ch = malloc(sizeof(struct cl_host));
-		memset(ch, 0, sizeof(*ch));
-		ch->cl_in_addr = addr->sin_addr;
-		net_add_client_host(ch);
-
-		printf("server: connection from %s\n", inet_ntoa(addr->sin_addr));
+		list_del(&tp->head);
+		free(tp);
 	}
-
-	ch->net_connections = realloc(ch->net_connections, (ch->nconn + 1) * sizeof(*nc));
-	nc = &ch->net_connections[ch->nconn++];
-	memset(nc, 0, sizeof(*nc));
-
-	time(&nc->connect_time);
-	nc->ch = ch;
-	nc->in_fd = in_fd;
-	nc->ncpus = -1;
-	net_connects++;
+	ntracers = 0;
 }
 
-/*
- * event driven loop, handle new incoming connections and data from
- * existing connections
- */
-static void net_server_handle_connections(int listen_fd,
-					  struct sockaddr_in *addr)
+static void wait_tracers(void)
 {
-	struct pollfd *pfds = NULL;
-	struct net_connection **ncs = NULL;
-	int max_connects = 0;
-	int i, nconns, events;
-	struct cl_host *ch;
-	struct net_connection *nc;
-	
-	printf("server: waiting for connections...\n");
-
-	while (!is_done()) {
-		if (net_connects >= max_connects) {
-			pfds = realloc(pfds, (net_connects + 1) * sizeof(*pfds));
-			ncs = realloc(ncs, (net_connects + 1) * sizeof(*ncs));
-			max_connects = net_connects + 1;
-		}
-		/*
-		 * the zero entry is for incoming connections, remaining
-		 * entries for clients
-		 */
-		pfds[0].fd = listen_fd;
-		pfds[0].events = POLLIN;
-		nconns = 0;
-		for_each_cl_host(ch) {
-			for (i = 0; i < ch->nconn; i++) {
-				nc = &ch->net_connections[i];
-				pfds[nconns + 1].fd = nc->in_fd;
-				pfds[nconns + 1].events = POLLIN;
-				ncs[nconns++] = nc;
-			}
-		}
+	struct list_head *p;
 
-		events = poll(pfds, 1 + nconns, -1);
-		if (events < 0) {
-			if (errno == EINTR)
-				continue;
+	if (use_tracer_devpaths())
+		process_trace_bufs();
 
-			perror("poll");
-			break;
-		} else if (!events)
-			continue;
+	__list_for_each(p, &tracers) {
+		int ret;
+		struct tracer *tp = list_entry(p, struct tracer, head);
 
-		if (pfds[0].revents & POLLIN) {
-			net_add_connection(listen_fd, addr);
-			events--;
-		}
+		pthread_mutex_lock(&tp->mutex);
+		while (tp->running)
+			pthread_cond_wait(&tp->cond, &tp->mutex);
+		pthread_mutex_unlock(&tp->mutex);
 
-		for (i = 0; events && i < nconns; i++) {
-			if (pfds[i + 1].revents & POLLIN) {
-				net_client_data(ncs[i]);
-				events--;
-			}
-		}
+		ret = pthread_join(tp->thread, NULL);
+		if (ret)
+			fprintf(stderr, "Thread join %d failed %d\n",
+				tp->cpu, ret);
 	}
-}
 
-/*
- * Start here when we are in server mode - just fetch data from the network
- * and dump to files
- */
-static int net_server(void)
-{
-	struct sockaddr_in addr;
-	int fd, opt;
+	if (use_tracer_devpaths())
+		clean_trace_bufs();
 
-	fd = socket(AF_INET, SOCK_STREAM, 0);
-	if (fd < 0) {
-		perror("server: socket");
-		return 1;
-	}
-
-	opt = 1;
-	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt)) < 0) {
-		perror("setsockopt");
-		return 1;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sin_family = AF_INET;
-	addr.sin_addr.s_addr = htonl(INADDR_ANY);
-	addr.sin_port = htons(net_port);
-
-	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		perror("bind");
-		return 1;
-	}
-
-	if (listen(fd, 1) < 0) {
-		perror("listen");
-		return 1;
-	}
+	get_all_drops();
+}
 
-	net_server_handle_connections(fd, &addr);
-	return 0;
+static void exit_tracing(void)
+{
+	signal(SIGINT, SIG_IGN);
+	signal(SIGHUP, SIG_IGN);
+	signal(SIGTERM, SIG_IGN);
+	signal(SIGALRM, SIG_IGN);
+
+	stop_tracers();
+	wait_tracers();
+	del_tracers();
+	rel_devpaths();
 }
 
-/*
- * Setup outgoing network connection where we will transmit data
- */
-static int net_setup_client_cpu(int i, struct sockaddr_in *addr)
+static void handle_sigint(__attribute__((__unused__)) int sig)
 {
-	int fd;
+	done = 1;
+	stop_tracers();
+}
 
-	fd = socket(AF_INET, SOCK_STREAM, 0);
-	if (fd < 0) {
-		perror("client: socket");
-		return 1;
-	}
+static void show_stats(struct list_head *devpaths)
+{
+	FILE *ofp;
+	struct list_head *p;
+	unsigned long long nevents, data_read;
+	unsigned long long total_drops = 0;
+	unsigned long long total_events = 0;
+
+	if (piped_output)
+		ofp = my_fopen("/dev/null", "w");
+	else
+		ofp = stdout;
 
-	if (connect(fd, (struct sockaddr *) addr, sizeof(*addr)) < 0) {
-		perror("client: connect");
-		return 1;
-	}
+	__list_for_each(p, devpaths) {
+		int cpu;
+		struct pdc_stats *sp;
+		struct devpath *dpp = list_entry(p, struct devpath, head);
 
-	net_out_fd[i] = fd;
-	return 0;
-}
+		if (net_mode == Net_server)
+			printf("server: end of run for %s:%s\n",
+				dpp->ch->hostname, dpp->buts_name);
 
-static int net_setup_client(void)
-{
-	struct sockaddr_in addr;
-	int i;
+		data_read = 0;
+		nevents = 0;
+
+		fprintf(ofp, "=== %s ===\n", dpp->buts_name);
+		for (cpu = 0, sp = dpp->stats; cpu < dpp->ncpus; cpu++, sp++) {
+			/*
+			 * Estimate events if not known...
+			 */
+			if (sp->nevents == 0) {
+				sp->nevents = sp->data_read /
+						sizeof(struct blk_io_trace);
+			}
 
-	memset(&addr, 0, sizeof(addr));
-	addr.sin_family = AF_INET;
-	addr.sin_port = htons(net_port);
+			fprintf(ofp,
+				"  CPU%3d: %20llu events, %8llu KiB data\n",
+				cpu, sp->nevents, (sp->data_read + 1023) >> 10);
 
-	if (inet_aton(hostname, &addr.sin_addr) != 1) {
-		struct hostent *hent = gethostbyname(hostname);
-		if (!hent) {
-			perror("gethostbyname");
-			return 1;
+			data_read += sp->data_read;
+			nevents += sp->nevents;
 		}
 
-		memcpy(&addr.sin_addr, hent->h_addr, 4);
-		strcpy(hostname, hent->h_name);
-	}
-
-	printf("blktrace: connecting to %s\n", hostname);
+		fprintf(ofp, "  Total:  %20llu events (dropped %llu),"
+			     " %8llu KiB data\n", nevents,
+			     dpp->drops, (data_read + 1024) >> 10);
 
-	net_out_fd = malloc(ncpus * sizeof(*net_out_fd));
-	for (i = 0; i < ncpus; i++) {
-		if (net_setup_client_cpu(i, &addr))
-			return 1;
+		total_drops += dpp->drops;
+		total_events += (nevents + dpp->drops);
 	}
 
-	printf("blktrace: connected!\n");
-	
-	return 0;
-}
+	fflush(ofp);
+	if (piped_output)
+		fclose(ofp);
 
-static char usage_str[] = \
-	"-d <dev> [ -r debugfs path ] [ -o <output> ] [-k ] [ -w time ]\n" \
-	"[ -a action ] [ -A action mask ] [ -I  <devs file> ] [ -v ]\n\n" \
-	"\t-d Use specified device. May also be given last after options\n" \
-	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
-	"\t-o File(s) to send output to\n" \
-	"\t-D Directory to prepend to output file names\n" \
-	"\t-k Kill a running trace\n" \
-	"\t-w Stop after defined time, in seconds\n" \
-	"\t-a Only trace specified actions. See documentation\n" \
-	"\t-A Give trace mask as a single value. See documentation\n" \
-	"\t-b Sub buffer size in KiB\n" \
-	"\t-n Number of sub buffers\n" \
-	"\t-l Run in network listen mode (blktrace server)\n" \
-	"\t-h Run in network client mode, connecting to the given host\n" \
-	"\t-p Network port to use (default 8462)\n" \
-	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
-	"\t-I Add devices found in <devs file>\n" \
-	"\t-V Print program version info\n\n";
+	if (total_drops) {
+		double drops_ratio = 1.0;
 
-static void show_usage(char *program)
-{
-	fprintf(stderr, "Usage: %s %s %s",program, blktrace_version, usage_str);
+		if (total_events)
+			drops_ratio = (double)total_drops/(double)total_events;
+
+		fprintf(stderr, "\nYou have %llu (%5.1lf%%) dropped events\n"
+				"Consider using a larger buffer size (-b) "
+				"and/or more buffers (-n)\n",
+			total_drops, 100.0 * drops_ratio);
+	}
 }
 
-int main(int argc, char *argv[])
+static int handle_args(int argc, char *argv[])
 {
-	static char default_debugfs_path[] = "/sys/kernel/debug";
+	int c, i;
 	struct statfs st;
-	int i, c;
-	int stop_watch = 0;
 	int act_mask_tmp = 0;
 
 	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) >= 0) {
@@ -1846,7 +1863,7 @@ int main(int argc, char *argv[])
 		case 'a':
 			i = find_mask_map(optarg);
 			if (i < 0) {
-				fprintf(stderr,"Invalid action mask %s\n",
+				fprintf(stderr, "Invalid action mask %s\n",
 					optarg);
 				return 1;
 			}
@@ -1854,7 +1871,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'A':
-			if ((sscanf(optarg, "%x", &i) != 1) || 
+			if ((sscanf(optarg, "%x", &i) != 1) ||
 							!valid_act_opt(i)) {
 				fprintf(stderr,
 					"Invalid set action mask %s/0x%x\n",
@@ -1865,27 +1882,26 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'd':
-			if (resize_devices(optarg) != 0)
+			if (add_devpath(optarg) != 0)
 				return 1;
 			break;
 
 		case 'I': {
 			char dev_line[256];
-			FILE *ifp = fopen(optarg, "r");
+			FILE *ifp = my_fopen(optarg, "r");
 
 			if (!ifp) {
-				fprintf(stderr, 
-				        "Invalid file for devices %s\n", 
+				fprintf(stderr,
+					"Invalid file for devices %s\n",
 					optarg);
 				return 1;
 			}
 
 			while (fscanf(ifp, "%s\n", dev_line) == 1)
-				if (resize_devices(strdup(dev_line)) != 0)
+				if (add_devpath(dev_line) != 0)
 					return 1;
 			break;
 		}
-			
 
 		case 'r':
 			debugfs_path = optarg;
@@ -1909,12 +1925,13 @@ int main(int argc, char *argv[])
 		case 'V':
 		case 'v':
 			printf("%s version %s\n", argv[0], blktrace_version);
-			return 0;
+			exit(0);
+			/*NOTREACHED*/
 		case 'b':
 			buf_size = strtoul(optarg, NULL, 10);
 			if (buf_size <= 0 || buf_size > 16*1024) {
-				fprintf(stderr,
-					"Invalid buffer size (%lu)\n",buf_size);
+				fprintf(stderr, "Invalid buffer size (%lu)\n",
+					buf_size);
 				return 1;
 			}
 			buf_size <<= 10;
@@ -1945,65 +1962,473 @@ int main(int argc, char *argv[])
 			break;
 		default:
 			show_usage(argv[0]);
-			return 1;
+			exit(1);
+			/*NOTREACHED*/
 		}
 	}
 
-	setlocale(LC_NUMERIC, "en_US");
+	while (optind < argc)
+		if (add_devpath(argv[optind++]) != 0)
+			return 1;
 
-	page_size = getpagesize();
+	if (net_mode != Net_server && ndevs == 0) {
+		show_usage(argv[0]);
+		return 1;
+	}
 
-	if (net_mode == Net_server) {
-		if (output_name) {
-			fprintf(stderr, "-o ignored in server mode\n");
-			output_name = NULL;
-		}
+	if (statfs(debugfs_path, &st) < 0 || st.f_type != (long)DEBUGFS_TYPE) {
+		fprintf(stderr, "Invalid debug path %s: %d/%s\n",
+			debugfs_path, errno, strerror(errno));
+		return 1;
+	}
+
+	if (act_mask_tmp != 0)
+		act_mask = act_mask_tmp;
+
+	/*
+	 * Set up for appropriate PFD handler based upon output name.
+	 */
+	if (net_client_use_sendfile())
+		handle_pfds = handle_pfds_netclient;
+	else if (net_client_use_send())
+		handle_pfds = handle_pfds_entries;
+	else if (output_name && (strcmp(output_name, "-") == 0)) {
+		piped_output = 1;
+		handle_pfds = handle_pfds_entries;
+		pfp = stdout;
+	} else
+		handle_pfds = handle_pfds_file;
+	return 0;
+}
+
+static void ch_add_connection(struct net_server_s *ns, struct cl_host *ch,
+			      int fd)
+{
+	struct cl_conn *nc;
+
+	nc = malloc(sizeof(*nc));
+	memset(nc, 0, sizeof(*nc));
+
+	time(&nc->connect_time);
+	nc->ch = ch;
+	nc->fd = fd;
+	nc->ncpus = -1;
+
+	list_add_tail(&nc->ch_head, &ch->conn_list);
+	ch->connects++;
+
+	list_add_tail(&nc->ns_head, &ns->conn_list);
+	ns->connects++;
+	ns->pfds = realloc(ns->pfds, (ns->connects+1) * sizeof(struct pollfd));
+}
+
+static void ch_rem_connection(struct net_server_s *ns, struct cl_host *ch,
+			      struct cl_conn *nc)
+{
+	net_close_connection(&nc->fd);
+
+	list_del(&nc->ch_head);
+	ch->connects--;
+
+	list_del(&nc->ns_head);
+	ns->connects--;
+	ns->pfds = realloc(ns->pfds, (ns->connects+1) * sizeof(struct pollfd));
+
+	free(nc);
+}
 
-		return net_server();
+static struct cl_host *net_find_client_host(struct net_server_s *ns,
+					    struct in_addr cl_in_addr)
+{
+	struct list_head *p;
+
+	__list_for_each(p, &ns->ch_list) {
+		struct cl_host *ch = list_entry(p, struct cl_host, head);
+
+		if (in_addr_eq(ch->cl_in_addr, cl_in_addr))
+			return ch;
 	}
 
-	while (optind < argc) {
-		if (resize_devices(argv[optind++]) != 0)
-			return 1;
+	return NULL;
+}
+
+static struct cl_host *net_add_client_host(struct net_server_s *ns,
+					   struct sockaddr_in *addr)
+{
+	struct cl_host *ch;
+
+	ch = malloc(sizeof(*ch));
+	memset(ch, 0, sizeof(*ch));
+
+	ch->ns = ns;
+	ch->cl_in_addr = addr->sin_addr;
+	list_add_tail(&ch->head, &ns->ch_list);
+	ns->nchs++;
+
+	ch->hostname = strdup(inet_ntoa(addr->sin_addr));
+	printf("server: connection from %s\n", ch->hostname);
+
+	INIT_LIST_HEAD(&ch->conn_list);
+	INIT_LIST_HEAD(&ch->devpaths);
+
+	return ch;
+}
+
+static void device_done(struct devpath *dpp, int ncpus)
+{
+	int cpu;
+	struct io_info *iop;
+
+	for (cpu = 0, iop = dpp->ios; cpu < ncpus; cpu++, iop++)
+		close_iop(iop);
+
+	list_del(&dpp->head);
+	dpp_free(dpp);
+}
+
+static void net_ch_remove(struct cl_host *ch, int ncpus)
+{
+	struct list_head *p, *q;
+	struct net_server_s *ns = ch->ns;
+
+	list_for_each_safe(p, q, &ch->devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+		device_done(dpp, ncpus);
 	}
 
-	if (ndevs == 0) {
-		show_usage(argv[0]);
-		return 1;
+	list_for_each_safe(p, q, &ch->conn_list) {
+		struct cl_conn *nc = list_entry(p, struct cl_conn, ch_head);
+
+		ch_rem_connection(ns, ch, nc);
 	}
 
-	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
-	if (ncpus < 0) {
-		fprintf(stderr, "sysconf(_SC_NPROCESSORS_ONLN) failed\n");
-		return 1;
+	list_del(&ch->head);
+	ns->nchs--;
+
+	if (ch->hostname)
+		free(ch->hostname);
+	free(ch);
+}
+
+static void net_add_connection(struct net_server_s *ns)
+{
+	int fd;
+	struct cl_host *ch;
+	socklen_t socklen = sizeof(ns->addr);
+
+	fd = accept(ns->listen_fd, (struct sockaddr *)&ns->addr, &socklen);
+	if (fd < 0) {
+		/*
+		 * This is OK: we just won't accept this connection,
+		 * nothing fatal.
+		 */
+		perror("accept");
+	} else {
+		ch = net_find_client_host(ns, ns->addr.sin_addr);
+		if (!ch)
+			ch = net_add_client_host(ns, &ns->addr);
+
+		ch_add_connection(ns, ch, fd);
 	}
+}
 
-	if (increase_limits() != 0)
-		return 1;
+static struct devpath *nc_add_dpp(struct cl_conn *nc,
+				  struct blktrace_net_hdr *bnh,
+				  time_t connect_time)
+{
+	int cpu;
+	struct io_info *iop;
+	struct devpath *dpp;
 
-	if (act_mask_tmp != 0)
-		act_mask = act_mask_tmp;
+	dpp = malloc(sizeof(*dpp));
+	memset(dpp, 0, sizeof(*dpp));
 
-	if (!debugfs_path)
-		debugfs_path = default_debugfs_path;
+	dpp->buts_name = strdup(bnh->buts_name);
+	dpp->path = strdup(bnh->buts_name);
+	dpp->fd = -1;
+	dpp->ch = nc->ch;
+	dpp->cl_id = bnh->cl_id;
+	dpp->cl_connect_time = connect_time;
+	dpp->ncpus = nc->ncpus;
+	dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
+	memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
 
-	if (statfs(debugfs_path, &st) < 0) {
-		perror("statfs");
-		fprintf(stderr,"%s does not appear to be a valid path\n",
-			debugfs_path);
-		return 1;
-	} else if (st.f_type != (long) DEBUGFS_TYPE) {
-		fprintf(stderr,"%s does not appear to be a debug filesystem\n",
-			debugfs_path);
-		return 1;
+	list_add_tail(&dpp->head, &nc->ch->devpaths);
+	nc->ch->ndevs++;
+
+	dpp->ios = calloc(nc->ncpus, sizeof(*iop));
+	memset(dpp->ios, 0, ndevs * sizeof(*iop));
+
+	for (cpu = 0, iop = dpp->ios; cpu < nc->ncpus; cpu++, iop++) {
+		iop->dpp = dpp;
+		iop->nc = nc;
+		init_mmap_info(&iop->mmap_info);
+
+		if (iop_open(iop, cpu))
+			goto err;
 	}
 
-	if (open_devices() != 0)
-		return 1;
+	return dpp;
 
-	if (kill_running_trace) {
-		stop_all_traces();
+err:
+	/*
+	 * Need to unravel what's been done...
+	 */
+	while (cpu >= 0)
+		close_iop(&dpp->ios[cpu--]);
+	dpp_free(dpp);
+
+	return NULL;
+}
+
+static struct devpath *nc_find_dpp(struct cl_conn *nc,
+				   struct blktrace_net_hdr *bnh)
+{
+	struct list_head *p;
+	time_t connect_time = nc->connect_time;
+
+	__list_for_each(p, &nc->ch->devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+
+		if (!strcmp(dpp->buts_name, bnh->buts_name))
+			return dpp;
+
+		if (dpp->cl_id == bnh->cl_id)
+			connect_time = dpp->cl_connect_time;
+	}
+
+	return nc_add_dpp(nc, bnh, connect_time);
+}
+
+static void net_client_read_data(struct cl_conn *nc, struct devpath *dpp,
+				 struct blktrace_net_hdr *bnh)
+{
+	int ret;
+	struct io_info *iop = &dpp->ios[bnh->cpu];
+	struct mmap_info *mip = &iop->mmap_info;
+
+	if (setup_mmap(iop->ofd, bnh->len, &iop->mmap_info)) {
+		fprintf(stderr, "ncd(%s:%d): mmap failed\n",
+			nc->ch->hostname, nc->fd);
+		exit(1);
+	}
+
+	ret = net_recv_data(nc->fd, mip->fs_buf + mip->fs_off, bnh->len);
+	if (ret > 0) {
+		pdc_dr_update(dpp, bnh->cpu, ret);
+		mip->fs_size += ret;
+		mip->fs_off += ret;
+	} else if (ret < 0)
+		exit(1);
+}
+
+/*
+ * Returns 1 if we closed a host - invalidates other polling information
+ * that may be present.
+ */
+static int net_client_data(struct cl_conn *nc)
+{
+	int ret;
+	struct devpath *dpp;
+	struct blktrace_net_hdr bnh;
+
+	ret = net_get_header(nc, &bnh);
+	if (ret == 0)
 		return 0;
+
+	if (ret < 0) {
+		fprintf(stderr, "ncd(%d): header read failed\n", nc->fd);
+		exit(1);
+	}
+
+	if (data_is_native == -1 && check_data_endianness(bnh.magic)) {
+		fprintf(stderr, "ncd(%d): received data is bad\n", nc->fd);
+		exit(1);
+	}
+
+	if (!data_is_native) {
+		bnh.magic = be32_to_cpu(bnh.magic);
+		bnh.cpu = be32_to_cpu(bnh.cpu);
+		bnh.max_cpus = be32_to_cpu(bnh.max_cpus);
+		bnh.len = be32_to_cpu(bnh.len);
+		bnh.cl_id = be32_to_cpu(bnh.cl_id);
+		bnh.buf_size = be32_to_cpu(bnh.buf_size);
+		bnh.buf_nr = be32_to_cpu(bnh.buf_nr);
+		bnh.page_size = be32_to_cpu(bnh.page_size);
+	}
+
+	if ((bnh.magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
+		fprintf(stderr, "ncd(%s:%d): bad data magic\n",
+			nc->ch->hostname, nc->fd);
+		exit(1);
+	}
+
+	if (nc->ncpus == -1)
+		nc->ncpus = bnh.max_cpus;
+
+	/*
+	 * len == 0 means the other end is sending us a new connection/dpp
+	 * len == 1 means that the other end signalled end-of-run
+	 */
+	dpp = nc_find_dpp(nc, &bnh);
+	if (bnh.len == 0) {
+		/*
+		 * Just adding in the dpp above is enough
+		 */
+		ack_open_close(nc->fd, dpp->buts_name);
+		nc->ch->cl_opens++;
+	} else if (bnh.len == 1) {
+		/*
+		 * overload cpu count with dropped events
+		 */
+		dpp->drops = bnh.cpu;
+
+		ack_open_close(nc->fd, dpp->buts_name);
+		if (--nc->ch->cl_opens == 0) {
+			show_stats(&nc->ch->devpaths);
+			net_ch_remove(nc->ch, nc->ncpus);
+			return 1;
+		}
+	} else
+		net_client_read_data(nc, dpp, &bnh);
+
+	return 0;
+}
+
+static void handle_client_data(struct net_server_s *ns, int events)
+{
+	struct cl_conn *nc;
+	struct pollfd *pfd;
+	struct list_head *p, *q;
+
+	pfd = &ns->pfds[1];
+	list_for_each_safe(p, q, &ns->conn_list) {
+		if (pfd->revents & POLLIN) {
+			nc = list_entry(p, struct cl_conn, ns_head);
+
+			if (net_client_data(nc) || --events == 0)
+				break;
+		}
+		pfd++;
+	}
+}
+
+static void net_setup_pfds(struct net_server_s *ns)
+{
+	struct pollfd *pfd;
+	struct list_head *p;
+
+	ns->pfds[0].fd = ns->listen_fd;
+	ns->pfds[0].events = POLLIN;
+
+	pfd = &ns->pfds[1];
+	__list_for_each(p, &ns->conn_list) {
+		struct cl_conn *nc = list_entry(p, struct cl_conn, ns_head);
+
+		pfd->fd = nc->fd;
+		pfd->events = POLLIN;
+		pfd++;
+	}
+}
+
+static int net_server_handle_connections(struct net_server_s *ns)
+{
+	int events;
+
+	printf("server: waiting for connections...\n");
+
+	while (!done) {
+		net_setup_pfds(ns);
+		events = poll(ns->pfds, ns->connects + 1, -1);
+		if (events < 0) {
+			if (errno != EINTR) {
+				perror("FATAL: poll error");
+				return 1;
+			}
+		} else if (events > 0) {
+			if (ns->pfds[0].revents & POLLIN) {
+				net_add_connection(ns);
+				events--;
+			}
+
+			if (events)
+				handle_client_data(ns, events);
+		}
+	}
+
+	return 0;
+}
+
+static int net_server(void)
+{
+	int fd, opt;
+	int ret = 1;
+	struct net_server_s net_server;
+	struct net_server_s *ns = &net_server;
+
+	memset(ns, 0, sizeof(*ns));
+	INIT_LIST_HEAD(&ns->ch_list);
+	INIT_LIST_HEAD(&ns->conn_list);
+	ns->pfds = malloc(sizeof(struct pollfd));
+
+	fd = my_socket(AF_INET, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("server: socket");
+		goto out;
+	}
+
+	opt = 1;
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt)) < 0) {
+		perror("setsockopt");
+		goto out;
+	}
+
+	memset(&ns->addr, 0, sizeof(ns->addr));
+	ns->addr.sin_family = AF_INET;
+	ns->addr.sin_addr.s_addr = htonl(INADDR_ANY);
+	ns->addr.sin_port = htons(net_port);
+
+	if (bind(fd, (struct sockaddr *) &ns->addr, sizeof(ns->addr)) < 0) {
+		perror("bind");
+		goto out;
+	}
+
+	if (listen(fd, 1) < 0) {
+		perror("listen");
+		goto out;
+	}
+
+	/*
+	 * The actual server looping is done here:
+	 */
+	ns->listen_fd = fd;
+	ret = net_server_handle_connections(ns);
+
+	/*
+	 * Clean up and return...
+	 */
+out:
+	free(ns->pfds);
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+
+	setlocale(LC_NUMERIC, "en_US");
+	pagesize = getpagesize();
+	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (ncpus < 0) {
+		fprintf(stderr, "sysconf(_SC_NPROCESSORS_ONLN) failed %d/%s\n",
+			errno, strerror(errno));
+		ret = 1;
+		goto out;
+	}
+
+	if (handle_args(argc, argv)) {
+		ret = 1;
+		goto out;
 	}
 
 	signal(SIGINT, handle_sigint);
@@ -2012,27 +2437,63 @@ int main(int argc, char *argv[])
 	signal(SIGALRM, handle_sigint);
 	signal(SIGPIPE, SIG_IGN);
 
-	if (net_mode == Net_client && net_setup_client())
-		return 1;
+	if (kill_running_trace) {
+		struct devpath *dpp;
+		struct list_head *p;
 
-	if (start_devices() != 0)
-		return 1;
+		__list_for_each(p, &devpaths) {
+			dpp = list_entry(p, struct devpath, head);
+			if (__stop_trace(dpp->fd)) {
+				fprintf(stderr,
+					"BLKTRACETEARDOWN %s failed: %d/%s\n",
+					dpp->path, errno, strerror(errno));
+			}
+		}
+	} else if (net_mode == Net_server) {
+		if (output_name) {
+			fprintf(stderr, "-o ignored in server mode\n");
+			output_name = NULL;
+		}
 
-	atexit(stop_all_tracing);
+		ret = net_server();
+	} else {
+		atexit(exit_tracing);
 
-	if (stop_watch)
-		alarm(stop_watch);
+		if (net_mode == Net_client)
+			printf("blktrace: connecting to %s\n", hostname);
 
-	wait_for_threads();
+		setup_buts();
 
-	if (!is_trace_stopped()) {
-		trace_stopped = 1;
-		stop_all_threads();
-		stop_all_traces();
-	}
+		if (use_tracer_devpaths()) {
+			if (setup_tracer_devpaths())
+				goto out;
+
+			if (piped_output)
+				handle_list = handle_list_file;
+			else
+				handle_list = handle_list_net;
+		}
 
-	show_stats(device_information, ndevs, ncpus);
+		ntracers = start_tracers();
+		if (ntracers != ncpus)
+			stop_tracers();
+		else {
+			if (net_mode == Net_client)
+				printf("blktrace: connected!\n");
+			fprintf(stderr, "main: tracers running\n");
+			if (stop_watch)
+				alarm(stop_watch);
+		}
 
-	return 0;
-}
+		wait_tracers();
+		show_stats(&devpaths);
 
+		if (net_client_use_send())
+			close_client_connections();
+		del_tracers();
+	}
+
+out:
+	rel_devpaths();
+	return ret;
+}
diff --git a/btt/list.h b/btt/list.h
index 363c888..71c4a65 100644
--- a/btt/list.h
+++ b/btt/list.h
@@ -213,4 +213,27 @@ static inline void list_splice(struct list_head *list, struct list_head *head)
                 __list_splice(list, head);
 }
 
+/**
+ * list_replace - replace old entry by new one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * If @old was empty, it will be overwritten.
+ */
+static inline void list_replace(struct list_head *old,
+				struct list_head *new)
+{
+	new->next = old->next;
+	new->next->prev = new;
+	new->prev = old->prev;
+	new->prev->next = new;
+}
+
+static inline void list_replace_init(struct list_head *old,
+					struct list_head *new)
+{
+	list_replace(old, new);
+	INIT_LIST_HEAD(old);
+}
+
 #endif
-- 
1.5.6.3


--------------080006020508010104090108--
