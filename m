From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 22 May 2008 14:47:13 +0000
Subject: Re: [PATCH] Handled no difference in seek times
Message-Id: <48358771.6090303@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <48347F9C.1080509@hp.com>
In-Reply-To: <48347F9C.1080509@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hm, might just be my testbed - I'm getting:

[    6.665781] Clocksource tsc unstable (delta = 88002879 ns)

in dmesg, and looking at the code I /think/ this drops the high res
timer off.

<sigh>
Alan
