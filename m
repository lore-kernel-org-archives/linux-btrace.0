From: Ming Zhang <blackmagic02881@gmail.com>
Date: Sun, 08 Apr 2007 18:10:07 +0000
Subject: Re: [BTT PATCH] Fix memory leak
Message-Id: <1176055807.4834.13.camel@localhost.localdomain>
List-Id: <linux-btrace.vger.kernel.org>
References: <4617D567.500@pobox.com>
In-Reply-To: <4617D567.500@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sat, 2007-04-07 at 13:31 -0400, Alan D. Brunelle wrote:
> [[Note: I do not have access to my work mail right now, so I'm doing 
> this quite blind - please excuse me if I've got the name wrong below...]]
> 
> Hi Jens -
> 
> A couple of weeks ago Ming Zhang had noted that btt was using tremendous 
> amounts of memory to accomplish a run. After looking at the code, and 
> doing some testing, I determined the cause - please find a patch to the 
> latest tree that seems to fix the problem for me...
> 
> Thanks for pointing this out Ming!

welcome. thanks a lot for this. i tried and it at least can parse the
previous 7xxMB log in my laptop now. i ran a valgrind on it quickly and
found there are some memory loss. most of them possibly are left to OS
to do cleanup, though this make the memory leak debug more difficult.

> 
> Alan
> 
> PS. /If/ anyone tries this, and there is an issue, I'll only see my home 
> e-mail (Alan.Brunelle@pobox.com) until Monday 9 April 2007...
> 
> 
> plain text document attachment (fix-memusage)
> From: Alan D. Brunelle <Alan.Brunelle@hp.com>
> Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
> ---
> 
>  btt/Makefile         |   12 +++++-
>  btt/bt_timeline.c    |   41 +++++++++++++++++++---
>  btt/devs.c           |   11 +++---
>  btt/globals.h        |   27 +++++++++-----
>  btt/inlines.h        |   94 +++++++++++++++++++++++++++++++++++---------------
>  btt/trace.c          |   17 +++++----
>  btt/trace_complete.c |   19 +++++-----
>  btt/trace_im.c       |   43 +++++++++--------------
>  btt/trace_issue.c    |   41 +++++++---------------
>  btt/trace_queue.c    |    8 ++--
>  btt/trace_remap.c    |   12 +++---
>  btt/trace_requeue.c  |   18 +++++-----
>  12 files changed, 200 insertions(+), 143 deletions(-)
> 
> diff --git a/btt/Makefile b/btt/Makefile
> index 17fb8c0..ba9e86f 100644
> --- a/btt/Makefile
> +++ b/btt/Makefile
> @@ -1,7 +1,13 @@
>  CC	= gcc
> -CFLAGS	= -Wall -O2 -W -g
> -# CFLAGS	= -Wall -g -W -UDO_INLINE -DDEBUG
> -ALL_CFLAGS = $(CFLAGS) -I.. -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITSd
> +
> +ECFLAGS	= 
> +# ECFLAGS	= -DCOUNT_IOS
> +
> +CFLAGS	= -Wall -O2 -W -g $(ECFLAGS)
> +# CFLAGS	= -Wall -g -W -UDO_INLINE -DDEBUG $(ECFLAGS)
> +
> +ALL_CFLAGS = $(CFLAGS) -I.. -D_GNU_SOURCE -D_LARGEFILE_SOURCE \
> +		-D_FILE_OFFSET_BITSd
>  PROGS	= btt
>  #ELIBS	= -lefence
>  #PLIBS	= -lpthread
> diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
> index 8ae046b..045c081 100644
> --- a/btt/bt_timeline.c
> +++ b/btt/bt_timeline.c
> @@ -39,6 +39,8 @@ time_t genesis, last_vtrace;
>  LIST_HEAD(all_devs);
>  LIST_HEAD(all_procs);
>  LIST_HEAD(free_ios);
> +LIST_HEAD(rmhd);
> +LIST_HEAD(retries);
>  __u64 q_histo[N_HIST_BKTS], d_histo[N_HIST_BKTS];
>  
>  double range_delta = 0.1;
> @@ -53,7 +55,12 @@ struct region_info all_regions = {
>  };
>  
>  #if defined(DEBUG)
> -int rb_tree_size;
> +	int rb_tree_size;
> +#endif
> +
> +#if defined(COUNT_IOS)
> +unsigned long nios_reused, nios_alloced, nios_freed;
> +LIST_HEAD(cios);
>  #endif
>  
>  int process(void);
> @@ -111,11 +118,33 @@ int process(void)
>  			n_traces, tps/1000.0,
>  			dt_input, tv2dbl(&tve) - tv2dbl(&tvi),
>  			tv2dbl(&tve) - tv2dbl(&tvs));
> -#if defined(DEBUG)
> -		printf("\ttree = |%d|\n", rb_tree_size);
> -		if (rb_tree_size > 0)
> -			dump_rb_trees();
> -#endif
> +
> +#		if defined(DEBUG)
> +			printf("\ttree = |%d|\n", rb_tree_size);
> +			if (rb_tree_size > 0)
> +				dump_rb_trees();
> +#		endif
> +
> +#		if defined(COUNT_IOS)
> +			{
> +				struct io *_iop;
> +				struct list_head *_p;
> +				FILE *_ofp = fopen("cios.txt", "w");
> +				printf("(%ld + %ld) = %ld - %ld = %ld\n", 
> +					nios_alloced, nios_reused, 
> +					nios_alloced + nios_reused, 
> +					nios_freed, 
> +					(nios_alloced + nios_reused) 
> +								- nios_freed);
> +
> +				__list_for_each(_p, &cios) {
> +					_iop = list_entry(_p, struct io, 
> +								cio_head);
> +					__dump_iop(_ofp, _iop, 0);
> +				}
> +				fclose(_ofp);
> +			}
> +#		endif
>  	}
>  
>  	return ret;
> diff --git a/btt/devs.c b/btt/devs.c
> index 545d5c5..21e658d 100644
> --- a/btt/devs.c
> +++ b/btt/devs.c
> @@ -125,12 +125,13 @@ struct d_info *dip_add(__u32 device, struct io *iop)
>  	}
>  
>  	iop->linked = dip_rb_ins(dip, iop);
> -#if defined(DEBUG)
> -	if (iop->linked) 
> -		rb_tree_size++;
> -#endif
> -
>  	dip->end_time = BIT_TIME(iop->t.time);
> +
> +#	if defined(DEBUG)
> +		if (iop->linked) 
> +			rb_tree_size++;
> +#	endif
> +
>  	return dip;
>  }
>  
> diff --git a/btt/globals.h b/btt/globals.h
> index e8b8e7e..69c9e9d 100644
> --- a/btt/globals.h
> +++ b/btt/globals.h
> @@ -173,15 +173,18 @@ struct d_info {
>  
>  struct io {
>  	struct rb_node rb_node;
> -	struct list_head f_head, c_pending, retry;
> +	struct list_head f_head, c_pending, retry, rm_head;
>  	struct list_head down_list, up_list;
>  	struct d_info *dip;
>  	struct p_info *pip;
>  	void *pdu;
>  	struct blk_io_trace t;
>  	__u64 bytes_left;
> -	int linked, on_retry_list, down_len, up_len;
> +	int linked, on_retry_list, down_len, up_len, on_rm_list;
>  	enum iop_type type;
> +#if defined(COUNT_IOS)
> +	struct list_head cio_head;
> +#endif
>  };
>  
>  struct bilink {
> @@ -199,7 +202,7 @@ extern FILE *ranges_ofp, *avgs_ofp, *iostat_ofp, *per_io_ofp;
>  extern int verbose, done, time_bounded, output_all_data;
>  extern unsigned int n_devs;
>  extern unsigned long n_traces;
> -extern struct list_head all_devs, all_procs, retries;
> +extern struct list_head all_devs, all_procs, retries, rmhd;
>  extern struct avgs_info all_avgs;
>  extern __u64 last_q, next_retry_check;
>  extern struct region_info all_regions;
> @@ -211,6 +214,10 @@ extern __u64 q_histo[N_HIST_BKTS], d_histo[N_HIST_BKTS];
>  #if defined(DEBUG)
>  extern int rb_tree_size;
>  #endif
> +#if defined(COUNT_IOS)
> +extern unsigned long nios_reused, nios_alloced, nios_freed;
> +extern struct list_head cios;
> +#endif
>  
>  /* args.c */
>  void handle_args(int argc, char *argv[]);
> @@ -297,7 +304,7 @@ int seeki_mode(void *handle, struct mode *mp);
>  /* trace.c */
>  void __dump_iop(FILE *ofp, struct io *iop, int extra_nl);
>  void __dump_iop2(FILE *ofp, struct io *a_iop, struct io *l_iop);
> -void release_iops(struct list_head *rmhd);
> +void release_iops(void);
>  void add_trace(struct io *iop);
>  void do_retries(__u64 now);
>  
> @@ -306,15 +313,15 @@ void trace_complete(struct io *c_iop);
>  void retry_complete(struct io *c_iop, __u64 now);
>  
>  /* trace_im.c */
> -void run_im(struct io *im_iop, struct io *c_iop, void *param);
> -void run_unim(struct io *im_iop, struct list_head *rmhd);
> +void run_im(struct io *im_iop, struct io *d_iop, struct io *c_iop);
> +void run_unim(struct io *im_iop, struct io *d_iop, struct io *c_iop);
>  int ready_im(struct io *im_iop, struct io *c_iop);
>  void trace_insert(struct io *i_iop);
>  void trace_merge(struct io *m_iop);
>  
>  /* trace_issue.c */
> -void run_issue(struct io *d_iop, struct io *c_iop, void *param);
> -void run_unissue(struct io *d_iop, struct list_head *rmhd);
> +void run_issue(struct io *d_iop, struct io *u_iop, struct io *c_iop);
> +void run_unissue(struct io *d_iop, struct io *u_iop, struct io *c_iop);
>  int ready_issue(struct io *d_iop, struct io *c_iop);
>  void trace_issue(struct io *d_iop);
>  
> @@ -324,12 +331,12 @@ void trace_unplug_io(struct io *u_iop);
>  void trace_unplug_timer(struct io *u_iop);
>  
>  /* trace_queue.c */
> -void run_queue(struct io *q_iop, struct io *c_iop, struct list_head *rmhd);
> +void run_queue(struct io *q_iop, struct io *u_iop, struct io *c_iop);
>  int ready_queue(struct io *q_iop, struct io *c_iop);
>  void trace_queue(struct io *q_iop);
>  
>  /* trace_remap.c */
> -void run_remap(struct io *a_iop, struct io *c_iop, void *param);
> +void run_remap(struct io *a_iop, struct io *u_iop, struct io *c_iop);
>  int ready_remap(struct io *a_iop, struct io *c_iop);
>  void trace_remap(struct io *a_iop);
>  
> diff --git a/btt/inlines.h b/btt/inlines.h
> index 3dff512..38ac5ef 100644
> --- a/btt/inlines.h
> +++ b/btt/inlines.h
> @@ -117,28 +117,47 @@ static inline struct io *io_alloc(void)
>  	if (!list_empty(&free_ios)) {
>  		iop = list_entry(free_ios.next, struct io, f_head);
>  		LIST_DEL(&iop->f_head);
> +
> +#		if defined(COUNT_IOS)
> +			nios_reused++;
> +#		endif
>  	}
> -	else
> +	else {
>  		iop = malloc(sizeof(struct io));
>  
> +#		if defined(COUNT_IOS)
> +			nios_alloced++;
> +#		endif
> +	}
> +
>  	memset(iop, 0, sizeof(struct io));
>  	INIT_LIST_HEAD(&iop->down_list);
>  	INIT_LIST_HEAD(&iop->up_list);
>  
> -#if defined(DEBUG)
> -	iop->f_head.next = LIST_POISON1;
> -	iop->c_pending.next = LIST_POISON1;
> -	iop->retry.next = LIST_POISON1;
> -#endif
> +#	if defined(DEBUG)
> +		iop->f_head.next = LIST_POISON1;
> +		iop->c_pending.next = LIST_POISON1;
> +		iop->retry.next = LIST_POISON1;
> +#	endif
> +
> +#	if defined(COUNT_IOS)
> +		list_add_tail(&iop->cio_head, &cios);
> +#	endif
>  
>  	return iop;
>  }
>  
>  static inline void io_free(struct io *iop)
>  {
> +#	if defined(COUNT_IOS)
> +		nios_freed++;
> +		LIST_DEL(&iop->cio_head);
> +#	endif
> +
>  #	if defined(DEBUG)
>  		memset(iop, 0, sizeof(*iop));
>  #	endif
> +
>  	list_add_tail(&iop->f_head, &free_ios);
>  }
>  
> @@ -190,25 +209,29 @@ static inline void io_release(struct io *iop)
>  
>  static inline void update_q2c(struct io *iop, __u64 c_time)
>  {
> -#if defined(DEBUG)
> -	if (per_io_ofp) fprintf(per_io_ofp, "q2c %13.9f\n", BIT_TIME(c_time));
> -#endif
> +#	if defined(DEBUG)
> +		if (per_io_ofp) 
> +			fprintf(per_io_ofp, "q2c %13.9f\n", BIT_TIME(c_time));
> +#	endif
>  	UPDATE_AVGS(q2c, iop, iop->pip, c_time);
>  }
>  
>  static inline void update_q2a(struct io *iop, __u64 a_time)
>  {
> -#if defined(DEBUG)
> -	if (per_io_ofp) fprintf(per_io_ofp, "q2a %13.9f\n", BIT_TIME(a_time));
> -#endif
> +#	if defined(DEBUG)
> +		if (per_io_ofp) 
> +			fprintf(per_io_ofp, "q2a %13.9f\n", BIT_TIME(a_time));
> +#	endif
>  	UPDATE_AVGS(q2a, iop, iop->pip, a_time);
>  }
>  
>  static inline void update_q2i(struct io *iop, __u64 i_time)
>  {
> -#if defined(DEBUG)
> -	if (per_io_ofp) fprintf(per_io_ofp, "q2i %13.9f\n", BIT_TIME(i_time));
> -#endif
> +#	if defined(DEBUG)
> +		if (per_io_ofp) 
> +			fprintf(per_io_ofp, "q2i %13.9f\n", BIT_TIME(i_time));
> +#	endif
> +
>  	UPDATE_AVGS(q2i, iop, iop->pip, i_time);
>  }
>  
> @@ -219,9 +242,11 @@ static inline void unupdate_q2i(struct io *iop, __u64 i_time)
>  
>  static inline void update_i2d(struct io *iop, __u64 d_time)
>  {
> -#if defined(DEBUG)
> -	if (per_io_ofp) fprintf(per_io_ofp, "i2d %13.9f\n", BIT_TIME(d_time));
> -#endif
> +#	if defined(DEBUG)
> +		if (per_io_ofp) 
> +			fprintf(per_io_ofp, "i2d %13.9f\n", BIT_TIME(d_time));
> +#	endif
> +
>  	UPDATE_AVGS(i2d, iop, iop->pip, d_time);
>  }
>  
> @@ -232,9 +257,12 @@ static inline void unupdate_i2d(struct io *iop, __u64 d_time)
>  
>  static inline void update_d2c(struct io *iop, int n, __u64 c_time)
>  {
> -#if defined(DEBUG)
> -	if (per_io_ofp) fprintf(per_io_ofp, "d2c %13.9f\n", n*BIT_TIME(c_time));
> -#endif
> +#	if defined(DEBUG)
> +		if (per_io_ofp) 
> +			fprintf(per_io_ofp, "d2c %13.9f\n", 
> +							n*BIT_TIME(c_time));
> +#	endif
> +
>  	UPDATE_AVGS_N(d2c, iop, iop->pip, c_time, n);
>  }
>  
> @@ -268,9 +296,10 @@ static inline int dip_rb_ins(struct d_info *dip, struct io *iop)
>  static inline void dip_rb_rem(struct io *iop)
>  {
>  	rb_erase(&iop->rb_node, __get_root(iop->dip, iop->type));
> -#if defined(DEBUG)
> -	rb_tree_size--;
> -#endif
> +
> +#	if defined(DEBUG)
> +		rb_tree_size--;
> +#	endif
>  }
>  
>  static inline void dip_rb_fe(struct d_info *dip, enum iop_type type, 
> @@ -420,16 +449,17 @@ static inline struct io *bilink_first_up(struct io *iop, struct bilink **blp_p)
>  	return blp->uiop;
>  }
>  
> -typedef void (*bilink_func)(struct io *diop, struct io *uiop, void *param);
> -static inline void bilink_for_each_down(bilink_func func, struct io *uiop, 
> -							void *param, int ul)
> +typedef void (*bilink_func)(struct io *diop, struct io *uiop, 
> +							struct io *c_iop);
> +static inline void bilink_for_each_down(bilink_func func, struct io *uiop,
> +				        struct io *c_iop, int ul)
>  {
>  	struct bilink *blp;
>  	struct list_head *p, *q;
>  
>  	list_for_each_safe(p, q, &uiop->down_list) {
>  		blp = list_entry(p, struct bilink, up_head);
> -		func(blp->diop, uiop, param);
> +		func(blp->diop, uiop, c_iop);
>  		if (ul)
>  			biunlink(blp);
>  	}
> @@ -450,3 +480,11 @@ static inline void update_d_histo(__u64 nbytes)
>  {
>  	d_histo[histo_idx(nbytes)]++;
>  }
> +
> +static inline void add_rmhd(struct io *iop)
> +{
> +	if (!iop->on_rm_list) {
> +		list_add_tail(&iop->rm_head, &rmhd);
> +		iop->on_rm_list = 1;
> +	}
> +}
> diff --git a/btt/trace.c b/btt/trace.c
> index e192594..7f8e689 100644
> --- a/btt/trace.c
> +++ b/btt/trace.c
> @@ -21,7 +21,6 @@
>  #include "globals.h"
>  
>  int dump_level;
> -LIST_HEAD(retries);
>  
>  void __dump_iop(FILE *ofp, struct io *iop, int extra_nl)
>  {
> @@ -44,14 +43,14 @@ void __dump_iop2(FILE *ofp, struct io *a_iop, struct io *l_iop)
>  		MINOR(l_iop->t.device), (unsigned long long)l_iop->t.sector);
>  }
>  
> -void release_iops(struct list_head *rmhd)
> +void release_iops(void)
>  {
>  	struct io *x_iop;
>  	struct list_head *p, *q;
>  
> -	list_for_each_safe(p, q, rmhd) {
> -		x_iop = list_entry(p, struct io, f_head);
> -		LIST_DEL(&x_iop->f_head);
> +	list_for_each_safe(p, q, &rmhd) {
> +		x_iop = list_entry(p, struct io, rm_head);
> +		LIST_DEL(&x_iop->rm_head);
>  		io_release(x_iop);
>  	}
>  }
> @@ -85,12 +84,14 @@ static void __add_trace(struct io *iop)
>  	iostat_check_time(iop->t.time);
>  
>  	if (verbose && ((now - last_vtrace) > 0)) {
> -#if defined(DEBUG)
> +
> +#	if defined(DEBUG)
>  		printf("%10lu t\tretries=|%10d|\ttree size=|%10d|\r", 
>  			n_traces, list_len(&retries), rb_tree_size);
> -#else
> +#	else
>  		printf("%10lu t\r", n_traces);
> -#endif
> +#	endif
> +
>  		if ((n_traces % 1000000) = 0) printf("\n");
>  		fflush(stdout);
>  		last_vtrace = now;
> diff --git a/btt/trace_complete.c b/btt/trace_complete.c
> index ac85c32..b48bf79 100644
> --- a/btt/trace_complete.c
> +++ b/btt/trace_complete.c
> @@ -24,29 +24,27 @@ LIST_HEAD(pending_cs);
>  
>  static inline void __run_complete(struct io *c_iop)
>  {
> -	LIST_HEAD(rmhd);
> -
>  	if (remapper_dev(c_iop->t.device)) {
>  		struct bilink *blp = blp;
>  		struct io *iop = bilink_first_down(c_iop, &blp);
>  
>  		if (iop->type = IOP_Q) {
> -			run_queue(iop, c_iop, &rmhd);
> +			run_queue(iop, c_iop, c_iop);
>  			biunlink(blp);
>  		}
>  		else
> -			bilink_for_each_down(run_remap, c_iop, &rmhd, 1);
> +			bilink_for_each_down(run_remap, c_iop, c_iop, 1);
>  	}
>  	else
> -		bilink_for_each_down(run_issue, c_iop, &rmhd, 1);
> +		bilink_for_each_down(run_issue, c_iop, c_iop, 1);
>  
>  	dump_iop(c_iop, 1);
>  
>  	LIST_DEL(&c_iop->c_pending);
>  	del_retry(c_iop);
> +	add_rmhd(c_iop);
>  
> -	list_add_tail(&c_iop->f_head, &rmhd);
> -	release_iops(&rmhd);
> +	release_iops();
>  }
>  
>  static int ready_complete_remapper(struct io *c_iop)
> @@ -170,9 +168,10 @@ void retry_complete(struct io *c_iop, __u64 now)
>  
>  	switch (ready_complete(c_iop)) {
>  	case  1: 
> -#if defined(DEBUG)
> -		fprintf(stderr, "Retried %15.9lf success!\n", tc);
> -#endif
> +#		if defined(DEBUG)
> +			fprintf(stderr, "Retried %15.9lf success!\n", tc);
> +#		endif
> +
>  		__run_complete(c_iop); 
>  		break;
>  	case  0:
> diff --git a/btt/trace_im.c b/btt/trace_im.c
> index 0744b5f..c16f1a8 100644
> --- a/btt/trace_im.c
> +++ b/btt/trace_im.c
> @@ -20,51 +20,40 @@
>   */
>  #include "globals.h"
>  
> -struct params {
> -	struct io *c_iop;
> -	struct list_head *rmhd;
> -};
> -
> -void __run_im(struct io *q_iop, struct io *im_iop, void *param)
> +static void __run_im(struct io *q_iop, struct io *im_iop, struct io *c_iop)
>  {
> -	struct params *p = param;
> -	run_queue(q_iop, p->c_iop, p->rmhd);
> +	run_queue(q_iop, im_iop, c_iop);
>  	dump_iop(im_iop, 0);
> -	list_add_tail(&im_iop->f_head, p->rmhd);
>  }
>  
> -void __run_unim(struct io *q_iop, struct io *im_iop, void *param)
> +static void __run_unim(struct io *q_iop, struct io *im_iop, 
> +		       __attribute__((__unused__))struct io *c_iop)
>  {
> -	struct params *p = param;
>  	if (q_iop->bytes_left = 0) {
>  		q_iop->linked = dip_rb_ins(q_iop->dip, q_iop);
>  		ASSERT(q_iop->linked);
> -#if defined(DEBUG)
> -		rb_tree_size++;
> -#endif
> +
> +#		if defined(DEBUG)
> +			rb_tree_size++;
> +#		endif
>  	}
>  
>  	q_iop->bytes_left += im_iop->t.bytes;
>  	unupdate_q2i(q_iop, tdelta(q_iop, im_iop));
> -	list_add_tail(&im_iop->f_head, p->rmhd);
>  }
>  
> -void run_im(struct io *im_iop, struct io *c_iop, void *param)
> +void run_im(struct io *im_iop, __attribute__((__unused__))struct io *d_iop, 
> +	    struct io *c_iop)
>  {
> -	struct params p = {
> -		.c_iop = c_iop,
> -		.rmhd = (struct list_head *)param
> -	};
> -	bilink_for_each_down(__run_im, im_iop, &p, 1);
> +	bilink_for_each_down(__run_im, im_iop, c_iop, 1);
> +	add_rmhd(im_iop);
>  }
>  
> -void run_unim(struct io *im_iop, struct list_head *rmhd)
> +void run_unim(struct io *im_iop, __attribute__((__unused__))struct io *d_iop, 
> +	      struct io *c_iop)
>  {
> -	struct params p = {
> -		.c_iop = NULL,
> -		.rmhd = rmhd
> -	};
> -	bilink_for_each_down(__run_unim, im_iop, &p, 1);
> +	bilink_for_each_down(__run_unim, im_iop, c_iop, 1);
> +	add_rmhd(im_iop);
>  }
>  
>  int ready_im(struct io *im_iop, struct io *c_iop)
> diff --git a/btt/trace_issue.c b/btt/trace_issue.c
> index 52aa8b1..d2b0832 100644
> --- a/btt/trace_issue.c
> +++ b/btt/trace_issue.c
> @@ -20,46 +20,33 @@
>   */
>  #include "globals.h"
>  
> -struct params {
> -	struct io *c_iop;
> -	struct list_head *rmhd;
> -};
> -
> -void __run_issue(struct io *im_iop, struct io *d_iop, void *param)
> +static void __run_issue(struct io *im_iop, struct io *d_iop, struct io *c_iop)
>  {
> -	struct params *p = param;
> -
>  	update_i2d(im_iop, tdelta(im_iop, d_iop));
> -	run_im(im_iop, p->c_iop, p->rmhd);
> +	run_im(im_iop, d_iop, c_iop);
>  	dump_iop(d_iop, 0);
> -	list_add_tail(&d_iop->f_head, p->rmhd);
>  }
>  
> -void __run_unissue(struct io *im_iop, struct io *d_iop, void *param)
> +static void __run_unissue(struct io *im_iop, struct io *d_iop, 
> +			  struct io *c_iop)
>  {
> -	struct params *p = param;
> -
>  	unupdate_i2d(im_iop, tdelta(im_iop, d_iop));
> -	run_unim(im_iop, p->rmhd);
> -	list_add_tail(&d_iop->f_head, p->rmhd);
> +	run_unim(im_iop, d_iop, c_iop);
>  }
>  
> -void run_issue(struct io *d_iop, struct io *c_iop, void *param)
> +void run_issue(struct io *d_iop, __attribute__((__unused__))struct io *u_iop, 
> +							struct io *c_iop)
>  {
> -	struct params p = {
> -		.c_iop = c_iop,
> -		.rmhd = (struct list_head *)param
> -	};
> -	bilink_for_each_down(__run_issue, d_iop, &p, 1);
> +	bilink_for_each_down(__run_issue, d_iop, c_iop, 1);
> +	add_rmhd(d_iop);
>  }
>  
> -void run_unissue(struct io *d_iop, struct list_head *rmhd)
> +void run_unissue(struct io *d_iop, 
> +		 __attribute__((__unused__))struct io *u_iop, 
> +		 struct io *c_iop)
>  {
> -	struct params p = {
> -		.c_iop = NULL,
> -		.rmhd = rmhd
> -	};
> -	bilink_for_each_down(__run_unissue, d_iop, &p, 1);
> +	bilink_for_each_down(__run_unissue, d_iop, c_iop, 1);
> +	add_rmhd(d_iop);
>  }
>  
>  int ready_issue(struct io *d_iop, struct io *c_iop)
> diff --git a/btt/trace_queue.c b/btt/trace_queue.c
> index ea285e3..ad5e30c 100644
> --- a/btt/trace_queue.c
> +++ b/btt/trace_queue.c
> @@ -28,20 +28,20 @@ static inline void __update_q2c(struct io *q_iop, struct io *c_iop)
>  	latency_q2c(q_iop->dip, q_iop->t.time, q2c);
>  }
>  
> -void run_queue(struct io *q_iop, struct io *c_iop, struct list_head *rmhd)
> +void run_queue(struct io *q_iop, __attribute__((__unused__))struct io *u_iop,
> +	       struct io *c_iop)
>  {
>  	struct bilink *blp;
>  	struct io *a_iop = bilink_first_down(q_iop, &blp);
>  
>  	if (a_iop) {
> -		run_remap(a_iop, c_iop, rmhd);
> +		run_remap(a_iop, q_iop, c_iop);
>  		biunlink(blp);
>  	}
>  
>  	__update_q2c(q_iop, c_iop);
>  	dump_iop(q_iop, 0);
> -
> -	list_add_tail(&q_iop->f_head, rmhd);
> +	add_rmhd(q_iop);
>  }
>  
>  int ready_queue(struct io *q_iop, struct io *c_iop)
> diff --git a/btt/trace_remap.c b/btt/trace_remap.c
> index 54a26e3..c5203e8 100644
> --- a/btt/trace_remap.c
> +++ b/btt/trace_remap.c
> @@ -20,24 +20,24 @@
>   */
>  #include "globals.h"
>  
> -void run_remap(struct io *a_iop, struct io *c_iop, void *param)
> +void run_remap(struct io *a_iop, __attribute__((__unused__)) struct io *u_iop,
> +				 struct io *c_iop)
>  {
>  	struct bilink *blp = blp, *blp2;
> -	struct list_head *rmhd = param;
>  	struct io *q_iop, *l_iop = bilink_first_down(a_iop, &blp);
>  
>  	ASSERT(l_iop);
>  	q_iop = bilink_first_down(l_iop, &blp2);
>  	if (q_iop) {
> -		run_queue(q_iop, c_iop, rmhd);
> +		run_queue(q_iop, a_iop, c_iop);
>  		biunlink(blp2);
>  	}
>  
>  	dump_iop2(a_iop, l_iop);
> -
>  	biunlink(blp);
> -	list_add_tail(&l_iop->f_head, rmhd);
> -	list_add_tail(&a_iop->f_head, rmhd);
> +
> +	add_rmhd(l_iop);
> +	add_rmhd(a_iop);
>  }
>  
>  int ready_dev_remap(struct io *l_iop, struct io *c_iop)
> diff --git a/btt/trace_requeue.c b/btt/trace_requeue.c
> index ac1948d..4baf66e 100644
> --- a/btt/trace_requeue.c
> +++ b/btt/trace_requeue.c
> @@ -22,7 +22,6 @@
>  
>  void trace_requeue(struct io *r_iop)
>  {
> -	LIST_HEAD(rmhd);
>  	struct io *d_iop;
>  
>  	if ((io_setup(r_iop, IOP_R) = 0) ||
> @@ -33,13 +32,14 @@ void trace_requeue(struct io *r_iop)
>  	}
>  	dip_rem(d_iop);
>  
> -#if defined(DEBUG)
> -	ASSERT(ready_issue(d_iop, r_iop) != 0);
> -#else
> -	(void)ready_issue(d_iop, r_iop);
> -#endif
> +#	if defined(DEBUG)
> +		ASSERT(ready_issue(d_iop, r_iop) != 0);
> +#	else
> +		(void)ready_issue(d_iop, r_iop);
> +#	endif
>  
> -	run_unissue(d_iop, &rmhd);
> -	list_add_tail(&r_iop->f_head, &rmhd);
> -	release_iops(&rmhd);
> +	run_unissue(d_iop, r_iop, r_iop);
> +	add_rmhd(r_iop);
> +
> +	release_iops();
>  }

