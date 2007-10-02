From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 02 Oct 2007 17:54:29 +0000
Subject: Re: [PATCH] Add btrecord/btreplay capability
Message-Id: <20071002175429.GO5236@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <47027480.2040408@hp.com>
In-Reply-To: <47027480.2040408@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Oct 02 2007, Alan D. Brunelle wrote:
> 

> From d5095b9054fb40e33a76bc790e6ce459c9a0ee91 Mon Sep 17 00:00:00 2001
> From: Alan D. Brunelle <Alan.Brunelle@hp.com>
> Date: Tue, 2 Oct 2007 12:35:07 -0400
> Subject: [PATCH] Add btrecord/btreplay capability
> 
> These facilities allow one to attempt to replay a stream of IOs
> captured with blktrace. The general workflow is:
> 
> 1. Initiate blktrace to capture traces
> 2. Do whatever to generate initial IO stream...
> 3. Stop blktrace
> 4. Run btrecord to convert traces into IO records
> 5. Run btreplay to replay IOs
> 
> The IO stream characteristics during replay will try to respect the
> following characteristics of the original IO stream:
> 
> 1. The IOs will target the same device(s) as originally seen. [One can
>    alter this behavior by specifyin the -M option to btreplay, which
>    allows one to remap IOs slated to one set of devices to a specified
>    other set of devices.]
> 
> 2. IO direction: the IOs will follow the same read/write
>    (from-device/to-device) characteristics of the originating flow. [Note:
>    By default replay will /not/ do writes, one must specify the -W option
>    to do this. THis is a meager attempt to stop someone from shooting
>    themselves in the foot (with a very large-caliber weapon).]
> 
> 3. IO offset & size are maintained.
> 
> 4. CPU: IOs are submitted on the originating CPU whenever possible. [Note:
>    Since we are using asynchronous IO, IOs may be routed to another CPU
>    prior to being processed by the block IO layer.]
> 
> In order to try and replicate inter-IO timing as much as possible,
> btrecord will combine IOs "close in time" into one set, or bunch, of
> IOs. Then btreplay will replay all the IOs in one go (via asynchronous
> direct IO - io_submit). The size of the bunches are configurable via
> the -m flag to btrecord (which specifies the a time-based bunch size)
> and/or the -M flag (which specifies the maximum amount of IOs to put
> into a bunch). At the low-end, specifying '-M 1' instructs btrecord to
> act like fio - replay each IO as an individual unit.
> 
> Besides the potential to remap devices (utilizing the -M option to replay,
> as noted above), one can also limit the number of CPUs on the replay
> machine - so if you have fewer CPUs on the replay machine you specify
> the -c option to btreplay.
> 
> Lastly, one can specify the -N option to btreplay to instruct it to ignore
> inter-IO (inter-bunch of IOs) timings. Thus, this instructs btreplay
> to replay the bunches as fast as possible, ignoring the original delays
> between original IOs.
> 
> The utilities include a write-up in the docs directory.

This looks pretty nifty and useful. I've applied both your patches. They
do have a few build warnings here, involving fatal():

btrecord.c: In function 'stream_open':
btrecord.c:685: warning: the address of 'ofile_name' will always
evaluate as 'true'
btrecord.c:704: warning: the address of 'vfile_name' will always
evaluate as 'true'

btreplay.c: In function 'tip_init':
btreplay.c:783: warning: the address of 'fn' will always evaluate as
'true'
btreplay.c: In function 'replay_sub':
btreplay.c:1314: warning: the address of 'path' will always evaluate as
'true'

-- 
Jens Axboe

