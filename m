From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 17 Jan 2020 13:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20200117130002.4977D1BC0155@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 9c73da91540b27adaaf56065629e831cc50c5a3d:

  doc: tex: add absolute timestamp printing option (2019-09-25 00:22:13 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to f4f8ef7cdea138cfaa2f3ca0ee31fa23d3bcf1cc:

  fix parallel build of btt and blkiomon (2020-01-16 13:33:59 -0700)

----------------------------------------------------------------
Gwendal Grignou (1):
      fix parallel build of btt and blkiomon

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

Diff of recent changes:

diff --git a/Makefile b/Makefile
index 5917814..eb3c6a1 100644
--- a/Makefile
+++ b/Makefile
@@ -14,7 +14,7 @@ all: $(ALL) $(SUBDIRS)
 
 # We always descend into subdirs because they contain their own dependency
 # information which we don't track in this top level Makefile.
-$(SUBDIRS):
+$(SUBDIRS): $(PROGS)
 	$(MAKE) -C $@
 .PHONY: $(SUBDIRS)
 
