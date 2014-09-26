From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 26 Sep 2014 12:00:03 +0000
Subject: Recent changes (master)
Message-Id: <20140926120003.C58B9403D6@lyth.info>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit fe311e7c01593444f397d6d012ec212c4b22f514:

  Makefile: ensure that iowatcher gets cleaned (2014-09-24 14:49:04 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 2cf87e6092da7b36d5ef10c830ddf12d9e18121d:

  iowatcher: wrap system() in a checker function (2014-09-25 15:17:06 -0600)

----------------------------------------------------------------
Andrew Price (4):
      iowatcher: Add iowatcher to .gitignore
      iowatcher: Move iowatcher.1 into doc directory
      iowatcher: Remove iowatcher/README
      Add iowatcher requirements to README

Chris Mason (2):
      iowatcher: fixup the Makefile
      iowatcher: check the return value from write()

Jens Axboe (3):
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/mason/blktrace
      Merge branch 'for-upstream' of https://github.com/andyprice/blktrace
      iowatcher: wrap system() in a checker function

 .gitignore                     |    1 +
 README                         |    2 +
 {iowatcher => doc}/iowatcher.1 |    0
 iowatcher/Makefile             |    2 +-
 iowatcher/README               |   97 ------------------------------------
 iowatcher/main.c               |   20 ++++++--
 iowatcher/plot.c               |  107 ++++++++++++++++++++++------------------
 7 files changed, 77 insertions(+), 152 deletions(-)
 rename {iowatcher => doc}/iowatcher.1 (100%)
 delete mode 100644 iowatcher/README

---

Diff of recent changes:

diff --git a/.gitignore b/.gitignore
index 2436e34..87a5d2d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,3 +11,4 @@ verify_blkparse
 btt/btt
 btt/doc/btt.pdf
 doc/blktrace.pdf
+iowatcher/iowatcher
diff --git a/README b/README
index f52f48d..d7d1fbf 100644
--- a/README
+++ b/README
@@ -31,6 +31,8 @@ your browser to:
 
 http://git.kernel.dk/
 
+A blktrace visualization tool, iowatcher, was added to blktrace in version
+1.1.0. It requires librsvg and either png2theora or ffmpeg to generate movies.
 
 Usage
 -----
diff --git a/doc/iowatcher.1 b/doc/iowatcher.1
new file mode 100644
index 0000000..3044abf
--- /dev/null
+++ b/doc/iowatcher.1
@@ -0,0 +1,162 @@
+.TH iowatcher "1" "April 2014" "iowatcher" "User Commands"
+
+.SH NAME
+iowatcher - Create visualizations from blktrace results
+
+.SH SYNOPSIS
+.B iowatcher
+\fI[options]\fR [--] \fI[program arguments ...]\fR
+
+.SH DESCRIPTION
+iowatcher graphs the results of a blktrace run.  It can graph the result of an existing blktrace, start a new blktrace, or start a new blktrace and a benchmark run.  It can then create an image or movie of the IO from a given trace.  iowatcher can produce either SVG files or movies in mp4 format (with ffmpeg) or ogg format (with png2theora).
+
+.SH OPTIONS
+.TP
+\fB--help\fP
+Print a brief usage summary.
+.TP
+\fB-d, --device\fP \fIdevice\fP
+Controls which device you are tracing.  You can only trace one device at a time for now.  It is sent directly to blktrace, and only needed when you are making a new trace.
+.TP
+\fB-D, --blktrace-destination\fP \fIdestination\fP
+Destination for blktrace.
+.TP
+\fB-p, --prog\fP
+Run a program while blktrace is run. The program and its arguments must be
+specified after all other options.  Note that this option previously required
+the program to be given as a single argument but it now tells \fBiowatcher\fP
+to expect extra arguments which it should be run during the trace.
+.TP
+\fB--\fP
+End option parsing. If \fB--prog\fP is specified, everything after \fB--\fP is
+the program to be run. This can be useful if the program name could otherwise
+be mistaken for an option.
+.TP
+\fB-K, --keep-movie-svgs\fP
+Keep the SVG files generated for movie mode.
+.TP
+\fB-t, --trace\fP \fIpath\fP
+Specify the name of the file or directory in which blktrace output is located.
+\fBiowatcher\fP uses a dump from blkparse, so this option tries to guess the
+name of the corresponding per-CPU blktrace data files if the dump file doesn't
+already exist.  To add multiple traces to a given graph, you can specify
+\fB--trace\fP more than once.  If \fIpath\fP is a directory, \fBiowatcher\fP
+will use the name of the directory as the base name of the dump file and all
+trace files found inside the directory will be processed.
+.TP
+\fB-l, --label\fP \fIlabel\fP
+Sets a label in the graph for a trace file.  The labels are added in the same order as the trace files.
+.TP
+\fB-m, --movie\fP \fI[style]\fP
+Create a movie.  The file format depends on the extension used in the \fB-o\fP
+\fIfile\fP option.  If you specify an .ogv or .ogg extension, the result will
+be Ogg Theora video, if png2theora is available.  If you use an .mp4 extension,
+the result will be an mp4 video if ffmpeg is available.  You can use any other
+extension, but the end result will be an mp4.  The accepted \fIstyle\fP values
+are \fBspindle\fP for a circular disc-like effect (default) or \fBrect\fP for a
+rectangular graph style.
+.TP
+\fB-T, --title\fP \fItitle\fP
+Set a \fItitle\fP to be placed at the top of the graph.
+.TP
+\fB-o, --output\fP \fIfile\fP
+Output filename for the SVG image or video. The video format used will depend
+on the file name extension. See \fB--movie\fP for details.
+.TP
+\fB-r, --rolling\fP \fIseconds\fP
+Control the duration for the rolling average.  \fBiowatcher\fP tries to smooth out bumpy graphs by averaging the current second with seconds from the past.  Larger numbers here give you flatter graphs.
+.TP
+\fB-h, --height\fP \fIheight\fP
+Set the height of each graph
+.TP
+\fB-w, --width\fP \fIwidth\fP
+Set the width of each graph
+.TP
+\fB-c, --columns\fP \fIcolumns\fP
+Number of columns in graph output
+.TP
+\fB-x, --xzoom\fP \fImin:max\fP
+Limit processed time range to \fImin:max\fP.
+.TP
+\fB-y, --yzoom\fP \fImin:max\fP
+Limit processed sectors to \fImin:max\fP.
+.TP
+\fB-a, --io-plot-action\fP \fIaction\fP
+Plot \fIaction\fP (one of Q, D, or C) in the IO graph.
+.TP
+\fB-P, --per-process-io\fP
+Distinguish between processes in the IO graph.
+.TP
+\fB-O, --only-graph\fP \fIgraph\fP
+Add a single graph to the output (see section \fBGRAPHS\fP for options).  By
+default all graphs are included. Use \fB-O\fP to generate only the required
+graphs.  \fB-O\fP may be used more than once.
+.TP
+\fB-N, --no-graph\fP \fItype\fP
+Remove a single graph from the output (see section \fBGRAPHS\fP for options).
+This option may be used more than once.
+.SH GRAPHS
+Values accepted by the \fB-O\fP and \fB-N\fP options are:
+
+   io, tput, latency, queue_depth, iops, cpu-sys, cpu-io, cpu-irq, cpu-user, cpu-soft
+
+.SH EXAMPLES
+Generate graph from the existing trace.dump:
+.PP
+.RS
+# iowatcher -t trace
+.RE
+.PP
+Skip the IO graph:
+.PP
+.RS
+# iowatcher -t trace.dump -o trace.svg -N io
+.RE
+.PP
+Only graph tput and latency:
+.PP
+.RS
+# iowatcher -t trace.dump -o trace.svg -O tput -O latency
+.RE
+.PP
+Generate a graph from two runs, and label them:
+.PP
+.RS
+# iowatcher -t ext4.dump -t xfs.dump -l Ext4 -l XFS -o trace.svg
+.RE
+.PP
+Run a fio benchmark and store the trace in trace.dump, add a title to the top, use /dev/sda for blktrace:
+.PP
+.RS
+# iowatcher -d /dev/sda -t trace.dump -T 'Fio Benchmark' -p fio some_job_file
+.RE
+.PP
+Make a movie from an existing trace:
+.PP
+.RS
+# iowatcher -t trace --movie -o trace.mp4
+.RE
+
+.SH AUTHORS
+iowatcher was created and is maintained by Chris Mason.
+
+This man page was largely written by Andrew Price based on Chris's original README.
+
+.SH COPYRIGHT
+This program is free software; you can redistribute it and/or modify it under
+the terms of the GNU General Public License v2 as published by the Free
+Software Foundation.
+
+This program is distributed in the hope that it will be useful, but WITHOUT ANY
+WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
+PARTICULAR PURPOSE.  See the GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License along with
+this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
+Street, Fifth Floor, Boston, MA 02110-1301 USA
+
+.SH "SEE ALSO"
+.BR blktrace (8),
+.BR blkparse (1),
+.BR fio (1),
+.BR mpstat (1)
diff --git a/iowatcher/Makefile b/iowatcher/Makefile
index e0f34b2..3551ea0 100644
--- a/iowatcher/Makefile
+++ b/iowatcher/Makefile
@@ -1,5 +1,5 @@
 CC      = gcc
-CFLAGS  = -Wall -O0 -g -W
+CFLAGS  = -Wall -O2 -g -W -Wunused-result
 ALL_CFLAGS = $(CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITSd
 
 PROGS = iowatcher
diff --git a/iowatcher/README b/iowatcher/README
deleted file mode 100644
index 83db494..0000000
--- a/iowatcher/README
+++ /dev/null
@@ -1,97 +0,0 @@
-iowatcher graphs the results of a blktrace run.  It has a few different modes:
-
-	* Graph the result of an existing blktrace
-
-	* Start a new blktrace
-
-	* Start a new blktrace and a benchmark run
-
-	* Make a movie of the IO from a given trace (only mp4 for now)
-
-Output:
-
-	iowatcher can produce either svg files or mp4 movies.  Most browsers
-	can view the svg files, or you can use rsvg-view-3 from librsvg.
-	rsvg-convert can turn the svgs into many other formats.
-
-Building:
-
-	Type make and make install.  We need ffmpeg or png2theora, and
-	librsvg to make movies, otherwise there are no dependencies.
-
-The basic options:
-
-	-d controls which device you are tracing.  You can only trace one device
-	   at a time for now.  It is sent directly to blktrace, and only
-	   needed when you are making a new trace.
-
-	-t controls the name of the blktrace file.  iowatcher uses a dump from
-	   blkparse, so -t tries to guess the name of the corresponding
-	   per CPU blktrace data files if the dump file doesn't already exist.
-
-	   If you want more than one trace in a given graph, you can specify
-	   -t more than once.
-
-	-F Add a fio bandwidth log graph.  You need to run fio --bandwidth-log
-	   to get one of these, and then pass either the read log or the write
-	   log into iowatcher.
-
-	-l Sets a label in the graph for a trace file.  The labels are added in
-	   the same order the trace files are added.
-
-	-m Create a movie.  The file format depends on the extension used in the
-	   -o filename.* option.  If you specify an .ogv or .ogg extension, the
-	   result will be Ogg Theora video, if png2theora is available.
-	   If you use an .mp4 extension, the result will be an mp4 video if
-	   ffmpeg is avilable.  You can use any other extension, but the end
-	   result will be an mp4.
-
-	   You can use --movie=spindle or --movie=rect, which changes the
-	   style of the IO mapping.
-
-	-T Set a title for the graph.  This goes at the top of the image.
-
-	-o output filename.  The default is trace.svg.  iowatcher is
-	   only able to create svg for now.
-
-	-r control the duration in seconds for the rolling average.
-	   iowatcher tries to smooth out bumpy graphs by averaging the
-	   current second with seconds from the past.  Longer numbers here
-	   give you flatter graphs.
-
-	-P add per-process tags to the IO.  Each process responsible for
-	   submitting the IO gets a different color.
-
-	-O add a single graph to the output.  By default all the graphs
-	   are included, but with -O you get only the graphs you ask for.
-	   -O may be used more than once.
-
-	-N remove a single graph from the output.  This may also be used more
-	   than once.
-
-	Choices for -O and -N are:
-	   io, fio, tput, latency, queue_depth, iops, cpu-sys, cpu-io,
-	   cpu-irq, cpu-user, cpu-soft
-
-Examples:
-	
-	# generate graph from the existing trace.dump
-	iowatcher -t trace.dump -o trace.svg
-	
-	# skip the IO graph
-	iowatcher -t trace.dump -o trace.svg -N io
-
-	# only graph tput and latency
-	iowatcher -t trace.dump -o trace.svg -O tput -O latency
-
-	# generate a graph from two runs, and label them
-	iowatcher -t ext4.dump -t xfs.dump -l Ext4 -l XFS -o trace.svg
-
-	# Run a fio benchmark and store the trace in trace.dump
-	# add a title to the top.  Use /dev/sda for blktrace
-	iowatcher -d /dev/sda -t trace.dump -T 'Fio Benchmark' -p 'fio some_job_file'
-
-	# Make a movie from an existing trace
-	iowatcher -t trace --movie -o trace.mp4
-
-Please email chris.mason@fusionio.com with any questions
diff --git a/iowatcher/iowatcher.1 b/iowatcher/iowatcher.1
deleted file mode 100644
index 3044abf..0000000
--- a/iowatcher/iowatcher.1
+++ /dev/null
@@ -1,162 +0,0 @@
-.TH iowatcher "1" "April 2014" "iowatcher" "User Commands"
-
-.SH NAME
-iowatcher - Create visualizations from blktrace results
-
-.SH SYNOPSIS
-.B iowatcher
-\fI[options]\fR [--] \fI[program arguments ...]\fR
-
-.SH DESCRIPTION
-iowatcher graphs the results of a blktrace run.  It can graph the result of an existing blktrace, start a new blktrace, or start a new blktrace and a benchmark run.  It can then create an image or movie of the IO from a given trace.  iowatcher can produce either SVG files or movies in mp4 format (with ffmpeg) or ogg format (with png2theora).
-
-.SH OPTIONS
-.TP
-\fB--help\fP
-Print a brief usage summary.
-.TP
-\fB-d, --device\fP \fIdevice\fP
-Controls which device you are tracing.  You can only trace one device at a time for now.  It is sent directly to blktrace, and only needed when you are making a new trace.
-.TP
-\fB-D, --blktrace-destination\fP \fIdestination\fP
-Destination for blktrace.
-.TP
-\fB-p, --prog\fP
-Run a program while blktrace is run. The program and its arguments must be
-specified after all other options.  Note that this option previously required
-the program to be given as a single argument but it now tells \fBiowatcher\fP
-to expect extra arguments which it should be run during the trace.
-.TP
-\fB--\fP
-End option parsing. If \fB--prog\fP is specified, everything after \fB--\fP is
-the program to be run. This can be useful if the program name could otherwise
-be mistaken for an option.
-.TP
-\fB-K, --keep-movie-svgs\fP
-Keep the SVG files generated for movie mode.
-.TP
-\fB-t, --trace\fP \fIpath\fP
-Specify the name of the file or directory in which blktrace output is located.
-\fBiowatcher\fP uses a dump from blkparse, so this option tries to guess the
-name of the corresponding per-CPU blktrace data files if the dump file doesn't
-already exist.  To add multiple traces to a given graph, you can specify
-\fB--trace\fP more than once.  If \fIpath\fP is a directory, \fBiowatcher\fP
-will use the name of the directory as the base name of the dump file and all
-trace files found inside the directory will be processed.
-.TP
-\fB-l, --label\fP \fIlabel\fP
-Sets a label in the graph for a trace file.  The labels are added in the same order as the trace files.
-.TP
-\fB-m, --movie\fP \fI[style]\fP
-Create a movie.  The file format depends on the extension used in the \fB-o\fP
-\fIfile\fP option.  If you specify an .ogv or .ogg extension, the result will
-be Ogg Theora video, if png2theora is available.  If you use an .mp4 extension,
-the result will be an mp4 video if ffmpeg is available.  You can use any other
-extension, but the end result will be an mp4.  The accepted \fIstyle\fP values
-are \fBspindle\fP for a circular disc-like effect (default) or \fBrect\fP for a
-rectangular graph style.
-.TP
-\fB-T, --title\fP \fItitle\fP
-Set a \fItitle\fP to be placed at the top of the graph.
-.TP
-\fB-o, --output\fP \fIfile\fP
-Output filename for the SVG image or video. The video format used will depend
-on the file name extension. See \fB--movie\fP for details.
-.TP
-\fB-r, --rolling\fP \fIseconds\fP
-Control the duration for the rolling average.  \fBiowatcher\fP tries to smooth out bumpy graphs by averaging the current second with seconds from the past.  Larger numbers here give you flatter graphs.
-.TP
-\fB-h, --height\fP \fIheight\fP
-Set the height of each graph
-.TP
-\fB-w, --width\fP \fIwidth\fP
-Set the width of each graph
-.TP
-\fB-c, --columns\fP \fIcolumns\fP
-Number of columns in graph output
-.TP
-\fB-x, --xzoom\fP \fImin:max\fP
-Limit processed time range to \fImin:max\fP.
-.TP
-\fB-y, --yzoom\fP \fImin:max\fP
-Limit processed sectors to \fImin:max\fP.
-.TP
-\fB-a, --io-plot-action\fP \fIaction\fP
-Plot \fIaction\fP (one of Q, D, or C) in the IO graph.
-.TP
-\fB-P, --per-process-io\fP
-Distinguish between processes in the IO graph.
-.TP
-\fB-O, --only-graph\fP \fIgraph\fP
-Add a single graph to the output (see section \fBGRAPHS\fP for options).  By
-default all graphs are included. Use \fB-O\fP to generate only the required
-graphs.  \fB-O\fP may be used more than once.
-.TP
-\fB-N, --no-graph\fP \fItype\fP
-Remove a single graph from the output (see section \fBGRAPHS\fP for options).
-This option may be used more than once.
-.SH GRAPHS
-Values accepted by the \fB-O\fP and \fB-N\fP options are:
-
-   io, tput, latency, queue_depth, iops, cpu-sys, cpu-io, cpu-irq, cpu-user, cpu-soft
-
-.SH EXAMPLES
-Generate graph from the existing trace.dump:
-.PP
-.RS
-# iowatcher -t trace
-.RE
-.PP
-Skip the IO graph:
-.PP
-.RS
-# iowatcher -t trace.dump -o trace.svg -N io
-.RE
-.PP
-Only graph tput and latency:
-.PP
-.RS
-# iowatcher -t trace.dump -o trace.svg -O tput -O latency
-.RE
-.PP
-Generate a graph from two runs, and label them:
-.PP
-.RS
-# iowatcher -t ext4.dump -t xfs.dump -l Ext4 -l XFS -o trace.svg
-.RE
-.PP
-Run a fio benchmark and store the trace in trace.dump, add a title to the top, use /dev/sda for blktrace:
-.PP
-.RS
-# iowatcher -d /dev/sda -t trace.dump -T 'Fio Benchmark' -p fio some_job_file
-.RE
-.PP
-Make a movie from an existing trace:
-.PP
-.RS
-# iowatcher -t trace --movie -o trace.mp4
-.RE
-
-.SH AUTHORS
-iowatcher was created and is maintained by Chris Mason.
-
-This man page was largely written by Andrew Price based on Chris's original README.
-
-.SH COPYRIGHT
-This program is free software; you can redistribute it and/or modify it under
-the terms of the GNU General Public License v2 as published by the Free
-Software Foundation.
-
-This program is distributed in the hope that it will be useful, but WITHOUT ANY
-WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
-PARTICULAR PURPOSE.  See the GNU General Public License for more details.
-
-You should have received a copy of the GNU General Public License along with
-this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
-Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-.SH "SEE ALSO"
-.BR blktrace (8),
-.BR blkparse (1),
-.BR fio (1),
-.BR mpstat (1)
diff --git a/iowatcher/main.c b/iowatcher/main.c
index cbf6c9a..2797afb 100644
--- a/iowatcher/main.c
+++ b/iowatcher/main.c
@@ -1016,12 +1016,22 @@ static void plot_queue_depth(struct plot *plot, unsigned int min_seconds,
 	total_graphs_written++;
 }
 
+static void system_check(const char *cmd)
+{
+	if (system(cmd) < 0) {
+		int err = errno;
+
+		fprintf(stderr, "system exec failed (%d): %s\n", err, cmd);
+		exit(1);
+	}
+}
+
 static void convert_movie_files(char *movie_dir)
 {
 	fprintf(stderr, "Converting svg files in %s\n", movie_dir);
 	snprintf(line, line_len, "find %s -name \\*.svg | xargs -I{} -n 1 -P 8 rsvg-convert -o {}.png {}",
 		 movie_dir);
-	system(line);
+	system_check(line);
 }
 
 static void mencode_movie(char *movie_dir)
@@ -1030,7 +1040,7 @@ static void mencode_movie(char *movie_dir)
 	snprintf(line, line_len, "ffmpeg -r 20 -y -i %s/%%10d-%s.svg.png -b:v 250k "
 		 "-vcodec %s %s", movie_dir, output_filename, ffmpeg_codec,
 		 output_filename);
-	system(line);
+	system_check(line);
 }
 
 static void tencode_movie(char *movie_dir)
@@ -1038,7 +1048,7 @@ static void tencode_movie(char *movie_dir)
 	fprintf(stderr, "Creating movie %s with png2theora\n", movie_dir);
 	snprintf(line, line_len, "png2theora -o %s %s/%%010d-%s.svg.png",
 			output_filename, movie_dir, output_filename);
-	system(line);
+	system_check(line);
 }
 
 static void encode_movie(char *movie_dir)
