From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 17 Sep 2019 12:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20190917120001.7A8562C0099@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit a7263b8fb22f07f4f1a3ec54f0c37193c5908b22:

  blkparse: add support sort program by io event (2019-05-21 08:06:08 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 667ac92a1a72b6038f0fae4acfc6a280fd69697b:

  btreplay: fix device IO remap functionality (2019-09-16 10:30:23 -0600)

----------------------------------------------------------------
Ignat Korchagin (1):
      btreplay: fix device IO remap functionality

 btreplay/btreplay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

---

Diff of recent changes:

diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index edaf81f..23cc2a9 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -645,7 +645,7 @@ static void find_input_devs(char *idir)
 static void read_map_devs(char *file_name)
 {
 	FILE *fp;
-	char from_dev[256], to_dev[256];
+	char *from_dev, *to_dev;
 
 	fp = fopen(file_name, "r");
 	if (!fp) {
@@ -653,7 +653,7 @@ static void read_map_devs(char *file_name)
 		/*NOTREACHED*/
 	}
 
-	while (fscanf(fp, "%s %s", from_dev, to_dev) = 2) {
+	while (fscanf(fp, "%ms %ms", &from_dev, &to_dev) = 2) {
 		struct map_dev *mdp = malloc(sizeof(*mdp));
 
 		mdp->from_dev = from_dev;
