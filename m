From: "M. Mohan Kumar" <mohan@in.ibm.com>
Date: Wed, 16 Sep 2009 11:54:15 +0000
Subject: blktrace -k
Message-Id: <200909161712.15652.mohan@in.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

I observed that when we issue the command blktrace -d /dev/sda -k, which
stops on going trace. But the process which initiated tracing still runs. Is 
it the expected behavior? Should not the process also be killed when blktrace 
-k option is used?

Regards,
M. Mohan Kumar.
