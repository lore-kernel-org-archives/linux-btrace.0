From: "majianpeng" <majianpeng@gmail.com>
Date: Wed, 29 Jun 2011 06:07:28 +0000
Subject: Ask a question
Message-Id: <201106291407157819892@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

   Hi all:
         At present,I wanted to use blktrace.So I readed source and founded the problem.
         Following is my step:
         1:mount  -t debugfs debugfs /sys/kernel/debug
         2:blktrace -d /dev/sdb &
            $pid
         3:kill -9 $pid
         I found some file in /sys/kernel/debug/block.
         
	     If a btrace is ruing,but I call ioctl(BLKTRACETEARDOWN) 
		case BLKTRACETEARDOWN:
               ret = blk_trace_remove(q);
		int blk_trace_remove(struct request_queue *q)
 297 {               
 298         struct blk_trace *bt;
 299 
 300         bt = xchg(&q->blk_trace, NULL);
 301         if (!bt)
 302                 return -EINVAL;
 303                 
 304         if (bt->trace_state != Blktrace_running)
 305                 blk_trace_cleanup(bt);
 306                 
 307         return 0;
 308 }       
        But the btrace is in blktrace_running, so bt did not cleanup.
        When and Who cleanup btrace?
           
 				
--------------
majianpeng
2011-06-29

