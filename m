From: Srinivasa R Chamarthy <schamart@linux.vnet.ibm.com>
Date: Thu, 30 Jul 2009 13:33:05 +0000
Subject: Re: weird messages in blktrace pertaining to manor and minor
Message-Id: <20090730132105.GA12804@chamarthy.in.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20090730125459.GA5120@chamarthy.in.ibm.com>
In-Reply-To: <20090730125459.GA5120@chamarthy.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi Alan,

Thanks for the reply.

I am using RHEL5.4 Snap-3 with kernel version 2.6.18-158.el5 for
testing on s390x for test.

The blktrace version is:
blktrace version 1.0.0

On Thu, Jul 30, 2009 at 09:03:16AM -0400, Alan D. Brunelle wrote:
> On Thu, 2009-07-30 at 18:24 +0530, Srinivasa R Chamarthy wrote:
> > Hello,
> > 
> > I am running blktrace against scsi disks on linux. I get the
> > following output which i am not able to infer some of the messages
> > in it.
> > 
> > 2057,8440  1     8043     0.580951687  2047  A   W 14666 + 1 <-
> > (253,0) 14666
> >   8,0    1     8044     0.580951812  2047  Q   W 14666 + 1
> > [mkfs.ext3]
> >   8,0    1     8045     0.580952000  2047  M   W 14666 + 1
> > [mkfs.ext3]
> > 2057,8440  1     8046     0.580953656  2047  A   W 14667 + 1 <-
> > (253,0) 14667
> >   8,0    1     8047     0.580953781  2047  Q   W 14667 + 1
> > [mkfs.ext3]
> >   8,0    1     8048     0.580953968  2047  M   W 14667 + 1
> > [mkfs.ext3]
> > 2057,8440  1     8049     0.580955406  2047  A   W 14668 + 1 <-
> > (253,0) 14668
> >   8,0    1     8050     0.580955718  2047  Q   W 14668 + 1
> > [mkfs.ext3]
> > 
> > For some of the lines, it shows the list of major and minor numbers
> > (2057,8440) which are not there applicable to my system. I am not
> > able to understand the output pertaining to these numbers and i do
> > not find any documentation about them. Can anybody let me know what
> > this output means?
> > 
> > I have run blktrace as following:
> > 
> > blktrace -d /dev/sda /dev/sdb -o - | blkparse -i -
> > 
> > and ran mkfs.ext3 to the scsi disks.
> > 
> 
> What Linux version are you using? Issues in MD/DM mappings were fixed in
> kernels post-RHEL5/SLES10 for example. 
> 
> Alan
> 

-- 
Srinivasa R Chamarthy (schamart@linux.vnet.ibm.com)
---------------------------------------------------
Linux on System z (Component & System Verification),
IBM India Systems and Technology Labs, Bangalore.
+91-80-41776451 / ITN: *869246992
