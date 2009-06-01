From: Vikram Oberoi <voberoi@gmail.com>
Date: Mon, 01 Jun 2009 23:19:32 +0000
Subject: Re: Questions about btt output
Message-Id: <d66e59810906011619y4de73939y82704500243d9ea7@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <d66e59810905311625j59b9fe56n8d256b38469c7772@mail.gmail.com>
In-Reply-To: <d66e59810905311625j59b9fe56n8d256b38469c7772@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Thanks for the help!

Vikram

On Mon, Jun 1, 2009 at 5:17 AM, Alan D. Brunelle
<Alan.Brunelle@pobox.com> wrote:
> Vikram Oberoi wrote:
>>
>> Hey folks,
>>
>> I have three specific questions about btt's output. I've searched the
>> list, Google, and read the user guide, but I'm still not completely
>> sure what the answers are. I'm finally posting my questions here, and
>> I hope I'm not in the wrong place or going against etiquette by doing
>> so! Please let me know if I am. Here are my questions:
>>
>> Under "Device Merge Information", are BLKmin/BLKavg/BLKmax the
>> min/avg/max I/O size in *number of filesystem blocks* (in my case, 4
>> KB each) being *issued to the device*?
>
>
> "Blocks" are all 512 bytes.
>
>
>>
>> Under "Device Seek Information", is the mean seek distance *the
>> average number of 512 byte disk sectors* over which the disk head had
>> to move before beginning its next IO? Finally, are the median and mode
>> also *distances*? If so, I find it hard to believe that my mean seek
>> distance is regularly in the tens or hundreds of thousands of disk
>> sectors when the mode -- always 0 -- constitutes over 95% of my seek
>> distances. Or is there a gap in my understanding here?
>
> The problem with that field - and it's always bugged me - is that it truly
> represents distances from the previous I/O to the next I/O. (It is actually
> the closest distance - meaning: if where the previous I/O ends is closer to
> where the next one begins we use that, else if where the previous I/O begins
> is closer to where the next I/O ends (backwards seek) we use that distance.)
>
> But remember: with disks that are very large - as most every disk is today -
> some seeks can be tremendously large. So a (very) few (very) large seeks can
> dwarf lots (and lots) of small seeks.
>
> The mode field provides a better idea as to what is going on - it will show
> that sequential (or nearly sequential) I/Os predominate for a lot of typical
> I/O patterns (highly sequential). In my typical FS runs I usually see on the
> order of 80-90+ percent of the I/Os being 0 or 8 blocks off (8 being
> equivalent to the 4,096 byte FS block).
>
>>
>> Thanks,
>> Vikram
>
