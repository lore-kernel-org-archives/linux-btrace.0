From: Pallav Bose <pallavbose@gmail.com>
Date: Tue, 07 Jun 2011 03:34:06 +0000
Subject: Re: No "Unplug" or "Unplug due to timer" observed in the output of blkparse
Message-Id: <BANLkTin=C4BPuNT++nqMxAuX5GsfMPWGHQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <BANLkTi=VkspzpuyetXti0ZHZB6yMXgbFyw@mail.gmail.com>
In-Reply-To: <BANLkTi=VkspzpuyetXti0ZHZB6yMXgbFyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

Hello Tao,

Thank you for your mail. I have updated my code to read as follows:

subq =3D bio->bi_bdev->bd_disk->queue;
if (subq && subq->make_request_fn) {
    subq->make_request_fn(subq, bio);
    blk_unplug(subq);
}

I now see the unplug actions in the output of blkparse. I conducted
another experiment wherein a single write request was sent from my
driver. Once the bio_endio() function is called to end I/O on a bio, I
compose another bio and invoke the make_request_fn() for that bio as
shown in the above code snippet. This has been done to ensure that the
requests are "chained;" only when a write request has been serviced,
the next write request is made. When I look at the output produced by
blkparse, I see that the time elapsed once the request is sent to the
driver, and when it has been completed is greater than 1.3 ms always.
The write requests have been issued such that they are 350 sectors
apart. My understanding is that if the write requests are reasonably
spaced out and once the previous request has been completed, the disk
head would (approximately) be positioned around the sector where the
next write request is supposed to happen. Is this case, I can expect
the latency of some of the write requests to be at least < 1 millisec,
which, unfortunately, is not the case as per my experiments. Any idea
why the latency of each write request is greater than a millisec? Is
it possible to do better?

I have repeated the experiment with different sector distances and
found that a inter-write spacing of 350 sectors gave the least
latency.

Line numbers - 14-18, 32-35, 45-47, 57-59, 69-71, 81-83,
93-95,105-107, 117-119, and 129-131 - contain the timestamps (format -
secs.nanosecs) taken once a write request has been sent to the driver
and when it's completed.

Best,
Pallav

  1   8,32   0        1     0.000000000  7079  G   W 0 + 8 [read_write_ioct]
  2   8,32   0        2     0.000002802  7079  P   N [read_write_ioct]
  3   8,32   0        3     0.000004150  7079  I   W 0 + 8 [read_write_ioct]
  4   8,32   0        0     0.000006706     0  m   N cfq6042 insert_request
  5   8,32   0        0     0.000007818     0  m   N cfq6042 add_to_rr
  6   8,32   0        4     0.000009547  7079  U   N [read_write_ioct] 1
  7   8,32   0        0     0.000012459     0  m   N cfq workload slice:30
  8   8,32   0        0     0.000013632     0  m   N cfq6042
set_active wl_prio:0 wl_type:0
  9   8,32   0        0     0.000014599     0  m   N cfq6042 Not
idling. st->count:1
 10   8,32   0        0     0.000015932     0  m   N cfq6042 fifo=3D(null)
 11   8,32   0        0     0.000016639     0  m   N cfq6042 dispatch_insert
 12   8,32   0        0     0.000018117     0  m   N cfq6042
dispatched a request
 13   8,32   0        0     0.000019230     0  m   N cfq6042 activate rq, d=
rv=3D1
 14   8,32   0        5     0.000019475  7079  D   W 0 + 8 (   15325)
[read_write_ioct]
 15   8,32   0        0     0.000095252     0  m   N cfq6042 slice expired =
t=3D0
 16   8,32   0        0     0.000095959     0  m   N cfq6042 sl_used=3D1
 17   8,32   0        0     0.000096706     0  m   N cfq6042 del_from_rr
 18   8,32   0        6     0.011556813     0  C   W 0 + 8 (11537338) [0]
 19   8,32   0        7     0.011572264     0  G   W 350 + 8 [swapper]
 20   8,32   0        8     0.011574495     0  P   N [swapper]
 21   8,32   0        9     0.011575642     0  I   W 350 + 8 (
3378) [swapper]
 22   8,32   0        0     0.011577406     0  m   N cfq6042 insert_request
 23   8,32   0        0     0.011578524     0  m   N cfq6042 add_to_rr
 24   8,32   0       10     0.011583481     0  U   N [swapper] 2
 25   8,32   0        0     0.011586523     0  m   N cfq workload slice:30
 26   8,32   0        0     0.011587776     0  m   N cfq6042
