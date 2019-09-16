From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 16 Sep 2019 17:12:39 +0000
Subject: Re: [PATCH] btreplay: fix device IO remap functionality
Message-Id: <CALrw=nHs=NmO53_qCmgzL2To9tVYZpRyuTu2CQnZW2xNDkuOvw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CALrw=nGNOAibEAU5q9S=caPmgdoJzHDkLeR+Dk+M772m4yasiw@mail.gmail.com>
In-Reply-To: <CALrw=nGNOAibEAU5q9S=caPmgdoJzHDkLeR+Dk+M772m4yasiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Thank you and sorry. I thought Gmail corrupts only tabs, but seems
whitespaces as well. Next time will use git to send it.

On Mon, Sep 16, 2019 at 5:31 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/16/19 9:39 AM, Ignat Korchagin wrote:
> > Commit dd093eb1c48e ("Fix warnings on newer gcc") moved string buffers holding
> > device names during map file parse stage to stack. However, only pointers to
> > them are being stored in the allocated "struct map_dev" structure. These
> > pointers are invalid outside of scope of this function and in a different
> > thread context. Also "release_map_devs" function still tries to "free" them
> > later as if they were allocated on the heap.
> >
> > Moving the buffers back to the heap by instructing "fscanf" to allocate them
> > while parsing the file.
> >
> > Alternatively, we could redefine the "struct map_dev" to include the whole
> > buffers instead of just pointers to them and free them as part of releasing the
> > whole "struct map_dev".
>
> Applied - but by hand, your patch is corrupted, it has mangled whitespace.
>
> --
> Jens Axboe
>
