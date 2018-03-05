From: Souvik Banerjee <souvik1997@gmail.com>
Date: Mon, 05 Mar 2018 02:00:59 +0000
Subject: BLKTRACESETUP sometimes fails
Message-Id: <CAA_L7Z44Tdx5pFr3X+UX6tH4RkNY29uzrk4O09dgPQeCG6Ou+Q@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

I've noticed that BLKTRACESETUP sometimes fails with an error message
if a previous instance of blktrace was killed e.g. with SIGKILL
(though sometimes it happens when it is killed with SIGTERM). An easy
fix is to call BLKTRACESETUP in a loop: if BLKTRACESETUP fails, we can
call BLKTRACESTOP and BLKTRACETEARDOWN and try BLKTRACESETUP again.
Does this sound reasonable?

Thanks,

Souvik Banerjee
