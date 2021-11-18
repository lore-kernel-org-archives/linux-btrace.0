From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
Date: Thu, 18 Nov 2021 02:17:23 +0000
Subject: Question regarding output of btrace and use of blk-mq
Message-Id: <SJ0PR11MB58966D3BE29649A350F098AEC39B9@SJ0PR11MB5896.namprd11.prod.outlook.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

Hello btrace community,

I came across blktrace and blkparse tools as a part of my learning on blk-m=
q.=20
I'm trying to test some code in my driver and I want to test a few things b=
y turning multiqueue on and off, and compare results.
I'm running IOs using medusa on my multipath device /dev/dm-2

When I turn off mq, I still see IOs queued from each CPU:

CPU0 (dm-2):
Reads Queued:=A0=A0=A0=A0=A0=A0 1,980,=A0 199,438KiB=A0 Writes Queued:=A0=
=A0=A0=A0=A0=A0 1,344,=A0 172,032KiB
Read Dispatches:=A0=A0=A0 3,429,=A0 199,894KiB=A0 Write Dispatches:=A0=A0=
=A0 2,688,=A0 172,032KiB
Reads Requeued:=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Writes Requeued:=A0=A0=A0=A0=A0=A0=A0=A0 0
Reads Completed:=A0=A0=A0 6,826,=A0 199,130KiB=A0 Writes Completed:=A0=A0=
=A0 5,376,=A0 172,032KiB
Read Merges:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,=A0=A0=A0=A0=A0=A0=A0 0KiB=
=A0 Write Merges:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,=A0=A0=A0=A0=A0=A0=A0 =
0KiB
Read depth:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 70=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Write depth:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64
IO unplugs:=A0=A0=A0=A0=A0=A0=A0=A0 3,177=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Timer unplugs:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
CPU1 (dm-2):
Reads Queued:=A0=A0=A0=A0=A0=A0 2,101,=A0 247,313KiB=A0 Writes Queued:=A0=
=A0=A0=A0=A0=A0 1,856,=A0 237,568KiB
Read Dispatches:=A0=A0=A0 3,986,=A0 247,177KiB=A0 Write Dispatches:=A0=A0=
=A0 3,709,=A0 237,376KiB
Reads Requeued:=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Writes Requeued:=A0=A0=A0=A0=A0=A0=A0=A0 0
Reads Completed:=A0=A0=A0 7,975,=A0 247,177KiB=A0 Writes Completed:=A0=A0=
=A0 7,545,=A0 241,344KiB
Read Merges:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,=A0=A0=A0=A0=A0=A0=A0 0KiB=
=A0 Write Merges:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,=A0=A0=A0=A0=A0=A0=A0 =
0KiB
Read depth:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 70=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Write depth:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64
IO unplugs:=A0=A0=A0=A0=A0=A0=A0=A0 3,899=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Timer unplugs:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
CPU2 (dm-2):
Reads Queued:=A0=A0=A0=A0=A0=A0 1,907,=A0 224,925KiB=A0 Writes Queued:=A0=
=A0=A0=A0=A0=A0 1,760,=A0 225,280KiB
Read Dispatches:=A0=A0=A0 3,635,=A0 224,793KiB=A0 Write Dispatches:=A0=A0=
=A0 3,524,=A0 225,536KiB
Reads Requeued:=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Writes Requeued:=A0=A0=A0=A0=A0=A0=A0=A0 0
Reads Completed:=A0=A0=A0 7,273,=A0 224,793KiB=A0 Writes Completed:=A0=A0=
=A0 7,044,=A0 225,536KiB
Read Merges:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,=A0=A0=A0=A0=A0=A0=A0 0KiB=
=A0 Write Merges:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,=A0=A0=A0=A0=A0=A0=A0 =
0KiB
Read depth:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 70=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Write depth:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64
IO unplugs:=A0=A0=A0=A0=A0=A0=A0=A0 3,625=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Timer unplugs:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
CPU3 (dm-2):
Reads Queued:=A0=A0=A0=A0=A0=A0 1,572,=A0 173,940KiB=A0 Writes Queued:=A0=
=A0=A0=A0=A0=A0 1,408,=A0 180,224KiB
Read Dispatches:=A0=A0=A0 2,885,=A0 173,753KiB=A0 Write Dispatches:=A0=A0=
=A0 2,815,=A0 180,160KiB
Reads Requeued:=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Writes Requeued:=A0=A0=A0=A0=A0=A0=A0=A0 0
Reads Completed:=A0=A0 =A05,766,=A0 173,541KiB=A0 Writes Completed:=A0=A0=
=A0 5,631,=A0 180,160KiB
Read Merges:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,=A0=A0=A0=A0=A0=A0=A0 0KiB=
=A0 Write Merges:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,=A0=A0=A0=A0=A0=A0=A0 =
0KiB
Read depth:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 70=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Write depth:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64
IO unplugs:=A0=A0=A0=A0=A0=A0=A0=A0 2,922=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Timer unplugs:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0


#cat /sys/module/scsi_mod/parameters/use_blk_mq
N
#cat /sys/module/dm_mod/parameters/use_blk_mq
N


When multiqueue is off, we don't expect IOs from all CPUs. Is this correct?
I've tried running medusa with one thread, and with eight threads on separa=
te occasions, and I see IOs from all CPUs each time.
Is this expected? Please advise.

Thanks,
Karan

