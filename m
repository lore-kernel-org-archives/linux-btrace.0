From: Alireza Haghdoost <haghdoost@gmail.com>
Date: Thu, 06 Dec 2012 04:20:10 +0000
Subject: Re: Q2I percentage
Message-Id: <CAB-428kKv44JH+rfLzppGDn6hTMJu7sAPezU_b2sNBx9hn=X7A@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAB-428mK1L3ONmpviRvB_0PTUw5qMubu-=xUC=+naFjtnMV8oA@mail.gmail.com>
In-Reply-To: <CAB-428mK1L3ONmpviRvB_0PTUw5qMubu-=xUC=+naFjtnMV8oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I did double check the source code of btt/output.c. However, still it
does not make sense to have a value like 164% for G2I. In other words
it seems to me that the value of G2I should always be smaller than
Q2C, since G2I is included in Q2C. Note that I have no IO merge in my
block IO workload.

I will appreciate if anyone can help me to understand how the average
value of G2I can be larger than average Q2C ?



 262 void __output_dip_prep_ohead(struct d_info *dip, void *arg)
 263 {
 264         if (dip->avgs.q2c.n > 0 && dip->avgs.q2c.total > 0) {
 265                 char dev_info[15];
 266                 struct ohead_data *odp = arg;
 267                 double q2c_total = (double)(dip->avgs.q2c.total);
 268
 269                 fprintf(odp->ofp,
 270                         "%10s | %8.4lf%% %8.4lf%% %8.4lf%%
%8.4lf%% %8.4lf%%\n",
 271                         make_dev_hdr(dev_info, 15, dip, 1),
 272                         100.0 * (double)(dip->avgs.q2g.total) / q2c_total,
 273                         100.0 * (double)(dip->avgs.g2i.total) / q2c_total,
 274                         100.0 * (double)(dip->avgs.q2m.total) / q2c_total,
 275                         100.0 * (double)(dip->avgs.i2d.total) / q2c_total,
 276                         100.0 * (double)(dip->avgs.d2c.total) / q2c_total);
 277
 278                 __update_odp(odp, dip, q2g);
 279                 __update_odp(odp, dip, g2i);
 280                 __update_odp(odp, dip, q2m);
 281                 __update_odp(odp, dip, i2d);
 282                 __update_odp(odp, dip, d2c);
 283                 __update_odp(odp, dip, q2c);
 284         }
 285 }




On Wed, Dec 5, 2012 at 10:01 PM, Alireza Haghdoost <haghdoost@gmail.com> wrote:
> Hi
>
> I changed device driver queue depth and run an IO workload on the
> device while capturing block trace. In the final results btt report
> value of 164% in Q2I timing segment. I was wondering how this
> percentage value calculated and how it does make sense to see more
> than 100% value ?
>
> Thanks
> Alireza
