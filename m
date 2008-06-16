From: "Carl Henrik Lunde" <chlunde@ping.uio.no>
Date: Mon, 16 Jun 2008 11:46:15 +0000
Subject: blktrace -k / invalid blktrace state
Message-Id: <ed038eb20806160446w6f212610rbb4fba53d0f8285c@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

I've been having an issue with blktrace -k, basically I could only run
it once per boot.  Am I the only one running into this issue?


This may be due to some local modification I've done, but I took a
look at the code and there seems to be two issues with the current
code:

# TEARDOWN:
> int blk_trace_remove(struct request_queue *q)
> {
>         struct blk_trace *bt;
>
>         bt = xchg(&q->blk_trace, NULL);
>         if (!bt)
>                 return -EINVAL;
>
>         if (bt->trace_state = Blktrace_setup ||
>             bt->trace_state = Blktrace_stopped)
>                 blk_trace_cleanup(bt);

When this "if" fails then we have lost the only reference to
q->blk_trace?

>
>         return 0;
> }


The other issue seems to be that blk_trace_cleanup will fail when if
we run blk_trace_cleanup when user space has the traceN files
open:

> static void blk_trace_cleanup(struct blk_trace *bt)
> {
>         relay_close(bt->rchan);

This will only decrease the refcount of the files by one, but user
space still holds one reference so blk_remove_buf_file_callback will
not be called.

>         debugfs_remove(bt->dropped_file);

This will run OK.  (I'm not sure if blktrace user space has read this
file yet?)

>         blk_remove_tree(bt->dir);

This will fail because dir is not empty.

>         free_percpu(bt->sequence);
>         free_percpu(bt->msg_data);
>         kfree(bt);
> }

Workaround: use "killall blktrace" or similar?

If time permits I'll write a patch later this week.

-- 
Carl Henrik
