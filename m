From: Jens Axboe <jaxboe@fusionio.com>
Date: Sat, 15 Jan 2011 05:00:03 +0000
Subject: Recent changes
Message-Id: <20110115050003.7EB8B37A2F9@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 5480f591a58df0e873ab80ba21e7b81b9a6fa0c5:

  Merge branch 'master' of ssh://router.home.kernel.dk/data/git/blktrace (2011-01-11 08:36:21 +0100)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Tao Ma (1):
      blkiomon: Fix an output error

 stats.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

---

Diff of recent changes:

diff --git a/stats.h b/stats.h
index fdedf27..5b9a313 100644
--- a/stats.h
+++ b/stats.h
@@ -75,6 +75,9 @@ static inline void minmax_to_be(struct minmax *mm)
 
 static inline double minmax_avg(struct minmax *mm)
 {
+	if (!mm->num)
+		return 0;
+
 	return (mm->sum / (double)mm->num);
 }
 
@@ -82,6 +85,9 @@ static inline double minmax_var(struct minmax *mm)
 {
 	double num = (double)mm->num;
 
+	if (!mm->num)
+		return 0;
+
 	return ((mm->sos - ((mm->sum * mm->sum) / num)) / num);
 }
 
