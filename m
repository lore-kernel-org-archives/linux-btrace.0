From: Hou Tao <houtao1@huawei.com>
Date: Tue, 09 Jan 2018 06:56:23 +0000
Subject: [PATCH 0/3] blktrace: support saving and parsing cgroup info
Message-Id: <20180109065626.5459-1-houtao1@huawei.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi Jens,

The patchset is a userspace counterpart of patchset [1] committed
recently by Shaohua Li. It adds support for saving and parsing io
cgroup info in blktrace and blkparse utilities, so the following
command can be used to output blk trace with cgroup info:

	# blktrace -g -d /dev/sda -o - | blkparse -g -i -

	253,0    6        1     0.000000000  1565  A   R 3353712 + 8 <- (253,1) 3351664
	253,0    5        1     0.000001944  1564  A   R 1585104 + 8 <- (253,1) 1583056
	253,0    3        1     0.000004072  1563  A   R 65448 + 8 <- (253,1) 63400
	253,0    6        2     0.000010653 / 1565  Q   R 3353712 + 8 [fio]
	253,0    5        2     0.000012018 /mk/t2 1564  Q   R 1585104 + 8 [fio]
	253,0    3        2     0.000013575 /t1 1563  Q   R 65448 + 8 [fio]
	253,0    6        3     0.000018975 / 1565  G   R 3353712 + 8 [fio]
	253,0    5        3     0.000019629 /mk/t2 1564  G   R 1585104 + 8 [fio]
	253,0    3        3     0.000020689 /t1 1563  G   R 65448 + 8 [fio]
	......

I have three concerns on the implementation. The first is about the
output format for the cgroup path. Now blkparse just outputs the
cgroup path before the pid, but i'm not sure whether or not it's proper.
The second one is about caching the translations from kernfs (inod, gen)
(namely cgroup info) to cgroup path. Now there is no such cache, and i
will add one if needed. The last one is about the enabling of blk_cgroup
option in blktrace. Now blktrace enables it by writing text directly into
trace files, maybe a per-device API will be better ?

Thoughts and reviews are welcome.

Regards,

Tao

[1]: https://www.spinics.net/lists/linux-block/msg15289.html
---

Hou Tao (3):
  blktrace: support trace with cgroup info
  blkparse: add option g/group to output cgroup info
  blktrace: add option g/group to save cgroup info

 blkparse.c     | 152 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 blkparse_fmt.c |  32 ++++++++++--
 blktrace.c     | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 blktrace.h     |   7 +++
 blktrace_api.h |  10 ++++
 doc/blkparse.1 |   9 +++-
 doc/blktrace.8 |   9 +++-
 7 files changed, 336 insertions(+), 27 deletions(-)

-- 
2.9.5