@@ -1060,10 +1070,10 @@ static void cleanup_movie(char *movie_dir)
 	}
 	fprintf(stderr, "Removing movie dir %s\n", movie_dir);
 	snprintf(line, line_len, "rm %s/*", movie_dir);
-	system(line);
+	system_check(line);
 
 	snprintf(line, line_len, "rmdir %s", movie_dir);
-	system(line);
+	system_check(line);
 }
 
 static void plot_io_movie(struct plot *plot)
diff --git a/iowatcher/plot.c b/iowatcher/plot.c
index 8dd112d..012d4f9 100644
--- a/iowatcher/plot.c
+++ b/iowatcher/plot.c
@@ -249,6 +249,20 @@ static double rolling_avg(struct graph_line_pair *data, int index, int distance)
 	return sum / distance;
 }
 
+static void write_check(int fd, char *buf, size_t size)
+{
+	ssize_t ret;
+
+	ret = write(fd, buf, size);
+	if (ret != (ssize_t)size) {
+		if (ret < 0)
+			perror("write failed");
+		else
+			fprintf(stderr, "error: short write\n");
+		exit(1);
+	}
+}
+
 void write_svg_header(int fd)
 {
 	char *spaces = "                                                    \n";
@@ -275,17 +289,17 @@ void write_svg_header(int fd)
 	final_width = 0;
 	final_height = 0;
 
-	write(fd, header, strlen(header));
+	write_check(fd, header, strlen(header));
 	/* write a bunch of spaces so we can stuff in the width and height later */
-	write(fd, spaces, strlen(spaces));
-	write(fd, spaces, strlen(spaces));
-	write(fd, spaces, strlen(spaces));
-
-	write(fd, defs_start, strlen(defs_start));
-	write(fd, filter1, strlen(filter1));
-	write(fd, filter2, strlen(filter2));
-	write(fd, filter3, strlen(filter3));
-	write(fd, defs_close, strlen(defs_close));
+	write_check(fd, spaces, strlen(spaces));
+	write_check(fd, spaces, strlen(spaces));
+	write_check(fd, spaces, strlen(spaces));
+
+	write_check(fd, defs_start, strlen(defs_start));
+	write_check(fd, filter1, strlen(filter1));
+	write_check(fd, filter2, strlen(filter2));
+	write_check(fd, filter3, strlen(filter3));
+	write_check(fd, defs_close, strlen(defs_close));
 }
 
 /* svg y offset for the traditional 0,0 (bottom left corner) of the plot */
