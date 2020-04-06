From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 06 Apr 2020 14:09:12 +0000
Subject: [PATCH 0/3] Split io tracing
Message-Id: <20200406140915.109022-1-agruenba@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

we recently ran into bio splitting problems in the kernel.  A typical
request would show up in the blktrace output as follows or worse:

  253,2    8       23     0.041305439  4907  Q   R 645838360 + 896 [dd]
  253,2    8       24     0.041307791  4907  X   R 645838360 / 645838872 [dd]
  253,2    8       25     0.041308789  4907  X   R 645838360 / 645838592 [dd]
  253,2    8       26     0.041313578  4907  X   R 645838872 / 645839104 [dd]
  253,2    8       27     0.041319035  4907  X   R 645838592 / 645838848 [dd]
  [...]
  253,2    8       68     0.051036527     0  C   R 645839104 + 152 ( 9731088) [0]

The kernel bug leading to this kind of result (a split into
232-256-24-232-152 instead of 232-256-256-152) has meanwhile been fixed,
but those kinds of traces remain difficult to read, for two reasons:
first, it's hard to match a request to the corresponding completion
because the sector and length of the completion don't match the request.
Second, it's difficult to figure out which pieces a request is getting
split into.

I don't have a good answer to the second problem, but how about at least
addressing the first problem by fixing up the sector and length of the
completion to match the request in blkparse when --track-ios is used, as
in the last of these three patches?  The last line above would turn
into:

  253,2    8       68     0.051036527     0  C   R 645838360 + 896 ( 9731088) [0]

Thanks,
Andreas

Andreas Gruenbacher (3):
  blkparse: Fix device in event tracking error messages
  blkparse: Allow request tracking on non md/dm devices
  blkparse: Fix up the sector and length of split completions

 blkparse.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)


base-commit: db4f6340e04716285ea56fe26d76381c3adabe58
-- 
2.25.1
