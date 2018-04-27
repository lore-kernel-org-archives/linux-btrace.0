From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:38 +0000
Subject: [PATCH 31/31] blkparse: new option to customize format of default output header only
Message-Id: <20180427130738.102806-32-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Allows the user to only modify the default output header without the
need to specify one individual custom format (-F) for each action.
One common custom format (-f) is hardly an option either because
it would not have suitable action-specific output per event type.

Actually use the previously unused already existing define for the
default header format string as default. Optionally replace it if
the user specifies new option with argument format string.

Factor out the actual processing of custom format strings using a
function argument for the latter.

It's either default processing or custom processing.

Default processing now supports the option of replacing the default
header. The code path simply re-uses custom processing for the header
in either case.

Custom processing (-F, -f) does not change and ignores the new option.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 blkparse.c            | 13 ++++++++++++-
 blkparse_fmt.c        | 27 ++++++++++++++++++++++-----
 blktrace.h            |  1 +
 doc/blkparse.1        | 18 ++++++++++++++++++
 doc/blktrace.tex      |  1 +
 doc/verify_blkparse.1 |  2 +-
 6 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 8049bb55bb0e..b24a9f946e9e 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -147,6 +147,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'F'
 	},
+	{
+		.name = "header",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'H'
+	},
 	{
 		.name = "hash-by-name",
 		.has_arg = no_argument,
@@ -2727,7 +2733,7 @@ static int is_pipe(const char *str)
 	return 0;
 }
 
-#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVM"
+#define S_OPTS  "a:A:b:D:d:f:F:H:hi:o:Oqstw:vVM"
 static char usage_str[] =    "\n\n" \
 	"-i <file>           | --input=<file>\n" \
 	"[ -a <action field> | --act-mask=<action field> ]\n" \
@@ -2737,6 +2743,7 @@ static char usage_str[] =    "\n\n" \
 	"[ -D <dir>          | --input-directory=<dir> ]\n" \
 	"[ -f <format>       | --format=<format> ]\n" \
 	"[ -F <spec>         | --format-spec=<spec> ]\n" \
+	"[ -H <format>       | --header=<format> ]\n" \
 	"[ -h                | --hash-by-name ]\n" \
 	"[ -o <file>         | --output=<file> ]\n" \
 	"[ -O                | --no-text-output ]\n" \
@@ -2755,6 +2762,7 @@ static char usage_str[] =    "\n\n" \
 	"\t-f Output format. Customize the output format. The format field\n" \
 	"\t   identifies can be found in the documentation\n" \
 	"\t-F Format specification. Can be found in the documentation\n" \
+	"\t-H Output header format. Customize the output header format.\n" \
 	"\t-h Hash processes by name, not pid\n" \
 	"\t-i Input file containing trace data, or '-' for stdin\n" \
 	"\t-o Output file. If not given, output is stdout\n" \
@@ -2844,6 +2852,9 @@ int main(int argc, char *argv[])
 			if (add_format_spec(optarg) != 0)
 				return 1;
 			break;
+		case 'H':
+			set_default_header_format(optarg);
+			break;
 		case 'h':
 			ppi_hash_by_pid = 0;
 			break;
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 45ffe04d71c1..5ddc621e2938 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -15,6 +15,8 @@
 
 #define HEADER		"%D %2c %8s %5T.%9t %5p %2a %3d "
 
+static char *override_header = HEADER;
+
 static char *override_format[256];
 
 static inline int valid_spec(int spec)
@@ -22,6 +24,11 @@ static inline int valid_spec(int spec)
 	return strchr(VALID_SPECS, spec) != NULL;
 }
 
