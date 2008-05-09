From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 09 May 2008 17:58:14 +0000
Subject: [PATCHed btt] Added S2G times + fixed up -X output to include X2X
Message-Id: <482490B6.1070500@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Including Q2Q, Q2G, S2G, G2I, Q2M, I2D, M2D, D2C, Q2C.

S2G is part of Q2G, and shows the number of times we had to sleep to
get a request.

Ignored 0-byte I/Os - coming from barrier I/Os...

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 btt/bt_timeline.c    |    2 +-
 btt/doc/btt.tex      |   38 ++++++++++++++++++++++++++++++--------
 btt/globals.h        |    8 ++++++--
 btt/inlines.h        |    5 +++++
 btt/output.c         |   42 +++++++++++++++++++++++++++---------------
 btt/trace.c          |    1 +
 btt/trace_complete.c |    3 +++
 btt/trace_im.c       |   36 +++++++++++++++++++++++++++++++-----
 btt/trace_issue.c    |    4 ++++
 btt/trace_queue.c    |    3 +++
 10 files changed, 111 insertions(+), 31 deletions(-)