@@ -329,7 +343,6 @@ static int axis_x_off(int x)
  */
 void setup_axis(struct plot *plot)
 {
-	int ret;
 	int len;
 	int fd = plot->fd;
 	int bump_height = tick_font_size * 3 + axis_label_font_size;
@@ -351,7 +364,7 @@ void setup_axis(struct plot *plot)
 		plot->start_y_offset, plot->total_width + 40,
 		plot->total_height + 20);
 	len = strlen(line);
-	write(fd, line, len);
+	write_check(fd, line, len);
 
 	snprintf(line, line_len, "<rect x=\"%d\" y=\"%d\" width=\"%d\" "
 		 "filter=\"url(#shadow)\" "
@@ -359,7 +372,7 @@ void setup_axis(struct plot *plot)
 		 plot->start_x_offset + 15,
 		plot->start_y_offset, plot->total_width, plot->total_height);
 	len = strlen(line);
-	write(fd, line, len);
+	write_check(fd, line, len);
 	plot->total_height += 20;
 	plot->total_width += 20;
 
@@ -370,18 +383,14 @@ void setup_axis(struct plot *plot)
 
 	/* create an svg object for all our coords to be relative against */
 	snprintf(line, line_len, "<svg x=\"%d\" y=\"%d\">\n", plot->start_x_offset, plot->start_y_offset);
