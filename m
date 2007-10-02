From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 02 Oct 2007 16:40:32 +0000
Subject: [PATCH] Add btrecord/btreplay capability
Message-Id: <47027480.2040408@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010603050100090509080205"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603050100090509080205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------010603050100090509080205
Content-Type: text/x-patch;
 name="0002-Add-btrecord-btreplay-capability.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Add-btrecord-btreplay-capability.patch"

From d5095b9054fb40e33a76bc790e6ce459c9a0ee91 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <Alan.Brunelle@hp.com>
Date: Tue, 2 Oct 2007 12:35:07 -0400
Subject: [PATCH] Add btrecord/btreplay capability

These facilities allow one to attempt to replay a stream of IOs
captured with blktrace. The general workflow is:

1. Initiate blktrace to capture traces
2. Do whatever to generate initial IO stream...
3. Stop blktrace
4. Run btrecord to convert traces into IO records
5. Run btreplay to replay IOs

The IO stream characteristics during replay will try to respect the
following characteristics of the original IO stream:

1. The IOs will target the same device(s) as originally seen. [One can
   alter this behavior by specifyin the -M option to btreplay, which
   allows one to remap IOs slated to one set of devices to a specified
   other set of devices.]

2. IO direction: the IOs will follow the same read/write
   (from-device/to-device) characteristics of the originating flow. [Note:
   By default replay will /not/ do writes, one must specify the -W option
   to do this. THis is a meager attempt to stop someone from shooting
   themselves in the foot (with a very large-caliber weapon).]

3. IO offset & size are maintained.

4. CPU: IOs are submitted on the originating CPU whenever possible. [Note:
   Since we are using asynchronous IO, IOs may be routed to another CPU
   prior to being processed by the block IO layer.]

In order to try and replicate inter-IO timing as much as possible,
btrecord will combine IOs "close in time" into one set, or bunch, of
IOs. Then btreplay will replay all the IOs in one go (via asynchronous
direct IO - io_submit). The size of the bunches are configurable via
the -m flag to btrecord (which specifies the a time-based bunch size)
and/or the -M flag (which specifies the maximum amount of IOs to put
into a bunch). At the low-end, specifying '-M 1' instructs btrecord to
act like fio - replay each IO as an individual unit.

Besides the potential to remap devices (utilizing the -M option to replay,
as noted above), one can also limit the number of CPUs on the replay
machine - so if you have fewer CPUs on the replay machine you specify
the -c option to btreplay.

Lastly, one can specify the -N option to btreplay to instruct it to ignore
inter-IO (inter-bunch of IOs) timings. Thus, this instructs btreplay
to replay the bunches as fast as possible, ignoring the original delays
between original IOs.

The utilities include a write-up in the docs directory.

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---
 Makefile                  |   11 +-
 btreplay/Makefile         |   45 ++
 btreplay/btrecord.c       |  780 ++++++++++++++++++++++
 btreplay/btrecord.h       |   95 +++
 btreplay/btreplay.c       | 1590 +++++++++++++++++++++++++++++++++++++++++++++
 btreplay/doc/Makefile     |   18 +
 btreplay/doc/abstract.tex |   34 +
 btreplay/doc/btreplay.tex |  521 +++++++++++++++
 8 files changed, 3093 insertions(+), 1 deletions(-)
 create mode 100644 btreplay/Makefile
 create mode 100644 btreplay/btrecord.c
 create mode 100644 btreplay/btrecord.h
 create mode 100644 btreplay/btreplay.c
 create mode 100644 btreplay/doc/Makefile
 create mode 100644 btreplay/doc/abstract.tex
 create mode 100644 btreplay/doc/btreplay.tex

diff --git a/Makefile b/Makefile
index e36f5a2..fda76f4 100644
--- a/Makefile
+++ b/Makefile
@@ -5,13 +5,19 @@ PROGS	= blkparse blktrace verify_blkparse blkrawverify
 LIBS	= -lpthread
 SCRIPTS	= btrace
 
-ALL = $(PROGS) $(SCRIPTS) btt/btt
+ALL = $(PROGS) $(SCRIPTS) btt/btt btreplay/btrecord btreplay/btreplay
 
 all: $(ALL)
 
 btt/btt:
 	$(MAKE) -C btt
 
+btreplay/btrecord:
+	$(MAKE) -C btreplay
+
+btreplay/btreplay:
+	$(MAKE) -C btreplay
+
 %.o: %.c
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
@@ -32,10 +38,12 @@ $(PROGS): | depend
 docs:
 	$(MAKE) -C doc all
 	$(MAKE) -C btt docs
+	$(MAKE) -C btreplay docs
 
 docsclean:
 	$(MAKE) -C doc clean
 	$(MAKE) -C btt clean
+	$(MAKE) -C btreplay clean
 
 depend:
 	@$(CC) -MM $(ALL_CFLAGS) *.c 1> .depend
@@ -63,6 +71,7 @@ rpm: dist
 clean: docsclean
 	-rm -f *.o $(PROGS) .depend btrace-1.0.tar.bz2
 	$(MAKE) -C btt clean
+	$(MAKE) -C btreplay clean
 
 install: all
 	$(INSTALL) -m 755 -d $(DESTDIR)$(bindir)
