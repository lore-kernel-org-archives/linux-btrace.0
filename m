From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 21 May 2008 14:59:25 +0000
Subject: [PATCHed btt] Added in -m option, seeks-per-second (version 2.05)
Message-Id: <483438CD.2030905@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


btt can now output data files containing seeks-per-second information.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 btt/args.c        |   17 +-
 btt/bt_timeline.c |    5 +-
 btt/doc/btt.tex   |   52 +-
 btt/doc/sps.eps   | 5377
+++++++++++++++++++++++++++++++++++++++++++++++++++++
 btt/globals.h     |    2 +-
 btt/seek.c        |   69 +-
 6 files changed, 5514 insertions(+), 8 deletions(-)
