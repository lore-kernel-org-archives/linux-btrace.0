From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 24 Jun 2019 09:58:47 +0000
Subject: Re: [blktrace-tools RFC PATCH 5/5] blkparse: add support for trace extension
Message-Id: <e695009a-c4f4-ec47-e275-a7779f7ef0c6@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190602165810.14817-6-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190602165810.14817-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 6/23/19 10:45 PM, Chaitanya Kulkarni wrote:
> On 6/18/19 5:33 AM, Steffen Maier wrote:
>> On 6/2/19 6:58 PM, Chaitanya Kulkarni wrote:

>>> @@ -2618,19 +3038,23 @@ static void do_pipe(int fd)
>>>    		read_sequence++;
>>> -	
>>>    #if 0
>>>    		smallest_seq_read = -1U;
>>>    #endif
>>> -
>>>    		if (sort_entries(&youngest))
>>>    			break;
>>> -
>>>    		if (youngest > stopwatch_end)
>>>    			break;
>>> -
>>>    		show_entries_rb(0);
>>>    	}
>> Why such seemingly unrelated whitespace changes?

I think I meant to refer to the removed empty lines above.

> This is needed to realign the "| --" since strlen("-y <...>" and larger than
> existing options.

yep

>>
>>> -#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVM"
>>> +#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVMPx:X:y:Y:E"
>>>    static char usage_str[] =    "\n\n" \
>>> -	"-i <file>           | --input=<file>\n" \
>>> -	"[ -a <action field> | --act-mask=<action field> ]\n" \


>>> -	"[ -V                | --version ]\n\n" \
>>> +	"-i <file>               | --input=<file>\n" \

>>> +	"[ -y <action field ext> | --act-mask-ext=<action field ext>]\n" \
>>> +	"[ -Y <action mask ext>  | --set-mask=<action mask>]\n" \
>>> +	"[ -P                    | --track-priority ]\n" \
>>> +	"[ -x <ioprio field>     | --prio-mask=<ioprio field> ]\n" \
>>> +	"[ -X <ioprio mask>      | --set-mask=<ioprio mask> ]\n" \
>>> +	"[ -v                    | --verbose ]\n" \
>>> +	"[ -V                    | --version ]\n\n" \
>>>    	"\t-a Only trace specified actions. See documentation\n" \
>>>    	"\t-A Give trace mask as a single value. See documentation\n" \
>>>    	"\t-b stdin read batching\n" \



-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
