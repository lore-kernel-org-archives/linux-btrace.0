From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 16 Dec 2011 19:27:33 +0000
Subject: [PATCH 10/10] blktrace: remove unused variable
Message-Id: <4EEB9BA5.7000901@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

sp was being incremented w/o initialization, but thankfully
not used otherwise.  Just remove it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/blktrace.c b/blktrace.c
index 5f74ef2..6c3533e 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1728,11 +1728,10 @@ static int handle_pfds_netclient(struct tracer *tp, int nevs, int force_read)
 {
 	struct stat sb;
 	int i, nentries = 0;
-	struct pdc_stats *sp;
 	struct pollfd *pfd = tp->pfds;
 	struct io_info *iop = tp->ios;
 
-	for (i = 0; i < ndevs; i++, pfd++, iop++, sp++) {
+	for (i = 0; i < ndevs; i++, pfd++, iop++) {
 		if (pfd->revents & POLLIN || force_read) {
 			if (fstat(iop->ifd, &sb) < 0) {
 				perror(iop->ifn);


