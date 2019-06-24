From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date: Mon, 24 Jun 2019 16:51:12 +0000
Subject: Re: [blktrace-tools RFC PATCH 5/5] blkparse: add support for trace extension
Message-Id: <BYAPR04MB5749519665750FB7A1BDB89F86E00@BYAPR04MB5749.namprd04.prod.outlook.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190602165810.14817-6-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190602165810.14817-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 6/24/19 2:58 AM, Steffen Maier wrote:
> On 6/23/19 10:45 PM, Chaitanya Kulkarni wrote:
>> On 6/18/19 5:33 AM, Steffen Maier wrote:
>>> On 6/2/19 6:58 PM, Chaitanya Kulkarni wrote:
>>>> @@ -2618,19 +3038,23 @@ static void do_pipe(int fd)
>>>>    		read_sequence++;
>>>> -	
>>>>    #if 0
>>>>    		smallest_seq_read = -1U;
>>>>    #endif
>>>> -
>>>>    		if (sort_entries(&youngest))
>>>>    			break;
>>>> -
>>>>    		if (youngest > stopwatch_end)
>>>>    			break;
>>>> -
>>>>    		show_entries_rb(0);
>>>>    	}
>>> Why such seemingly unrelated whitespace changes?
> I think I meant to refer to the removed empty lines above.

Those lines should not be removed, I'll fix it in a next version.

It will be great if you can provide a feedback on kernel part.

There is much room for improvement/optimization for kernel code but
would like to

get some feedback on the approach.

>
>> This is needed to realign the "| --" since strlen("-y <...>" and larger than
>> existing options.
> yep
>
>>>> -#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVM"
>>>> +#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVMPx:X:y:Y:E"
>>>>    static char usage_str[] =    "\n\n" \
>>>> -	"-i <file>           | --input=<file>\n" \
>>>> -	"[ -a <action field> | --act-mask=<action field> ]\n" \
>
>>>> -	"[ -V                | --version ]\n\n" \
>>>> +	"-i <file>               | --input=<file>\n" \
>>>> +	"[ -y <action field ext> | --act-mask-ext=<action field ext>]\n" \
>>>> +	"[ -Y <action mask ext>  | --set-mask=<action mask>]\n" \
>>>> +	"[ -P                    | --track-priority ]\n" \
>>>> +	"[ -x <ioprio field>     | --prio-mask=<ioprio field> ]\n" \
>>>> +	"[ -X <ioprio mask>      | --set-mask=<ioprio mask> ]\n" \
>>>> +	"[ -v                    | --verbose ]\n" \
>>>> +	"[ -V                    | --version ]\n\n" \
>>>>    	"\t-a Only trace specified actions. See documentation\n" \
>>>>    	"\t-A Give trace mask as a single value. See documentation\n" \
>>>>    	"\t-b stdin read batching\n" \
>
>

