From: Lakshmi <sendtold@gmail.com>
Date: Wed, 04 Dec 2013 16:02:37 +0000
Subject: Blktrace with read filter shows events with N for PIDs 0
Message-Id: <CAEyTGCdPR3tBKv3R5Shrm_O=HL21VLjNGfedO5EC4OoHwcpx9Q@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

I ran a blktrace with -a read mask and when i parsed it to txt
file,Along with Reads (R) I also see lots of Ns in the RWBS field.
What does this mean and how do I filter only the reads or writes in
this case?

The Blktrace and Blkparse statements I used are

blktrace -w 130 -d /dev/sdb -a read -b 4096 -o 4K_RR_Trace

blkparse
  blkparse -i ./*.blktrace.0 -d ./bp.bin -o bp.txt -w 0:130



  8,16  12        1     0.000000000  8632  Q   R 0 + 128 [vgdisplay]
  8,16  12        0     0.000008612     0  m     N cfq8632S / alloced
  8,16  12        2     0.000008807  8632  G   R 0 + 128 [vgdisplay]
  8,16  12        3     0.000009475  8632  P   N [vgdisplay]
  8,16  12        4     0.000009686  8632  I     R 0 + 128 [vgdisplay]
  8,16  12        0     0.000010338     0  m     N cfq8632S / insert_request
  8,16  12        0     0.000010901     0  m     N cfq8632S / add_to_rr
  8,16  12        0     0.000011620     0  m      N cfq8632S / idle=0
  8,16  12        5     0.000011907  8632  U    N [vgdisplay] 1
  8,16  12        0     0.000012643     0  m     N cfq workload slice:30

Please help.

Thanks
