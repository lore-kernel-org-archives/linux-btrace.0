From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 07 Apr 2020 18:39:45 +0000
Subject: Re: [PATCH 3/3] blkparse: Fix up the sector and length of split completions
Message-Id: <CAHc6FU5SNrfyV_WCz3Hr1MwwbhN6KL8XzjGYibXtyynTcmJ4yA@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20200406140915.109022-4-agruenba@redhat.com>
In-Reply-To: <20200406140915.109022-4-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, Apr 6, 2020 at 4:09 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> When a split io completes, the sector and length of the completion refer to the
> last split of the original request.  This makes reading the blkparse output
> difficult, so fix up the sector and length to match the original request when
> we can (that is, when --track-ios is enabled).

I've noticed that split requests also cause the queued vs. completed
statistics at the end of a trace to be completely off, so the same
fix-up logic is needed there as well.

Also, the code currently assumes that after request splitting, the
only event that will follow is the completion of the request. I hope
that assumption holds.

Any thoughts?

Thanks,
Andreas
