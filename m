From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 12 Jun 2007 10:39:36 +0000
Subject: Re: blktrace crashing with 2.6.22-rc3
Message-Id: <20070612103936.GX18832@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <466E7226.7060609@lichota.net>
In-Reply-To: <466E7226.7060609@lichota.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Jun 12 2007, Krzysztof Lichota wrote:
> Hello!
> I am trying to use blktrace on latest Ubuntu kernel for Gutsy
> (2.6.22-rc3, git tree is at
> git://kernel.ubuntu.com/ubuntu/ubuntu-gutsy.git and web frontend at
> http://kernel.ubuntu.com/git).
> 
> I have compiled it with blktrace enabled and when I try to run
> blktrace -k to stop tracing, it doesn't do anything, but in dmesg I can
> see the messages:
> [  239.499614] DebugFS rmdir on hda failed : directory not empty.
> [  239.499637] DebugFS rmdir on block failed : directory not empty.
> 
> If I try to kill it afterwards using ^C, it shows message "BLKTRACESTOP:
> invalid argument", crashes with segmentation fault (core file is empty)
> and I cannot start it again.
> 
> This happens if I run blktrace using: blktrace -d /dev/hda -o somefile
> (on the same partition which is traced).
> 
> If I use network mode, it works fine.
> 
> blktrace tools are pulled today using git:
> $ cat .git/remotes/origin
> URL: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git
> Pull: refs/heads/master:refs/heads/origin
> 
> Should I investigate it further or is it a known issue?

I think it's a known issue. Don't run blktrace -k unless the trace is
really stuck - does it work correctly if you just ctrl-c out of
blktrace?

-- 
Jens Axboe

