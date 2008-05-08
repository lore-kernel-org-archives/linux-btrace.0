From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 08 May 2008 19:33:27 +0000
Subject: [PATCHed btt]  Added -X option - generate easily parseable file
Message-Id: <48235587.4050004@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Writes a portion of the default output into a separate file that is more
easily parsed.

Sample output (btt.xvg):

DMI 8,16 310407 106729 2.908366049 0 182 1024 19504768
QSK 8,16 310407 167141.958551192 0 0 235753
DSK 8,16 106729 433247.436563633 0 0 33974
PLG 8,16 40824 382 0.008882101
UPG 8,16 1.993361748 1.866492147
ARQ 8,16 22.863331046

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 btt/args.c        |   36 ++++++++++++++++++++++++-----
 btt/bt_timeline.c |    5 ++-
 btt/doc/btt.tex   |   56 +++++++++++++++++++++++++++++++++++++++++++--
 btt/globals.h     |    3 +-
 btt/output.c      |   64
+++++++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 148 insertions(+), 16 deletions(-)
