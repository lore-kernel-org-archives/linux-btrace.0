From: Pallav Bose <pallavbose@gmail.com>
Date: Sat, 04 Jun 2011 02:55:04 +0000
Subject: No "Unplug" or "Unplug due to timer" observed in the output of blkparse
Message-Id: <BANLkTi=VkspzpuyetXti0ZHZB6yMXgbFyw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello,

I'm working on the 2.6.35.9 version of the linux kernel and am trying
to understand the latency observed in write requests sent from my
driver. To start off, my userlevel program - read_write_ioctl - issues
an ioctl() which is intercepted by my driver. Next, the driver issues
a couple of read requests to position the disk head on the first
track. My driver then composes a struct bio and calls the
make_request_fn of the lower level driver, followed by a call to the
unplug function so that this particular write request is serviced
immediately:

subq = bio->bi_bdev->bd_disk->queue;
if (subq && subq->make_request_fn) {
   subq->make_request_fn(subq, bio);
}

if (subq && subq->unplug_fn) {
   subq->unplug_fn(subq);
}

The output of blkparse (as shown below) seems to suggest that there
were zero IO unplugs, which is strange because one would expect at
least an unplug due to a timeout to occur after 3 milliseconds has
elapsed (please refer to the function blk_queue_make_request()
<http://lxr.linux.no/linux+v2.6.35.9/block/blk-settings.c#L137>).
Plus, if an "unplug" action doesn't take place, how would the write
request be actually serviced?

As you can see in the actions column, there is no 'U' or 'T' seen. Can
someone help me identify what the issue might be? Thank you!

Regards,
Pallav

  8,32   1        0     0.000000000     0  m   N cfq8639 alloced
  8,32   1        1     0.000001529  8639  G  RS 0 + 8 [read_write_ioct]
  8,32   1        2     0.000003769  8639  P   N [read_write_ioct]
  8,32   1        3     0.000005092  8639  I   R 0 + 8 (    3563)
[read_write_ioct]
  8,32   1        0     0.000006420     0  m   N cfq8639 insert_request
  8,32   1        0     0.000007382     0  m   N cfq8639 add_to_rr
  8,32   1        0     0.000012153     0  m   N cfq workload slice:75
  8,32   1        0     0.000013316     0  m   N cfq8639 set_active
wl_prio:0 wl_type:2
  8,32   1        0     0.000015020     0  m   N cfq8639 fifo=(null)
  8,32   1        0     0.000015687     0  m   N cfq8639 dispatch_insert
  8,32   1        0     0.000017080     0  m   N cfq8639 dispatched a request
  8,32   1        0     0.000018087     0  m   N cfq8639 activate rq, drv=1
  8,32   1        4     0.000018408  8639  D   R 0 + 8 (   13316)
[read_write_ioct]
  8,32   0        1     0.018944185     0  C   R 0 + 8 (18925777) [0]
  8,32   0        0     0.018952148     0  m   N cfq8639 complete rqnoidle 0
  8,32   0        0     0.018953997     0  m   N cfq8639 set_slice%
  8,32   0        0     0.018955796     0  m   N cfq8639 arm_idle: 2
  8,32   0        0     0.018956267     0  m   N cfq schedule dispatch
  8,32   1        0     0.026823036     0  m   N cfq idle timer fired
  8,32   1        0     0.026824374     0  m   N cfq8639 slice expired t=0
  8,32   1        0     0.026825156     0  m   N cfq8639 sl_used=2
  8,32   1        0     0.026825912     0  m   N cfq8639 del_from_rr
  8,32   1        5     0.999061326  8639  G  RS 0 + 8 [read_write_ioct]
  8,32   1        6     0.999063356  8639  P   N [read_write_ioct]
  8,32   1        7     0.999064488  8639  I   R 0 + 8 (    3162)
[read_write_ioct]
  8,32   1        0     0.999066779     0  m   N cfq8639 insert_request
  8,32   1        0     0.999067891     0  m   N cfq8639 add_to_rr
  8,32   1        0     0.999072016     0  m   N cfq workload slice:75
  8,32   1        0     0.999073133     0  m   N cfq8639 set_active
wl_prio:0 wl_type:2
  8,32   1        0     0.999074882     0  m   N cfq8639 fifo=(null)
  8,32   1        0     0.999075484     0  m   N cfq8639 dispatch_insert
  8,32   1        0     0.999076671     0  m   N cfq8639 dispatched a request
  8,32   1        0     0.999077654     0  m   N cfq8639 activate rq, drv=1
  8,32   1        8     0.999077984  8639  D   R 0 + 8 (   13496)
[read_write_ioct]
  8,32   0        2     1.002077309     0  C   R 0 + 8 ( 2999325) [0]
  8,32   0        0     1.002085713     0  m   N cfq8639 complete rqnoidle 0
  8,32   0        0     1.002087542     0  m   N cfq8639 set_slice%
  8,32   0        0     1.002089597     0  m   N cfq8639 arm_idle: 2
  8,32   0        0     1.002090058     0  m   N cfq schedule dispatch
  8,32   1        0     1.007040509     0  m   N cfq idle timer fired
  8,32   1        0     1.007052351     0  m   N cfq8639 slice expired t=0
  8,32   1        0     1.007053173     0  m   N cfq8639 sl_used=2
  8,32   1        0     1.007053944     0  m   N cfq8639 del_from_rr
  8,32   1        9     1.007065907  8639  G   W 0 + 8 [read_write_ioct]
  8,32   1       10     1.007066649  8639  P   N [read_write_ioct]
  8,32   1       11     1.007067005  8639  I   W 0 + 8 (    1098)
[read_write_ioct]
  8,32   1        0     1.007067576     0  m   N cfq6207 insert_request
  8,32   1        0     1.007068147     0  m   N cfq6207 add_to_rr
  8,32   1       12     1.007075374  8639  G   W 350 + 8 [read_write_ioct]
  8,32   1       13     1.007075775  8639  I   W 350 + 8 (     401)
[read_write_ioct]
  8,32   1        0     1.007076361     0  m   N cfq6207 insert_request
  8,32   1       14     1.007082926  8639  G   W 700 + 8 [read_write_ioct]
  8,32   1       15     1.007083282  8639  I   W 700 + 8 (     356)
[read_write_ioct]
  8,32   1        0     1.007083733     0  m   N cfq6207 insert_request
  8,32   1       16     1.007089371  8639  G   W 1050 + 8 [read_write_ioct]
  8,32   1       17     1.007089747  8639  I   W 1050 + 8 (     376)
[read_write_ioct]
  8,32   1        0     1.007090183     0  m   N cfq6207 insert_request
  8,32   1        0     1.007091461     0  m   N cfq workload slice:30
  8,32   1        0     1.007092338     0  m   N cfq6207 set_active
wl_prio:0 wl_type:0
  8,32   1        0     1.007093200     0  m   N cfq6207 Not idling. st->count:1
  8,32   1        0     1.007093962     0  m   N cfq6207 fifo=(null)
  8,32   1        0     1.007094503     0  m   N cfq6207 dispatch_insert
  8,32   1        0     1.007095345     0  m   N cfq6207 dispatched a request
  8,32   1        0     1.007095996     0  m   N cfq6207 activate rq, drv=1
  8,32   1       18     1.007096207  8639  D   W 0 + 8 (   29202)
[read_write_ioct]
  8,32   1        0     1.007100512     0  m   N cfq6207 Not idling. st->count:1
  8,32   1        0     1.007101048     0  m   N cfq6207 dispatch_insert
  8,32   1        0     1.007101800     0  m   N cfq6207 dispatched a request
  8,32   1        0     1.007102456     0  m   N cfq6207 activate rq, drv=2
  8,32   1       19     1.007102677  8639  D   W 350 + 8 (   26902)
[read_write_ioct]
  8,32   1        0     1.007105523     0  m   N cfq6207 Not idling. st->count:1
  8,32   1        0     1.007106025     0  m   N cfq6207 dispatch_insert
  8,32   1        0     1.007106821     0  m   N cfq6207 dispatched a request
  8,32   1        0     1.007107373     0  m   N cfq6207 activate rq, drv=3
  8,32   1       20     1.007107568  8639  D   W 700 + 8 (   24286)
[read_write_ioct]
  8,32   1        0     1.007111016     0  m   N cfq6207 Not idling. st->count:1
  8,32   1        0     1.007111482     0  m   N cfq6207 dispatch_insert
  8,32   1        0     1.007112159     0  m   N cfq6207 dispatched a request
  8,32   1        0     1.007112710     0  m   N cfq6207 activate rq, drv=4
  8,32   1       21     1.007112910  8639  D   W 1050 + 8 (   23163)
[read_write_ioct]
  8,32   1       22     1.007121455  8639  G   W 1400 + 8 [read_write_ioct]
  8,32   1       23     1.007122102  8639  P   N [read_write_ioct]
  8,32   1       24     1.007122407  8639  I   W 1400 + 8 (     952)
[read_write_ioct]
  8,32   1        0     1.007122883     0  m   N cfq6207 insert_request
  8,32   1       25     1.007128747  8639  G   W 1750 + 8 [read_write_ioct]
  8,32   1       26     1.007129083  8639  I   W 1750 + 8 (     336)
[read_write_ioct]
  8,32   1        0     1.007129554     0  m   N cfq6207 insert_request
  8,32   1       27     1.007135041  8639  G   W 2100 + 8 [read_write_ioct]
  8,32   1       28     1.007135427  8639  I   W 2100 + 8 (     386)
[read_write_ioct]
  8,32   1        0     1.007135853     0  m   N cfq6207 insert_request
  8,32   1       29     1.007141521  8639  G   W 2450 + 8 [read_write_ioct]
  8,32   1       30     1.007141867  8639  I   W 2450 + 8 (     346)
[read_write_ioct]
  8,32   1        0     1.007142348     0  m   N cfq6207 insert_request
  8,32   1        0     1.007143396     0  m   N cfq6207 Not idling. st->count:1
  8,32   1        0     1.007144012     0  m   N cfq6207 dispatch_insert
  8,32   1        0     1.007144659     0  m   N cfq6207 dispatched a request
  8,32   1        0     1.007145285     0  m   N cfq6207 activate rq, drv=5
  8,32   1       31     1.007145486  8639  D   W 1400 + 8 (   23079)
[read_write_ioct]
  8,32   1        0     1.007149049     0  m   N cfq6207 Not idling. st->count:1
  8,32   1        0     1.007149595     0  m   N cfq6207 dispatch_insert
  8,32   1        0     1.007150151     0  m   N cfq6207 dispatched a request
  8,32   1        0     1.007150708     0  m   N cfq6207 activate rq, drv=6
  8,32   1       32     1.007150908  8639  D   W 1750 + 8 (   21825)
[read_write_ioct]
  8,32   1        0     1.007153775     0  m   N cfq6207 Not idling. st->count:1
  8,32   1        0     1.007154251     0  m   N cfq6207 dispatch_insert
  8,32   1        0     1.007154822     0  m   N cfq6207 dispatched a request
  8,32   1        0     1.007155383     0  m   N cfq6207 activate rq, drv=7
  8,32   1       33     1.007155579  8639  D   W 2100 + 8 (   20152)
[read_write_ioct]
  8,32   1        0     1.007158195     0  m   N cfq6207 Not idling. st->count:1
  8,32   1        0     1.007158666     0  m   N cfq6207 dispatch_insert
  8,32   1        0     1.007159287     0  m   N cfq6207 dispatched a request
  8,32   1        0     1.007159819     0  m   N cfq6207 activate rq, drv=8
  8,32   1       34     1.007160014  8639  D   W 2450 + 8 (   18147)
[read_write_ioct]
  8,32   1       35     1.007168639  8639  G   W 2800 + 8 [read_write_ioct]
  8,32   1       36     1.007169235  8639  P   N [read_write_ioct]
  8,32   1       37     1.007169526  8639  I   W 2800 + 8 (     887)
[read_write_ioct]
  8,32   1        0     1.007170007     0  m   N cfq6207 insert_request
  8,32   1       38     1.007175645  8639  G   W 3150 + 8 [read_write_ioct]
  8,32   1       39     1.007176011  8639  I   W 3150 + 8 (     366)
[read_write_ioct]
  8,32   1        0     1.007176507     0  m   N cfq6207 insert_request
  8,32   1        0     1.007267482     0  m   N cfq6207 slice expired t=0
  8,32   1        0     1.007268143     0  m   N cfq6207 sl_used=1
  8,32   1        0     1.007268940     0  m   N cfq schedule dispatch
  8,32   1        0     1.007271361     0  m   N cfq8639 put_queue
  8,32   1        0     1.007644341     0  m   N cfq6207 set_active
wl_prio:0 wl_type:0
  8,32   1        0     1.007645087     0  m   N cfq6207 Not idling. st->count:1
  8,32   1        0     1.007645984     0  m   N cfq6207 fifo=(null)
  8,32   1        0     1.007646546     0  m   N cfq6207 dispatch_insert
  8,32   1        0     1.007647383     0  m   N cfq6207 dispatched a request
  8,32   1        0     1.007648144     0  m   N cfq6207 activate rq, drv=9
  8,32   1       40     1.007648806    71  D   W 2800 + 8 (  479280) [kblockd/1]
  8,32   1        0     1.007654734     0  m   N cfq6207 Not idling. st->count:1
  8,32   1        0     1.007655256     0  m   N cfq6207 dispatch_insert
  8,32   1        0     1.007655957     0  m   N cfq6207 dispatched a request
  8,32   1        0     1.007657897     0  m   N cfq6207 activate rq, drv
  8,32   1       41     1.007658107    71  D   W 3150 + 8 (  482096) [kblockd/1]
  8,32   0        3     1.010473553     0  C   W 0 + 8 ( 3377346) [0]
  8,32   0        0     1.010485585     0  m   N cfq6207 complete rqnoidle 0
  8,32   0        0     1.010486969     0  m   N cfq6207 set_slice
  8,32   0        4     1.011653008  4284  C   W 2100 + 8 ( 4497429) [0]
  8,32   0        0     1.011660821     0  m   N cfq6207 complete rqnoidle 0
  8,32   0        5     1.013044496  8641  C   W 2450 + 8 ( 5884482) [0]
  8,32   0        0     1.013053437     0  m   N cfq6207 complete rqnoidle 0
  8,32   0        6     1.014461559     0  C   W 2800 + 8 ( 6812753) [0]
  8,32   0        0     1.014472955     0  m   N cfq6207 complete rqnoidle 0
  8,32   0        7     1.015877794     0  C   W 3150 + 8 ( 8219687) [0]
  8,32   0        0     1.015887111     0  m   N cfq6207 complete rqnoidle 0
  8,32   0        8     1.017436633     0  C   W 1750 + 8 (10285725) [0]
  8,32   0        0     1.017443338     0  m   N cfq6207 complete rqnoidle 0
  8,32   0        9     1.020186849     0  C   W 350 + 8 (13084172) [0]
  8,32   0        0     1.020195990     0  m   N cfq6207 complete rqnoidle 0
  8,32   0       10     1.021573807     0  C   W 700 + 8 (14466239) [0]
  8,32   0        0     1.021580312     0  m   N cfq6207 complete rqnoidle 0
  8,32   0       11     1.022962941  4282  C   W 1050 + 8 (15850031) [0]
  8,32   0        0     1.022971370     0  m   N cfq6207 complete rqnoidle 0
  8,32   0       12     1.024364562     0  C   W 1400 + 8 (17219076) [0]
  8,32   0        0     1.024373447     0  m   N cfq6207 complete rqnoidle 0
  8,32   0        0     1.024374209     0  m   N cfq schedule dispatch

CPU0 (sdc):
 Reads Queued:           0,        0KiB  Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB  Write Dispatches:        0,        0KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:        2,        8KiB  Writes Completed:       10,       40KiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 Read depth:             1               Write depth:            10
 IO unplugs:             0               Timer unplugs:           0
CPU1 (sdc):
 Reads Queued:           0,        0KiB  Writes Queued:           0,        0KiB
 Read Dispatches:        2,        8KiB  Write Dispatches:       10,       40KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:        0,        0KiB  Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 Read depth:             1               Write depth:            10
 IO unplugs:             0               Timer unplugs:           0

Total (sdc):
 Reads Queued:           0,        0KiB  Writes Queued:           0,        0KiB
 Read Dispatches:        2,        8KiB  Write Dispatches:       10,       40KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:        2,        8KiB  Writes Completed:       10,       40KiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 IO unplugs:             0               Timer unplugs:           0

Throughput (R/W): 7KiB/s / 39KiB/s
Events (sdc): 158 entries
Skips: 0 forward (0 -   0.0%)
Input file sdc.blktrace.0 added
Input file sdc.blktrace.1 added
