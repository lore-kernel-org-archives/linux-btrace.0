From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 22 Feb 2010 18:58:00 +0000
Subject: Re: [PATCH] add libpthread to btreplay/Makefile LIBS
Message-Id: <20100222185800.GC1025@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <4B76F03B.7040206@redhat.com>
In-Reply-To: <4B76F03B.7040206@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sat, Feb 13 2010, Eric Sandeen wrote:
> Fedora linking changes picked this up:
> 
> /usr/bin/ld: btreplay.o: undefined reference to symbol 'pthread_create@@GLIBC_2.2.5'
> /usr/bin/ld: note: 'pthread_create@@GLIBC_2.2.5' is defined in DSO /lib64/libpthread.so.0 so try adding it to the linker command line
> 
> See also https://bugzilla.redhat.com/show_bug.cgi?idV4775

Thanks Eric, applied!

-- 
Jens Axboe