-	write(fd, line, strlen(line));
+	write_check(fd, line, strlen(line));
 
 	snprintf(line, 1024, "<path d=\"M%d %d h %d V %d H %d Z\" stroke=\"black\" stroke-width=\"2\" fill=\"none\"/>\n",
 		 axis_x(), axis_y(),
 		 graph_width + graph_inner_x_margin * 2, axis_y_off(graph_height) - graph_inner_y_margin,
 		 axis_x());
 	len = strlen(line);
-	ret = write(fd, line, len);
-	if (ret != len) {
-		fprintf(stderr, "failed to write svg axis\n");
-		exit(1);
-	}
+	write_check(fd, line, len);
 }
 
 /*
@@ -410,7 +419,7 @@ void setup_axis_spindle(struct plot *plot)
 		plot->start_y_offset, plot->total_width + 10,
 		plot->total_height + 20);
 	len = strlen(line);
-	write(fd, line, len);
+	write_check(fd, line, len);
 
 	snprintf(line, line_len, "<rect x=\"%d\" y=\"%d\" width=\"%d\" "
 		 "filter=\"url(#shadow)\" "
@@ -419,7 +428,7 @@ void setup_axis_spindle(struct plot *plot)
 		plot->start_y_offset, plot->total_width - 30,
 		plot->total_height);
 	len = strlen(line);
-	write(fd, line, len);
+	write_check(fd, line, len);
 	plot->total_height += 20;
 
 	if (plot->total_height + plot->start_y_offset > final_height)
@@ -429,7 +438,7 @@ void setup_axis_spindle(struct plot *plot)
 
 	/* create an svg object for all our coords to be relative against */
 	snprintf(line, line_len, "<svg x=\"%d\" y=\"%d\">\n", plot->start_x_offset, plot->start_y_offset);
