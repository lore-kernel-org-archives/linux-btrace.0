From: Eric Sandeen <sandeen@redhat.com>
Date: Tue, 20 Aug 2019 16:20:03 +0000
Subject: [PATCH] iowatcher: gracefully skip zero-length trace files
Message-Id: <07b08af7-e6ee-a022-14c3-80229f806312@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I received a bug report where this result confused the reporter:

# iowatcher -t dump.blktrace.1 -o movie.ogg  --movie=rect
Using movie style: rect
Unable to mmap trace file dump.blktrace.1, err Invalid argument
#

mmap() failed because the specified trace file was zero length.
Since mmap will fail, and we can't use a zero-length file anyway,
make the error more clear and don't even try the mmap.

Reported-by: Karel Srot <ksrot@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index 41e20f0..c56e017 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -930,6 +930,10 @@ struct trace *open_trace(char *filename)
 		fprintf(stderr, "stat failed on %s err %s\n", filename, strerror(errno));
 		goto fail_fd;
 	}
+	if (!st.st_size) {
+		fprintf(stderr, "skipping zero-length file %s\n", filename);
+		goto fail_fd;
+	}
 	p = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (p = MAP_FAILED) {
 		fprintf(stderr, "Unable to mmap trace file %s, err %s\n", filename, strerror(errno));
