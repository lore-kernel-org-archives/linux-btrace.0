From: Bill Broadley <bill@broadley.org>
Date: Wed, 25 May 2011 08:48:48 +0000
Subject: Re: Seg fault in blkparse.
Message-Id: <4DDCC270.2010804@broadley.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <4DDC418E.4080407@broadley.org>
In-Reply-To: <4DDC418E.4080407@broadley.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 05/24/2011 11:19 PM, Tao Ma wrote:
> would you mind providing a tar.gz for the btrfs-12-blk.log?

Sure.  I did have the log from the previous run, but I was careful in
reproducing it and I get a slightly different result:
# blkparse rand-read-btrfs-r1-blk.log | wc -l
Bad magic 0
Bad magic 0
Bad magic 0
Bad magic 0
Out of memory, CPU info for device rand-read-btrfs-r1- (-46513984)

Which brings up another question.  I setup a btrfs with 12 32GB partitions:
# btrfs filesystem show
failed to read /dev/sr0
Label: none  uuid: 16c43865-52d8-42ec-a0c3-420f0184f622
	Total devices 12 FS bytes used 96.12GB
	devid    2 size 32.00GB used 32.00GB path /dev/sdd1
	devid    3 size 32.00GB used 32.00GB path /dev/sde1
	devid    5 size 32.00GB used 32.00GB path /dev/sdg1
	devid    6 size 32.00GB used 32.00GB path /dev/sdh1
	devid   11 size 32.00GB used 32.00GB path /dev/sdm1
	devid    8 size 32.00GB used 32.00GB path /dev/sdj1
	devid   10 size 32.00GB used 32.00GB path /dev/sdl1
	devid   12 size 32.00GB used 32.00GB path /dev/sdn1
	devid    1 size 32.00GB used 32.00GB path /dev/sdc1
	devid    4 size 32.00GB used 32.00GB path /dev/sdf1
	devid    9 size 32.00GB used 32.00GB path /dev/sdk1
	devid    7 size 32.00GB used 32.00GB path /dev/sdi1

But there's no specific device for it, so I can mount any of the devices
(/dev/sd[cdefghijklmn]1) and see the entire volume:
$ df -h /tank
Filesystem            Size  Used Avail Use% Mounted on
/dev/sdc1             385G  193G  191G  51% /tank

So obvious the btrfs mounted with /dev/sdc1 (385GB across 12 disks) is
not the same as the device /dev/sdc1 (a 32GB partition on a single disk).

So for proper btrfs usage I should monitor /dev/sdc1? Use 12 -d's to add
each device?  Use -I and list the 12 devices one per line in a file?

Oh, the requests logs as well as details for making the filesystem,
running the benchmark, and recording the blktrace is a 5.1MB file at
http://broadley.org/bill/blktrace-btrfs.tar.gz
