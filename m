From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 26 Sep 2008 09:06:57 +0000
Subject: Re: [patch] man page typo
Message-Id: <20080926090655.GU2677@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Fri, Aug 01 2008, Nathan Scott wrote:
> This fixes up a formatting problem when displaying the blktrace
> man pages - just a typo (bold mode not correctly terminated, so
> it flows on until the next bold-mode-termination a few lines on).
> 
> --
> Nathan

> diff --git a/doc/blktrace.8 b/doc/blktrace.8
> index e87feae..4b34dff 100644
> --- a/doc/blktrace.8
> +++ b/doc/blktrace.8
> @@ -201,7 +201,7 @@ sends the command data block as a payload so that blkparse can decode it.
>  
>  
>  .SH EXAMPLES
> -To trace the i/o on the device \fI/dev/hda\fB and parse the output to human
> +To trace the i/o on the device \fI/dev/hda\fR and parse the output to human
>  readable form, use the following command:
>  
>      % blktrace \-d /dev/sda \-o \- | blkparse \-i \-


On Tue, Aug 05 2008, Nathan Scott wrote:
> I found I needed this tweak to make the spec file usable on a RHEL5
> system (I hit rpmbuild errors about unpackaged files without this).
> Not sure if its correct though, maybe someone with stronger rpm-fu
> than I have could take a closer look?
> 
> cheers.
> 
> --
> Nathan

> diff --git a/btrace.spec b/btrace.spec
> index ad70957..90f88d8 100644
> --- a/btrace.spec
> +++ b/btrace.spec
> @@ -48,6 +48,7 @@ rm -rf $RPM_BUILD_ROOT
>  %defattr(-,root,root)
>  %doc README doc/blktrace.pdf
>  /usr/bin/*
> +/usr/man/*
>  
>  %changelog -n btrace
>  * Mon Oct 10 2005 - axboe@suse.de

Better late than never, I got these two applied. My rpm fu is pretty
darn weak as well, so...

-- 
Jens Axboe