diff --git a/btreplay/Makefile b/btreplay/Makefile
new file mode 100644
index 0000000..a8d2e3b
--- /dev/null
+++ b/btreplay/Makefile
@@ -0,0 +1,45 @@
+#
+# OCFLAGS:
+# 	COUNT_IOS	- Counts struct io's left at end
+# 	DEBUG		- Various and sundy debug asserts
+# 	NDEBUG		- Defined: no asserts, Undefined: asserts
+#
+
+CC	= gcc
+CFLAGS	= -Wall -W -O2 -g
+INCS	= -I. -I.. -I../btt
+OCFLAGS	= -UCOUNT_IOS -UDEBUG -DNDEBUG
+XCFLAGS	= -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
+override CFLAGS += $(INCS) $(XCFLAGS) $(OCFLAGS)
+
+PROGS	= btrecord btreplay
+LIBS	= -laio -lrt
+
+all: depend $(PROGS)
+
+$(PROGS): | depend
+
+docs:
+	$(MAKE) -C doc all
+
+docsclean:
+	$(MAKE) -C doc clean
+
+clean: docsclean
+	-rm -f *.o $(PROGS) .depend
+
+%.o: %.c
+	$(CC) $(CFLAGS) -c -o $*.o $<
+
+btrecord: btrecord.o
+	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+
+btreplay: btreplay.o
+	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+
+depend:
+	@$(CC) -MM $(CFLAGS) *.c 1> .depend
+
+ifneq ($(wildcard .depend),)
+include .depend
+endif
diff --git a/btreplay/btrecord.c b/btreplay/btrecord.c
new file mode 100644
index 0000000..e02c153
--- /dev/null
+++ b/btreplay/btrecord.c
@@ -0,0 +1,780 @@
+/*
+ * Blktrace record utility - Convert binary trace data into bunches of IOs
+ *
+ * Copyright (C) 2007 Alan D. Brunelle <Alan.Brunelle@hp.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+static char build_date[] = __DATE__ " at "__TIME__;
+
+#include <assert.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/param.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <dirent.h>
+
+#if !defined(_GNU_SOURCE)
+#	define _GNU_SOURCE
+#endif
+#include <getopt.h>
+
+#include "list.h"
+#include "btrecord.h"
+#include "blktrace.h"
+
+/*
+ * Per input file information
+ *
+ * @head: 	Used to link up on input_files
+ * @devnm: 	Device name portion of this input file
+ * @file_name: 	Fully qualified name for this input file
+ * @cpu: 	CPU that this file was collected on
+ * @ifd: 	Input file descriptor (when opened)
+ * @tpkts: 	Total number of packets processed.
+ */
+struct ifile_info {
+	struct list_head head;
+	char *devnm, *file_name;
+	int cpu, ifd;
+	__u64 tpkts, genesis;
+};
+
+/*
+ * Per IO trace information
+ *
+ * @time: 	Time stamp when trace was emitted
+ * @sector: 	IO sector identifier
+ * @bytes: 	Number of bytes transferred
+ * @rw: 	Read (1) or write (0) 
+ */
+struct io_spec {
+	__u64 time;
+	__u64 sector;
+	__u32 bytes;
+	int rw;
+};
+
+/*
+ * Per output file information
+ *
+ * @ofp: 	Output file 
+ * @vfp:	Verbose output file
+ * @file_name: 	Fully qualified name for this file
+ * @vfn:	Fully qualified name for this file
+ * @cur: 	Current IO bunch being collected
+ * @iip: 	Input file this is associated with
+ * @start_time: Start time of th ecurrent bunch
+ * @last_time: 	Time of last packet put in
+ * @bunches: 	Number of bunches processed
+ * @pkts: 	Number of packets stored in bunches
+ */
+struct io_stream {
+	FILE *ofp, *vfp;
+	char *file_name, *vfn;
+	struct io_bunch *cur;
+	struct ifile_info *iip;
+	__u64 start_time, last_time, bunches, pkts;
+};
+
+int data_is_native;				// Indicates whether to swap
+static LIST_HEAD(input_files);			// List of all input files
+static char *idir = ".";			// Input directory base
+static char *odir = ".";			// Output directory base
+static char *obase = "replay";			// Output file base
+static __u64 max_bunch_tm = (10 * 1000 * 1000);	// 10 milliseconds
+static __u64 max_pkts_per_bunch = 8;		// Default # of pkts per bunch
+static int verbose = 0;				// Boolean: output stats
+static int find_traces = 0;			// Boolean: Find traces in dir
+
+static char usage_str[] =                                                  \
+        "\n"                                                               \
+	"\t[ -d <dir>  : --input-directory=<dir> ] Default: .\n"           \
+	"\t[ -D <dir>  : --output-directory=<dir>] Default: .\n"           \
+	"\t[ -F        : --find-traces           ] Default: Off\n"         \
+        "\t[ -h        : --help                  ] Default: Off\n"         \
+        "\t[ -m <nsec> : --max-bunch-time=<nsec> ] Default: 10 msec\n"     \
+	"\t[ -M <pkts> : --max-pkts=<pkts>       ] Default: 8\n"           \
+        "\t[ -o <base> : --output-base=<base>    ] Default: replay\n"      \
+        "\t[ -v        : --verbose               ] Default: Off\n"         \
+        "\t[ -V        : --version               ] Default: Off\n"         \
+	"\t<dev>...                                Default: None\n"	   \
+        "\n";
+
+#define S_OPTS	"d:D:Fhm:M:o:vV"
+static struct option l_opts[] = {
+	{
+		.name = "input-directory",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'd'
+	},
+	{
+		.name = "output-directory",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'D'
+	},
+	{
+		.name = "find-traces",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'F'
+	},
+	{
+		.name = "help",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'h'
+	},
+	{
+		.name = "max-bunch-time",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'm'
+	},
+	{
+		.name = "max_pkts",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'M'
+	},
+	{
+		.name = "output-base",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'o'
+	},
+	{
+		.name = "verbose",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'v'
+	},
+	{
+		.name = "version",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'V'
+	},
+	{
+		.name = NULL
+	}
+};
+
+#define ERR_ARGS			1
+#define ERR_SYSCALL			2
+#define fatal(errstring, exitval, arg...)				\
+	do {								\
+		if (errstring) perror(errstring);			\
+		fprintf(stderr, ##arg);					\
+		exit(exitval);						\
+		/*NOTREACHED*/						\
+	} while (0)
+
+/**
+ * match - Return true if this trace is a proper QUEUE transaction
+ * @action: Action field from trace
+ */
+static inline int match(__u32 action)
+{
+	return ((action & 0xffff) == __BLK_TA_QUEUE) &&
+				       (action & BLK_TC_ACT(BLK_TC_QUEUE));
+}
+
+/**
+ * usage - Display usage string and version
+ */
+static void usage(void)
+{
+	fprintf(stderr, "Usage: btrecord -- version %s\n%s", 
+		my_btversion, usage_str);
+}
+
+/**
+ * write_file_hdr - Seek to and write btrecord file header
+ * @stream: Output file information
+ * @hdr: Header to write
+ */
+static void write_file_hdr(struct io_stream *stream, struct io_file_hdr *hdr)
+{
+	hdr->version = mk_btversion(btver_mjr, btver_mnr, btver_sub);
+
+	if (verbose) {
+		fprintf(stderr, "\t%s: %llx %llx %llx %llx\n", 
+			stream->file_name,
+			(long long unsigned)hdr->version,
+			(long long unsigned)hdr->genesis,
+			(long long unsigned)hdr->nbunches,
+			(long long unsigned)hdr->total_pkts);
+	}
+
+	fseek(stream->ofp, 0, SEEK_SET);
+	if (fwrite(hdr, sizeof(*hdr), 1, stream->ofp) != 1) {
+		fatal(stream->file_name, ERR_SYSCALL, "Hdr write failed\n");
+		/*NOTREACHED*/
+	}
+}
+
+/**
+ * io_bunch_create - Allocate & initialize an io_bunch
+ * @io_stream: IO stream being added to
+ * @pre_stall: Amount of time that this bunch should be delayed by
+ * @start_time: Records current start 
+ */
+static inline void io_bunch_create(struct io_stream *stream, __u64 start_time)
+{
+	struct io_bunch *cur = malloc(sizeof(*cur));
+
+	memset(cur, 0, sizeof(*cur));
+
+	cur->hdr.npkts = 0;
+	cur->hdr.time_stamp = stream->start_time = start_time;
+
+	stream->cur = cur;
+}
+
+/**
+ * io_bunch_add - Add an IO to the current bunch of IOs
+ * @stream: Per-output file stream information
+ * @spec: IO trace specification
+ *
+ * Returns update bunch information
+ */
+static void io_bunch_add(struct io_stream *stream, struct io_spec *spec)
+{
+	struct io_bunch *cur = stream->cur;
+	struct io_pkt iop = {
+		.sector = spec->sector,
+		.nbytes = spec->bytes,
+		.rw = spec->rw
+	};
+
+	assert(cur != NULL);
+	assert(cur->hdr.npkts < BT_MAX_PKTS);
+	assert(stream->last_time == 0 || stream->last_time <= spec->time);
+
+	cur->pkts[cur->hdr.npkts++] = iop;	// Struct copy
+	stream->last_time = spec->time;
+}
+
+/**
+ * rem_input_file - Release resources associated with an input file
+ * @iip: Per-input file information
+ */
+static void rem_input_file(struct ifile_info *iip)
+{
+	list_del(&iip->head);
+
+	close(iip->ifd);
+	free(iip->file_name);
+	free(iip->devnm);
+	free(iip);
+}
+
+/**
+ * __add_input_file - Allocate and initialize per-input file structure
+ * @cpu: CPU for this file
+ * @devnm: Device name for this file
+ * @file_name: Fully qualifed input file name
+ */
+static void __add_input_file(int cpu, char *devnm, char *file_name)
+{
+	struct ifile_info *iip = malloc(sizeof(*iip));
+
+	iip->cpu = cpu;
+	iip->tpkts = 0;
+	iip->genesis = 0;
+	iip->devnm = strdup(devnm);
+	iip->file_name = strdup(file_name);
+	iip->ifd = open(file_name, O_RDONLY);
+	if (iip->ifd < 0) {
+		fatal(file_name, ERR_ARGS, "Unable to open\n");
+		/*NOTREACHED*/
+	}
+
+	list_add_tail(&iip->head, &input_files);
+}
+
+/**
+ * add_input_file - Set up the input file name
+ * @devnm: Device name to use
+ */
+static void add_input_file(char *devnm)
+{
+	struct list_head *p;
+	int cpu, found = 0;
+
+	__list_for_each(p, &input_files) {
+		struct ifile_info *iip = list_entry(p, struct ifile_info, head);
+		if (strcmp(iip->devnm, devnm) == 0)
+			return;
+	}
+
+	for (cpu = 0; ; cpu++) {
+		char full_name[MAXPATHLEN];
+
+		sprintf(full_name, "%s/%s.blktrace.%d", idir, devnm, cpu);
+		if (access(full_name, R_OK) != 0)
+			break;
+
+		__add_input_file(cpu, devnm, full_name);
+		found++;
+	}
+
+	if (!found) {
+		fatal(NULL, ERR_ARGS, "No traces found for %s\n", devnm);
+		/*NOTREACHED*/
+	}
+}
+
+static void find_input_files(char *idir)
+{
+	struct dirent *ent;
+	DIR *dir = opendir(idir);
+
+	if (dir == NULL) {
+		fatal(idir, ERR_ARGS, "Unable to open %s\n", idir);
+		/*NOTREACHED*/
+	}
+
+	while ((ent = readdir(dir)) != NULL) {
+		char *p, *dsf = malloc(256);
+
+		if (strstr(ent->d_name, ".blktrace.") == NULL)
+			continue;
+
+		dsf = strdup(ent->d_name);
+		p = index(dsf, '.');
+		assert(p != NULL);
+		*p = '\0';
+		add_input_file(dsf);
+		free(dsf);
+	}
+
+	closedir(dir);
+}
+
+/**
+ * handle_args - Parse passed in argument list
+ * @argc: Number of arguments in argv
+ * @argv: Arguments passed in
+ *
+ * Does rudimentary parameter verification as well.
+ */
+void handle_args(int argc, char *argv[])
+{
+	int c;
+
+	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) != -1) {
+		switch (c) {
+		case 'd':
+			idir = optarg;
+			if (access(idir, R_OK | X_OK) != 0) {
+				fatal(idir, ERR_ARGS, 
+				      "Invalid input directory specified\n");
+				/*NOTREACHED*/
+			}
+			break;
+
+		case 'D':
+			odir = optarg;
+			if (access(odir, R_OK | X_OK) != 0) {
+				fatal(odir, ERR_ARGS, 
+				      "Invalid output directory specified\n");
+				/*NOTREACHED*/
+			}
+			break;
+
+		case 'F': 
+			find_traces = 1;
+			break;
+
+		case 'h': 
+			usage(); 
+			exit(0);
+			/*NOTREACHED*/
+
+		case 'm':
+			max_bunch_tm = (__u64)atoll(optarg);
+			if (max_bunch_tm < 1) {
+				fprintf(stderr, "Invalid bunch time %llu\n",
+					(unsigned long long)max_bunch_tm);
+				exit(ERR_ARGS);
+				/*NOTREACHED*/
+			}
+			break;
+
+		case 'M':
+			max_pkts_per_bunch = (__u64)atoll(optarg);
+			if (!((1 <= max_pkts_per_bunch) && 
+						(max_pkts_per_bunch < 513))) {
+				fprintf(stderr, "Invalid max pkts %llu\n",
+					(unsigned long long)max_pkts_per_bunch);
+				exit(ERR_ARGS);
+				/*NOTREACHED*/
+			}
+			break;
+
+		case 'o':
+			obase = optarg;
+			break;
+
+		case 'V':
+			fprintf(stderr, "btrecord -- version %s\n", 
+				my_btversion);
+			fprintf(stderr, "            Built on %s\n", build_date);
+			exit(0);
+			/*NOTREACHED*/
+
+		case 'v':
+			verbose++;
+			break;
+
+		default:
+			usage();
+			fatal(NULL, ERR_ARGS, "Invalid command line\n");
+			/*NOTREACHED*/
+		}
+	}
+
+	while (optind < argc)
+		add_input_file(argv[optind++]);
+
+	if (find_traces)
+		find_input_files(idir);
+
+	if (list_len(&input_files) == 0) {
+		fatal(NULL, ERR_ARGS, "Missing required input file name(s)\n");
+		/*NOTREACHED*/
+	}
+}
+
+/**
+ * next_io - Retrieve next Q trace from input stream
+ * @iip: Per-input file information
+ * @spec: IO specifier for trace
+ *
+ * Returns 0 on end of file, 1 if valid data returned.
+ */
+static int next_io(struct ifile_info *iip, struct io_spec *spec)
+{
+	ssize_t ret;
+	__u32 action;
+	__u16 pdu_len;
+	struct blk_io_trace t;
+
+again:
+	ret = read(iip->ifd, &t, sizeof(t));
+	if (ret < 0) {
+		fatal(iip->file_name, ERR_SYSCALL, "Read failed\n");
+		/*NOTREACHED*/
+	}
+	else if (ret == 0)
+		return 0;
+	else if (ret < (ssize_t)sizeof(t)) {
+		fprintf(stderr, "WARNING: Short read on %s (%d)\n", 
+			iip->file_name, (int)ret);
+		return 0;
+	}
+
+	if (data_is_native == -1)
+		check_data_endianness(t.magic);
+
+	assert(data_is_native >= 0);
+	if (data_is_native) {
+		spec->time = t.time;
+		spec->sector = t.sector;
+		spec->bytes = t.bytes;
+		action = t.action;
+		pdu_len = t.pdu_len;
+	}
+	else {
+		spec->time = be64_to_cpu(t.time);
+		spec->sector = be64_to_cpu(t.sector);
+		spec->bytes = be32_to_cpu(t.bytes);
+		action = be32_to_cpu(t.action);
+		pdu_len = be16_to_cpu(t.pdu_len);
+	}
+
+
+	if (pdu_len) {
+		char buf[pdu_len];
+
+		ret = read(iip->ifd, buf, pdu_len);
+		if (ret < 0) {
+			fatal(iip->file_name, ERR_SYSCALL, "Read PDU failed\n");
+			/*NOTREACHED*/
+		}
+		else if (ret < (ssize_t)pdu_len) {
+			fprintf(stderr, "WARNING: Short PDU read on %s (%d)\n", 
+				iip->file_name, (int)ret);
+			return 0;
+		}
+	}
+
+	iip->tpkts++;
+	if (!match(action))
+		goto again;
+
+	spec->rw = (action & BLK_TC_ACT(BLK_TC_READ)) ? 1 : 0;
+	if (verbose > 1)
+		fprintf(stderr, "%2d: %10llu+%10llu (%d) @ %10llx\n",
+			iip->cpu, (long long unsigned)spec->sector,
+			(long long unsigned)spec->bytes / 512LLU,
+			spec->rw, (long long unsigned)spec->time);
+
+	if (iip->genesis == 0) {
+		iip->genesis = spec->time;
+		if (verbose > 1)
+			fprintf(stderr, "\tSetting new genesis: %llx(%d)\n",
+				(long long unsigned)iip->genesis, iip->cpu);
+	}
+	else if (iip->genesis > spec->time)
+		fatal(NULL, ERR_SYSCALL, 
+			"Time inversion? %llu ... %llu\n",
+			(long long unsigned )iip->genesis, 
+			(long long unsigned )spec->time);
+
+	return 1;
+}
+
+/**
+ * bunch_output_hdr - Output bunch header
+ */
+static inline void bunch_output_hdr(struct io_stream *stream)
+{
+	struct io_bunch_hdr *hdrp = &stream->cur->hdr;
+
+	assert(0 < hdrp->npkts && hdrp->npkts <= BT_MAX_PKTS);
+	if (fwrite(hdrp, sizeof(struct io_bunch_hdr), 1, stream->ofp) != 1) {
+		fatal(stream->file_name, ERR_SYSCALL, "fwrite(hdr) failed\n");
+		/*NOTREACHED*/
+	}
+
+	if (verbose) {
+		__u64 off = hdrp->time_stamp - stream->iip->genesis;
+
+		assert(stream->vfp);
+		fprintf(stream->vfp, "------------------\n");
+		fprintf(stream->vfp, "%4llu.%09llu %3llu\n", 
+			(unsigned long long)off / (1000 * 1000 * 1000),
+			(unsigned long long)off % (1000 * 1000 * 1000), 
+			(unsigned long long)hdrp->npkts);
+		fprintf(stream->vfp, "------------------\n");
+	}
+}
+
+/**
+ * bunch_output_pkt - Output IO packets
+ */
+static inline void bunch_output_pkts(struct io_stream *stream)
+{
+	struct io_pkt *p = stream->cur->pkts;
+	size_t npkts = stream->cur->hdr.npkts;
+
+	assert(0 < npkts && npkts <= BT_MAX_PKTS);
+	if (fwrite(p, sizeof(struct io_pkt), npkts, stream->ofp) != npkts) {
+		fatal(stream->file_name, ERR_SYSCALL, "fwrite(pkts) failed\n");
+		/*NOTREACHED*/
+	}
+
+	if (verbose) {
+		size_t i;
+
+		assert(stream->vfp);
+		for (i = 0; i < npkts; i++, p++)
+			fprintf(stream->vfp, "\t%1d %10llu\t%10llu\n",
+				p->rw, 
+				(unsigned long long)p->sector,
+				(unsigned long long)p->nbytes / 512);
+	}
+}
+
+/**
+ * stream_flush - Flush current bunch of IOs out to the output stream
+ * @stream: Per-output file stream information
+ */
+static void stream_flush(struct io_stream *stream)
+{
+	struct io_bunch *cur = stream->cur;
+
+	if (cur) {
+		if (cur->hdr.npkts) {
+			assert(cur->hdr.npkts <= BT_MAX_PKTS);
+			bunch_output_hdr(stream);
+			bunch_output_pkts(stream);
+
+			stream->bunches++;
+			stream->pkts += cur->hdr.npkts;
+		}
+		free(cur);
+	}
+}
+
+/**
+ * bunch_done - Returns true if current bunch is either full, or next IO is late
+ * @stream: Output stream information
+ * @spec: IO trace specification
+ */
+static inline int bunch_done(struct io_stream *stream, struct io_spec *spec)
+{
+	if (stream->cur->hdr.npkts >= max_pkts_per_bunch)
+		return 1;
+
+	if ((spec->time - stream->start_time) > max_bunch_tm)
+		return 1;
+
+	return 0;
+}
+
+/**
+ * stream_add_io - Add an IO trace to the current stream
+ * @stream: Output stream information
+ * @spec: IO trace specification
+ */
+static void stream_add_io(struct io_stream *stream, struct io_spec *spec)
+{
+
+	if (stream->cur == NULL)
+		io_bunch_create(stream, spec->time);
+	else if (bunch_done(stream, spec)) {
+		stream_flush(stream);
+		io_bunch_create(stream, spec->time);
+	}
+
+	io_bunch_add(stream, spec);
+}
+
+/**
+ * stream_open - Open output stream for specified input stream
+ * @iip: Per-input file information
+ */
+static struct io_stream *stream_open(struct ifile_info *iip)
+{
+	char ofile_name[MAXPATHLEN];
+	struct io_stream *stream = malloc(sizeof(*stream));
+	struct io_file_hdr io_file_hdr = {
+		.genesis = 0,
+		.nbunches = 0,
+		.total_pkts = 0
+	};
+
+	memset(stream, 0, sizeof(*stream));
+
+	sprintf(ofile_name, "%s/%s.%s.%d", odir, iip->devnm, obase, iip->cpu);
+	stream->ofp = fopen(ofile_name, "w");
+	if (!stream->ofp) {
+		fatal(ofile_name, ERR_SYSCALL, "Open failed\n");
+		/*NOTREACHED*/
+	}
+
+	stream->iip = iip;
+	stream->cur = NULL;
+	stream->bunches = stream->pkts = 0;
+	stream->last_time = 0;
+	stream->file_name = strdup(ofile_name);
+
+	write_file_hdr(stream, &io_file_hdr);
+
+	if (verbose) {
+		char vfile_name[MAXPATHLEN];
+
+		sprintf(vfile_name, "%s/%s.%s.%d.rec", odir, iip->devnm,
+			obase, iip->cpu);
+		stream->vfp = fopen(vfile_name, "w");
+		if (!stream->vfp) {
+			fatal(vfile_name, ERR_SYSCALL, "Open failed\n");
+			/*NOTREACHED*/
+		}
+
+		stream->vfn = strdup(vfile_name);
+	}
+
+	data_is_native = -1;
+	return stream;
+}
+
+/**
+ * stream_close - Release resources associated with an output stream
+ * @stream: Stream to release
+ */
+static void stream_close(struct io_stream *stream)
+{
+	struct io_file_hdr io_file_hdr = {
+		.genesis = stream->iip->genesis,
+		.nbunches = stream->bunches,
+		.total_pkts = stream->pkts
+	};
+
+	stream_flush(stream);
+	write_file_hdr(stream, &io_file_hdr);
+	fclose(stream->ofp);
+
+	if (verbose && stream->bunches) {
+		fprintf(stderr, 
+			"%s:%d: %llu pkts (tot), %llu pkts (replay), "
+					"%llu bunches, %.1lf pkts/bunch\n",
+			stream->iip->devnm, stream->iip->cpu,
+			(unsigned long long)stream->iip->tpkts, 
+			(unsigned long long)stream->pkts, 
+			(unsigned long long)stream->bunches,
+			(double)(stream->pkts) / (double)(stream->bunches));
+
+		fclose(stream->vfp);
+		free(stream->vfn);
+	}
+
+	free(stream->file_name);
+	free(stream);
+}
+
+/**
+ * process - Process one input file to an output file
+ * @iip: Per-input file information
+ */
+static void process(struct ifile_info *iip)
+{
+	struct io_spec spec;
+	struct io_stream *stream;
+
+	stream = stream_open(iip);
+	while (next_io(iip, &spec))
+		stream_add_io(stream, &spec);
+	stream_close(stream);
+
+	rem_input_file(iip);
+}
+
+/**
+ * main - 
+ * @argc: Number of arguments
+ * @argv: Array of arguments
+ */
+int main(int argc, char *argv[])
+{
+	struct list_head *p, *q;
+
+	handle_args(argc, argv);
+	list_for_each_safe(p, q, &input_files)
+		process(list_entry(p, struct ifile_info, head));
+
+	return 0;
+}
diff --git a/btreplay/btrecord.h b/btreplay/btrecord.h
new file mode 100644
index 0000000..8026206
--- /dev/null
+++ b/btreplay/btrecord.h
@@ -0,0 +1,95 @@
+/*
+ * Blktrace record utility - Convert binary trace data into bunches of IOs
+ *
+ * Copyright (C) 2007 Alan D. Brunelle <Alan.Brunelle@hp.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#if !defined(__BTRECORD_H__)
+#define __BTRECORD_H__
+
+#include <asm/types.h>
+
+#define BT_MAX_PKTS	512
+
+/*
+ * Header for each bunch
+ *
+ * @nkts: 	Number of IO packets to process
+ * @time_stamp:	Time stamp for this bunch of IOs
+ */
+struct io_bunch_hdr {
+	__u64 npkts;
+	__u64 time_stamp;
+};
+
+/*
+ * IO specifer
+ *
+ * @sector:	Sector number of IO
+ * @nbytes:	Number of bytes to process
+ * @rw:		IO direction: 0 = write, 1 = read
+ */
+struct io_pkt {
+	__u64 sector;
+	__u64 nbytes;
+	__u32 rw;
+};
+
+/*
+ * Shorthand notion of a bunch of IOs
+ *
+ * @hdr: 	Header describing stall and how many IO packets follow
+ * @pkts: 	Individual IOs are described here
+ */
+struct io_bunch {
+	struct io_bunch_hdr hdr;
+	struct io_pkt pkts[BT_MAX_PKTS];
+};
+
+/*
+ * Header for each recorded file
+ *
+ * @version:	Version information
+ * @genesis:	Time stamp for earliest bunch
+ * @nbunches:	Number of bunches put into the file
+ * @total_pkts:	Number of packets to be processed
+ */
+struct io_file_hdr {
+	__u64 version;
+	__u64 genesis;
+	__u64 nbunches;
+	__u64 total_pkts;
+};
+
+static inline __u64 mk_btversion(int mjr, int mnr, int sub)
+{
+	return ((mjr & 0xff) << 16) | ((mnr & 0xff) << 8) | (sub & 0xff);
+}
+
+static inline void get_btversion(__u64 version, int *mjr, int *mnr, int *sub)
+{
+	*mjr = (int)((version >> 16) & 0xff);
+	*mnr = (int)((version >>  8) & 0xff);
+	*sub = (int)((version >>  0) & 0xff);
+}
+
+static char my_btversion[] = "0.9.3";
+static int btver_mjr = 0;
+static int btver_mnr = 9;
+static int btver_sub = 3;
+
+#endif
diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
new file mode 100644
index 0000000..48181a4
--- /dev/null
+++ b/btreplay/btreplay.c
@@ -0,0 +1,1590 @@
+/*
+ * Blktrace replay utility - Play traces back
+ *
+ * Copyright (C) 2007 Alan D. Brunelle <Alan.Brunelle@hp.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+static char build_date[] = __DATE__ " at "__TIME__;
+
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <libaio.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/param.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <dirent.h>
+
+#if !defined(_GNU_SOURCE)
+#	define _GNU_SOURCE
+#endif
+#include <getopt.h>
+
+#include "list.h"
+#include "btrecord.h"
+
+/* 
+ * ========================================================================
+ * ==== STRUCTURE DEFINITIONS =============================================
+ * ========================================================================
+ */
+
+/**
+ * Each device map has one of these:
+ * 
+ * @head:	Linked on to map_devs
+ * @from_dev:	Device name as seen on recorded system
+ * @to_dev:	Device name to be used on replay system
+ */
+struct map_dev {
+	struct list_head head;
+	char *from_dev, *to_dev;
+};
+
+/**
+ * Each device name specified has one of these (until threads are created)
+ *
+ * @head: 	Linked onto input_devs
+ * @devnm: 	Device name -- 'sd*'
+ */
+struct dev_info {
+	struct list_head head;
+	char *devnm;
+};
+
+/*
+ * Per input file information
+ *
+ * @head: 	Used to link up on input_files
+ * @free_iocbs: List of free iocb's available for use
+ * @used_iocbs: List of iocb's currently outstanding
+ * @mutex: 	Mutex used with condition variable to protect volatile values
+ * @cond: 	Condition variable used when waiting on a volatile value change
+ * @naios_out: 	Current number of AIOs outstanding on this context
+ * @naios_free: Number of AIOs on the free list (short cut for list_len)
+ * @send_wait: 	Boolean: When true, the sub thread is waiting on free IOCBs
+ * @reap_wait: 	Boolean: When true, the rec thread is waiting on used IOCBs
+ * @send_done: 	Boolean: When true, the sub thread has completed work
+ * @reap_done: 	Boolean: When true, the rec thread has completed work
+ * @sub_thread: Thread used to submit IOs.
+ * @rec_thread: Thread used to reclaim IOs.
+ * @ctx: 	IO context
+ * @devnm: 	Copy of the device name being managed by this thread
+ * @file_name: 	Full name of the input file
+ * @cpu: 	CPU this thread is pinned to
+ * @ifd: 	Input file descriptor
+ * @ofd: 	Output file descriptor
+ * @iterations: Remaining iterations to process
+ * @vfp:	For verbose dumping of actions performed
+ */
+struct thr_info {
+	struct list_head head, free_iocbs, used_iocbs;
+	pthread_mutex_t mutex;
+	pthread_cond_t cond;
+	volatile long naios_out, naios_free;
+	volatile int send_wait, reap_wait, send_done, reap_done;
+	pthread_t sub_thread, rec_thread;
+	io_context_t ctx;
+	char *devnm, *file_name;
+	int cpu, ifd, ofd, iterations;
+	FILE *vfp;
+};
+
+/*
+ * Every Asynchronous IO used has one of these (naios per file/device).
+ *
+ * @iocb:	IOCB sent down via io_submit
+ * @head:	Linked onto file_list.free_iocbs or file_list.used_iocbs
+ * @tip:	Pointer to per-thread information this IO is associated with
+ * @nbytes:	Number of bytes in buffer associated with iocb
+ */
+struct iocb_pkt {
+	struct iocb iocb;
+	struct list_head head;
+	struct thr_info *tip;
+	int nbytes;
+};
+
+/* 
+ * ========================================================================
+ * ==== GLOBAL VARIABLES ==================================================
+ * ========================================================================
+ */
+
+static volatile int signal_done = 0;	// Boolean: Signal'ed, need to quit
+
+static char *ibase = "replay";		// Input base name
+static char *idir = ".";		// Input directory base
+static int cpus_to_use = -1;		// Number of CPUs to use
+static int def_iterations = 1;		// Default number of iterations
+static int naios = 512;			// Number of AIOs per thread
+static int ncpus = 0;			// Number of CPUs in the system
+static int verbose = 0;			// Boolean: Output some extra info
+static int write_enabled = 0;		// Boolean: Enable writing
+static __u64 genesis = ~0;		// Earliest time seen
+static __u64 rgenesis;			// Our start time
+static size_t pgsize;			// System Page size
+static int nb_sec = 512;		// Number of bytes per sector
+static LIST_HEAD(input_devs);		// List of devices to handle
+static LIST_HEAD(input_files);		// List of input files to handle
+static LIST_HEAD(map_devs);		// List of device maps
+static int nfiles = 0;			// Number of files to handle
+static int no_stalls = 0;		// Boolean: Disable pre-stalls
+static int find_records = 0;		// Boolean: Find record files auto
+
+/*
+ * Variables managed under control of condition variables.
+ *
+ * n_reclaims_done: 	Counts number of reclaim threads that have completed.
+ * n_replays_done:	Counts number of replay threads that have completed.
+ * n_replays_ready:	Counts number of replay threads ready to start.
+ * n_iters_done:	Counts number of replay threads done one iteration.
+ * iter_start:		Starts an iteration for the replay threads.
+ */
+static volatile int n_reclaims_done = 0;
+static pthread_mutex_t reclaim_done_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t reclaim_done_cond = PTHREAD_COND_INITIALIZER;
+
+static volatile int n_replays_done = 0;
+static pthread_mutex_t replay_done_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t replay_done_cond = PTHREAD_COND_INITIALIZER;
+
+static volatile int n_replays_ready = 0;
+static pthread_mutex_t replay_ready_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t replay_ready_cond = PTHREAD_COND_INITIALIZER;
+
+static volatile int n_iters_done = 0;
+static pthread_mutex_t iter_done_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t iter_done_cond = PTHREAD_COND_INITIALIZER;
+
+static volatile int iter_start = 0;
+static pthread_mutex_t iter_start_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t iter_start_cond = PTHREAD_COND_INITIALIZER;
+
+/* 
+ * ========================================================================
+ * ==== FORWARD REFERENECES ===============================================
+ * ========================================================================
+ */
+
+static void *replay_sub(void *arg);
+static void *replay_rec(void *arg);
+static char usage_str[];
+
+/* 
+ * ========================================================================
+ * ==== INLINE ROUTINES ===================================================
+ * ========================================================================
+ */
+
+/*
+ * The 'fatal' macro will output a perror message (if errstring is !NULL)
+ * and display a string (with variable arguments) and then exit with the 
+ * specified exit value.
+ */
+#define ERR_ARGS			1
+#define ERR_SYSCALL			2
+#define fatal(errstring, exitval, arg...)				\
+	do {								\
+		if (errstring) perror(errstring);			\
+		fprintf(stderr, ##arg);					\
+		exit(exitval);						\
+		/*NOTREACHED*/						\
+	} while (0)
+
+static inline long long unsigned du64_to_sec(__u64 du64)
+{
+	return (long long unsigned)du64 / (1000 * 1000 * 1000);
+}
+
+static inline long long unsigned du64_to_nsec(__u64 du64)
+{
+	return llabs((long long)du64) % (1000 * 1000 * 1000);
+}
+
+/**
+ * min - Return minimum of two integers
+ */
+static inline int min(int a, int b)
+{ 
+	return a < b ? a : b;
+}
+
+/**
+ * minl - Return minimum of two longs
+ */
+static inline long minl(long a, long b)
+{ 
+	return a < b ? a : b;
+}
+
+/**
+ * usage - Display usage string and version
+ */
+static inline void usage(void)
+{
+	fprintf(stderr, "Usage: btreplay -- version %s\n%s", 
+		my_btversion, usage_str);
+}
+
+/**
+ * is_send_done - Returns true if sender should quit early
+ * @tip: Per-thread information
+ */
+static inline int is_send_done(struct thr_info *tip)
+{
+	return signal_done || tip->send_done;
+}
+
+/**
+ * is_reap_done - Returns true if reaper should quit early
+ * @tip: Per-thread information
+ */
+static inline int is_reap_done(struct thr_info *tip)
+{
+	return tip->send_done && tip->naios_out == 0;
+}
+
+/**
+ * ts2ns - Convert timespec values to a nanosecond value
+ */
+#define NS_TICKS		((__u64)1000 * (__u64)1000 * (__u64)1000)
+static inline __u64 ts2ns(struct timespec *ts)
+{
+	return ((__u64)(ts->tv_sec) * NS_TICKS) + (__u64)(ts->tv_nsec);
+}
+
+/**
+ * ts2ns - Convert timeval values to a nanosecond value
+ */
+static inline __u64 tv2ns(struct timeval *tp)
+{
+	return ((__u64)(tp->tv_sec)) + ((__u64)(tp->tv_usec) * (__u64)1000);
+}
+
+/**
+ * touch_memory - Force physical memory to be allocating it
+ * 
+ * For malloc()ed memory we need to /touch/ it to make it really
+ * exist. Otherwise, for write's (to storage) things may not work
+ * as planned - we see Linux just use a single area to /read/ from
+ * (as there isn't any memory that has been associated with the 
+ * allocated virtual addresses yet).
+ */
+static inline void touch_memory(char *buf, size_t bsize)
+{
+#if defined(PREP_BUFS)
+	memset(buf, 0, bsize);
+#else
+	size_t i;
+
+	for (i = 0; i < bsize; i += pgsize)
+		buf[i] = 0;
+#endif
+}
+
+/**
+ * buf_alloc - Returns a page-aligned buffer of the specified size
+ * @nbytes: Number of bytes to allocate
+ */
+static inline void *buf_alloc(size_t nbytes)
+{
+	void *buf;
+
+	if (posix_memalign(&buf, pgsize, nbytes)) {
+		fatal("posix_memalign", ERR_SYSCALL, "Allocation failed\n");
+		/*NOTREACHED*/
+	}
+
+	return buf;
+}
+
+/**
+ * gettime - Returns current time 
+ */
+static inline __u64 gettime(void)
+{
+	static int use_clock_gettime = -1;		// Which clock to use
+
+	if (use_clock_gettime < 0) {
+		use_clock_gettime = clock_getres(CLOCK_MONOTONIC, NULL) == 0;
+		if (use_clock_gettime) {
+			struct timespec ts = {
+				.tv_sec = 0,
+				.tv_nsec = 0
+			};
+			clock_settime(CLOCK_MONOTONIC, &ts);
+		}
+	}
+
+	if (use_clock_gettime) {
+		struct timespec ts;
+		clock_gettime(CLOCK_MONOTONIC, &ts);
+		return ts2ns(&ts);
+	}
+	else {
+		struct timeval tp;
+		gettimeofday(&tp, NULL);
+		return tv2ns(&tp);
+	}
+}
+
+/**
+ * setup_signal - Set up a signal handler for the specified signum
+ */
+static inline void setup_signal(int signum, sighandler_t handler)
+{
+	if (signal(signum, handler) == SIG_ERR) {
+		fatal("signal", ERR_SYSCALL, "Failed to set signal %d\n",
+			signum);
+		/*NOTREACHED*/
+	}
+}
+
+/* 
+ * ========================================================================
+ * ==== CONDITION VARIABLE ROUTINES =======================================
+ * ========================================================================
+ */
+
+/**
+ * __set_cv - Increments a variable under condition variable control.
+ * @pmp: 	Pointer to the associated mutex
+ * @pcp: 	Pointer to the associated condition variable
+ * @vp: 	Pointer to the variable being incremented
+ * @mxv: 	Max value for variable (Used only when ASSERTS are on)
+ */
+static inline void __set_cv(pthread_mutex_t *pmp, pthread_cond_t *pcp,
+			    volatile int *vp, 
+			    __attribute__((__unused__))int mxv)
+{
+	pthread_mutex_lock(pmp);
+	assert(*vp < mxv);
+	*vp += 1;
+	pthread_cond_signal(pcp);
+	pthread_mutex_unlock(pmp);
+}
+
+/**
+ * __wait_cv - Waits for a variable under cond var control to hit a value
+ * @pmp: 	Pointer to the associated mutex
+ * @pcp: 	Pointer to the associated condition variable
+ * @vp: 	Pointer to the variable being incremented
+ * @mxv: 	Value to wait for
+ */
+static inline void __wait_cv(pthread_mutex_t *pmp, pthread_cond_t *pcp,
+			     volatile int *vp, int mxv)
+{
+	pthread_mutex_lock(pmp);
+	while (*vp < mxv)
+		pthread_cond_wait(pcp, pmp);
+	*vp = 0;
+	pthread_mutex_unlock(pmp);
+}
+
+static inline void set_reclaim_done(void)
+{
+	__set_cv(&reclaim_done_mutex, &reclaim_done_cond, &n_reclaims_done,
+		 nfiles);
+}
+
+static inline void wait_reclaims_done(void)
+{
+	__wait_cv(&reclaim_done_mutex, &reclaim_done_cond, &n_reclaims_done,
+		  nfiles);
+}
+
+static inline void set_replay_ready(void)
+{
+	__set_cv(&replay_ready_mutex, &replay_ready_cond, &n_replays_ready,
+		 nfiles);
+}
+
+static inline void wait_replays_ready(void)
+{
+	__wait_cv(&replay_ready_mutex, &replay_ready_cond, &n_replays_ready,
+		  nfiles);
+}
+
+static inline void set_replay_done(void)
+{
+	__set_cv(&replay_done_mutex, &replay_done_cond, &n_replays_done,
+		nfiles);
+}
+
+static inline void wait_replays_done(void)
+{
+	__wait_cv(&replay_done_mutex, &replay_done_cond, &n_replays_done,
+		  nfiles);
+}
+
+static inline void set_iter_done(void)
+{
+	__set_cv(&iter_done_mutex, &iter_done_cond, &n_iters_done,
+		nfiles);
+}
+
+static inline void wait_iters_done(void)
+{
+	__wait_cv(&iter_done_mutex, &iter_done_cond, &n_iters_done,
+		  nfiles);
+}
+
+/**
+ * wait_iter_start - Wait for an iteration to start 
+ * 
+ * This is /slightly/ different: we are waiting for a value to become
+ * non-zero, and then we decrement it and go on. 
+ */
+static inline void wait_iter_start(void)
+{
+	pthread_mutex_lock(&iter_start_mutex);
+	while (iter_start == 0)
+		pthread_cond_wait(&iter_start_cond, &iter_start_mutex);
+	assert(1 <= iter_start && iter_start <= nfiles);
+	iter_start--;
+	pthread_mutex_unlock(&iter_start_mutex);
+}
+
+/**
+ * start_iter - Start an iteration at the replay thread level
+ */
+static inline void start_iter(void)
+{
+	pthread_mutex_lock(&iter_start_mutex);
+	assert(iter_start == 0);
+	iter_start = nfiles;
+	pthread_cond_broadcast(&iter_start_cond);
+	pthread_mutex_unlock(&iter_start_mutex);
+}
+
+/* 
+ * ========================================================================
+ * ==== CPU RELATED ROUTINES ==============================================
+ * ========================================================================
+ */
+
+/**
+ * get_ncpus - Sets up the global 'ncpus' value
+ */
+static void get_ncpus(void)
+{
+	cpu_set_t cpus;
+
+	if (sched_getaffinity(getpid(), sizeof(cpus), &cpus)) {
+		fatal("sched_getaffinity", ERR_SYSCALL, "Can't get CPU info\n");
+		/*NOTREACHED*/
+	}
+
+	/*
+	 * XXX This assumes (perhaps wrongly) that there are no /holes/ 
+	 * XXX in the mask.
+	 */
+	for (ncpus = 0; ncpus < CPU_SETSIZE && CPU_ISSET(ncpus, &cpus); ncpus++)
+		;
+	if (ncpus == 0) {
+		fatal(NULL, ERR_SYSCALL, "Insufficient number of CPUs\n");
+		/*NOTREACHED*/
+	}
+}
+
+/**
+ * pin_to_cpu - Pin this thread to a specific CPU
+ * @tip: Thread information
+ */
+static void pin_to_cpu(struct thr_info *tip)
+{
+	cpu_set_t cpus;
+
+	assert(0 <= tip->cpu && tip->cpu < ncpus);
+
+	CPU_ZERO(&cpus);
+	CPU_SET(tip->cpu, &cpus);
+	if (sched_setaffinity(getpid(), sizeof(cpus), &cpus)) {
+		fatal("sched_setaffinity", ERR_SYSCALL, "Failed to pin CPU\n");
+		/*NOTREACHED*/
+	}
+
+	if (verbose > 1) {
+		int i;
+		cpu_set_t now;
+
+		(void)sched_getaffinity(getpid(), sizeof(now), &now);
+		fprintf(tip->vfp, "Pinned to CPU %02d ", tip->cpu);
+		for (i = 0; i < ncpus; i++)
+			fprintf(tip->vfp, "%1d", CPU_ISSET(i, &now));
+		fprintf(tip->vfp, "\n");
+	}
+}
+
+/* 
+ * ========================================================================
+ * ==== INPUT DEVICE HANDLERS =============================================
+ * ========================================================================
+ */
+
+/**
+ * add_input_dev - Add a device ('sd*') to the list of devices to handle
+ */
+static void add_input_dev(char *devnm)
+{
+	struct list_head *p;
+	struct dev_info *dip;
+
+	__list_for_each(p, &input_devs) {
+		dip = list_entry(p, struct dev_info, head);
+		if (strcmp(dip->devnm, devnm) == 0)
+			return;
+	}
+
+	dip = malloc(sizeof(*dip));
+	dip->devnm = strdup(devnm);
+	list_add_tail(&dip->head, &input_devs);
+}
+
+/**
+ * rem_input_dev - Remove resources associated with this device
+ */
+static void rem_input_dev(struct dev_info *dip)
+{
+	list_del(&dip->head);
+	free(dip->devnm);
+	free(dip);
+}
+
+static void find_input_devs(char *idir)
+{
+	struct dirent *ent;
+	DIR *dir = opendir(idir);
+
+	if (dir == NULL) {
+		fatal(idir, ERR_ARGS, "Unable to open %s\n", idir);
+		/*NOTREACHED*/
+	}
+
+	while ((ent = readdir(dir)) != NULL) {
+		char *p, *dsf = malloc(256);
+
+		if (strstr(ent->d_name, ".replay.") == NULL)
+			continue;
+
+		dsf = strdup(ent->d_name);
+		p = index(dsf, '.');
+		assert(p != NULL);
+		*p = '\0';
+		add_input_dev(dsf);
+		free(dsf);
+	}
+
+	closedir(dir);
+}
+
+/* 
+ * ========================================================================
+ * ==== MAP DEVICE INTERFACES =============================================
+ * ========================================================================
+ */
+
+/**
+ * read_map_devs - Read in a set of device mapping from the provided file.
+ * @file_name:	File containing device maps
+ *
+ * We support the notion of multiple such files being specifed on the cmd line
+ */
+static void read_map_devs(char *file_name)
+{
+	FILE *fp;
+	char *from_dev, *to_dev;
+
+	fp = fopen(file_name, "r");
+	if (!fp) {
+		fatal(file_name, ERR_SYSCALL, "Could not open map devs file\n");
+		/*NOTREACHED*/
+	}
+
+	while (fscanf(fp, "%as %as", &from_dev, &to_dev) == 2) {
+		struct map_dev *mdp = malloc(sizeof(*mdp));
+
+		mdp->from_dev = from_dev;
+		mdp->to_dev = to_dev;
+		list_add_tail(&mdp->head, &map_devs);
+	}
+
+	fclose(fp);
+}
+
+/**
+ * release_map_devs - Release resources associated with device mappings.
+ */
+static void release_map_devs(void)
+{
+	struct list_head *p, *q;
+
+	list_for_each_safe(p, q, &map_devs) {
+		struct map_dev *mdp = list_entry(p, struct map_dev, head);
+
+		list_del(&mdp->head);
+
+		free(mdp->from_dev);
+		free(mdp->to_dev);
+		free(mdp);
+	}
+}
+
+/**
+ * map_dev - Return the mapped device for that specified
+ * @from_dev:	Device name as seen on recorded system
+ *
+ * Note: If there is no such mapping, we return the same name.
+ */
+static char *map_dev(char *from_dev)
+{
+	struct list_head *p;
+
+	__list_for_each(p, &map_devs) {
+		struct map_dev *mdp = list_entry(p, struct map_dev, head);
+
+		if (strcmp(from_dev, mdp->from_dev) == 0)
+			return mdp->to_dev;
+	}
+
+	return from_dev;
+}
+
+/* 
+ * ========================================================================
+ * ==== IOCB MANAGEMENT ROUTINES ==========================================
+ * ========================================================================
+ */
+
+/**
+ * iocb_init - Initialize the fields of an IOCB
+ * @tip: Per-thread information
+ * iocbp: IOCB pointer to update
+ */
+static void iocb_init(struct thr_info *tip, struct iocb_pkt *iocbp)
+{
+	iocbp->tip = tip;
+	iocbp->nbytes = 0;
+	iocbp->iocb.u.c.buf = NULL;
+}
+
+/**
+ * iocb_setup - Set up an iocb with this AIOs information
+ * @iocbp: IOCB pointer to update
+ * @rw: Direction (0 == write, 1 == read)
+ * @n: Number of bytes to transfer
+ * @off: Offset (in bytes)
+ */
+static void iocb_setup(struct iocb_pkt *iocbp, int rw, int n, long long off)
+{
+	char *buf;
+	struct iocb *iop = &iocbp->iocb;
+
+	assert(rw == 0 || rw == 1);
+	assert(0 < n && (n % nb_sec) == 0);
+	assert(0 <= off);
+
+	if (iocbp->nbytes) {
+		if (iocbp->nbytes >= n) {
+			buf = iop->u.c.buf;
+			goto prep;
+		}
+
+		assert(iop->u.c.buf);
+		free(iop->u.c.buf);
+	}
+
+	buf = buf_alloc(n);
+	iocbp->nbytes = n;
+
+prep:
+	if (rw)
+		io_prep_pread(iop, iocbp->tip->ofd, buf, n, off);
+	else {
+		assert(write_enabled);
+		io_prep_pwrite(iop, iocbp->tip->ofd, buf, n, off);
+		touch_memory(buf, n);
+	}
+
+	iop->data = iocbp;
+}
+
+/* 
+ * ========================================================================
+ * ==== PER-THREAD SET UP & TEAR DOWN =====================================
+ * ========================================================================
+ */
+
+/**
+ * tip_init - Per thread initialization function
+ */
+static void tip_init(struct thr_info *tip)
+{
+	int i;
+
+	INIT_LIST_HEAD(&tip->free_iocbs);
+	INIT_LIST_HEAD(&tip->used_iocbs);
+
+	pthread_mutex_init(&tip->mutex, NULL);
+	pthread_cond_init(&tip->cond, NULL);
+
+	if (io_setup(naios, &tip->ctx)) {
+		fatal("io_setup", ERR_SYSCALL, "io_setup failed\n");
+		/*NOTREACHED*/
+	}
+
+	tip->ofd = -1;
+	tip->naios_out = 0;
+	tip->send_done = tip->reap_done = 0;
+	tip->send_wait = tip->reap_wait = 0;
+
+	memset(&tip->sub_thread, 0, sizeof(tip->sub_thread));
+	memset(&tip->rec_thread, 0, sizeof(tip->rec_thread));
+
+	for (i = 0; i < naios; i++) {
+		struct iocb_pkt *iocbp = buf_alloc(sizeof(*iocbp));
+
+		iocb_init(tip, iocbp);
+		list_add_tail(&iocbp->head, &tip->free_iocbs);
+	}
+	tip->naios_free = naios;
+
+	if (verbose > 1) {
+		char fn[MAXPATHLEN];
+
+		sprintf(fn, "%s/%s.%s.%d.rep", idir, tip->devnm, ibase, 
+			tip->cpu);
+		tip->vfp = fopen(fn, "w");
+		if (!tip->vfp) {
+			fatal(fn, ERR_SYSCALL, "Failed to open report\n");
+			/*NOTREACHED*/
+		}
+
+		setlinebuf(tip->vfp);
+	}
+
+	if (pthread_create(&tip->sub_thread, NULL, replay_sub, tip)) {
+		fatal("pthread_create", ERR_SYSCALL, 
+			"thread create failed\n");
+		/*NOTREACHED*/
+	}
+
+	if (pthread_create(&tip->rec_thread, NULL, replay_rec, tip)) {
+		fatal("pthread_create", ERR_SYSCALL, 
+			"thread create failed\n");
+		/*NOTREACHED*/
+	}
+}
+
+/**
+ * tip_release - Release resources associated with this thread
+ */
+static void tip_release(struct thr_info *tip)
+{
+	struct list_head *p, *q;
+
+	assert(tip->send_done);
+	assert(tip->reap_done);
+	assert(list_len(&tip->used_iocbs) == 0);
+	assert(tip->naios_free == naios);
+
+	if (pthread_join(tip->sub_thread, NULL)) {
+		fatal("pthread_join", ERR_SYSCALL, "pthread sub join failed\n");
+		/*NOTREACHED*/
+	}
+	if (pthread_join(tip->rec_thread, NULL)) {
+		fatal("pthread_join", ERR_SYSCALL, "pthread rec join failed\n");
+		/*NOTREACHED*/
+	}
+
+	io_destroy(tip->ctx);
+
+	list_splice(&tip->used_iocbs, &tip->free_iocbs);
+	list_for_each_safe(p, q, &tip->free_iocbs) {
+		struct iocb_pkt *iocbp = list_entry(p, struct iocb_pkt, head);
+
+		list_del(&iocbp->head);
+		if (iocbp->nbytes) 
+			free(iocbp->iocb.u.c.buf);
+		free(iocbp);
+	}
+
+	pthread_cond_destroy(&tip->cond);
+	pthread_mutex_destroy(&tip->mutex);
+}
+
+/**
+ * add_input_file - Allocate and initialize per-input file structure
+ * @cpu: CPU for this file
+ * @devnm: Device name for this file
+ * @file_name: Fully qualifed input file name
+ */
+static void add_input_file(int cpu, char *devnm, char *file_name)
+{
+	struct stat buf;
+	struct io_file_hdr hdr;
+	struct thr_info *tip = buf_alloc(sizeof(*tip));
+	__u64 my_version = mk_btversion(btver_mjr, btver_mnr, btver_sub);
+
+	assert(0 <= cpu && cpu < ncpus);
+
+	memset(&hdr, 0, sizeof(hdr));
+	memset(tip, 0, sizeof(*tip));
+	tip->cpu = cpu % cpus_to_use;
+	tip->iterations = def_iterations;
+
+	tip->ifd = open(file_name, O_RDONLY);
+	if (tip->ifd < 0) {
+		fatal(file_name, ERR_ARGS, "Unable to open\n");
+		/*NOTREACHED*/
+	}
+	if (fstat(tip->ifd, &buf) < 0) {
+		fatal(file_name, ERR_SYSCALL, "fstat failed\n");
+		/*NOTREACHED*/
+	}
+	if (buf.st_size < (off_t)sizeof(hdr)) {
+		if (verbose)
+			fprintf(stderr, "\t%s empty\n", file_name);
+		goto empty_file;
+	}
+
+	if (read(tip->ifd, &hdr, sizeof(hdr)) != sizeof(hdr)) {
+		fatal(file_name, ERR_ARGS, "Header read failed\n");
+		/*NOTREACHED*/
+	}
+
+	if (hdr.version != my_version) {
+		fprintf(stderr, "%llx %llx %llx %llx\n", 
+			(long long unsigned)hdr.version,
+			(long long unsigned)hdr.genesis,
+			(long long unsigned)hdr.nbunches,
+			(long long unsigned)hdr.total_pkts);
+		fatal(NULL, ERR_ARGS, 
+			"BT version mismatch: %lx versus my %lx\n",
+			(long)hdr.version, (long)my_version);
+			
+	}
+
+	if (hdr.nbunches == 0) {
+empty_file:
+		close(tip->ifd);
+		free(tip);
+		return;
+	}
+
+	if (hdr.genesis < genesis) {
+		if (verbose > 1)
+			fprintf(stderr, "Setting genesis to %llu.%llu\n",
+				du64_to_sec(hdr.genesis),
+				du64_to_nsec(hdr.genesis));
+		genesis = hdr.genesis;
+	}
+
+	tip->devnm = strdup(devnm);
+	tip->file_name = strdup(file_name);
+
+	list_add_tail(&tip->head, &input_files);
+
+	if (verbose)
+		fprintf(stderr, "Added %s %llu\n", file_name, 
+			(long long)hdr.genesis);
+}
+
+/**
+ * rem_input_file - Release resources associated with an input file
+ * @tip: Per-input file information
+ */
+static void rem_input_file(struct thr_info *tip)
+{
+	list_del(&tip->head);
+
+	tip_release(tip);
+
+	close(tip->ofd);
+	close(tip->ifd);
+	free(tip->file_name);
+	free(tip->devnm);
+	free(tip);
+}
+
+/**
+ * rem_input_files - Remove all input files
+ */
+static void rem_input_files(void)
+{
+	struct list_head *p, *q;
+
+	list_for_each_safe(p, q, &input_files) {
+		rem_input_file(list_entry(p, struct thr_info, head));
+	}
+}
+
+/**
+ * __find_input_files - Find input files associated with this device (per cpu)
+ */
+static void __find_input_files(struct dev_info *dip)
+{
+	int cpu = 0;
+
+	for (;;) {
+		char full_name[MAXPATHLEN];
+
+		sprintf(full_name, "%s/%s.%s.%d", idir, dip->devnm, ibase, cpu);
+		if (access(full_name, R_OK) != 0)
+			break;
+
+		add_input_file(cpu, dip->devnm, full_name);
+		cpu++;
+	}
+
+	if (!cpu) {
+		fatal(NULL, ERR_ARGS, "No traces found for %s\n", dip->devnm);
+		/*NOTREACHED*/
+	}
+
+	rem_input_dev(dip);
+}
+
+
+/**
+ * find_input_files - Find input files for all devices
+ */
+static void find_input_files(void)
+{
+	struct list_head *p, *q;
+
+	list_for_each_safe(p, q, &input_devs) {
+		__find_input_files(list_entry(p, struct dev_info, head));
+	}
+}
+
+/* 
+ * ========================================================================
+ * ==== RECLAIM ROUTINES ==================================================
+ * ========================================================================
+ */
+
+/**
+ * reap_wait_aios - Wait for and return number of outstanding AIOs
+ *
+ * Will return 0 if we are done
+ */
+static int reap_wait_aios(struct thr_info *tip)
+{
+	int naios = 0;
+
+	if (!is_reap_done(tip)) {
+		pthread_mutex_lock(&tip->mutex);
+		while (tip->naios_out == 0) {
+			tip->reap_wait = 1;
+			if (pthread_cond_wait(&tip->cond, &tip->mutex)) {
+				fatal("pthread_cond_wait", ERR_SYSCALL, 
+					"nfree_current cond wait failed\n");
+				/*NOTREACHED*/
+			}
+		}
+		naios = tip->naios_out;
+		pthread_mutex_unlock(&tip->mutex);
+	}
+	assert(is_reap_done(tip) || naios > 0);
+
+	return is_reap_done(tip) ? 0 : naios;
+}
+
+/**
+ * reclaim_ios - Reclaim AIOs completed, recycle IOCBs
+ * @tip: Per-thread information
+ * @naios_out: Number of AIOs we have outstanding (min)
+ */
+static void reclaim_ios(struct thr_info *tip, long naios_out)
+{
+	long i, ndone;
+	struct io_event *evp, events[naios_out];
+
+again:
+	assert(naios > 0);
+	for (;;) {
+		ndone = io_getevents(tip->ctx, 1, naios_out, events, NULL);
+		if (ndone > 0)
+			break;
+
+		if (errno && errno != EINTR) {
+			fatal("io_getevents", ERR_SYSCALL, 
+				"io_getevents failed\n");
+			/*NOTREACHED*/
+		}
+	}
+	assert(0 < ndone && ndone <= naios_out);
+
+	pthread_mutex_lock(&tip->mutex);
+	for (i = 0, evp = events; i < ndone; i++, evp++) {
+		struct iocb_pkt *iocbp = evp->data;
+
+                if (evp->res != iocbp->iocb.u.c.nbytes) {
+                        fatal(NULL, ERR_SYSCALL,
+                              "Event failure %ld/%ld\t(%ld + %ld)\n",
+                              (long)evp->res, (long)evp->res2,
+                              (long)iocbp->iocb.u.c.offset / nb_sec, 
+			      (long)iocbp->iocb.u.c.nbytes / nb_sec);
+                        /*NOTREACHED*/
+                }
+
+		list_move_tail(&iocbp->head, &tip->free_iocbs);
+	}
+
+	tip->naios_free += ndone;
+	tip->naios_out -= ndone;
+	naios_out = minl(naios_out, tip->naios_out);
+
+	if (tip->send_wait) {
+		tip->send_wait = 0;
+		pthread_cond_signal(&tip->cond);
+	}
+	pthread_mutex_unlock(&tip->mutex);
+
+	/*
+	 * Short cut: If we /know/ there are some more AIOs, go handle them
+	 */
+	if (naios_out)
+		goto again;
+}
+
+/**
+ * replay_rec - Worker thread to reclaim AIOs
+ * @arg: Pointer to thread information
+ */
+static void *replay_rec(void *arg)
+{
+	long naios_out;
+	struct thr_info *tip = arg;
+
+	while ((naios_out = reap_wait_aios(tip)) > 0) 
+		reclaim_ios(tip, naios_out);
+
+	assert(tip->send_done);
+	tip->reap_done = 1;
+	set_reclaim_done();
+
+	return NULL;
+}
+
+/* 
+ * ========================================================================
+ * ==== REPLAY ROUTINES ===================================================
+ * ========================================================================
+ */
+
+/**
+ * next_bunch - Retrieve next bunch of AIOs to process
+ * @tip: Per-thread information
+ * @bunch: Bunch information
+ *
+ * Returns TRUE if we recovered a bunch of IOs, else hit EOF
+ */
+static int next_bunch(struct thr_info *tip, struct io_bunch *bunch)
+{
+	size_t count, result;
+	
+	result = read(tip->ifd, &bunch->hdr, sizeof(bunch->hdr));
+	if (result != sizeof(bunch->hdr)) {
+		if (result == 0)
+			return 0;
+
+		fatal(tip->file_name, ERR_SYSCALL, "Short hdr(%ld)\n", 
+			(long)result);
+		/*NOTREACHED*/
+	}
+	assert(bunch->hdr.npkts <= BT_MAX_PKTS);
+
+	count = bunch->hdr.npkts * sizeof(struct io_pkt);
+	result = read(tip->ifd, &bunch->pkts, count);
+	if (result != count) {
+		fatal(tip->file_name, ERR_SYSCALL, "Short pkts(%ld/%ld)\n", 
+			(long)result, (long)count);
+		/*NOTREACHED*/
+	}
+
+	return 1;
+}
+
+/**
+ * nfree_current - Returns current number of AIOs that are free
+ *
+ * Will wait for available ones...
+ *
+ * Returns 0 if we have some condition that causes us to exit
+ */
+static int nfree_current(struct thr_info *tip)
+{
+	int nfree = 0;
+
+	pthread_mutex_lock(&tip->mutex);
+	while (!is_send_done(tip) && ((nfree = tip->naios_free) == 0)) {
+		tip->send_wait = 1;
+		if (pthread_cond_wait(&tip->cond, &tip->mutex)) {
+			fatal("pthread_cond_wait", ERR_SYSCALL, 
+				"nfree_current cond wait failed\n");
+			/*NOTREACHED*/
+		}
+	}
+	pthread_mutex_unlock(&tip->mutex);
+
+	return nfree;
+}
+
+/**
+ * stall - Stall for the number of nanoseconds requested
+ *
+ * We may be late, in which case we just return.
+ */
+static void stall(struct thr_info *tip, long long oclock)
+{
+	struct timespec req;
+	long long dreal, tclock = gettime() - rgenesis;
+
+	if (verbose > 1)
+		fprintf(tip->vfp, "   stall(%lld.%09lld, %lld.%09lld)\n",
+			du64_to_sec(oclock), du64_to_nsec(oclock),
+			du64_to_sec(tclock), du64_to_nsec(tclock));
+
+	while (!is_send_done(tip) && tclock < oclock) {
+		dreal = oclock - tclock;
+		req.tv_sec = dreal / (1000 * 1000 * 1000);
+		req.tv_nsec = dreal % (1000 * 1000 * 1000);
+
+		if (verbose > 1) {
+			fprintf(tip->vfp, "++ stall(%lld.%09lld) ++\n",
+				(long long)req.tv_sec,
+				(long long)req.tv_nsec);
+		}
+
+		if (nanosleep(&req, NULL) < 0 && signal_done)
+			break;
+
+		tclock = gettime() - rgenesis;
+	}
+}
+
+/**
+ * iocbs_map - Map a set of AIOs onto a set of IOCBs
+ * @tip: Per-thread information
+ * @list: List of AIOs created
+ * @pkts: AIOs to map
+ * @ntodo: Number of AIOs to map
+ */
+static void iocbs_map(struct thr_info *tip, struct iocb **list, 
+					     struct io_pkt *pkts, int ntodo)
+{
+	int i;
+	struct io_pkt *pkt;
+
+	assert(0 < ntodo && ntodo <= naios);
+
+	pthread_mutex_lock(&tip->mutex);
+	assert(ntodo <= list_len(&tip->free_iocbs));
+	for (i = 0, pkt = pkts; i < ntodo; i++, pkt++) {
+		__u32 rw = pkt->rw;
+		struct iocb_pkt *iocbp;
+
+		if (!pkt->rw && !write_enabled)
+			rw = 1;
+
+		if (verbose > 1)
+			fprintf(tip->vfp, "\t%10llu + %10llu %c%c\n",
+				(unsigned long long)pkt->sector, 
+				(unsigned long long)pkt->nbytes / nb_sec,
+				rw ? 'R' : 'W', 
+				(rw == 1 && pkt->rw == 0) ? '!' : ' ');
+		
+		iocbp = list_entry(tip->free_iocbs.next, struct iocb_pkt, head);
+		iocb_setup(iocbp, rw, pkt->nbytes, pkt->sector * nb_sec);
+
+		list_move_tail(&iocbp->head, &tip->used_iocbs);
+		list[i] = &iocbp->iocb;
+	}
+
+	tip->naios_free -= ntodo;
+	assert(tip->naios_free >= 0);
+	pthread_mutex_unlock(&tip->mutex);
+}
+
+/**
+ * process_bunch - Process a bunch of requests
+ * @tip: Per-thread information
+ * @bunch: Bunch to process
+ */
+static void process_bunch(struct thr_info *tip, struct io_bunch *bunch)
+{
+	__u64 i = 0;
+	struct iocb *list[bunch->hdr.npkts];
+
+	assert(0 < bunch->hdr.npkts && bunch->hdr.npkts <= BT_MAX_PKTS);
+	while (!is_send_done(tip) && (i < bunch->hdr.npkts)) {
+		long ndone;
+		int ntodo = min(nfree_current(tip), bunch->hdr.npkts - i);
+
+		assert(0 < ntodo && ntodo <= naios);
+		iocbs_map(tip, list, &bunch->pkts[i], ntodo);
+		if (!no_stalls)
+			stall(tip, bunch->hdr.time_stamp - genesis);
+
+		if (ntodo) {
+			if (verbose > 1)
+				fprintf(tip->vfp, "submit(%d)\n", ntodo);
+			ndone = io_submit(tip->ctx, ntodo, list);
+			if (ndone != (long)ntodo) {
+				fatal("io_submit", ERR_SYSCALL,
+					"%d: io_submit(%d:%ld) failed (%s)\n", 
+					tip->cpu, ntodo, ndone, 
+					strerror(labs(ndone)));
+				/*NOTREACHED*/
+			}
+
+			pthread_mutex_lock(&tip->mutex);
+			tip->naios_out += ndone;
+			assert(tip->naios_out <= naios);
+			if (tip->reap_wait) {
+				tip->reap_wait = 0;
+				pthread_cond_signal(&tip->cond);
+			}
+			pthread_mutex_unlock(&tip->mutex);
+
+			i += ndone;
+			assert(i <= bunch->hdr.npkts);
+		}
+	}
+}
+
+/**
+ * reset_input_file - Reset the input file for the next iteration
+ * @tip: Thread information
+ *
+ * We also do a dummy read of the file header to get us to the first bunch.
+ */
+static void reset_input_file(struct thr_info *tip)
+{
+	struct io_file_hdr hdr;
+
+	lseek(tip->ifd, 0, 0);
+
+	if (read(tip->ifd, &hdr, sizeof(hdr)) != sizeof(hdr)) {
+		fatal(tip->file_name, ERR_ARGS, "Header reread failed\n");
+		/*NOTREACHED*/
+	}
+}
+
+/**
+ * replay_sub - Worker thread to submit AIOs that are being replayed
+ */
+static void *replay_sub(void *arg)
+{
+	char path[MAXPATHLEN];
+	struct io_bunch bunch;
+	struct thr_info *tip = arg;
+
+	pin_to_cpu(tip);
+
+	sprintf(path, "/dev/%s", map_dev(tip->devnm));
+	tip->ofd = open(path, O_RDWR | O_DIRECT);
+	if (tip->ofd < 0) {
+		fatal(path, ERR_SYSCALL, "Failed device open\n");
+		/*NOTREACHED*/
+	}
+
+	set_replay_ready();
+	while (!is_send_done(tip) && tip->iterations--) {
+		wait_iter_start();
+		if (verbose)
+			fprintf(tip->vfp, "\n=== %d ===\n", tip->iterations);
+		while (!is_send_done(tip) && next_bunch(tip, &bunch))
+			process_bunch(tip, &bunch);
+		set_iter_done();
+		reset_input_file(tip);
+	}
+	tip->send_done = 1;
+	set_replay_done();
+
+	return NULL;
+}
+
+/* 
+ * ========================================================================
+ * ==== COMMAND LINE ARGUMENT HANDLING ====================================
+ * ========================================================================
+ */
+
+static char usage_str[] = 						\
+        "\n"                                                           \
+        "\t[ -c <cpus> : --cpus=<cpus>           ] Default: 1\n"        \
+        "\t[ -d <dir>  : --input-directory=<dir> ] Default: .\n"        \
+	"\t[ -F        : --find-records          ] Default: Off\n"         \
+        "\t[ -h        : --help                  ] Default: Off\n"      \
+        "\t[ -i <base> : --input-base=<base>     ] Default: replay\n"   \
+        "\t[ -I <iters>: --iterations=<iters>    ] Default: 1\n"        \
+        "\t[ -M <file> : --map-devs=<file>       ] Default: None\n"     \
+        "\t[ -N        : --no-stalls             ] Default: Off\n"      \
+        "\t[ -v        : --verbose               ] Default: Off\n"      \
+        "\t[ -V        : --version               ] Default: Off\n"      \
+        "\t[ -W        : --write-enable          ] Default: Off\n"      \
+        "\t<dev...>                                Default: None\n"     \
+        "\n";
+
+#define S_OPTS	"c:d:Fhi:I:M:Nt:vVW"
+static struct option l_opts[] = {
+	{
+		.name = "cpus",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'c'
+	},
+	{
+		.name = "input-directory",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'd'
+	},
+	{
+		.name = "find-records",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'F'
+	},
+	{
+		.name = "help",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'h'
+	},
+	{
+		.name = "input-base",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'i'
+	},
+	{
+		.name = "iterations",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'I'
+	},
+	{
+		.name = "map-devs",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'M'
+	},
+	{
+		.name = "no-stalls",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'N'
+	},
+	{
+		.name = "verbose",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'v'
+	},
+	{
+		.name = "version",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'V'
+	},
+	{
+		.name = "write-enable",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'W'
+	},
+	{
+		.name = NULL
+	}
+};
+
+/**
+ * handle_args: Parse passed in argument list
+ * @argc: Number of arguments in argv
+ * @argv: Arguments passed in
+ *
+ * Does rudimentary parameter verification as well.
+ */
+static void handle_args(int argc, char *argv[])
+{
+	int c;
+
+	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) != -1) {
+		switch (c) {
+		case 'c': 
+			cpus_to_use = atoi(optarg);
+			if (cpus_to_use <= 0 || cpus_to_use > ncpus) {
+				fatal(NULL, ERR_ARGS, 
+				      "Invalid number of cpus %d (0<x<%d)\n",
+				      cpus_to_use, ncpus);
+				/*NOTREACHED*/
+			}
+			break;
+
+		case 'd':
+			idir = optarg;
+			if (access(idir, R_OK | X_OK) != 0) {
+				fatal(idir, ERR_ARGS, 
+				      "Invalid input directory specified\n");
+				/*NOTREACHED*/
+			}
+			break;
+
+		case 'F': 
+			find_records = 1;
+			break;
+
+		case 'h': 
+			usage(); 
+			exit(0);
+			/*NOTREACHED*/
+
+		case 'i': 
+			ibase = optarg;
+			break;
+
+		case 'I':
+			def_iterations = atoi(optarg);
+			if (def_iterations <= 0) {
+				fprintf(stderr, 
+					"Invalid number of iterations %d\n",
+					def_iterations);
+				exit(ERR_ARGS);
+				/*NOTREACHED*/
+			}
+			break;
+
+		case 'M':
+			read_map_devs(optarg);
+			break;
+
+		case 'N':
+			no_stalls = 1;
+			break;
+
+		case 'V':
+			fprintf(stderr, "btreplay -- version %s\n", 
+				my_btversion);
+			fprintf(stderr, "            Built on %s\n", 
+				build_date);
+			exit(0);
+			/*NOTREACHED*/
+
+		case 'v':
+			verbose++;
+			break;
+
+		case 'W':
+			write_enabled = 1;
+			break;
+
+		default:
+			usage();
+			fatal(NULL, ERR_ARGS, 
+			      "Invalid command line argument %c\n", c);
+			/*NOTREACHED*/
+		}
+	}
+
+	while (optind < argc)
+		add_input_dev(argv[optind++]);
+
+	if (find_records)
+		find_input_devs(idir);
+
+	if (list_len(&input_devs) == 0) {
+		fatal(NULL, ERR_ARGS, "Missing required input dev name(s)\n");
+		/*NOTREACHED*/
+	}
+
+	if (cpus_to_use < 0)
+		cpus_to_use = ncpus;
+}
+
+/* 
+ * ========================================================================
+ * ==== MAIN ROUTINE ======================================================
+ * ========================================================================
+ */
+
+/**
+ * set_signal_done - Signal handler, catches signals & sets signal_done
+ */
+static void set_signal_done(__attribute__((__unused__))int signum)
+{
+	signal_done = 1;
+}
+
+/**
+ * main - 
+ * @argc: Number of arguments
+ * @argv: Array of arguments
+ */
+int main(int argc, char *argv[])
+{
+	int i;
+	struct list_head *p;
+
+	pgsize = getpagesize();
+	assert(pgsize > 0);
+
+	setup_signal(SIGINT, set_signal_done);
+	setup_signal(SIGTERM, set_signal_done);
+
+	get_ncpus();
+	handle_args(argc, argv);
+	find_input_files();
+
+	nfiles = list_len(&input_files);
+	__list_for_each(p, &input_files) {
+		tip_init(list_entry(p, struct thr_info, head));
+	}
+
+	wait_replays_ready();
+	for (i = 0; i < def_iterations; i++) {
+		rgenesis = gettime();
+		start_iter();
+		if (verbose)
+			fprintf(stderr, "I");
+		wait_iters_done();
+	}
+
+	wait_replays_done();
+	wait_reclaims_done();
+
+	if (verbose)
+		fprintf(stderr, "\n");
+
+	rem_input_files();
+	release_map_devs();
+
+	return 0;
+}
diff --git a/btreplay/doc/Makefile b/btreplay/doc/Makefile
new file mode 100644
index 0000000..e3b383e
--- /dev/null
+++ b/btreplay/doc/Makefile
@@ -0,0 +1,18 @@
+DOCTMP  = btreplay.log btreplay.aux btreplay.dvi btreplay.toc
+
+all: btreplay.dvi btreplay.pdf
+
+btreplay.tex:
+	@touch btreplay.tex
+
+btreplay.dvi: btreplay.tex abstract.tex
+	@latex btreplay.tex
+	@latex btreplay.tex
+
+btreplay.pdf: btreplay.dvi
+	@dvipdfm -p letter btreplay
+
+clean:
+	-rm -f $(DOCTMP)
+	-rm -f *.bak *.ps *.pdf
+	@rm -rf btreplay
diff --git a/btreplay/doc/abstract.tex b/btreplay/doc/abstract.tex
new file mode 100644
index 0000000..314d820
--- /dev/null
+++ b/btreplay/doc/abstract.tex
@@ -0,0 +1,34 @@
+%
+% Copyright (C) 2007 Alan D. Brunelle <Alan.Brunelle@hp.com>
+%
+%  This program is free software; you can redistribute it and/or modify
+%  it under the terms of the GNU General Public License as published by
+%  the Free Software Foundation; either version 2 of the License, or
+%  (at your option) any later version.
+%
+%  This program is distributed in the hope that it will be useful,
+%  but WITHOUT ANY WARRANTY; without even the implied warranty of
+%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+%  GNU General Public License for more details.
+%
+%  You should have received a copy of the GNU General Public License
+%  along with this program; if not, write to the Free Software
+%  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+%
+%  vi :set textwidth=75
+%
+The \texttt{btrecord} and \texttt{btreplay} tools provide the ability to
+record and replay IOs captured by the \texttt{blktrace} utility. Attempts
+are made to maintain ordering, CPU mappings and time-separation of IOs. The
+general workflow is expected to be:
+
+\begin{enumerate}
+  \item Initiate \texttt{blktrace} to capture traces
+  \item Generate traces\ldots
+  \item Stop \texttt{blktrace}
+  \item Run \texttt{btrecord} to convert traces into IO records 
+  \item Utilize \texttt{btreplay} to replay IOs 
+\end{enumerate}
+
+This document will discuss the operating characteristics of
+\texttt{btreplay} and provide detailed command line option descriptions.
diff --git a/btreplay/doc/btreplay.tex b/btreplay/doc/btreplay.tex
new file mode 100644
index 0000000..beec720
--- /dev/null
+++ b/btreplay/doc/btreplay.tex
@@ -0,0 +1,521 @@
+%
+% Copyright (C) 2007 Alan D. Brunelle <Alan.Brunelle@hp.com>
+%
+%  This program is free software; you can redistribute it and/or modify
+%  it under the terms of the GNU General Public License as published by
+%  the Free Software Foundation; either version 2 of the License, or
+%  (at your option) any later version.
+%
+%  This program is distributed in the hope that it will be useful,
+%  but WITHOUT ANY WARRANTY; without even the implied warranty of
+%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+%  GNU General Public License for more details.
+%
+%  You should have received a copy of the GNU General Public License
+%  along with this program; if not, write to the Free Software
+%  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+%
+%  vi :set textwidth=75
+%
+\documentclass{article}
+\usepackage{multirow,graphicx,placeins}
+
+\begin{document}
+%---------------------
+\title{\texttt{btrecord} and \texttt{btreplay} User Guide}
+\author{Alan D. Brunelle (Alan.Brunelle@hp.com)}
+\date{\today}
+\maketitle
+\begin{abstract}
+\input{abstract.tex}
+\end{abstract}
+\thispagestyle{empty}\newpage
+%---------------------
+\tableofcontents\thispagestyle{empty}\newpage
+%---------------------
+\section{Introduction}
+\input{abstract.tex}
+
+\bigskip 
+This document presents the command line overview for
+\texttt{btrecord} and \texttt{btreplay}, and shows some commonly used
+example usages of it in everyday work here at OSLO's Scalability and
+Performance Group.
+
+\subsection*{Build Note}
+
+To build these tools, one needs to
+place the source directory next to a valid
+\texttt{blktrace}\footnote{\texttt{git://git.kernel.dk/blktrace.git}}
+directory, as it includes \texttt{../blktrace} in the \texttt{Makefile}.
+
+
+%---------------------
+\newpage\section{\texttt{btrecord} and \texttt{btreplay} Operating Model}
+
+The \texttt{blktrace} utility provides the ability to collect detailed
+traces from the kernel for each IO processed by the block IO layer. The
+traces provide a complete timeline for each IO processed, including
+detailed information concerning when an IO was first received by the block
+IO layer -- indicating the device, CPU number, time stamp, IO direction,
+sector number and IO size (number of sectors). Using this information,
+one is able to \emph{replay} the IO again on the same machine or another
+set up entirely.
+
+\subsection{Basic Workflow}
+The basic operating work-flow to replay IOs would be something like:
+
+\begin{enumerate}
+  \item Run \texttt{blktrace} to collect traces. Here you specify the
+  device or devices that you wish to trace and later replay IOs upon. Note:
+  the only traces you are interested in are \emph{QUEUE} requests --
+  thus, to save system resources (including storage for traces), one could
+  specify the \texttt{-a queue} command line option to \texttt{blktrace}.
+
+  \item While \texttt{blktrace} is running, you run the workload that you
+  are interested in. 
+
+  \item When the work load has completed, you stop the \texttt{blktrace}
+  utility (thus saving all traces over the complete workload). 
+
+  \item You extract the pertinent IO information from the traces saved by
+  \texttt{blktrace} using the \texttt{btrecord} utility. This will parse
+  each trace file created by \texttt{blktrace}, and crafty IO descriptions
+  to be used in the next phase of the workload processing.
+
+  \item Once \texttt{btrecord} has successfully created a series of data
+  files to be processed, you can run the \texttt{btreplay} utility which
+  attempts to generate the same IOs seen during the sample workload phase.
+\end{enumerate}
+
+\subsection{IO Stream Replay Characteristics}
+  The major characteristics of the IO stream that are kept intact include:
+
+  \begin{description}
+    \item[Device] The IOs are replayed on the same device as was seen
+    during the sample workload.
+
+    \item[IO direction] The same IO direction (read/write) is maintained.
+
+    \item[IO offset] The same device offset is maintained.
+
+    \item[IO size] The same number of sectors are transferred.
+
+    \item[Time differential] The time stamps stored during the
+    \texttt{blktrace} run are used to determine the amount of time between
+    IOs during the sample workload. \texttt{btreplay} \emph{attempts} to
+    maintain the same time differential between IOs, but no guarantees as
+    to complete accuracy are provided by the utility.
+
+    \item[Device IO Stream Ordering] All IOs on a device are submitted in
+    the precise order they were seen during the sample workload run. 
+  \end{description}
+
+  As noted above, the time between IOs may not be accurately maintained
+  during replays. In addition the actual ordering of IOs \emph{between}
+  devices is not necessarily maintained. (Each device with an IO stream
+  maintains its own concept of time, and thus there may be slippage of the
+  time kept between managing threads.)
+
+  \begin{quotation}
+    We have prototyped a different approach, wherein a single managing
+    thread handles all IOs across all devices. This approach, while
+    guaranteeing correct ordering of IOs across all devices, resulted in
+    much worse timing on a per IO basis. 
+  \end{quotation}
+
+\subsection{\texttt{btrecord/btreplay} Method of Operation}
+
+As noted above, \texttt{btrecord} extracts \texttt{QUEUE} operations from
+\texttt{blktrace} output. These \texttt{QUEUE} operations indicate the
+entrance of IOs into the block IO layer. In order to replay these IOs with
+some accuracy in regards to ordering and timeliness, we decided to take
+multiple sequential (in time) IOs and put them in a single \emph{bunch} of
+IOs that will be processed as a single \emph{asynchronous IO} call to the
+kernel\footnote{Attempts to do them individually resulted in too large of a
+turnaround time penalty (user-space to kernel and back). Note that in a
+number of workloads, the IOs are coming in from the page cache handling
+code, and thus are submitted to the block IO layer with \emph{very small}
+time intervals between issues.}. To manage the size of the \emph{bunches},
+the \texttt{btrecord} utility provides you with two controlling knobs:
+
+\begin{description}
+  \item[\texttt{--max-bunch-time}] This is the amount of time to encompass
+  in one bunch -- only IOs within the time specified are eligible
+  for \emph{bunching.} The default time is 10 milliseconds (10,000,000
+  nanoseconds). Refer to section~\ref{sec:c-o-m} on page~\pageref{sec:c-o-m}
+  for more information.
+
+  \item[\texttt{--max-pkts}] A \emph{bunch} size can be anywhere from
+  1 to 512 packets in size and by default we max a bunch to contain no
+  more than 8 individual IOs. With this option, one can increase or
+  decrease the maximum \emph{bunch} size.  Refer to section~\ref{sec:c-o-M}
+  on page~\pageref{sec:c-o-M} for more information.
+\end{description}
+
+Each input data file (one per device per CPU) results in a new record
+data file (again, one per device per CPU) which contains information
+about \emph{bunches} of IOs to be replayed. \texttt{btreplay} operates on
+these record data files by spawning a new pair of threads per file. One
+thread managed the submitting of AIOs per bunch in the record data file,
+while the other thread manages reclaiming AIOs completed\footnote{We
+have found that having the same thread do both results in a further
+reduction in replay timing accuracty.}.
+
+Each submitting thread simply reads the input file of \emph{bunches}
+recorded by \texttt{btrecord}, and attempts to faithfully reproduce the
+ordering and timing of IOs seen during the sample workload. The reclaiming
+thread simply wait for AIO completions, freeing up resources for the
+submitting thread to utilize to submit new AIOs.
+
+The number of CPUs being used on the replay system can be different from
+the number on the recorded system. To help with mappings here the
+\texttt{--cpus} option allows one to state how many CPUs on the replay
+system to utilize. If the number of CPUs on the replay system is less than
+on the recording system, we wrap CPU IDs. This \emph{may} result in an
+overload of CPU processing capabilities on the replay system. (Refer to
+section~\ref{sec:p-o-c} on page~\pageref{sec:p-o-c} for more details about the
+\texttt{--cpus} option.)
+
+\newpage\subsection{Known Deficiencies and Proposed Possible Fixes}
+
+The overall known deficiencies with this current set of utilities is
+outlined here, in some cases ideas on additions and/or improvements are
+included as well.
+
+\begin{enumerate}
+  \item Lack of IO ordering across devices. 
+
+  \begin{quote}
+    \emph{We could institute the notion of global time across threads,
+    and thus ensure IO ordering across devices, with some reduction in
+    timing accuracy.}
+  \end{quote}
+
+  \item Lack of IO timing accuracy -- additional time between IO bunches.
+
+  \begin{quote}
+    \emph{This is the primary problem with any IO replay mechanism -- how
+    to guarantee per-IO timing accuracy with respect to other replayed IOs?
+    One idea to reduce errors in this area would be to push the IO replay
+    into the kernel, where you \emph{may} receive more responsive timings.}
+  \end{quote}
+
+  \item Bunching of IOs results in reduced time amongst IOs within a bunch.
+
+  \begin{quote}
+    \emph{The user has \emph{some} control over this (via the
+    \texttt{--max-pkts} option). One \emph{could} simply specify
+    \texttt{-max-pkts=1} and then each IO would be treated individualy. Of
+    course, this would probably then run into the problem of excessive
+    inter-IO times.}
+  \end{quote}
+
+  \item 1-to-1 mapping of devices -- for now the devices on the replay
+  machine must be the same as on the recording machine. 
+
+  \begin{quote}
+    \emph{It should be relatively trivial to add in the notion of
+    mapping -- simply include a file that is read which maps devices
+    on one machine to devices (with offsets and sizes) on the replay
+    machine\footnote{The notion of an offset and device size to replay on
+    could be used to both allow for a single device to masquerade as more
+    than one device, and could be utilized in case the replay device is
+    smaller than the recorded device.}.}
+    
+    \medskip\emph{One could also add in the notion of CPU mappings as well --
+    device $D_{rec}$ managed by CPU $C_{rec}$ on the recorded system
+    shall be replayed on device $D_{rep}$ and CPU $C_{rep}$ on the
+    replay machine.}
+
+    \bigskip
+    \begin{quote}
+      With version 0.9.1 we now support the \texttt{-M} option to do this
+      -- see section~\ref{sec:p-o-M} on page~\pageref{sec:p-o-M} for more
+      information on device mapping.
+    \end{quote}
+  \end{quote}
+
+\end{enumerate}
+
+%---------------------
+\newpage\section{\label{sec:command-line}Command Line Options}
+\subsection{\texttt{btrecord} Command Line Options}
+\begin{figure}[h!]
+\begin{verbatim}
+Usage: btrecord -- version 0.9.3
+
+	[ -d <dir>  : --input-directory=<dir> ] Default: .
+	[ -D <dir>  : --output-directory=<dir>] Default: .
+	[ -F        : --find-traces           ] Default: Off
+	[ -h        : --help                  ] Default: Off
+	[ -m <nsec> : --max-bunch-time=<nsec> ] Default: 10 msec
+	[ -M <pkts> : --max-pkts=<pkts>       ] Default: 8
+	[ -o <base> : --output-base=<base>    ] Default: replay
+	[ -v        : --verbose               ] Default: Off
+	[ -V        : --version               ] Default: Off
+	<dev>...                                Default: None
+\end{verbatim}
+\caption{\label{fig:btrecord--help}\texttt{btrecord --help} Output}
+\end{figure}
+\FloatBarrier
+
+\subsubsection{\label{sec:c-o-d}\texttt{-d} or
+\texttt{--input-directory}\\Set Input Directory}
+
+The \texttt{-d} option requires a single parameter providing the directory
+name for where input files are to be found. The default directory is the
+current directory (\texttt{.}).
+
+\subsubsection{\label{sec:c-o-D}\texttt{-D} or
+\texttt{--output-directory}\\Set Output Directory}
+
+The \texttt{-D} option requires a single parameter providing the directory
+name for where output files are to be placed. The default directory is the
+current directory (\texttt{.}).
+
+\subsubsection{\texttt{-F} or \texttt{--find-traces}\\Find Trace Files
+Automatically}
+
+The \texttt{-F} option instructs \texttt{btrecord} to go find all the
+trace files in the directory specified (either via the \texttt{-d}
+option, or in the default directory '.').
+
+\subsubsection{\texttt{-h} or \texttt{--help}\\Display Help Message}
+\subsubsection{\texttt{-V} or \texttt{--version}\\Display
+\texttt{btrecord}Version}
+
+The \texttt{-h} option displays the command line options and
+defaults, as presented in figure~\ref{fig:btrecord--help} on
+page~\pageref{fig:btrecord--help}.
+
+The \texttt{-V} option displays the \texttt{btreplay} version, as shown here:
+
+\begin{verbatim}
+$ btrecord --version
+btrecord -- version 0.9.0
+\end{verbatim}
+
+Both commands exit immediately after processing the option.
+
+\subsubsection{\label{sec:c-o-m}\texttt{-m} or
+\texttt{--max-bunch-time}\\Set Maximum Time Per Bunch}
+
+The \texttt{-m} option requires a single parameter which specifies an
+amount of time (in nanoseconds) to include in any one bunch of IOs that
+are to be processed. The smaller the value, the smaller the number of
+IOs processed at one time -- perhaps yielding in more realistic replay.
+However, after a certain point the amount of overhead per bunch may result
+in additonal real replay time, thus yielding less accurate replay times.
+
+The default value is 10,000,000 nanoseconds (10 milliseconds).
+
+\subsubsection{\label{sec:c-o-M}\texttt{-M} or
+\texttt{--max-pkts}\\Set Maximum Packets Per Bunch}
+
+The \texttt{-M} option requires a single parameter which specifies the
+maximum number of IOs to store in a single bunch. As with the \texttt{-m}
+option (section~\ref{sec:c-o-m}), smaller values \emph{may} or \emph{may not}
+yield more accurate replay times.
+
+The default value is 8, with a maximum value of up to 512 being supported.
+
+\subsubsection{\label{sec:c-o-o}\texttt{-o} or
+\texttt{--output-base}\\Set Base Name for Output Files}
+
+Each output file has 3 fields:
+
+\begin{enumerate}
+  \item Device identifier (taken directly from the device name of the
+  \texttt{blktrace} output file).
+
+  \item \texttt{btrecord} base name -- by default ``replay''.
+
+  \item And the CPU number (again, taken directly from the
+  \texttt{blktrace} output file name).
+\end{enumerate}
+
+This option requires a single parameter that will override the default name
+(replay), and replace it with the specified value.
+
+\subsubsection{\label{sec:c-o-v}\texttt{-v} or
+\texttt{--verbose}\\Select Verbose Output}
+
+This option will output some simple statistics at the end of a successful
+run. Figure~\ref{fig:verb-out} (page~\pageref{fig:verb-out}) shows
+an example of some output, while figure~\ref{fig:verb-defs}
+(page~\pageref{fig:verb-defs}) shows what the fields mean.
+
+\begin{figure}[h!]
+\begin{verbatim}
+sdab:0: 580661 pkts (tot), 126030 pkts (replay), 89809 bunches, 1.4 pkts/bunch
+sdab:1: 2559775 pkts (tot), 430172 pkts (replay), 293029 bunches, 1.5 pkts/bunch
+sdab:2: 653559 pkts (tot), 136522 pkts (replay), 102288 bunches, 1.3 pkts/bunch
+sdab:3: 474773 pkts (tot), 117849 pkts (replay), 69572 bunches, 1.7 pkts/bunch
+\end{verbatim}
+\caption{\label{fig:verb-out}Verbose Output Example}
+\end{figure}
+\FloatBarrier
+
+\begin{figure}[h!]
+\begin{description}
+  \item[Field 1] The first field contains the device name and CPU
+  identrifer. Thus: \texttt{sdab:0:} means the device \texttt{sdab} and
+  traces on CPU 0. 
+
+  \item[Field 2] The second field contains the total number of packets
+  processed for each device file. 
+
+  \item[Field 3] The next field shows the number of packets eligible for
+  replay. 
+
+  \item[Field 4] The fourth field contains the total number of IO bunches. 
+
+  \item[Field 5] The last field shows the average number of IOs per bunch
+  recorded.
+\end{description}
+\caption{\label{fig:verb-defs}Verbose Field Definitions}
+\end{figure}
+\FloatBarrier
+
+%---------------------
+\newpage\subsection{\texttt{btreplay} Command Line Options}
+\begin{figure}[h!]
+\begin{verbatim}
+Usage: btreplay -- version 0.9.3
+
+	[ -c <cpus> : --cpus=<cpus>           ] Default: 1
+	[ -d <dir>  : --input-directory=<dir> ] Default: .
+	[ -F        : --find-records           ] Default: Off
+	[ -h        : --help                  ] Default: Off
+	[ -i <base> : --input-base=<base>     ] Default: replay
+	[ -I <iters>: --iterations=<iters>    ] Default: 1
+	[ -M <file> : --map-devs=<file>       ] Default: None
+	[ -N        : --no-stalls             ] Default: Off
+	[ -v        : --verbose               ] Default: Off
+	[ -V        : --version               ] Default: Off
+	[ -W        : --write-enable          ] Default: Off
+	<dev...>                                Default: None
+\end{verbatim}
+\caption{\label{fig:btreplay--help}\texttt{btreplay --help} Output}
+\end{figure}
+\FloatBarrier
+
+\subsubsection{\label{sec:p-o-c}\texttt{-c} or
+\texttt{--cpus}\\Set Number of CPUs to Use}
+
+\subsubsection{\label{sec:p-o-d}\texttt{-d} or
+\texttt{--input-directory}\\Set Input Directory}
+
+The \texttt{-d} option requires a single parameter providing the directory
+name for where input files are to be found. The default directory is the
+current directory (\texttt{.}).
+
+\subsubsection{\texttt{-F} or \texttt{--find-records}\\Find RecordFiles
+Automatically}
+
+The \texttt{-F} option instructs \texttt{btreplay} to go find all the
+record files in the directory specified (either via the \texttt{-d}
+option, or in the default directory '.').
+
+\subsubsection{\texttt{-h} or \texttt{--help}\\Display Help Message}
+\subsubsection{\texttt{-V} or \texttt{--version}\\Display
+\texttt{btreplay}Version}
+
+The \texttt{-h} option displays the command line options and
+defaults, as presented in figure~\ref{fig:btreplay--help} on
+page~\pageref{fig:btreplay--help}.
+
+The \texttt{-V} option displays the \texttt{btreplay} version, as show here:
+
+\begin{verbatim}
+$ btreplay --version
+btreplay -- version 0.9.0
+\end{verbatim}
+
+Both commands exit immediately after processing the option.
+
+\subsubsection{\label{sec:p-o-i}\texttt{-i} or
+\texttt{--input-base}\\Set Base Name for Input Files}
+
+Each input file has 3 fields:
+
+\begin{enumerate}
+  \item Device identifier (taken directly from the device name of the
+  \texttt{blktrace} output file).
+
+  \item \texttt{btrecord} base name -- by default ``replay''.
+
+  \item And the CPU number (again, taken directly from the
+  \texttt{blktrace} output file name).
+\end{enumerate}
+
+This option requires a single parameter that will override the default name
+(replay), and replace it with the specified value.
+
+\subsubsection{\label{sec:p-o-I}\texttt{-I} or
+\texttt{--iterations}\\Set Number of Iterations to Run}
+
+This option requires a single parameter which specifies the number of times
+to run through the input files. The default value is 1.
+
+\subsubsection{\label{sec:p-o-M}\texttt{-M} or \texttt{map-devs}\\
+Specify Device Mappings}
+
+This option requires a single paramter which specifies the name of a
+file contain device mappings. The file must be very simply managed, with
+just two pieces of data per line:
+
+\begin{enumerate}
+  \item The device name on the recorded system (with the \texttt{'/dev/'}
+  removed). Example: \texttt{/dev/sda} would just be \texttt{sda}.
+
+  \item The device name on the replay system to use (again, without the
+  \texttt{'/dev/'} path prepended).
+\end{enumerate}
+
+An example file for when one would map devices \texttt{/dev/sda} and
+\texttt{/dev/sdb} on the recorded system to \texttt{dev/sdg} and
+\texttt{sdh} on the replay system would be:
+
+\begin{verbatim}
+sda sdg
+sdb sdh
+\end{verbatim}
+
+The only entries in the file that are allowed are these two element lines
+-- we do not (yet?) support the notion of blank lines, or comment lines, or
+the like.
+
+The utility \emph{does} allow for multiple \texttt{-M} options to be
+supplied on the command line.
+
+\subsubsection{\label{sec:o-N}\texttt{-N} or \texttt{--no-stalls}\\Disable
+Pre-bunch Stalls}
+
+When specified on the command line, all pre-bunch stall indicators will be
+ignored. IOs will be replayed without inter-bunch delays.
+
+\subsubsection{\label{sec:p-o-v}\texttt{-v} or
+\texttt{--verbose}\\Select Verbose Output}
+
+When specified on the command line, this option instructs \texttt{btreplay}
+to store information concerning each \emph{stall} and IO operation
+performed by \texttt{btreplay}. The name of each file so created will be
+the input file name used with an extension of \texttt{.rep} appended onto
+it. Thus, an input file of the name \texttt{sdab.replay.3} would generate a
+verbose output file with the name \texttt{sdab.replay.3.rep} in the
+directory specified for input files.
+
+In addition, \texttt{btreplay} will also output to \texttt{stderr} the
+names of the input files being processed.
+
+\subsubsection{\label{sec:p-o-W}\texttt{-W} or
+\texttt{--write-enable}\\Enable Writing During Replay}
+
+As a precautionary measure, by default \texttt{btreplay} will \emph{not}
+process \emph{write} requests. In order to enable \texttt{btreplay} to
+actually \emph{write} to devices one must explicitly specify the
+\texttt{-W} option.
+
+\end{document}
-- 
1.5.2.5


--------------010603050100090509080205--
