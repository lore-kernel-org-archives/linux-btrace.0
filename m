From: Li Zefan <lizf@cn.fujitsu.com>
Date: Mon, 11 May 2009 07:06:46 +0000
Subject: [PATCH] blktrace: from-sector redundant in trace_block_remap, fix
Message-Id: <4A07CE86.5090301@cn.fujitsu.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <49FF4FAE.3000301@hp.com> <49FF517C.7000503@hp.com>
In-Reply-To: <49FF517C.7000503@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: "Alan D. Brunelle" <Alan.Brunelle@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-btrace <linux-btrace@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>

> Removed redundant from-sector parameter: it's /always/ the bio's sector
> passed in.
> 
> Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
> Cc: Jens Axboe <jens.axboe@oracle.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Reviewed-by: Li Zefan <lizf@cn.fujitsu.com>

I reviewed the older version of this patch, but didn't review it again when
Alan sent out this revised one, and I just found a typo in it...

> Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
...
>  DECLARE_TRACE(block_remap,
>  	TP_PROTO(struct request_queue *q, struct bio *bio, dev_t dev,
> -		 sector_t to, sector_t from),
> -	      TP_ARGS(q, bio, dev, to, from));
> +		 sector_t to),
> +	      TP_ARGS(q, bio, dev, to));

It should be 'from', not 'to'.


=======


From: Li Zefan <lizf@cn.fujitsu.com>
Subject: [PATCH] blktrace: from-sector redundant in trace_block_remap, fix

The last argument of block_remap prober is the original sector
before remap, so it should be 'from', not 'to'.

[ Impact: clean up ]

Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
---
 include/trace/block.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/block.h b/include/trace/block.h
index 8ac945b..5b12efa 100644
--- a/include/trace/block.h
+++ b/include/trace/block.h
@@ -70,7 +70,7 @@ DECLARE_TRACE(block_split,
 
 DECLARE_TRACE(block_remap,
 	TP_PROTO(struct request_queue *q, struct bio *bio, dev_t dev,
-		 sector_t to),
-	      TP_ARGS(q, bio, dev, to));
+		 sector_t from),
+	      TP_ARGS(q, bio, dev, from));
 
 #endif
-- 
1.5.4.rc3



