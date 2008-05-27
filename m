From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 27 May 2008 13:10:37 +0000
Subject: Re: [PATCH 1/2] Added in handling of MESSAGE notes
Message-Id: <483C084D.8080904@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <483C02CF.4040508@hp.com>
In-Reply-To: <483C02CF.4040508@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Jens Axboe wrote:
> On Tue, May 27 2008, Alan D. Brunelle wrote:
>> Sample output:
>>
>>   8,16   1   691118    17.417000000     0  C   R 2660776 + 8 [0]
>>   8,16   1   691119    17.417000000     0  D   R 2660792 + 8 [swapper]
>>   8,16   1   691120    17.417000000  4688  U   N [dd] 42
>>   8,16   1        0    17.418000000     0  m   N elv switch: noop
>>   8,16   1   691121    17.418000000  4638  C   R 2660784 + 8 [0]
>>   8,16   1   691122    17.418000000  4638  D   R 2660800 + 8 [bash]
>>   8,16   1   691123    17.418000000  4638  C   R 2660792 + 8 [0]
>>
>> Thanks to Carl Henrik Lunde <chlunde@ping.uio.no> for adding in sequence
>> printing & time-stamp correction.
>>
>> Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
> 
> Acked-by: Jens Axboe <jens.axboe@oracle.com>
> 
> Just go ahead and commit it, thanks.
> 

Pushed it out, thanks Jens.
