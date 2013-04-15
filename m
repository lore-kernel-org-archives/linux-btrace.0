From: Nathan Zimmer <nzimmer@sgi.com>
Date: Mon, 15 Apr 2013 14:53:31 +0000
Subject: [PATCH 0/5] Improve scaling and hotplugging tolerance in blktrace and friends
Message-Id: <1366037616-20159-1-git-send-email-nzimmer@sgi.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

While looking for issues at 4096 cpus I noticed that blktrace was behaving 
oddly.  Upon reviewing I discovered some parts of the code were written at at
time when boxes were limited to 512 and holes in cpu maps were impossible.

This patch series should correct that.


Nathan Zimmer (5):
  verify_blkparse: Change max_cpus to deal with systems larger the 512
  btreplay: Machines are now large enough that holes need to be dealt
    with
  btreplay: use sysconf to get the number of configured cpus
  blktrace: use number of configured cpus instead of online cpus
  blktrace blkreplay: convert to use a dynamic cpu_set_t

 blktrace.c          | 20 +++++++++++++-------
 btreplay/btreplay.c | 51 +++++++++++++++++++++++++++++++++++----------------
 verify_blkparse.c   | 23 +++++++++++++++++++----
 3 files changed, 67 insertions(+), 27 deletions(-)

-- 
1.8.1.2

