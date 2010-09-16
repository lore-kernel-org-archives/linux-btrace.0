From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Thu, 16 Sep 2010 11:54:05 +0000
Subject: Re: blkparse not displaying all events when tracing >1 devices?
Message-Id: <4C92055D.5070201@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4C9148BF.1000306@netezza.com>
In-Reply-To: <4C9148BF.1000306@netezza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hm, well, the problem is (I believe) that with the "-o" option just 
isn't designed to work with multiple devices.

Brett: The simplest thing to do for your example would be:

# blktrace /dev/sdbk /dev/sdam

...

# blkparse -q sdbk sdam

Basically, listing each device used on the blkparse line. [That's how I 
(and presumably everyone else) has always done it.]

The technical reason why "-o" doesn't work with multiple devices is 
because we use multiple threads of execution - one per device/CPU pair - 
and each of them opens a file named "<prefix>.blktrace.<cpu>". With the 
"-o" all of the "<prefix>" values are the same - so multiple threads 
open the same file and try to do output. Not good. Without the "-o" we 
get unique files named: "<device>.blktrace.<cpu>"  - as the tuple 
(<device>,<cpu>) is unique.

I suppose we could change the definition of "-o" to be: 
"<prefix>.<device>.blktrace.<cpu>" - but I don't know what else this 
would break. So, I think what I'll do is update the documentation to 
just note that "-o" doesn't work with multiple devices.

Regards,
Alan
