From: Eric Sandeen <sandeen@redhat.com>
Date: Mon, 11 May 2009 15:58:37 +0000
Subject: Re: new blktrace release tag?
Message-Id: <4A084B2D.4090605@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1242043134.4304.31.camel@kitka.ibm.com>
In-Reply-To: <1242043134.4304.31.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Jens Axboe wrote:
> On Mon, May 11 2009, Martin Peschke wrote:
>> Hi Jens,
>> a lot of fixes have been committed since 1.0.0, a some which are
>> essential for users, like the sched_setaffinity() patch.
>> It would be useful to tag a new release, something like 1.0.1?
> 
> Definitely. I'll tag a 1.0.1 right away.

Thanks!

Next time could you keep the tarball snapshot a bit more consistent with
previous versions, in particular with a top-level dir?  :)

# tar tvjf blktrace-1.0.1.tar.bz2
-rw-rw-r-- root/root       112 2009-05-11 07:00 .gitignore
-rw-rw-r-- root/root     18009 2009-05-11 07:00 COPYING
-rw-rw-r-- root/root      1992 2009-05-11 07:00 Makefile
-rw-rw-r-- root/root      5030 2009-05-11 07:00 README
-rw-rw-r-- root/root      1109 2009-05-11 07:00 act_mask.c
-rw-rw-r-- root/root      1362 2009-05-11 07:00 barrier.h
...


*grin*

Thanks,
-Eric
