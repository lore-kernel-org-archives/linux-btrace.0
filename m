From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 01 Sep 2018 12:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20180901120001.7B7612C00A8@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit f011d96f260a2be5dcc2ad9f4d1bf2d591946723:

  iowatcher: don't add Q events to the io hash (2018-08-30 20:57:53 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 10df4b691a68dd440547e393b6d241fc54fd2fad:

  iowatcher: spawn NPROCESSORS_ONLN for rsvg-convert-s (2018-08-31 14:57:57 -0600)

----------------------------------------------------------------
Jeff Moyer (1):
      iowatcher: spawn NPROCESSORS_ONLN for rsvg-convert-s

 iowatcher/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

---

Diff of recent changes:

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
 