+void set_default_header_format(char *option)
+{
+	override_header = option;
+}
+
 void set_all_format_specs(char *option)
 {
 	char *p;
@@ -310,6 +317,10 @@ static char *parse_field(char *act, struct per_cpu_info *pci,
 	return p;
 }
 
+static void process_custom(char *act, struct per_cpu_info *pci,
+			   struct blk_io_trace *t, unsigned long long elapsed,
+			   int pdu_len, unsigned char *pdu_buf, char *p);
+
 static void process_default(char *act, struct per_cpu_info *pci,
 			    struct blk_io_trace *t, unsigned long long elapsed,
 			    int pdu_len, unsigned char *pdu_buf)
@@ -332,10 +343,7 @@ static void process_default(char *act, struct per_cpu_info *pci,
 	/*
 	 * The header is always the same
 	 */
-	fprintf(ofp, "%3d,%-3d %2d %8d %5d.%09lu %5u %2s %3s ",
-		MAJOR(t->device), MINOR(t->device), pci->cpu, t->sequence,
-		(int) SECONDS(t->time), (unsigned long) NANO_SECONDS(t->time),
-		t->pid, act, rwbs);
+	process_custom(act, pci, t, elapsed, pdu_len, pdu_buf, override_header);
 
 	name = find_process_name(t->pid);
 
@@ -449,7 +457,6 @@ void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace *t,
 		 unsigned long long elapsed, int pdu_len,
 		 unsigned char *pdu_buf)
 {
-	struct blk_io_trace_remap r = { .device_from = 0, };
 	char *p = override_format[(int) *act];
 
 	if (!p) {
@@ -457,6 +464,16 @@ void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace *t,
 		return;
 	}
 
+	/* full custom event: header and action-specific */
+	process_custom(act, pci, t, elapsed, pdu_len, pdu_buf, p);
+}
+
+static void process_custom(char *act, struct per_cpu_info *pci,
+			   struct blk_io_trace *t, unsigned long long elapsed,
+			   int pdu_len, unsigned char *pdu_buf, char *p)
+{
+	struct blk_io_trace_remap r = { .device_from = 0, };
+
 	/*
 	 * For remaps we have to modify the device using the remap structure
 	 * passed up.
diff --git a/blktrace.h b/blktrace.h
index 944fc084cc09..7af9ba79e5f8 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -140,6 +140,7 @@ static inline int check_data_endianness(u32 magic)
 	return 1;
 }
 
+extern void set_default_header_format(char *);
 extern void set_all_format_specs(char *);
 extern int add_format_spec(char *);
 extern void process_fmt(char *, struct per_cpu_info *, struct blk_io_trace *,
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index dc1d0b393714..4a392434498d 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -21,6 +21,8 @@ blkparse \- produce formatted output of event streams of block devices
 .IR typ , fmt ]
 .RB [ \-f
 .IR fmt ]
+.RB [ \-H
+.IR fmt ]
 .RB [ \-o
 .IR file ]
 .RB [ \-d
@@ -72,6 +74,7 @@ the \fB\-o\fR option to blktrace), you must specify the same input name via the
 .TP
 \-
 The format of the output data can be controlled via the \fB\-f\fR or \fB\-F\fR
+or \fB\-H\fR
 options \-\- see OUTPUT DESCRIPTION AND FORMATTING for details.
 
 .PP
@@ -143,6 +146,17 @@ action specifiers described in TRACE ACTIONS.
 The \-f form specifies a common format for all event types.
 .RE
 
+\-H \fIfmt\fR
+.br
+\-\-header=\fIfmt\fR
+.RS
+While \fB-F\fR or \fB-f\fR set the full output with header and
+action-specific part, this option here replaces only the DEFAULT
+OUTPUT HEADER format but you still get the DEFAULT OUTPUT PER ACTION
+appended. Only applies if neither \fB-F\fR nor \fB-f\fR is used.
+(See OUTPUT DESCRIPTION AND FORMATTING for details.)
+.RE
+
 \-M
 .br
 \-\-no-msgs
@@ -660,6 +674,10 @@ The custom format syntax from section OUTPUT DESCRIPTION AND FORMATTING
 does not support conditional output. Thus, the example output differs
 by printing all information instead of skipping some based on conditions.
 
+To just replace the default output header with e.g. leading calendar time:
+
+    % blkparse sda sdb -H "%z %D %2c %8s %5p %2a %3d "
+
 
 .SH AUTHORS
 \fIblkparse\fR was written by Jens Axboe, Alan D. Brunelle and Nathan Scott.  This
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 008767e2010b..685353715417 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -966,6 +966,7 @@ Short              & Long                       & Description \\ \hline\hline
 		   &                            & action specifiers in section~\ref{sec:act-table} \\
                    &                            & \\
 		   &                            & The -f form specifies a common format for all events \\ \hline
+-H \emph{fmt}      & -{}-header=\emph{fmt}      & Without -F and -f, replaces default output header (sec~\ref{sec:default-output-header}) \\ \hline
 
 -h                 & -{}-hash-by-name             & Hash processes by name, not by PID\\ \hline
 
diff --git a/doc/verify_blkparse.1 b/doc/verify_blkparse.1
index 8ea886ef83a3..d54ffb739588 100644
--- a/doc/verify_blkparse.1
+++ b/doc/verify_blkparse.1
@@ -21,7 +21,7 @@ including timestamp. The sscanf format string for parsing input lines
 is "%3d,%3d %5d %8d %lf". This corresponds to blkparse's default
 output header prefix "%D %2c %8s %5T.%9t", see section DEFAULT OUTPUT
 HEADER in blkparse(1). Take care when using custom output format with
-blkparse options \fB-F\fR or \fB-f\fR.
+blkparse options \fB-F\fR or \fB-f\fR or \fB-H\fR.
 
 On reading an unrecognized input line, the tool exits early.
 
-- 
2.14.2

