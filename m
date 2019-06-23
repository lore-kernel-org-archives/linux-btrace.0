From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date: Sun, 23 Jun 2019 20:45:12 +0000
Subject: Re: [blktrace-tools RFC PATCH 5/5] blkparse: add support for trace extension
Message-Id: <BYAPR04MB5749CA5E8E3504819DB813EF86E10@BYAPR04MB5749.namprd04.prod.outlook.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190602165810.14817-6-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190602165810.14817-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Sorry for the late reply.
On 6/18/19 5:33 AM, Steffen Maier wrote:
> On 6/2/19 6:58 PM, Chaitanya Kulkarni wrote:
>
>> Update blktrace tool to support the trace extensions. The new option
>> '-E' will allow blktrace to configure trace with newly introduced
>> IOCTLs for trace extensions. '-Y' and '-y' options are similar to
>> '-a' and '-A' but can now use the mask for additional operations
>> which are supported for trace-extension. For tracking the priority we
>> add '-P' along with the '-X' and '-x' to specify priority value and
>> mask.
> Documentation in addition to the updated usage text?
Sure, I'll add with the final version.
>
> doc/blkparse.1
> doc/blktrace.tex
>
> optimally including new output formats such as for the extended RWBS and 
> prio-class so users know how to read it
> [my background is https://www.spinics.net/lists/linux-btrace/msg00840.html 
> https://www.spinics.net/lists/linux-btrace/msg00836.html 
> https://www.spinics.net/lists/linux-btrace/msg00825.html]
Totally agree with you.
>
>> Update blkparse format with the trace extension support so blkparse
>> now can now identify and dump the trace extension. The new function
>> fill_rwbs_ext() formats the trace string with newly added trace
>> categories. We encapsulate existing blk_trace and newly added
>> blk_trace_ext structure under struct trace and use the t_bit_xxx()
>> helpers to read the appropriate value based on whether extensions
>> are enabled or not. We also add the support for priority tracking
>> when trace extension is enabled.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>   Makefile       |    2 +-
>>   blkparse.c     | 1072 +++++++++++++++++++++++++++++++++++-------------
>>   blkparse.h     |   78 ++++
>>   blkparse_fmt.c |  204 ++++++---
>>   blktrace.h     |    6 +-
>>   5 files changed, 1017 insertions(+), 345 deletions(-)
>>   create mode 100644 blkparse.h
>>
>> diff --git a/Makefile b/Makefile
>> index 5917814..af90a45 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1,7 +1,7 @@
>>   CC	= gcc
>>   CFLAGS	= -Wall -O2 -g -W
>>   ALL_CFLAGS = $(CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
>> -PROGS	= blkparse blktrace verify_blkparse blkrawverify blkiomon
>> +PROGS	= blkparse blktrace #verify_blkparse blkrawverify blkiomon
> not building verify_blkparse any more looks odd, is it a left over from 
> development / debugging?

This is RFC so I want everyone to provide some feedback I'll be
providing patches

to all the tools under blktrace.

Also I've not created tools patch-series the way it should since we
still in the process

of finalizing the approach.

>>   LIBS	= -lpthread
>>   SCRIPTS	= btrace
>>   SUBDIRS = btreplay btt iowatcher
>> diff --git a/blkparse.c b/blkparse.c
>> index 227cc44..36fe568 100644
>> --- a/blkparse.c
>> +++ b/blkparse.c
>> @@ -201,6 +201,42 @@ static struct option l_opts[] = {
>>   		.flag = NULL,
>>   		.val = 'w'
>>   	},
>> +	{
>> +		.name = "act-mask-ext",
>> +		.has_arg = required_argument,
>> +		.flag = NULL,
>> +		.val = 'y'
>> +	},
>> +	{
>> +		.name = "set-mask-ext",
>> +		.has_arg = required_argument,
>> +		.flag = NULL,
>> +		.val = 'Y'
>> +	},
>> +	{
>> +		.name = "use-extensions",
>> +		.has_arg = no_argument,
>> +		.flag = NULL,
>> +		.val = 'E'
>> +	},
>> +	{
>> +		.name = "track-priority",
>> +		.has_arg = no_argument,
>> +		.flag = NULL,
>> +		.val = 'P'
>> +	},
>> +	{
>> +		.name = "prio-mask",
>> +		.has_arg = required_argument,
>> +		.flag = NULL,
>> +		.val = 'x'
>> +	},
>> +	{
>> +		.name = "prio-set-mask",
>> +		.has_arg = required_argument,
>> +		.flag = NULL,
>> +		.val = 'X'
>> +	},
>>   	{
>>   		.name = "verbose",
>>   		.has_arg = no_argument,
>> @@ -572,53 +611,82 @@ static struct process_pid_map *add_ppm_hash(pid_t pid, const char *name)
>>   	return ppm;
>>   }
>>
>> -static void handle_notify(struct blk_io_trace *bit)
>> +static void handle_notify(struct trace *t)
>>   {
>> -	void	*payload = (caddr_t) bit + sizeof(*bit);
>> +	void	*payload;
>>   	__u32	two32[2];
>>
>> -	switch (bit->action) {
>> -	case BLK_TN_PROCESS:
>> -		add_ppm_hash(bit->pid, payload);
>> -		break;
>> -
>> -	case BLK_TN_TIMESTAMP:
>> -		if (bit->pdu_len != sizeof(two32))
>> -			return;
>> -		memcpy(two32, payload, sizeof(two32));
>> -		if (!data_is_native) {
>> -			two32[0] = be32_to_cpu(two32[0]);
>> -			two32[1] = be32_to_cpu(two32[1]);
>> -		}
>> -		start_timestamp = bit->time;
>> -		abs_start_time.tv_sec  = two32[0];
>> -		abs_start_time.tv_nsec = two32[1];
>> -		if (abs_start_time.tv_nsec < 0) {
>> -			abs_start_time.tv_sec--;
>> -			abs_start_time.tv_nsec += 1000000000;
>> +	if (t->use_ext)
>> +		payload = (caddr_t) t->bit_ext + sizeof(*(t->bit_ext));
>> +	else
>> +		payload = (caddr_t) t->bit + sizeof(*(t->bit));
>> +
>> +	if (use_ext) {
>> -
>> -		break;
>> -
>> -	case BLK_TN_MESSAGE:
>> -		if (bit->pdu_len > 0) {
>> -			char msg[bit->pdu_len+1];
>> -
>> -			memcpy(msg, (char *)payload, bit->pdu_len);
>> -			msg[bit->pdu_len] = '\0';
>> -
>> -			fprintf(ofp,
>> -				"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
>> -				MAJOR(bit->device), MINOR(bit->device),
>> -				bit->cpu, "0", (int) SECONDS(bit->time),
>> -				(unsigned long) NANO_SECONDS(bit->time),
>> -				0, "m", "N", msg);
> I find it a bit hard to review that everything under the else case remains the 
> same code with just an additional indentation. Would it be possible to just add 
> the if(use_ext) with an early return and leave the old non-extended code as is?

This patch and other patches in the series will be refactored into the
small pieces

so that it will be easy for reveiwer.

>
>> +	} else {
>> +		if (t_bit_act(t) == BLK_TN_PROCESS) {
>> +			add_ppm_hash(t_bit_pid(t), payload);
>> +		} else if (t_bit_act(t) == BLK_TN_TIMESTAMP) {
>> +			if (t_bit_pdu_len(t) != sizeof(two32))
>> +				return;
>> +			memcpy(two32, payload, sizeof(two32));
>> +			if (!data_is_native) {
>> +				two32[0] = be32_to_cpu(two32[0]);
>> +				two32[1] = be32_to_cpu(two32[1]);
>> +			}
>> +			start_timestamp = t_bit_time(t);
>> +			abs_start_time.tv_sec  = two32[0];
>> +			abs_start_time.tv_nsec = two32[1];
>> +			if (abs_start_time.tv_nsec < 0) {
>> +				abs_start_time.tv_sec--;
>> +				abs_start_time.tv_nsec += 1000000000;
>> +			}
>> +		} else if (t_bit_act(t) == BLK_TN_MESSAGE) {
>> +			if (t_bit_pdu_len(t) > 0) {
>> +				char msg[t_bit_pdu_len(t)+1];
>> +
>> +				memcpy(msg, (char *)payload, t_bit_pdu_len(t));
>> +				msg[t_bit_pdu_len(t)] = '\0';
>> +
>> +				fprintf(ofp,
>> +					"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
>> +					MAJOR(t_bit_dev(t)), MINOR(t_bit_dev(t)),
>> +					t_bit_cpu(t), "0", (int) SECONDS(t_bit_time(t)),
>> +					(unsigned long) NANO_SECONDS(t_bit_time(t)),
>> +					0, "m", "N", msg);
>> +			}
>>   		}
>> -		break;
>> -
>> -	default:
>> -		/* Ignore unknown notify events */
>> -		;
>>   	}
>>   }
>>
>> -static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
>> +static void dump_trace(struct trace *t, struct per_cpu_info *pci,
>>   		       struct per_dev_info *pdi)
>>   {
>>   	if (text_output) {
>> -		if (t->action == BLK_TN_MESSAGE)
>> -			handle_notify(t);
>> -		else if (t->action & BLK_TC_ACT(BLK_TC_PC))
>> -			dump_trace_pc(t, pdi, pci);
>> -		else
>> -			dump_trace_fs(t, pdi, pci);
>> +		if (use_ext)
>> +			if (t->bit_ext->action == BLK_TN_MESSAGE_EXT)
>> +				handle_notify(t);
>> +			else if (t->bit_ext->action & BLK_TC_ACT_EXT(BLK_TC_PC))
>> +				dump_trace_pc(t, pdi, pci);
>> +			else
>> +				dump_trace_fs(t, pdi, pci);
>> +		else {
>> +			if (t->bit->action == BLK_TN_MESSAGE)
>> +				handle_notify(t);
>> +			else if (t->bit->action & BLK_TC_ACT(BLK_TC_PC))
>> +				dump_trace_pc(t, pdi, pci);
>> +			else
>> +				dump_trace_fs(t, pdi, pci);
>> +		}
> dito
Same here.
>
>>   	}
>>
>>   	if (!pdi->events)
>> -		pdi->first_reported_time = t->time;
>> +		pdi->first_reported_time = t_bit_time(t);
>>
>>   	pdi->events++;
>>
>> -	if (bin_output_msgs ||
>> -			    !(t->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
>> -			      t->action == BLK_TN_MESSAGE))
>> -		output_binary(t, sizeof(*t) + t->pdu_len);
>> +	if (use_ext) {
>> +		struct blk_io_trace_ext *bit_ext = t->bit_ext;
>> +
>> +		if (bin_output_msgs ||
>> +				!(bit_ext->action & BLK_TC_ACT_EXT(BLK_TC_NOTIFY) &&
>> +					bit_ext->action == BLK_TN_MESSAGE_EXT))
>> +			output_binary(bit_ext, sizeof(*bit_ext) + bit_ext->pdu_len);
>> +	} else {
>> +		struct blk_io_trace *bit = t->bit;
>> +
>> +		if (bin_output_msgs ||
>> +				!(bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
>> +					bit->action == BLK_TN_MESSAGE))
>> +			output_binary(bit, sizeof(*bit) + bit->pdu_len);
>> +	}
>>   }
>> @@ -2111,41 +2237,57 @@ static void show_entries_rb(int force)
>> -		if (!(bit->action == BLK_TN_MESSAGE) &&
>> -		    check_sequence(pdi, t, force))
>> -			break;
>> +		if (use_ext) {
>> +			if (!(t->bit_ext->action == BLK_TN_MESSAGE_EXT) &&
>> +					check_sequence(pdi, t, force))
>> +				break;
>> +		} else {
>> +			if (!(t->bit->action == BLK_TN_MESSAGE) &&
>> +					check_sequence(pdi, t, force))
>> +				break;
>> +		}
>> -		if (!(bit->action == BLK_TN_MESSAGE))
>> -			pci->last_sequence = bit->sequence;
>> +		if (use_ext) {
>> +			if (!(t->bit_ext->action == BLK_TN_MESSAGE_EXT))
>> +				pci->last_sequence = t->bit_ext->sequence;
>> +		} else {
>> +			if (!(t->bit->action == BLK_TN_MESSAGE))
>> +				pci->last_sequence = t->bit->sequence;
>> +		}
>> -		if (bit->action & (act_mask << BLK_TC_SHIFT))
>> -			dump_trace(bit, pci, pdi);
>> +		if (use_ext) {
>> +			if (t->bit_ext->action &
>> +					(act_mask_ext << BLK_TC_SHIFT_EXT))
>> +				dump_trace(t, pci, pdi);
>> +		} else {
>> +			if (t->bit->action & (act_mask << BLK_TC_SHIFT))
>> +				dump_trace(t, pci, pdi);
>> +		}
>>
>>   		put_trace(pdi, t);
>>   	}
>> @@ -2342,10 +2629,18 @@ static inline void ms_deq(struct ms_stream *msp)
>>   	msp->first = msp->first->next;
>>   	if (!msp->first) {
>>   		msp->last = NULL;
>> -		if (!ms_prime(msp)) {
>> -			ms_head = msp->next;
>> -			msp->next = NULL;
>> -			return;
>> +		if (use_ext) {
>> +			if (!ms_prime_ext(msp)) {
>> +				ms_head = msp->next;
>> +				msp->next = NULL;
>> +				return;
>> +			}
>> +		} else {
>> +			if (!ms_prime(msp)) {
>> +				ms_head = msp->next;
>> +				msp->next = NULL;
>> +				return;
>> +			}
>>   		}
>>   	}
>> @@ -2469,8 +2848,13 @@ static struct ms_stream *ms_alloc(struct per_dev_info *pdi, int cpu)
>> -	if (ms_prime(msp))
>> -		ms_sort(msp);
>> +	if (use_ext)  {
>> +		if (ms_prime_ext(msp))
>> +			ms_sort(msp);
>> +	} else {
>> +		if (ms_prime(msp))
>> +			ms_sort(msp);
>> +	}
>> @@ -2605,8 +3020,13 @@ static int do_file(void)
>> -	while (!is_done() && ms_head && handle(ms_head))
>> -		;
>> +	if (use_ext)
>> +		while (!is_done() && ms_head && handle_ext(ms_head))
>> +			;
>> +	else {
>> +		while (!is_done() && ms_head && handle(ms_head))
>> +			;
>> +	}
>> @@ -2618,19 +3038,23 @@ static void do_pipe(int fd)
>>   		read_sequence++;
>> -	
>>   #if 0
>>   		smallest_seq_read = -1U;
>>   #endif
>> -
>>   		if (sort_entries(&youngest))
>>   			break;
>> -
>>   		if (youngest > stopwatch_end)
>>   			break;
>> -
>>   		show_entries_rb(0);
>>   	}
> Why such seemingly unrelated whitespace changes?

This is needed to realign the "| --" since strlen("-y <...>" and larger than

existing options.

>
>> -#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVM"
>> +#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVMPx:X:y:Y:E"
>>   static char usage_str[] =    "\n\n" \
>> -	"-i <file>           | --input=<file>\n" \
>> -	"[ -a <action field> | --act-mask=<action field> ]\n" \
>> -	"[ -A <action mask>  | --set-mask=<action mask> ]\n" \
>> -	"[ -b <traces>       | --batch=<traces> ]\n" \
>> -	"[ -d <file>         | --dump-binary=<file> ]\n" \
>> -	"[ -D <dir>          | --input-directory=<dir> ]\n" \
>> -	"[ -f <format>       | --format=<format> ]\n" \
>> -	"[ -F <spec>         | --format-spec=<spec> ]\n" \
>> -	"[ -h                | --hash-by-name ]\n" \
>> -	"[ -o <file>         | --output=<file> ]\n" \
>> -	"[ -O                | --no-text-output ]\n" \
>> -	"[ -q                | --quiet ]\n" \
>> -	"[ -s                | --per-program-stats ]\n" \
>> -	"[ -t                | --track-ios ]\n" \
>> -	"[ -w <time>         | --stopwatch=<time> ]\n" \
>> -	"[ -M                | --no-msgs\n" \
>> -	"[ -v                | --verbose ]\n" \
>> -	"[ -V                | --version ]\n\n" \
>> +	"-i <file>               | --input=<file>\n" \
>> +	"[ -a <action field>     | --act-mask=<action field> ]\n" \
>> +	"[ -A <action mask>      | --set-mask=<action mask> ]\n" \
>> +	"[ -b <traces>           | --batch=<traces> ]\n" \
>> +	"[ -d <file>             | --dump-binary=<file> ]\n" \
>> +	"[ -D <dir>              | --input-directory=<dir> ]\n" \
>> +	"[ -f <format>           | --format=<format> ]\n" \
>> +	"[ -F <spec>             | --format-spec=<spec> ]\n" \
>> +	"[ -h                    | --hash-by-name ]\n" \
>> +	"[ -o <file>             | --output=<file> ]\n" \
>> +	"[ -O                    | --no-text-output ]\n" \
>> +	"[ -q                    | --quiet ]\n" \
>> +	"[ -s                    | --per-program-stats ]\n" \
>> +	"[ -t                    | --track-ios ]\n" \
>> +	"[ -w <time>             | --stopwatch=<time> ]\n" \
>> +	"[ -M                    | --no-msgs\n" \
>> +	"[ -E                    | --use-extensions ]\n" \
>> +	"[ -y <action field ext> | --act-mask-ext=<action field ext>]\n" \
>> +	"[ -Y <action mask ext>  | --set-mask=<action mask>]\n" \
>> +	"[ -P                    | --track-priority ]\n" \
>> +	"[ -x <ioprio field>     | --prio-mask=<ioprio field> ]\n" \
>> +	"[ -X <ioprio mask>      | --set-mask=<ioprio mask> ]\n" \
>> +	"[ -v                    | --verbose ]\n" \
>> +	"[ -V                    | --version ]\n\n" \
>>   	"\t-a Only trace specified actions. See documentation\n" \
>>   	"\t-A Give trace mask as a single value. See documentation\n" \
>>   	"\t-b stdin read batching\n" \
>> @@ -2769,6 +3199,12 @@ static char usage_str[] =    "\n\n" \
>>   	"\t-w Only parse data between the given time interval in seconds.\n" \
>>   	"\t   If 'start' isn't given, blkparse defaults the start time to 0\n" \
>>   	"\t-M Do not output messages to binary file\n" \
>> +	"\t-E Use Blocktrace Extensions\n" \
>> +	"\t-P Enable tracking priorites.\n" \
>> +	"\t-y Only trace specified actions ext.\n" \
>> +	"\t-Y Give trace mask as a single value ext.\n" \
>> +	"\t-x Only priority specified actions.\n" \
>> +	"\t-X Give priority mask as a single value.\n" \
>>   	"\t-v More verbose for marginal errors\n" \
>>   	"\t-V Print program version info\n\n";
>> @@ -2882,8 +3365,27 @@ int main(int argc, char *argv[])
>> -	if (act_mask_tmp != 0)
>> -		act_mask = act_mask_tmp;
>> +	if (use_ext) {
>> +		if (act_mask_tmp) {
>> +			fprintf(stderr, "please use y or Y with -E\n");
>> +			return 1;
>> +		}
>> +		if (act_mask_tmp_ext != 0)
>> +			act_mask_ext = act_mask_tmp_ext;
>> +
>> +		/*
>> +		 * When track-priority is on and user didn't specify prio_mask then
>> +		 * trace all the classes.
>> +		 */
>> +		if (blkparse_track_prio && !blkparse_prio_mask)
>> +			blkparse_prio_mask = TRACE_ALL_IOPRIO;
>> +	} else {
>> +		if (act_mask_tmp != 0)
>> +			act_mask = act_mask_tmp;
>> +	}
>> diff --git a/blkparse_fmt.c b/blkparse_fmt.c
>> index c42e6d7..15c5f44 100644
>> --- a/blkparse_fmt.c
>> +++ b/blkparse_fmt.c
>> +static inline void fill_rwbs_ext(char *rwbs, struct blk_io_trace_ext *t)
>> +{
>> +	uint64_t w = t->action & BLK_TC_ACT_EXT(BLK_TC_WRITE);
>> +	uint64_t a = t->action & BLK_TC_ACT_EXT(BLK_TC_AHEAD);
>> +	uint64_t s = t->action & BLK_TC_ACT_EXT(BLK_TC_SYNC);
>> +	uint64_t m = t->action & BLK_TC_ACT_EXT(BLK_TC_META);
>> +	uint64_t d = t->action & BLK_TC_ACT_EXT(BLK_TC_DISCARD);
>> +	uint64_t f = t->action & BLK_TC_ACT_EXT(BLK_TC_FLUSH);
>> +	uint64_t u = t->action & BLK_TC_ACT_EXT(BLK_TC_FUA);
>> +	uint64_t z = t->action & BLK_TC_ACT_EXT(BLK_TC_WRITE_ZEROES);
>> +	uint64_t r = t->action & BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET);
>> +	int i = 0;
>> +
>> +	if (f)
>> +		rwbs[i++] = 'F'; /* flush */
>> +
>> +	if (d)
>> +		rwbs[i++] = 'D';
>> +	else if (z) {
>> +		rwbs[i++] = 'W'; /* write-zeroes */
>> +		rwbs[i++] = 'Z';
>> +	} else if (r) {
>> +		rwbs[i++] = 'Z'; /* zone-reset */
>> +		rwbs[i++] = 'R';
>> +	} else if (w)
>> +		rwbs[i++] = 'W';
>> +	else if (t->bytes)
>> +		rwbs[i++] = 'R';
>> +	else
>> +		rwbs[i++] = 'N';
>> +
>> +	if (u)
>> +		rwbs[i++] = 'F'; /* fua */
>> +	if (a)
>> +		rwbs[i++] = 'A';
>> +	if (s)
>> +		rwbs[i++] = 'S';
>> +	if (m)
>> +		rwbs[i++] = 'M';
>> +
>> +	rwbs[i] = '\0';
>> +}
>> +
>> +static inline bool t_zone_reset(struct trace *t)
>> +{
>> +	if (!t->use_ext)
>> +		return false;
>> +
>> +	return t_bit_act(t) & BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET) ? true : false;
>> +}
> nice
Thanks.
>
>>   static void process_default(char *act, struct per_cpu_info *pci,
>> -			    struct blk_io_trace *t, unsigned long long elapsed,
>> +			    struct trace *t, unsigned long long elapsed,
>>   			    int pdu_len, unsigned char *pdu_buf)
>>   {
>> +	if (t->use_ext && blkparse_track_prio) {
>> +		switch (IOPRIO_PRIO_CLASS(t->bit_ext->ioprio)) {
>> +		case IOPRIO_CLASS_NONE:
>> +			if (blkparse_prio_mask & 0x1)
>> +				fprintf(ofp, "N ");
>> +			break;
>> +		case IOPRIO_CLASS_RT:
>> +			if (blkparse_prio_mask & 0x2)
>> +				fprintf(ofp, "R ");
>> +			break;
>> +		case IOPRIO_CLASS_BE:
>> +			if (blkparse_prio_mask & 0x4)
>> +				fprintf(ofp, "B ");
>> +			break;
>> +		case IOPRIO_CLASS_IDLE:
>> +			if (blkparse_prio_mask & 0x8)
>> +				fprintf(ofp, "I ");
>> +			break;
>> +		default:
>> +			fprintf(ofp, "E ");
>> +		}
>> +	}
>

