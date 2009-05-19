From: Li Zefan <lizf@cn.fujitsu.com>
Date: Tue, 19 May 2009 01:14:06 +0000
Subject: Re: [Patch] Remove debugfs entries on bad path
Message-Id: <4A1207DE.4000409@cn.fujitsu.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4A115BA5.6090905@linux.vnet.ibm.com>
In-Reply-To: <4A115BA5.6090905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raspl@linux.vnet.ibm.com
Cc: linux-btrace@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

A better title:
	[Patch] blktrace: remove debugfs entries on bad path

Stefan Raspl wrote:
> debugfs directory entries for devices are not removed on bad path.

Can you be more elaborate on how to reproduce this issue?

> If so, subsequent attempts to start blktrace on the respective
> devices will not succeed due to existing directories.
> 
> Signed-off-by: Stefan Raspl <stefan.raspl@linux.vnet.ibm.com>
> 
> ---
>  kernel/trace/blktrace.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -262,6 +262,7 @@ static void blk_trace_free(struct blk_tr
>  {
>  	debugfs_remove(bt->msg_file);
>  	debugfs_remove(bt->dropped_file);
> +	debugfs_remove(bt->dir);
>  	relay_close(bt->rchan);
>  	free_percpu(bt->sequence);
>  	free_percpu(bt->msg_data);
> 

