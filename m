From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:58:05 +0000
Subject: [blktrace-tools RFC PATCH 0/5] blktrace: add block trace extension support
Message-Id: <20190602165810.14817-1-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

This patch series adds support to track more request based flags and
different request fields to the blktrace infrastructure, for RFC we
only update blktrace and blkparse tools. As we make progress I'll
also update the rest of the tools.

With reference to the kernel side patch-series, in this series, we increase
the action, action mask field and add priority and priority mask field to
existing infrastructure.  We add new structures to hold the trace where we
increase the size of the action field and add a new member to track the
priority of the I/O. For the trace management side, we add new IOCTLs so
that user can configure trace extensions from the blktrace user-space tools.

For this RFC I kept the patches simple and per tool basis where the first 3
patches update the user API which is mostly common code and reflection
of the kernel side changes and later two patches are for blktrace and
blkparse tool. Please have a look at Kernel Side RFC reference :-
https://marc.info/?l=linux-btrace&m5949445123407&w=2

The RFC is still light on the details but with new IOCTLs I was able to
get the code running with user-space tools. There is still some more
scope to optimize the code and reducing the duplicate code, but I kept
it simple for now so that it is easy to review.

Chaitanya Kulkarni (5):
  blktrace_api.h: add trace extension definitions
  blktrace.h: update tools header for trace extension
  act_mask: add support for trace extension
  blktrace: add support for trace extension
  blkparse: add support for trace extension

 Makefile       |    2 +-
 act_mask.c     |   75 ++++
 blkparse.c     | 1072 +++++++++++++++++++++++++++++++++++-------------
 blkparse.h     |   78 ++++
 blkparse_fmt.c |  204 ++++++---
 blktrace.c     |  342 +++++++++++++--
 blktrace.h     |   78 +++-
 blktrace_api.h |  107 ++++-
 8 files changed, 1567 insertions(+), 391 deletions(-)
 create mode 100644 blkparse.h

-- 
2.19.1
