From: Jan Blunck <jblunck@suse.de>
Date: Fri, 26 Sep 2008 08:26:09 +0000
Subject: Re: [Patch] include blktrace_api.h in headers_install
Message-Id: <20080926082609.GT15570@bolzano.suse.de>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Jul 16, Martin Peschke wrote:

> From: Sven Schuetz <sven@linux.vnet.ibm.com>
> 
> This header file is of interest for user space programming, i.e.
> for tools that process blktrace data.
> 
> We would like to use it for a tool on-top of blktrace which processes
> data provided by blktrace. For this purpose, it would be helpful
> if the blktrace API would make it to /usr/include/linux.
> 
> The git tree for the blktrace tools comes with its own copy of this header
> file. I didn't manage to replace that copy with the file generated 
> by the patch below yet. A few more cleanups would be needed.
> For example, the blktrace ioctl numbers, which are currently defined in
> usr/include/fs.h, might need to be moved. Should be feasible, though.
> 

Any reason why this patch isn't upstream yet?

Regards,
	Jan

-- 
Jan Blunck <jblunck@suse.de>
