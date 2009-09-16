From: "M. Mohan Kumar" <mohan@in.ibm.com>
Date: Wed, 16 Sep 2009 14:36:03 +0000
Subject: Re: blktrace -k
Message-Id: <200909161954.03815.mohan@in.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <200909161712.15652.mohan@in.ibm.com>
In-Reply-To: <200909161712.15652.mohan@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

>
> No, the -k option just cleans up the kernel state (typically from a
> previously aborted blktrace run that failed to clean up the state). It
> doesn't do anything with user-level processes running blktrace.
>

Does it mean that one has to explicitly kill the existing blktrace process by 
Ctrl+C or kill?

Regards,
M. Mohan Kumar
