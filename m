From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 18 Nov 2021 02:32:53 +0000
Subject: Re: Question regarding output of btrace and use of blk-mq
Message-Id: <59446380-a449-aada-61ab-d791f4839660@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <SJ0PR11MB58966D3BE29649A350F098AEC39B9@SJ0PR11MB5896.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB58966D3BE29649A350F098AEC39B9@SJ0PR11MB5896.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org

On 11/17/21 7:17 PM, Karan Tilak Kumar (kartilak) wrote:
> Hello btrace community,
> 
> I came across blktrace and blkparse tools as a part of my learning on blk-mq. 
> I'm trying to test some code in my driver and I want to test a few things by turning multiqueue on and off, and compare results.
> I'm running IOs using medusa on my multipath device /dev/dm-2
> 
> When I turn off mq, I still see IOs queued from each CPU:
> 
> CPU0 (dm-2):
> Reads Queued:       1,980,  199,438KiB  Writes Queued:       1,344,  172,032KiB
> Read Dispatches:    3,429,  199,894KiB  Write Dispatches:    2,688,  172,032KiB
> Reads Requeued:         0               Writes Requeued:         0
> Reads Completed:    6,826,  199,130KiB  Writes Completed:    5,376,  172,032KiB
> Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
> Read depth:            70               Write depth:            64
> IO unplugs:         3,177               Timer unplugs:           0
> CPU1 (dm-2):
> Reads Queued:       2,101,  247,313KiB  Writes Queued:       1,856,  237,568KiB
> Read Dispatches:    3,986,  247,177KiB  Write Dispatches:    3,709,  237,376KiB
> Reads Requeued:         0               Writes Requeued:         0
> Reads Completed:    7,975,  247,177KiB  Writes Completed:    7,545,  241,344KiB
> Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
> Read depth:            70               Write depth:            64
> IO unplugs:         3,899               Timer unplugs:           0
> CPU2 (dm-2):
> Reads Queued:       1,907,  224,925KiB  Writes Queued:       1,760,  225,280KiB
> Read Dispatches:    3,635,  224,793KiB  Write Dispatches:    3,524,  225,536KiB
> Reads Requeued:         0               Writes Requeued:         0
> Reads Completed:    7,273,  224,793KiB  Writes Completed:    7,044,  225,536KiB
> Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
> Read depth:            70               Write depth:            64
> IO unplugs:         3,625               Timer unplugs:           1
> CPU3 (dm-2):
> Reads Queued:       1,572,  173,940KiB  Writes Queued:       1,408,  180,224KiB
> Read Dispatches:    2,885,  173,753KiB  Write Dispatches:    2,815,  180,160KiB
> Reads Requeued:         0               Writes Requeued:         0
> Reads Completed:    5,766,  173,541KiB  Writes Completed:    5,631,  180,160KiB
> Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
> Read depth:            70               Write depth:            64
> IO unplugs:         2,922               Timer unplugs:           0
> 
> 
> #cat /sys/module/scsi_mod/parameters/use_blk_mq
> N
> #cat /sys/module/dm_mod/parameters/use_blk_mq
> N
> 
> 
> When multiqueue is off, we don't expect IOs from all CPUs. Is this correct?
> I've tried running medusa with one thread, and with eight threads on separate occasions, and I see IOs from all CPUs each time.
> Is this expected? Please advise.

Yes this is expected, non blk-mq will still submit from any CPU that happens
to be issuing the IO.

-- 
Jens Axboe