-	write(fd, line, strlen(line));
+	write_check(fd, line, strlen(line));
 
 }
 
@@ -451,7 +460,7 @@ void set_plot_title(struct plot *plot, char *title)
 	snprintf(line, line_len, "<rect x=\"0\" y=\"%d\" width=\"%d\" height=\"%d\" fill=\"white\" stroke=\"none\"/>",
 		plot->start_y_offset, plot->total_width + 40, plot_title_height + 20);
 	len = strlen(line);
-	write(fd, line, len);
+	write_check(fd, line, len);
 
 	snprintf(line, line_len, "<text x=\"%d\" y=\"%d\" font-family=\"%s\" font-size=\"%d\" "
 		 "font-weight=\"bold\" fill=\"black\" style=\"text-anchor: %s\">%s</text>\n",
@@ -460,7 +469,7 @@ void set_plot_title(struct plot *plot, char *title)
 		font_family, plot_title_font_size, "middle", title);
 	plot->start_y_offset += plot_title_height;
 	len = strlen(line);
-	write(fd, line, len);
+	write_check(fd, line, len);
 }
 
 #define TICK_MINI_STEPS 3
@@ -516,7 +525,7 @@ void set_xticks(struct plot *plot, int num_ticks, int first, int last)
 		if (i != 0) {
 			snprintf(line, line_len, "<rect x=\"%d\" y=\"%d\" width=\"2\" height=\"%d\" style=\"stroke:none;fill:black;\"/>\n",
 				tick_x, tick_y, graph_tick_len);
-			write(plot->fd, line, strlen(line));
+			write_check(plot->fd, line, strlen(line));
 			anchor = middle;
 		} else {
 			anchor = start;
@@ -533,7 +542,7 @@ void set_xticks(struct plot *plot, int num_ticks, int first, int last)
 					"fill=\"black\" style=\"text-anchor: %s\">%.2f</text>\n",
 					tick_x, text_y, font_family, tick_font_size, anchor,
 					first + step * i);
