From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 20 Feb 2021 13:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20210220130002.092911BC0139@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit a021a33b405b5101eec6c389e1dacd7934fdd35e:

  blkparse: Print PID information for TN_MESSAGE events (2020-05-20 07:38:26 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 2ec0bb0b725305025dcc3e3f195894040e2dab90:

  blktrace: inclusive terminology (2021-02-19 09:42:41 -0700)

----------------------------------------------------------------
Eric Sandeen (1):
      blktrace: inclusive terminology

 blkparse_fmt.c | 4 ++--
 blktrace.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index df2f6ce..9b83d1d 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -276,12 +276,12 @@ static void print_field(char *act, struct per_cpu_info *pci,
 static char *parse_field(char *act, struct per_cpu_info *pci,
 			 struct blk_io_trace *t, unsigned long long elapsed,
 			 int pdu_len, unsigned char *pdu_buf,
-			 char *master_format)
+			 char *primary_format)
 {
 	int minus = 0;
 	int has_w = 0;
 	int width = 0;
-	char *p = master_format;
+	char *p = primary_format;
 
 	if (*p = '-') {
 		minus = 1;
diff --git a/blktrace.c b/blktrace.c
index d0d271f..82a6aad 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -307,7 +307,7 @@ static pthread_mutex_t dp_mutex = PTHREAD_MUTEX_INITIALIZER;
 static volatile int dp_entries;
 
 /*
- * These synchronize master / thread interactions.
+ * These synchronize main / thread interactions.
  */
 static pthread_cond_t mt_cond = PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t mt_mutex = PTHREAD_MUTEX_INITIALIZER;
