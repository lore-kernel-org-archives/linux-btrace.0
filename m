From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 16 Sep 2009 11:57:45 +0000
Subject: Re: blktrace -k
Message-Id: <1253102265.8180.0.camel@cail>
List-Id: <linux-btrace.vger.kernel.org>
References: <200909161712.15652.mohan@in.ibm.com>
In-Reply-To: <200909161712.15652.mohan@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, 2009-09-16 at 17:12 +0530, M. Mohan Kumar wrote:
> Hi,
> 
> I observed that when we issue the command blktrace -d /dev/sda -k, which
> stops on going trace. But the process which initiated tracing still runs. Is 
> it the expected behavior? Should not the process also be killed when blktrace 
> -k option is used?
> 
> Regards,
> M. Mohan Kumar.

No, the -k option just cleans up the kernel state (typically from a
previously aborted blktrace run that failed to clean up the state). It
doesn't do anything with user-level processes running blktrace.

Alan

