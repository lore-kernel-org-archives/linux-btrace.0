From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Mon, 12 May 2008 13:58:28 +0000
Subject: [PATCHed btt] Fixed percentage calculations for phases of an I/O
Message-Id: <48284D04.5030201@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 btt/output.c |   86
+++++++++++++++++----------------------------------------
 1 files changed, 26 insertions(+), 60 deletions(-)
