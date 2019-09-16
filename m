From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 16 Sep 2019 15:39:28 +0000
Subject: [PATCH] btreplay: fix device IO remap functionality
Message-Id: <CALrw=nGNOAibEAU5q9S=caPmgdoJzHDkLeR+Dk+M772m4yasiw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Commit dd093eb1c48e ("Fix warnings on newer gcc") moved string buffers holding
device names during map file parse stage to stack. However, only pointers to
them are being stored in the allocated "struct map_dev" structure. These
pointers are invalid outside of scope of this function and in a different
thread context. Also "release_map_devs" function still tries to "free" them
later as if they were allocated on the heap.

Moving the buffers back to the heap by instructing "fscanf" to allocate them
while parsing the file.

Alternatively, we could redefine the "struct map_dev" to include the whole
buffers instead of just pointers to them and free them as part of releasing the
whole "struct map_dev".

Fixes: dd093eb1c48e ("Fix warnings on newer gcc")
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 btreplay/btreplay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index edaf81f..23cc2a9 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -645,7 +645,7 @@ static void find_input_devs(char *idir)
 static void read_map_devs(char *file_name)
 {
  FILE *fp;
- char from_dev[256], to_dev[256];
+ char *from_dev, *to_dev;

  fp = fopen(file_name, "r");
  if (!fp) {
@@ -653,7 +653,7 @@ static void read_map_devs(char *file_name)
  /*NOTREACHED*/
  }

- while (fscanf(fp, "%s %s", from_dev, to_dev) = 2) {
+ while (fscanf(fp, "%ms %ms", &from_dev, &to_dev) = 2) {
  struct map_dev *mdp = malloc(sizeof(*mdp));

  mdp->from_dev = from_dev;
--
2.11.0