-			write(plot->fd, line, strlen(line));
+			write_check(plot->fd, line, strlen(line));
 		}
 		tick_x += pixels_per_tick;
 	}
@@ -549,7 +558,7 @@ void set_xticks(struct plot *plot, int num_ticks, int first, int last)
 				"fill=\"black\" style=\"text-anchor: middle\">%.2f</text>\n",
 				axis_x_off(graph_width - 2),
 				text_y, font_family, tick_font_size, (double)last);
-		write(plot->fd, line, strlen(line));
+		write_check(plot->fd, line, strlen(line));
 	}
 }
 
@@ -568,7 +577,7 @@ void set_ylabel(struct plot *plot, char *label)
 		 (int)axis_y_off(graph_height / 2),
 		 axis_label_font_size, "middle", label);
 	len = strlen(line);
-	write(fd, line, len);
+	write_check(fd, line, len);
 }
 
 void set_xlabel(struct plot *plot, char *label)
@@ -583,7 +592,7 @@ void set_xlabel(struct plot *plot, char *label)
 		 font_family,
 		 axis_label_font_size, "middle", label);
 	len = strlen(line);
-	write(fd, line, len);
+	write_check(fd, line, len);
 
 }
 
@@ -607,7 +616,7 @@ void set_yticks(struct plot *plot, int num_ticks, int first, int last, char *uni
 				 "style=\"stroke:lightgray;stroke-width:2;stroke-dasharray:9,12;\"/>\n",
 				tick_x, axis_y_off(tick_y),
 				axis_x_off(graph_width), axis_y_off(tick_y));
