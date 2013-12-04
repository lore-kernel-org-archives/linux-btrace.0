From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 04 Dec 2013 02:25:35 +0000
Subject: Re: [PATCH] blktrace bno_plot.py: output comprehensive message when gnuplot not found
Message-Id: <20131204022535.GH5051@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1386072299-10149-1-git-send-email-devel@etsukata.com>
In-Reply-To: <1386072299-10149-1-git-send-email-devel@etsukata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Dec 03 2013, Eiichi Tsukata wrote:
> Currently, bno_plot.py uses os.execvp which does not show enough information
> when executed command is not found. For example, when gnuplot is not found
> bno_plot.py shows the following messages:
> 
>     Traceback (most recent call last):
>       File "/usr/local/bin/bno_plot.py", line 123, in <module>
>         os.execvp(cmd[0], cmd)
>       File "/usr/lib64/python2.7/os.py", line 344, in execvp
>         _execvpe(file, args)
>       File "/usr/lib64/python2.7/os.py", line 368, in _execvpe
>         func(file, *argrest)
>     OSError: [Errno 2] No such file or directory
> 
> Users can't understand what happend directly from the message.
> 
> Instead of os.execvp, this patch uses os.system which shows the following
> messages when gnuplot not found:
> 
>     sh: gnuplot: command not found

Thanks, applied.

-- 
Jens Axboe

