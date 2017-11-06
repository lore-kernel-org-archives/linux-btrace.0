From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 06 Nov 2017 13:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20171106130002.1D42B2C02AF@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit cca113f2fe0759b91fd6a0e10fdcda2c28f18a7e:

  Blktrace 1.2.0 (2017-11-04 22:13:06 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 07d76e12aa46fa0bad4b736d581ec5aca62264f7:

  btt/devs: silence warning on sprintf overflow (2017-11-05 08:54:41 -0700)

----------------------------------------------------------------
Jens Axboe (2):
      jhash: fix annoying gcc fall through warnings
      btt/devs: silence warning on sprintf overflow

 btt/devs.c |  2 +-
 jhash.h    | 34 ++++++++++++++++------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

---

Diff of recent changes:

diff --git a/btt/devs.c b/btt/devs.c
index ccaae87..12ce2ca 100644
--- a/btt/devs.c
+++ b/btt/devs.c
@@ -108,7 +108,7 @@ void dip_exit(void)
 static inline FILE *open_pit(struct d_info *dip)
 {
 	FILE *fp;
-	char str[256];
+	char str[272];
 
 	sprintf(str, "%s_pit.dat", dip->dip_name);
 	if ((fp = my_fopen(str, "w")) = NULL)
diff --git a/jhash.h b/jhash.h
index 4cebd23..a4d3106 100644
--- a/jhash.h
+++ b/jhash.h
@@ -73,22 +73,21 @@ static inline u32 jhash(const void *key, u32 length, u32 initval)
 		k += 12;
 	}
 
-	/* last block: affect all 32 bits of (c) */
-	/* all the case statements fall through */
+	/* Last block: affect all 32 bits of (c) */
 	switch (length) {
-	case 12: c += (u32)k[11]<<24;
-	case 11: c += (u32)k[10]<<16;
-	case 10: c += (u32)k[9]<<8;
-	case 9 : c += k[8];
-	case 8 : b += (u32)k[7]<<24;
-	case 7 : b += (u32)k[6]<<16;
-	case 6 : b += (u32)k[5]<<8;
-	case 5 : b += k[4];
-	case 4 : a += (u32)k[3]<<24;
-	case 3 : a += (u32)k[2]<<16;
-	case 2 : a += (u32)k[1]<<8;
-	case 1 : a += k[0];
-		__jhash_final(a, b, c);
+	case 12: c += (u32)k[11]<<24;	/* fall through */
+	case 11: c += (u32)k[10]<<16;	/* fall through */
+	case 10: c += (u32)k[9]<<8;	/* fall through */
+	case 9:  c += k[8];		/* fall through */
+	case 8:  b += (u32)k[7]<<24;	/* fall through */
+	case 7:  b += (u32)k[6]<<16;	/* fall through */
+	case 6:  b += (u32)k[5]<<8;	/* fall through */
+	case 5:  b += k[4];		/* fall through */
+	case 4:  a += (u32)k[3]<<24;	/* fall through */
+	case 3:  a += (u32)k[2]<<16;	/* fall through */
+	case 2:  a += (u32)k[1]<<8;	/* fall through */
+	case 1:  a += k[0];
+		 __jhash_final(a, b, c);
 	case 0 :
 		break;
 	}
@@ -117,10 +116,9 @@ static inline u32 jhash2(u32 *k, u32 length, u32 initval)
 	}
 
 	/* handle the last 3 u32's */
-	/* all the case statements fall through */ 
 	switch (length) {
-	case 3: c += k[2];
-	case 2: b += k[1];
+	case 3: c += k[2];	/* fall through */
+	case 2: b += k[1];	/* fall through */
 	case 1: a += k[0];
 		__jhash_final(a, b, c);
 	case 0:     /* case 0: nothing left to add */