-			write(plot->fd, line, strlen(line));
+			write_check(plot->fd, line, strlen(line));
 		}
 
 		snprintf(line, line_len, "<text x=\"%d\" y=\"%d\" font-family=\"%s\" font-size=\"%d\" "
@@ -615,13 +624,13 @@ void set_yticks(struct plot *plot, int num_ticks, int first, int last, char *uni
 			text_x,
 			axis_y_off(tick_y - tick_font_size / 2),
 			font_family, tick_font_size, anchor, first + step * i, units);
-		write(plot->fd, line, strlen(line));
+		write_check(plot->fd, line, strlen(line));
 		tick_y += pixels_per_tick;
 	}
 	snprintf(line, line_len, "<text x=\"%d\" y=\"%d\" font-family=\"%s\" font-size=\"%d\" "
 		 "fill=\"black\" style=\"text-anchor: %s\">%d%s</text>\n",
 		 text_x, axis_y_off(graph_height), font_family, tick_font_size, anchor, last, units);
-	write(plot->fd, line, strlen(line));
+	write_check(plot->fd, line, strlen(line));
 }
 
 void set_plot_label(struct plot *plot, char *label)
@@ -635,14 +644,14 @@ void set_plot_label(struct plot *plot, char *label)
 		 plot_label_height / 2,
 		font_family, plot_label_font_size, "middle", label);
 	len = strlen(line);
-	write(fd, line, len);
+	write_check(fd, line, len);
 }
 
 static void close_svg(int fd)
 {
 	char *close_line = "</svg>\n";
 
-	write(fd, close_line, strlen(close_line));
+	write_check(fd, close_line, strlen(close_line));
 }
 
 int close_plot(struct plot *plot)
@@ -680,10 +689,10 @@ int close_plot_file(struct plot *plot)
 	snprintf(line, line_len, "<svg  xmlns=\"http://www.w3.org/2000/svg\" "
 		 "width=\"%d\" height=\"%d\">\n",
 		 final_width, final_height);
-	write(plot->fd, line, strlen(line));
+	write_check(plot->fd, line, strlen(line));
 	snprintf(line, line_len, "<rect x=\"0\" y=\"0\" width=\"%d\" "
 		 "height=\"%d\" fill=\"white\"/>\n", final_width, final_height);
