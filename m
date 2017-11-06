From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 06 Nov 2017 22:08:41 +0000
Subject: Re: [PATCH] btt: Fix overlapping IO stats.
Message-Id: <CAMHSBOX+0Zgo8JQtS3s4B+tpO-u7JQ6BFOsc9Je9sG6uVu01hw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20170818220022.26471-1-gwendal@chromium.org>
In-Reply-To: <20170818220022.26471-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Any chance this patch can be included in the next release?

Thanks,
Gwendal.

On Fri, Aug 18, 2017 at 3:00 PM, Gwendal Grignou <gwendal@chromium.org> wrote:
> Keep scanning the tree for overlapping IO otherwise Q2G and process
> traces will be incorrect.
>
> Let assume we have 2 IOs:
>
> A                                      A+a
> |---------------------------------------|
>        B                B+b
>        |-----------------|
>
> In the red/black tree we have:
>
>                     o -> [A,A+a]
>                    / \
>                 left right
>                  /    \
>            [...]o      o -> [B, B+b]
>
> In the current code, if we would not be able to find [B+b] in the tree:
> B is greater than A, so we won't go left
> B+b is smaller than A+a, so we are not going right either.
>
> When we have a [X, X+x] IO to look for:
> We need to check for right when either:
>  X+x >= A+a (for merged IO)
> and
>  X > A (for overlapping IO)
>
> TEST=Check with a trace with overlapping IO: Q2C and Q2G are expected.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  btt/dip_rb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/btt/dip_rb.c b/btt/dip_rb.c
> index 2aa7ffc..6efef6c 100644
> --- a/btt/dip_rb.c
> +++ b/btt/dip_rb.c
> @@ -57,7 +57,7 @@ struct io *rb_find_sec(struct rb_root *root, __u64 sec)
>                 __iop = rb_entry(n, struct io, rb_node);
>                 if (sec < BIT_START(__iop))
>                         n = n->rb_left;
> -               else if (sec >= BIT_END(__iop))
> +               else if (sec > BIT_START(__iop))
>                         n = n->rb_right;
>                 else
>                         return __iop;
> @@ -82,7 +82,7 @@ void rb_foreach(struct rb_node *n, struct io *iop,
>                 }
>                 if (iop_s < this_s)
>                         rb_foreach(n->rb_left, iop, fnc, head);
> -               if (this_e < iop_e)
> +               if ((this_e < iop_e) || (this_s < iop_s))
>                         rb_foreach(n->rb_right, iop, fnc, head);
>         }
>  }
> --
> 2.14.1.480.gb18f417b89-goog
>