set_active wl_prio:0 wl_type:0
 27   8,32   0        0     0.011588783     0  m   N cfq6042 Not
idling. st->count:1
 28   8,32   0        0     0.011590136     0  m   N cfq6042 fifo=3D(null)
 29   8,32   0        0     0.011590813     0  m   N cfq6042 dispatch_insert
 30   8,32   0        0     0.011592502     0  m   N cfq6042
dispatched a request
 31   8,32   0        0     0.011593564     0  m   N cfq6042 activate rq, d=
rv=3D2
 32   8,32   0       11     0.011593800     0  D   W 350 + 8 (
18158) [swapper]
 33   8,32   0        0     0.011610163     0  m   N cfq6042 complete rqnoi=
dle 0
 34   8,32   0        0     0.011611220     0  m   N cfq6042 set_slice=10
 35   8,32   0       12     0.012963877     0  C   W 350 + 8 ( 1370077) [0]
 36   8,32   0       13     0.012971285     0  G   W 700 + 8 [swapper]
 37   8,32   0       14     0.012972392     0  P   N [swapper]
 38   8,32   0       15     0.012972843     0  I   W 700 + 8 (
1558) [swapper]
 39   8,32   0        0     0.012973830     0  m   N cfq6042 insert_request
 40   8,32   0       16     0.012978657     0  U   N [swapper] 2
 41   8,32   0        0     0.012980210     0  m   N cfq6042 Not
idling. st->count:1
 42   8,32   0        0     0.012981097     0  m   N cfq6042 dispatch_insert
 43   8,32   0        0     0.012982330     0  m   N cfq6042
dispatched a request
 44   8,32   0        0     0.012983273     0  m   N cfq6042 activate rq, d=
rv=3D2
 45   8,32   0       17     0.012983588     0  D   W 700 + 8 (
10745) [swapper]
 46   8,32   0        0     0.012990344     0  m   N cfq6042 complete rqnoi=
dle 0
 47   8,32   0       18     0.014353105     0  C   W 700 + 8 ( 1369517) [0]
 48   8,32   0       19     0.014360166     0  G   W 1050 + 8 [swapper]
 49   8,32   0       20     0.014361249     0  P   N [swapper]
 50   8,32   0       21     0.014361705     0  I   W 1050 + 8 (
1539) [swapper]
 51   8,32   0        0     0.014362567     0  m   N cfq6042 insert_request
 52   8,32   0       22     0.014367283     0  U   N [swapper] 2
 53   8,32   0        0     0.014368796     0  m   N cfq6042 Not
idling. st->count:1
 54   8,32   0        0     0.014369578     0  m   N cfq6042 dispatch_insert
 55   8,32   0        0     0.014370635     0  m   N cfq6042
dispatched a request
 56   8,32   0        0     0.014371508     0  m   N cfq6042 activate rq, d=
rv=3D2
 57   8,32   0       23     0.014371818     0  D   W 1050 + 8 (
10113) [swapper]
 58   8,32   0        0     0.014378233     0  m   N cfq6042 complete rqnoi=
dle 0
 59   8,32   0       24     0.015744222     0  C   W 1050 + 8 ( 1372404) [0]
 60   8,32   0       25     0.015753594     0  G   W 1400 + 8 [swapper]
 61   8,32   0       26     0.015755142     0  P   N [swapper]
 62   8,32   0       27     0.015755759     0  I   W 1400 + 8 (
2165) [swapper]
 63   8,32   0        0     0.015756796     0  m   N cfq6042 insert_request
 64   8,32   0       28     0.015762018     0  U   N [swapper] 2
 65   8,32   0        0     0.015764053     0  m   N cfq6042 Not
idling. st->count:1
 66   8,32   0        0     0.015764880     0  m   N cfq6042 dispatch_insert
 67   8,32   0        0     0.015766173     0  m   N cfq6042
dispatched a request
 68   8,32   0        0     0.015767180     0  m   N cfq6042 activate rq, d=
rv=3D2
 69   8,32   0       29     0.015767521     0  D   W 1400 + 8 (
11762) [swapper]
 70   8,32   0        0     0.015777018     0  m   N cfq6042 complete rqnoi=
