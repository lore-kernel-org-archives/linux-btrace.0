From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 16 Sep 2009 14:35:57 +0000
Subject: Re: blktrace -k
Message-Id: <1253111757.12161.0.camel@cail>
List-Id: <linux-btrace.vger.kernel.org>
References: <200909161712.15652.mohan@in.ibm.com>
In-Reply-To: <200909161712.15652.mohan@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, 2009-09-16 at 19:54 +0530, M. Mohan Kumar wrote:
> >
> > No, the -k option just cleans up the kernel state (typically from a
> > previously aborted blktrace run that failed to clean up the state). It
> > doesn't do anything with user-level processes running blktrace.
> >
> 
> Does it mean that one has to explicitly kill the existing blktrace process by 
> Ctrl+C or kill?
> 
> Regards,
> M. Mohan Kumar

Yes - the point of '-k' is to clean up after some blktrace process has
failed unexpectedly and left the kernel in an unclean state. [Although I
think that the kernel has been cleaned up enough in this area where it
may not be necessary anymore...]

Alan

