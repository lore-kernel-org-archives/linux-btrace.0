From: Vinay Sridhar <vinay@linux.vnet.ibm.com>
Date: Tue, 03 Feb 2009 06:58:30 +0000
Subject: Re: blktrace hangs after "--kill" option
Message-Id: <1233643590.11051.2.camel@vinaysridhar.in.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1230875278.8200.2.camel@vinaysridhar.in.ibm.com>
In-Reply-To: <1230875278.8200.2.camel@vinaysridhar.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Jens,

Any plans of including this in any of the 2.6.29 rc's?

Thanks,
Vinay

On Mon, 2009-01-05 at 10:15 +0100, Jens Axboe wrote:
> On Fri, Jan 02 2009, Vinay Sridhar wrote:
> > Hello,
> > 
> > On executing "blktrace -k" on a running trace, the trace hangs. After
> > killing the trace, rerunning it results in "BLKTRACESTOP: invalid
> > argument" messages.
> > 
> > This was discussed earlier here:
> > http://www.mail-archive.com/linux-btrace@vger.kernel.org/msg00229.html
> > 
> > But I dont see this fix to have been included as I'm still seeing this
> > error with the the latest kernel. Could someone please indicate why this
> > fix didnt go in? I was able to port the above suggested fix to 2.6.28.
> 
> I think I wanted to test it a bit more. I'll toss it in for 2.6.29 and
> give it some testing! Thanks for the reminder...
> 
> 
> > 
> > 
> > diff -Nuarp a/block/blktrace.c b/block/blktrace.c
> > --- a/block/blktrace.c	2008-12-24 17:26:37.000000000 -0600
> > +++ b/block/blktrace.c	2009-01-02 11:13:11.000000000 -0600
> > @@ -181,59 +181,12 @@ EXPORT_SYMBOL_GPL(__blk_add_trace);
> >  
> >  static struct dentry *blk_tree_root;
> >  static DEFINE_MUTEX(blk_tree_mutex);
> > -static unsigned int root_users;
> > -
> > -static inline void blk_remove_root(void)
> > -{
> > -	if (blk_tree_root) {
> > -		debugfs_remove(blk_tree_root);
> > -		blk_tree_root = NULL;
> > -	}
> > -}
> > -
> > -static void blk_remove_tree(struct dentry *dir)
> > -{
> > -	mutex_lock(&blk_tree_mutex);
> > -	debugfs_remove(dir);
> > -	if (--root_users = 0)
> > -		blk_remove_root();
> > -	mutex_unlock(&blk_tree_mutex);
> > -}
> > -
> > -static struct dentry *blk_create_tree(const char *blk_name)
> > -{
> > -	struct dentry *dir = NULL;
> > -	int created = 0;
> > -
> > -	mutex_lock(&blk_tree_mutex);
> > -
> > -	if (!blk_tree_root) {
> > -		blk_tree_root = debugfs_create_dir("block", NULL);
> > -		if (!blk_tree_root)
> > -			goto err;
> > -		created = 1;
> > -	}
> > -
> > -	dir = debugfs_create_dir(blk_name, blk_tree_root);
> > -	if (dir)
> > -		root_users++;
> > -	else {
> > -		/* Delete root only if we created it */
> > -		if (created)
> > -			blk_remove_root();
> > -	}
> > -
> > -err:
> > -	mutex_unlock(&blk_tree_mutex);
> > -	return dir;
> > -}
> >  
> >  static void blk_trace_cleanup(struct blk_trace *bt)
> >  {
> > -	relay_close(bt->rchan);
> >  	debugfs_remove(bt->msg_file);
> >  	debugfs_remove(bt->dropped_file);
> > -	blk_remove_tree(bt->dir);
> > +	relay_close(bt->rchan);
> >  	free_percpu(bt->sequence);
> >  	free_percpu(bt->msg_data);
> >  	kfree(bt);
> > @@ -336,7 +289,18 @@ static int blk_subbuf_start_callback(str
> >  
> >  static int blk_remove_buf_file_callback(struct dentry *dentry)
> >  {
> > +	struct dentry *parent = dentry->d_parent;
> >  	debugfs_remove(dentry);
> > +
> > +	/*
> > +	* this will fail for all but the last file, but that is ok. what we
> > +	* care about is the top level buts->name directory going away, when
> > +	* the last trace file is gone. Then we don't have to rmdir() that
> > +	* manually on trace stop, so it nicely solves the issue with
> > +	* force killing of running traces.
> > +	*/
> > +
> > +	debugfs_remove(parent);
> >  	return 0;
> >  }
> >  
> > @@ -394,7 +358,15 @@ int do_blk_trace_setup(struct request_qu
> >  		goto err;
> >  
> >  	ret = -ENOENT;
> > -	dir = blk_create_tree(buts->name);
> > +
> > +	if (!blk_tree_root) {
> > +		blk_tree_root = debugfs_create_dir("block", NULL);
> > +		if (!blk_tree_root)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	dir = debugfs_create_dir(buts->name, blk_tree_root);
> > +
> >  	if (!dir)
> >  		goto err;
> >  
> > @@ -437,8 +409,6 @@ int do_blk_trace_setup(struct request_qu
> >  
> >  	return 0;
> >  err:
> > -	if (dir)
> > -		blk_remove_tree(dir);
> >  	if (bt) {
> >  		if (bt->msg_file)
> >  			debugfs_remove(bt->msg_file);
> > 
> > 
> > 
> > Vinay Sridhar,
> > Linux Technology Center,
> > IBM ISTL,
> > Bangalore, India
> > 
> > 
> 