dle 0
 71   8,32   0       30     0.017158533     0  C   W 1400 + 8 ( 1391012) [0]
 72   8,32   0       31     0.017165790     0  G   W 1750 + 8 [swapper]
 73   8,32   0       32     0.017166942     0  P   N [swapper]
 74   8,32   0       33     0.017167388     0  I   W 1750 + 8 (
1598) [swapper]
 75   8,32   0        0     0.017168215     0  m   N cfq6042 insert_request
 76   8,32   0       34     0.017172961     0  U   N [swapper] 2
 77   8,32   0        0     0.017174590     0  m   N cfq6042 Not
idling. st->count:1
 78   8,32   0        0     0.017175377     0  m   N cfq6042 dispatch_insert
 79   8,32   0        0     0.017176450     0  m   N cfq6042
dispatched a request
 80   8,32   0        0     0.017177447     0  m   N cfq6042 activate rq, d=
rv=3D2
 81   8,32   0       35     0.017177788     0  D   W 1750 + 8 (
10400) [swapper]
 82   8,32   0        0     0.017184233     0  m   N cfq6042 complete rqnoi=
dle 0
 83   8,32   0       36     0.018547795     0  C   W 1750 + 8 ( 1370007) [0]
 84   8,32   0       37     0.018554827     0  G   W 2100 + 8 [swapper]
 85   8,32   0       38     0.018555869     0  P   N [swapper]
 86   8,32   0       39     0.018556285     0  I   W 2100 + 8 (
1458) [swapper]
 87   8,32   0        0     0.018557067     0  m   N cfq6042 insert_request
 88   8,32   0       40     0.018561617     0  U   N [swapper] 2
 89   8,32   0        0     0.018563006     0  m   N cfq6042 Not
idling. st->count:1
 90   8,32   0        0     0.018563687     0  m   N cfq6042 dispatch_insert
 91   8,32   0        0     0.018564805     0  m   N cfq6042
dispatched a request
 92   8,32   0        0     0.018565677     0  m   N cfq6042 activate rq, d=
rv=3D2
 93   8,32   0       41     0.018566003     0  D   W 2100 + 8 (
9718) [swapper]
 94   8,32   0        0     0.018579830     0  m   N cfq6042 complete rqnoi=
dle 0
 95   8,32   0       42     0.021094716     0  C   W 2100 + 8 ( 2528713) [0]
 96   8,32   0       43     0.021103717     0  G   W 2450 + 8 [swapper]
 97   8,32   0       44     0.021105075     0  P   N [swapper]
 98   8,32   0       45     0.021105692     0  I   W 2450 + 8 (
1975) [swapper]
 99   8,32   0        0     0.021106644     0  m   N cfq6042 insert_request
