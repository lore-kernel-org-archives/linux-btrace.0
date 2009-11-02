From: dhsharp@google.com
Date: Mon, 02 Nov 2009 22:39:28 +0000
Subject: [PATCH] blktrace: triggered output: with '-t' option, trigger output on SIGUSR1
Message-Id: <1257201569-8551-1-git-send-email-dhsharp@google.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This patch adds a triggering mechanism so that traces are read from the kernel
ring buffer only on SIGUSR1.  In this way, we can detect an "interesting" event
(slow, etc) and then dump the most recent traces which should hopefully be
related to that event. The number of traces can be controlled by the buffer
size and number parameters.

Please CC me on replies.

Thanks,
David Sharp

