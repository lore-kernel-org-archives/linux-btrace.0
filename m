From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 11 Dec 2013 18:27:51 +0000
Subject: Re: Blktrace with read filter shows events with N for PIDs 0
Message-Id: <x49a9g74508.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAEyTGCdPR3tBKv3R5Shrm_O=HL21VLjNGfedO5EC4OoHwcpx9Q@mail.gmail.com>
In-Reply-To: <CAEyTGCdPR3tBKv3R5Shrm_O=HL21VLjNGfedO5EC4OoHwcpx9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Alireza Haghdoost <haghdoost@gmail.com> writes:

> On Wed, Dec 4, 2013 at 10:02 AM, Lakshmi <sendtold@gmail.com> wrote:
>> Hi,
>>
>> I ran a blktrace with -a read mask and when i parsed it to txt
>> file,Along with Reads (R) I also see lots of Ns in the RWBS field.
>
> I think the N events indicates that new data structure has been
> allocated for the request.

No.  It's a trace Notify message, which is used for debugging.

>> What does this mean and how do I filter only the reads or writes in
>> this case?

You can use the filter mask option for blktrace:

FILTER MASKS
       The following masks may be passed with the -a command line option, mul-
       tiple filters may be combined via multiple -a command line options.

              barrier: barrier attribute
              complete: completed by driver
              fs: requests
              issue: issued to driver
              pc: packet command events
              queue: queue operations
              read: read traces
              requeue: requeue operations
              sync: synchronous attribute
              write: write traces
              notify: trace messages     <============              drv_data: additional driver specific trace

Cheers,
Jeff
