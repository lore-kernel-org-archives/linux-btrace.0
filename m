From: Edward Shishkin <edward@redhat.com>
Date: Tue, 12 Oct 2010 15:38:28 +0000
Subject: Re: Recent changes
Message-Id: <4CB480F4.2050603@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello.
How about these ones:

http://marc.info/?l=linux-btrace&m8049870115477&w=2
http://marc.info/?l=linux-btrace&m8049870215491&w=2
http://marc.info/?l=linux-btrace&m8049871415498&w=2
http://marc.info/?l=linux-btrace&m8049873015527&w=2
http://marc.info/?l=linux-btrace&m8049874115543&w=2
http://marc.info/?l=linux-btrace&m8049875115566&w=2

any chances they will be pushed? All of them except the second
one (blkiomon fixups) are ack-ed by Alan D. Brunelle.

Thanks,
Edward.

Jens Axboe wrote:
> The following changes since commit fb7f86674a516ddff0d60bfab3bd284a4812075f:
>
>   blktrace: disable kill option - take 2 (2010-04-20 15:41:14 +0200)
>
> are available in the git repository at:
>   git://git.kernel.dk/blktrace.git master
>
> Alan D. Brunelle (1):
>       blktrace: disallow -o when using multiple devices
>
>  blktrace.c       |    6 ++++++
>  doc/blktrace.8   |    3 +++
>  doc/blktrace.tex |    5 ++++-
>  3 files changed, 13 insertions(+), 1 deletions(-)
>
> ---
>
> Diff of recent changes:
>
> diff --git a/blktrace.c b/blktrace.c
> index b9f9b68..4671a04 100644
> --- a/blktrace.c
> +++ b/blktrace.c
> @@ -2626,6 +2626,12 @@ int main(int argc, char *argv[])
>  		goto out;
>  	}
>  
> +	if (ndevs > 1 && output_name && strcmp(output_name, "-") != 0) {
> +		fprintf(stderr, "-o not supported with multiple devices\n");
> +		ret = 1;
> +		goto out;
> +	}
> +
>  	signal(SIGINT, handle_sigint);
>  	signal(SIGHUP, handle_sigint);
>  	signal(SIGTERM, handle_sigint);
> diff --git a/doc/blktrace.8 b/doc/blktrace.8
> index ab6a3f3..50b3a62 100644
> --- a/doc/blktrace.8
> +++ b/doc/blktrace.8
> @@ -122,6 +122,9 @@ Specifies number of buffers to use. blktrace defaults to 4 sub buffers.
>  \-\-output=\fIfile\fR        
>  .RS
>  Prepend \fIfile\fR to output file name(s)  
> +
> +This only works when supplying a single device, or when piping the output
> +via "-o -" with multiple devices.
>  .RE
>  
>  \-r \fIrel-path\fR
> diff --git a/doc/blktrace.tex b/doc/blktrace.tex
> index 54fe451..4d8278e 100644
> --- a/doc/blktrace.tex
> +++ b/doc/blktrace.tex
> @@ -389,7 +389,10 @@ Short              & Long                       & Description \\ \hline\hline
>  -d \emph{dev}      & --dev=\emph{dev}           & Adds \emph{dev} as a device to trace \\ \hline
>  -k                 & --kill                     & Kill on-going trace \\ \hline
>  -n \emph{num-sub}  & --num-sub=\emph{num-sub}   & Specifies number of buffers to use \\ \hline
> --o \emph{file}     & --output=\emph{file}       & Prepend \emph{file} to output file name(s) \\ \hline
> +-o \emph{file}     & --output=\emph{file}       & Prepend \emph{file} to output file name(s) \\
> +                   &                            & \textbf{This only works when using a single device} \\
> +                   &                            & \textbf{or when piping the output via \texttt{-o -}} \\
> +                   &                            & \textbf{with multiple devices.} \\ \hline
>  -r \emph{rel-path} & --relay=\emph{rel-path}    & Specifies debugfs mount point \\ \hline
>  -V                 & --version                  & Outputs version \\ \hline
>  -w \emph{seconds}  & --stopwatch=\emph{seconds} & Sets run time to the number of seconds specified \\ \hline
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   


-- 
Edward O. Shishkin
Principal Software Engineer
Red Hat Czech

