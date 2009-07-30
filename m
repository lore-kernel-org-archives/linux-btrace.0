From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 30 Jul 2009 14:08:50 +0000
Subject: Re: weird messages in blktrace pertaining to manor and minor
Message-Id: <1248962930.5242.74.camel@cail>
List-Id: <linux-btrace.vger.kernel.org>
References: <20090730125459.GA5120@chamarthy.in.ibm.com>
In-Reply-To: <20090730125459.GA5120@chamarthy.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Thu, 2009-07-30 at 08:57 -0500, Eric Sandeen wrote:
> Alan D. Brunelle wrote:
> > On Thu, 2009-07-30 at 18:24 +0530, Srinivasa R Chamarthy wrote:
> >> Hello,
> >>
> >> I am running blktrace against scsi disks on linux. I get the
> >> following output which i am not able to infer some of the messages
> >> in it.
> 
> ...
> 
> > What Linux version are you using? Issues in MD/DM mappings were fixed in
> > kernels post-RHEL5/SLES10 for example. 
> > 
> > Alan
> 
> Alan, if you happen to know, would you mind pointing me at the commits?
>  I had a quick look through the blktrace changelogs and nothing popped
> out at me...
> 
> Thanks,
> -Eric

Hi Eric-  

Here are some that I can recall off the top of my head - I think this
catches them all:

commit 79c5d3ce614d8fe706545c7bca2158b63db6bb5e
Author: Li Zefan <lizf@cn.fujitsu.com>
Date:   Mon May 11 15:06:46 2009 +0800

    blktrace: from-sector redundant in trace_block_remap, cleanup
    
    The last argument of block_remap prober is the original sector
    before remap, so it should be 'from', not 'to'.
    
    [ Impact: clean up ]
    
    Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
    Cc: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
    Cc: Jens Axboe <jens.axboe@oracle.com>
    Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
    LKML-Reference: <4A07CE86.5090301@cn.fujitsu.com>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

commit 22a7c31a9659deaddafbbcec6562d44141e84474
Author: Alan D. Brunelle <Alan.Brunelle@hp.com>
Date:   Mon May 4 16:35:08 2009 -0400

    blktrace: from-sector redundant in trace_block_remap
    
    Remove redundant from-sector parameter: it's /always/ the bio's
sector
    passed in.
    
    [ Impact: cleanup ]
    
    Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
    Reviewed-by: Li Zefan <lizf@cn.fujitsu.com>
    Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
    Cc: Jens Axboe <jens.axboe@oracle.com>
    Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
    LKML-Reference: <49FF517C.7000503@hp.com>commit
a42aaa3bbce85ac487ad4fad5db99e8e91b7aac1
Author: Alan D. Brunelle <Alan.Brunelle@hp.com>
Date:   Mon May 4 16:27:26 2009 -0400

    blktrace: correct remap names
    
    This attempts to clarify names utilized during block I/O remap
    operations (partition, volume manager). It correctly matches up the
    /from/ information for both device & sector. This takes in the
concept
    from Kosaki Motohiro and extends it to include better naming for the
    "device_from" field.
    
    [ Impact: cleanup ]
    
    Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
    Reviewed-by: Li Zefan <lizf@cn.fujitsu.com>
    Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
    Cc: Jens Axboe <jens.axboe@oracle.com>
    Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
    LKML-Reference: <49FF4FAE.3000301@hp.com>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

    Signed-off-by: Ingo Molnar <mingo@elte.hu>

commit a42aaa3bbce85ac487ad4fad5db99e8e91b7aac1
Author: Alan D. Brunelle <Alan.Brunelle@hp.com>
Date:   Mon May 4 16:27:26 2009 -0400

    blktrace: correct remap names
    
    This attempts to clarify names utilized during block I/O remap
    operations (partition, volume manager). It correctly matches up the
    /from/ information for both device & sector. This takes in the
concept
    from Kosaki Motohiro and extends it to include better naming for the
    "device_from" field.
    
    [ Impact: cleanup ]
    
    Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
    Reviewed-by: Li Zefan <lizf@cn.fujitsu.com>
    Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
    Cc: Jens Axboe <jens.axboe@oracle.com>
    Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
    LKML-Reference: <49FF4FAE.3000301@hp.com>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>


