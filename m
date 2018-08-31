From: Jeff Moyer <jmoyer@redhat.com>
Date: Fri, 31 Aug 2018 20:01:34 +0000
Subject: [patch] iowatcher: spwan NPROCESSORS_ONLN rsvg-convert-s
Message-Id: <x49pnxywbj5.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

iowatcher currently always spawns 8 rsvg-convert processes, no matter
how many CPUs a system has.  I did some limited testing of different
numbers of rsvg-convert processes.  Here are the results:

8 processes:
real	4m2.194s
user	23m36.665s
sys	0m38.523s

20 processes:
real	2m28.935s
user	24m51.817s
sys	0m49.227s

40 processes:
real	2m28.150s
user	24m56.994s
sys	0m49.621s

Note that this is the time it takes for a full run of iowatcher -- I
didn't separate out just the rsvg-convert portion.

Given the above results, it seems like a reasonable thing to spawn one
rsvg-convert process per cpu.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/iowatcher/main.c b/iowatcher/main.c
index 54325fb..4b97013 100644
--- a/iowatcher/main.c
+++ b/iowatcher/main.c
@@ -1043,9 +1043,14 @@ static void system_check(const char *cmd)
 
 static void convert_movie_files(char *movie_dir)
 {
+	long nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+
+	if (nr_cpus < 0)
+		nr_cpus = 8;
+
 	fprintf(stderr, "Converting svg files in %s\n", movie_dir);
-	snprintf(line, line_len, "find %s -name \\*.svg | xargs -I{} -n 1 -P 8 rsvg-convert -o {}.png {}",
-		 movie_dir);
+	snprintf(line, line_len, "find %s -name \\*.svg | xargs -I{} -n 1 -P %ld rsvg-convert -o {}.png {}",
+		 movie_dir, nr_cpus);
 	system_check(line);
 }
 
