From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 16 Oct 2008 06:04:06 +0000
Subject: Re: [PATCH] blktrace: Fix documentation for version flag
Message-Id: <20081016060405.GQ19428@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20081015093558.GA9353@schmichrtp.de.ibm.com>
In-Reply-To: <20081015093558.GA9353@schmichrtp.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Oct 15 2008, Christof Schmitt wrote:
> blktrace uses the -V flag (uppercase) for printing the version
> information. Fix the man page and the usage information that wrongly
> state the -v flag (lowercase).
> 
> Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
> ---
>  blktrace.c     |    2 +-
>  doc/blktrace.8 |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/blktrace.c	2008-10-15 11:12:53.000000000 +0200
> +++ b/blktrace.c	2008-10-15 11:14:57.000000000 +0200
> @@ -1756,7 +1756,7 @@ static int net_setup_client(void)
>  
>  static char usage_str[] = \
>  	"-d <dev> [ -r debugfs path ] [ -o <output> ] [-k ] [ -w time ]\n" \
> -	"[ -a action ] [ -A action mask ] [ -I  <devs file> ] [ -v ]\n\n" \
> +	"[ -a action ] [ -A action mask ] [ -I  <devs file> ] [ -V ]\n\n" \
>  	"\t-d Use specified device. May also be given last after options\n" \
>  	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
>  	"\t-o File(s) to send output to\n" \
> --- a/doc/blktrace.8	2008-10-15 11:12:53.000000000 +0200
> +++ b/doc/blktrace.8	2008-10-15 11:15:22.000000000 +0200
> @@ -6,7 +6,7 @@ blktrace \- generate traces of the i/o t
>  
>  
>  .SH SYNOPSIS
> -.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [\-k ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
> +.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [\-k ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-V ]
>  .br

I'll just change blktrace to take -v as well, that is what most other
programs accept so no point in deviating there.

-- 
Jens Axboe

