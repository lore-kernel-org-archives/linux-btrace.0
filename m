From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 16 Sep 2019 16:31:03 +0000
Subject: Re: [PATCH] btreplay: fix device IO remap functionality
Message-Id: <8f89cc40-5b47-e6e0-9b90-a523299ae52d@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <CALrw=nGNOAibEAU5q9S=caPmgdoJzHDkLeR+Dk+M772m4yasiw@mail.gmail.com>
In-Reply-To: <CALrw=nGNOAibEAU5q9S=caPmgdoJzHDkLeR+Dk+M772m4yasiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 9/16/19 9:39 AM, Ignat Korchagin wrote:
> Commit dd093eb1c48e ("Fix warnings on newer gcc") moved string buffers holding
> device names during map file parse stage to stack. However, only pointers to
> them are being stored in the allocated "struct map_dev" structure. These
> pointers are invalid outside of scope of this function and in a different
> thread context. Also "release_map_devs" function still tries to "free" them
> later as if they were allocated on the heap.
> 
> Moving the buffers back to the heap by instructing "fscanf" to allocate them
> while parsing the file.
> 
> Alternatively, we could redefine the "struct map_dev" to include the whole
> buffers instead of just pointers to them and free them as part of releasing the
> whole "struct map_dev".

Applied - but by hand, your patch is corrupted, it has mangled whitespace.

-- 
Jens Axboe
