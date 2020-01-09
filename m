From: Damien Le Moal <Damien.LeMoal@wdc.com>
Date: Thu, 09 Jan 2020 12:59:18 +0000
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace extension support
Message-Id: <BYAPR04MB58163E5A9D64C7367BFCEDC7E7390@BYAPR04MB5816.namprd04.prod.outlook.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB5749EDD9E5928E769413B38086520@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CANr-nt0=C+1v=1MU6eNhX0-X4CEvc7D2UEF02oRMNHraQ1FRow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Holmberg <hans@owltronix.com>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "axboe@kernel.dk" <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, Omar Sandoval <osandov@fb.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Matias Bjorling <Matias.Bjorling@wdc.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>

On 2020/01/09 19:19, Hans Holmberg wrote:
> On Thu, Dec 19, 2019 at 6:50 AM Chaitanya Kulkarni
> <Chaitanya.Kulkarni@wdc.com> wrote:
>>
>> Adding Damien to this thread.
>> On 12/10/2019 10:17 PM, Chaitanya Kulkarni wrote:
>>> Hi,
>>>
>>> * Background:-
>>> -----------------------------------------------------------------------
>>>
>>> Linux Kernel Block layer now supports new Zone Management operations
>>> (REQ_OP_ZONE_[OPEN/CLOSE/FINISH] [1]).
>>>
>>> These operations are added mainly to support NVMe Zoned Namespces
>>> (ZNS) [2]. We are adding support for ZNS in Linux Kernel Block layer,
>>> user-space tools (sys-utils/nvme-cli), NVMe driver, File Systems,
>>> Device-mapper in order to support these devices in the field.
>>>
>>> Over the years Linux kernel block layer tracing infrastructure
>>> has proven to be not only extremely useful but essential for:-
>>>
>>> 1. Debugging the problems in the development of kernel block drivers.
>>> 2. Solving the issues at the customer sites.
>>> 3. Speeding up the development for the file system developers.
>>> 4. Finding the device-related issues on the fly without modifying
>>>      the kernel.
>>> 5. Building white box test-cases around the complex areas in the
>>>      linux-block layer.
>>>
>>> * Problem with block layer tracing infrastructure:-
>>> -----------------------------------------------------------------------
>>>
>>> If blktrace is such a great tool why we need this session for ?
>>>
>>> Existing blktrace infrastructure lacks the number of free bits that are
>>> available to track the new trace category. With the addition of new
>>> REQ_OP_ZONE_XXX we need more bits to expand the blktrace so that we can
>>> track more number of requests.
> 
> In addition to tracing the zone operations, it would be greatly
> beneficial to add tracing(and blktrace support) for the reported zone
> states.

That would require a *lot* of data (e.g. super large capacity SMR
drives) and a lot of addition to the hot path tracking write commands
and all zone commands. Also massive modifications of the error path for
that tracking to be correct, and that would need report zones itself. I
am really not for this.

> I did something similar[5] for pblk and open channel chunk states, and
> that proved invaluable when figuring out whether the disk or pblk was
> broken.
> 
> In pblk the reported chunk state transitions are traced along with the
> expected zone transitions (based on io and management commands
> submitted).

pblk being a logically defined device, it likely has some form of
tracking of zone state, similarly to what dm-zoned does. So it may be
easier in that case. But for physical drives, the amount of code/changes
and the runtime overhead of this tracking would not be acceptable in my
opinion.

I have debugged enough buggy SMR drives to know that blktrace is a great
help as is. Drive level debug features (fw logs etc) combined with
blktrace as-is can easily do the same.

> 
> [5] https://www.lkml.org/lkml/2018/8/29/457
> 
> Thanks!
> Hans
> 
>>>
>>> * Current state of the work:-
>>> -----------------------------------------------------------------------
>>>
>>> RFC implementations [3] has been posted with the addition of new IOCTLs
>>> which is far from the production so that it can provide a basis to get
>>> the discussion started.
>>>
>>> This RFC implementation provides:-
>>> 1. Extended bits to track new trace categories.
>>> 2. Support for tracing per trace priorities.
>>> 3. Support for priority mask.
>>> 4. New IOCTLs so that user-space tools can setup the extensions.
>>> 5. Ability to track the integrity fields.
>>> 6. blktrace and blkparse implementation which supports the above
>>>      mentioned features.
>>>
>>> Bart and Martin has suggested changes which I've incorporated in the RFC
>>> revisions.
>>>
>>> * What we will discuss in the proposed session ?
>>> -----------------------------------------------------------------------
>>>
>>> I'd like to propose a session for Storage track to go over the following
>>> discussion points:-
>>>
>>> 1. What is the right approach to move this work forward?
>>> 2. What are the other information bits we need to add which will help
>>>      kernel community to speed up the development and improve tracing?
>>> 3. What are the other tracepoints we need to add in the block layer
>>>      to improve the tracing?
>>> 4. What are device driver callbacks tracing we can add in the block
>>>      layer?
>>> 5. Since polling is becoming popular what are the new tracepoints
>>>      we need to improve debugging ?
>>>
>>>
>>> * Required Participants:-
>>> -----------------------------------------------------------------------
>>>
>>> I'd like to invite block layer, device drivers and file system
>>> developers to:-
>>>
>>> 1. Share their opinion on the topic.
>>> 2. Share their experience and any other issues with blktrace
>>>      infrastructure.
>>> 3. Uncover additional details that are missing from this proposal.
>>>
>>> Regards,
>>> Chaitanya
>>>
>>> References :-
>>>
>>> [1] https://www.spinics.net/lists/linux-block/msg46043.html
>>> [2] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
>>> namespaces-zns-as-go-to-industry-technology/
>>> [3] https://www.spinics.net/lists/linux-btrace/msg01106.html
>>>       https://www.spinics.net/lists/linux-btrace/msg01002.html
>>>       https://www.spinics.net/lists/linux-btrace/msg01042.html
>>>       https://www.spinics.net/lists/linux-btrace/msg00880.html
>>>
>>
> 


-- 
Damien Le Moal
Western Digital Research
