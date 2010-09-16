From: Brett Russ <bruss@netezza.com>
Date: Thu, 16 Sep 2010 14:20:51 +0000
Subject: Re: [PATCH] blktrace: disallow -o when using multiple devices
Message-Id: <4C9227C3.7000404@netezza.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 09/16/2010 08:33 AM, Alan D. Brunelle wrote:
> Document that "-o" does not work when specyfing multiple devices to
> blktrace, also: enforce this by stopping blktrace when one tries do
> do this.
>
> The technical reason why "-o" doesn't work with multiple devices is
> because we use multiple threads of execution - one per device/CPU pair -
> and each of them opens a file named "<prefix>.blktrace.<cpu>". With the
> "-o" all of the"<prefix>" values are the same - so multiple threads
> open the same file and try to do output. Not good. Without the "-o"
> we get unique files named: "<device>.blktrace.<cpu>"  - as the tuple
> (<device>,<cpu>) is unique.

Alan,

-Wouldn't it be a good idea to just add <prefix> before the filename(s) 
that would have been created in either the single or multiple device 
case?  I.e. in the multiple device case, how about 
"<prefix>.<device>.blktrace.<cpu>"?  That way the program always does 
what the user wants, no special case documentation required.

-I just tested that the blktrace "-D" option (output dir, create if 
doesn't exist) works for the multiple device case as long as the -o 
option isn't also used.  So, this is another alternative.

-I found the following inconsistencies between the doc and the command 
line help, these would probably be a separate patch:
--blktrace
---doc is missing -[Dhlps]
---doc still contains deprecated option -k
--blkparse
---doc is missing -[aAD]
---doc still contains deprecated option -m


Thanks,
Brett