100   8,32   0       46     0.021111741     0  U   N [swapper] 2
101   8,32   0        0     0.021113485     0  m   N cfq6042 Not
idling. st->count:1
102   8,32   0        0     0.021114222     0  m   N cfq6042 dispatch_insert
103   8,32   0        0     0.021115390     0  m   N cfq6042
dispatched a request
104   8,32   0        0     0.021116362     0  m   N cfq6042 activate rq, d=
rv=3D2
105   8,32   0       47     0.021116713     0  D   W 2450 + 8 (
11021) [swapper]
106   8,32   0        0     0.021124481     0  m   N cfq6042 complete rqnoi=
dle 0
107   8,32   0       48     0.022482175     0  C   W 2450 + 8 ( 1365462) [0]
108   8,32   0       49     0.022489272     0  G   W 2800 + 8 [swapper]
109   8,32   0       50     0.022490329     0  P   N [swapper]
110   8,32   0       51     0.022490725     0  I   W 2800 + 8 (
1453) [swapper]
111   8,32   0        0     0.022491522     0  m   N cfq6042 insert_request
112   8,32   0       52     0.022496103     0  U   N [swapper] 2
113   8,32   0        0     0.022497511     0  m   N cfq6042 Not
idling. st->count:1
114   8,32   0        0     0.022498228     0  m   N cfq6042 dispatch_insert
115   8,32   0        0     0.022499330     0  m   N cfq6042
dispatched a request
116   8,32   0        0     0.022500302     0  m   N cfq6042 activate rq, d=
rv=3D2
117   8,32   0       53     0.022500628     0  D   W 2800 + 8 (
9903) [swapper]
118   8,32   0        0     0.022507033     0  m   N cfq6042 complete rqnoi=
dle 0
119   8,32   0       54     0.023900286     0  C   W 2800 + 8 ( 1399658) [0]
120   8,32   0       55     0.023909322     0  G   W 3150 + 8 [swapper]
121   8,32   0       56     0.023910706     0  P   N [swapper]
122   8,32   0       57     0.023911342     0  I   W 3150 + 8 (
2020) [swapper]
123   8,32   0        0     0.023912264     0  m   N cfq6042 insert_request
124   8,32   0       58     0.023917391     0  U   N [swapper] 2
125   8,32   0        0     0.023919150     0  m   N cfq6042 Not
idling. st->count:1
126   8,32   0        0     0.023919937     0  m   N cfq6042 dispatch_insert
127   8,32   0        0     0.023921170     0  m   N cfq6042
dispatched a request
128   8,32   0        0     0.023922152     0  m   N cfq6042 activate rq, d=
rv=3D2
129   8,32   0       59     0.023922493     0  D   W 3150 + 8 (
11151) [swapper]
130   8,32   0        0     0.023930171     0  m   N cfq6042 complete rqnoi=
dle 0
131   8,32   0       60     0.025288672     0  C   W 3150 + 8 ( 1366179) [0]
132   8,32   0        0     0.025295388     0  m   N cfq6042 complete rqnoi=
dle 0
133   8,32   0        0     0.025295934     0  m   N cfq schedule dispatch
134 CPU0 (sdc):
135  Reads Queued:            0,        0KiB  Writes Queued:
 0,        0KiB
136  Read Dispatches:        0,        0KiB  Write Dispatches:
10,       40KiB
137  Reads Requeued:        0                  Writes Requeued:         0
138  Reads Completed:       0,        0KiB  Writes Completed:
10,       40KiB
139  Read Merges:              0,        0KiB  Write Merges:
   0,        0KiB
140  Read depth:                 0                  Write depth:
          1
141  IO unplugs:                10                  Timer unplugs:
         0
142
143 Throughput (R/W): 0KiB/s / 1600KiB/s
144 Events (sdc): 133 entries
145 Skips: 0 forward (0 -   0.0%)
146 Input file sdc.blktrace.0 added
147 Input file sdc.blktrace.1 added

I conducted another experiment wherein
On Sat, Jun 4, 2011 at 4:46 AM, Tao Ma <tm@tao.ma> wrote:
> On 06/04/2011 10:55 AM, Pallav Bose wrote:
>> Hello,
>>
>> I'm working on the 2.6.35.9 version of the linux kernel and am trying
>> to understand the latency observed in write requests sent from my
>> driver. To start off, my userlevel program - read_write_ioctl - issues
>> an ioctl() which is intercepted by my driver. Next, the driver issues
>> a couple of read requests to position the disk head on the first
>> track. My driver then composes a struct bio and calls the
>> make_request_fn of the lower level driver, followed by a call to the
>> unplug function so that this particular write request is serviced
>> immediately:
>>
>> subq =3D bio->bi_bdev->bd_disk->queue;
>> if (subq && subq->make_request_fn) {
>> =A0 =A0subq->make_request_fn(subq, bio);
>> }
>>
>> if (subq && subq->unplug_fn)
>> =A0 =A0subq->unplug_fn(subq);
>> }
>>
>> The output of blkparse (as shown below) seems to suggest that there
>> were zero IO unplugs, which is strange because one would expect at
>> least an unplug due to a timeout to occur after 3 milliseconds has
>> elapsed (please refer to the function blk_queue_make_request()
>> <http://lxr.linux.no/linux+v2.6.35.9/block/blk-settings.c#L137>).
>> Plus, if an "unplug" action doesn't take place, how would the write
>> request be actually serviced?
> I am quite familiar with blktrace/parse, but maybe you can try my
> suggestion to see if it helps.
>
> The reason why unplug event does show up in blkparse is because you
> don't call it. Here "it" means trace_block_unplug.Your driver calls
> subq->unplug_fn, so the trace_block_unplug isn't called and blktrace
> can't catch it.
> So just before you call subq->unplug_fn, call trace_block_unplug
> directly and I guess you will see what you need.
>
> Regards,
> Tao
>
