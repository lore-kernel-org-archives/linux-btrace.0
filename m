From: Eric Sandeen <sandeen@redhat.com>
Date: Tue, 15 Dec 2009 20:49:50 +0000
Subject: Re: [patch 1/5] blktrace: avoid device duplication
Message-Id: <4B27F66E.5000607@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4B27CBC3.8040602@redhat.com>
In-Reply-To: <4B27CBC3.8040602@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Edward Shishkin wrote:
> 
> Fixup for bz 501457.

Just to be clear, these are Red Hat bugzilla numbers, i.e.

https://bugzilla.redhat.com/show_bug.cgi?idP1457

Thanks,
-Eric

> Problem:
> If the device list file contains the same device
> as supplied on the command line, blktrace stops
> immediately and further I/O tracing is impossible.
> 
> Bug: device duplication in the devpaths ends with
> programm termination (BLKTRACESETUP ioctl returns
> error) while resources (open files in debugfs) are
> not released.
> 
> Solution:
> Make sure devices are not duplicated in devpaths
> pool.
> 
> Signed-off-by: Edward Shishkin <edward@redhat.com>
> ---
>  blktrace.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> --- blktrace.orig/blktrace.c
> +++ blktrace/blktrace.c
> @@ -1200,8 +1200,17 @@ static int add_devpath(char *path)
>  {
>  	int fd;
>  	struct devpath *dpp;
> +	struct list_head *p;
>  
>  	/*
> +	 * Verify device is not duplicated
> +	 */
> +	__list_for_each(p, &devpaths) {
> +	       struct devpath *tmp = list_entry(p, struct devpath, head);
> +	       if (!strcmp(tmp->path, path))
> +		        return 0;
> +	}
> +	/*
>  	 * Verify device is valid before going too far
>  	 */
>  	fd = my_open(path, O_RDONLY | O_NONBLOCK);

