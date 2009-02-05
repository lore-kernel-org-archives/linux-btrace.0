From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 05 Feb 2009 11:42:00 +0000
Subject: Re: blktrace2: Fully working variant... Needs testing... :-)
Message-Id: <498AD088.4070000@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <498A0D14.3080000@hp.com>
In-Reply-To: <498A0D14.3080000@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Alan D. Brunelle wrote:
> I'm seeing some positive results on my 16-way amd64 box (w/ 48 FC disks
> & 48 CCISS disks) - less intrusive blktrace()ing, resulting in more
> benchmark through put for example.
> 
> It seems to be pretty valgrind clean (only issue I've seen is in
> inet_ntoa: man page says it uses static storage, but valgrind claims it
> uses malloc - nothing for us to be concerned with).
> 
> Anyways, I'm putting this out there whilst I do some more testing to
> verify things.
> 

Some good news: doing my previously reported testing on the balanced
configuration completed successfully. (mkfs on large numbers of CCISS
disks, tracing to a large number of FC disks)

What is more, it appears to be a little better in terms of fewer drops &
fewer drop cases - results below are in percent drops:

blktrace:

  -b      4     8    16    32    64   128   256   512  1024  2048  4096
-n   |----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
    4|                                            4.4   0.0   0.0   0.0
    8|                                      1.5   0.0
   16|                                0.1         0.0
   32|                          0.8               0.0
   64|                    1.1
  128|              0.8
  256|        2.6
  512|  2.3
 1024|  0.5
 2048|  0.1
 4096|  0.0

blktrace2:

  -b     4     8    16    32    64   128   256   512  1024  2048  4096
-n   |----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
    4|                                            0.2   0.0   0.0   0.0
    8|                                      0.1   0.0
   16|                                0.0         0.0
   32|                          0.0               0.0
   64|                    0.1
  128|              0.1
  256|        0.1
  512|  0.2
 1024|  0.0
 2048|  0.0
 4096|  0.0

 The goal now will be to try and see if I can wiggle out the remaining
 0.1 or 0.2% drops...

 Alan