-	write(plot->fd, line, strlen(line));
+	write_check(plot->fd, line, strlen(line));
 	close(plot->fd);
 	plot->fd = 0;
 	return 0;
@@ -788,19 +797,19 @@ int svg_line_graph(struct plot *plot, struct graph_line_data *gld, char *color,
 		if (!thresh1 && !thresh2) {
 
 			if (!printed_header) {
-				write(fd, start, strlen(start));
+				write_check(fd, start, strlen(start));
 				printed_header = 1;
 			}
 
 			/* in full line mode, everything in the graph is connected */
 			snprintf(line, line_len, "%c %d %d ", c, axis_x_off(x), axis_y_off(val));
 			c = 'L';
-			write(fd, line, strlen(line));
+			write_check(fd, line, strlen(line));
 			printed_lines = 1;
 		} else if (avg > thresh1 || avg > thresh2) {
 			int len = 10;
 			if (!printed_header) {
-				write(fd, start, strlen(start));
+				write_check(fd, start, strlen(start));
 				printed_header = 1;
 			}
 
@@ -814,14 +823,14 @@ int svg_line_graph(struct plot *plot, struct graph_line_data *gld, char *color,
 			 */
 			snprintf(line, line_len, "M %d %d h %d ", axis_x_off(x),
 				 axis_y_off(val), len);
-			write(fd, line, strlen(line));
+			write_check(fd, line, strlen(line));
 			printed_lines = 1;
 		}
 
 	}
 	if (printed_lines) {
 		snprintf(line, line_len, "\" fill=\"none\" stroke=\"%s\" stroke-width=\"2\"/>\n", color);
-		write(fd, line, strlen(line));
+		write_check(fd, line, strlen(line));
 	}
 	if (plot->timeline)
 		svg_write_time_line(plot, plot->timeline);
@@ -835,17 +844,17 @@ void svg_write_time_line(struct plot *plot, int col)
 				 "style=\"stroke:black;stroke-width:2;\"/>\n",
 				 axis_x_off(col), axis_y_off(0),
 				 axis_x_off(col), axis_y_off(graph_height));
-	write(plot->fd, line, strlen(line));
+	write_check(plot->fd, line, strlen(line));
 }
 
-static int svg_add_io(int fd, double row, double col, double width, double height, char *color)
+static void svg_add_io(int fd, double row, double col, double width, double height, char *color)
 {
 	float rx = 0;
 
 	snprintf(line, line_len, "<rect x=\"%.2f\" y=\"%.2f\" width=\"%.1f\" height=\"%.1f\" "
 		 "rx=\"%.2f\" style=\"stroke:none;fill:%s;stroke-width:0\"/>\n",
 		 axis_x_off_double(col), axis_y_off_double(row), width, height, rx, color);
-	return write(fd, line, strlen(line));
+	write_check(fd, line, strlen(line));
 }
 
 int svg_io_graph_movie_array(struct plot *plot, struct pid_plot_history *pph)
@@ -902,11 +911,11 @@ int svg_io_graph_movie_array_spindle(struct plot *plot, struct pid_plot_history
 		 "stroke=\"black\" stroke-width=\"6\" "
 		 "r=\"%.2f\" fill=\"none\"/>\n",
 		 spindle_steps * 1.2, center_x, center_y, center_x, center_y, graph_width_extra / 2);
-	write(plot->fd, line, strlen(line));
+	write_check(plot->fd, line, strlen(line));
 	snprintf(line, line_len, "<circle cx=\"%.2f\" cy=\"%.2f\" "
 		"stroke=\"none\" fill=\"red\" r=\"%.2f\"/>\n</g>\n",
 		axis_x_off_double(graph_width_extra), center_y, 4.5);
-	write(plot->fd, line, strlen(line));
+	write_check(plot->fd, line, strlen(line));
 	spindle_steps += 0.01;
 
 	radius = floor(radius / 2);
@@ -930,7 +939,7 @@ int svg_io_graph_movie_array_spindle(struct plot *plot, struct pid_plot_history
 			 axis_x_off_double(graph_width_extra / 2 + radius) + 8, center_y,
 			 radius, radius, pph->color);
 
-		write(plot->fd, line, strlen(line));
+		write_check(plot->fd, line, strlen(line));
 	}
 	return 0;
 }
@@ -1047,9 +1056,9 @@ void svg_write_legend(struct plot *plot)
 		 legend_width,
 		 plot->legend_index * legend_font_size + legend_font_size / 2 + 12);
 
-	write(plot->fd, line, strlen(line));
+	write_check(plot->fd, line, strlen(line));
 	for (i = 0; i < plot->legend_index; i++) {
-		write(plot->fd, plot->legend_lines[i],
+		write_check(plot->fd, plot->legend_lines[i],
 		      strlen(plot->legend_lines[i]));
 		free(plot->legend_lines[i]);
 	}
