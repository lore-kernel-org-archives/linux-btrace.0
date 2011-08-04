From: Edward Shishkin <edward@redhat.com>
Date: Thu, 04 Aug 2011 11:50:34 +0000
Subject: Re: Recent changes
Message-Id: <4E3A878A.50709@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello.

How about those bits:
http://marc.info/?l=linux-btrace&m0978262022784&w=2
http://marc.info/?l=linux-btrace&m0978263222799&w=2

any chances it will be applied?

Thanks in advance,
Edward.


On 08/04/2011 06:00 AM, Jens Axboe wrote:
> The following changes since commit 8e8bb835e375bd8cf0f01debff61f6bf467bb1ed:
>
>    blktrace: Use be32_to_cpu for blk_io_trace->cpu. (2011-05-26 21:11:09 +0200)
>
> are available in the git repository at:
>    git://git.kernel.dk/blktrace.git master
>
> Jeff Moyer (1):
>        blkparse: fix up incorrect pc write completion count
>
> Jens Axboe (1):
>        Merge branch 'master' of ssh://router.home.kernel.dk/data/git/blktrace
>
>   blkparse.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> ---
>
> Diff of recent changes:
>
> diff --git a/blkparse.c b/blkparse.c
> index 817cb31..12c7aae 100644
> --- a/blkparse.c
> +++ b/blkparse.c
> @@ -1675,7 +1675,7 @@ static void dump_io_stats(struct per_dev_info *pdi, struct io_stats *ios,
>   		fprintf(ofp, " PC Reads Req.:   %s\t\t", size_cnv(x, ios->rrqueue_pc, 0));
>   		fprintf(ofp, " PC Writes Req.:   %s\n", size_cnv(x, ios->wrqueue_pc, 0));
>   		fprintf(ofp, " PC Reads Compl.: %s\t\t", size_cnv(x, ios->creads_pc, 0));
> -		fprintf(ofp, " PC Writes Compl.: %s\n", size_cnv(x, ios->cwrites, 0));
> +		fprintf(ofp, " PC Writes Compl.: %s\n", size_cnv(x, ios->cwrites_pc, 0));
>   	}
>   	fprintf(ofp, " IO unplugs:      %'8lu%8c\t", ios->io_unplugs, ' ');
>   	fprintf(ofp, " Timer unplugs:    %'8lu\n", ios->timer_unplugs);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

