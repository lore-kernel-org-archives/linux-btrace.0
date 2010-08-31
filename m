From: Xuekun Hu <xuekun.hu@gmail.com>
Date: Tue, 31 Aug 2010 06:32:56 +0000
Subject: blktrace could cause system hang under 1G memory size and 20 minutes duration
Message-Id: <AANLkTi=++sLx+dJc-TRp41Sog+_Eqy9nNesumvCEd90o@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi, Guys

My Linux system (2.6.18, x86_64, RHEL5) only has 1G memory, and I
would like to use blktrace (1.0.1) to capture 20 minutes of IO traces
with medium IO traffics. After 20 minutes, system would hang. I think
at this phase, blktrace is exiting and  printing the summary section
that number of events captured on each cpu.

I'm guessing the system hang due to out of memory. (I can ping the
system, but can't login). I'm wondering is there a workaround?

Thx, Xuekun
