From: Ming Zhang <blackmagic02881@gmail.com>
Date: Thu, 14 Feb 2008 03:44:19 +0000
Subject: how to explain this blktrace data and speed result?
Message-Id: <1202960659.4061.27.camel@localhost.localdomain>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi All

Try to gain some idea here. I got very different dd result on write to a
whole disk and a partition in the disk.

i intentionally write small data, assumed they should go to page cache
and return very fast. but not.

#  dd if=/dev/zero of=/dev/sdq1 bs=1M count=4 seek=2 
4+0 records in
4+0 records out
4194304 bytes (4.2 MB) copied, 0.262441 seconds, 16.0 MB/s

#  dd if=/dev/zero of=/dev/sdq bs=1M count=4 seek=2 
4+0 records in
4+0 records out
4194304 bytes (4.2 MB) copied, 0.136515 seconds, 30.7 MB/s

so writing to whole disk is 2 time faster than writing to a partition.
Kernel is 2.6.22.15, reboot to RHEL5 kernel, same result.

fdisk shows.

Disk /dev/sdq: 430.2 GB, 430244364288 bytes
255 heads, 63 sectors/track, 52307 cylinders, total 840321024 sectors
Units = sectors of 1 * 512 = 512 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdq1             128   840311954   420155913+  83  Linux

by using blktrace, i found that writing to whole disk /dev/sdq almost
finish immediately and blktrace show nothing, until couple seconds later
that show io with 8 sector in size and process is pdflush. but write to
partition then blktrace show data immediately, in dd process context.
and most data show like

 65,0    1     8238     0.008146979  6006  Q   W 12325 + 2 [dd]
 65,0    1     8239     0.008147222  6006  M   W 12325 + 2 [dd]
 65,0    1     8240     0.008147741  6006  Q   W 12327 + 2 [dd]
 65,0    1     8241     0.008147975  6006  M   W 12327 + 2 [dd]
 65,0    1     8242     0.008148485  6006  Q   W 12329 + 2 [dd]
 65,0    1     8243     0.008148758  6006  M   W 12329 + 2 [dd]
 65,0    1     8244     0.008149271  6006  Q   W 12331 + 2 [dd]

no idea why here the request size is so small... try to check the call
path and see where limit the size, but did not have any luck.

then by adjusting the partition starting offset, i see different request
size here range from +1 to +2 to +8.... but no matter what, all go
inline in dd process context.

so why starting offset make such big difference? one would assume that
make partition align to power of 2 will make it faster, but ironically
make it odd will get +8 or +4 while even offset always get +1.


another big surprise, by blktracing a partition, io becomes "faster"...

here is ./blktrace -d /dev/sdq -o - |./blkparse -i -

[root@ks02 ~]#  dd if=/dev/zero of=/dev/sdq bs=1M count=4 seek=2 
4+0 records in
4+0 records out
4194304 bytes (4.2 MB) copied, 0.00300966 seconds, 1.4 GB/s

which make writing to whole disk faster but to partition unchanged.

but when using ./blktrace -d /dev/sdq1 -o - |./blkparse -i -

write to partition is faster too.
[root@ks02 ~]#  dd if=/dev/zero of=/dev/sdq1 bs=1M count=4 seek=2 
4+0 records in
4+0 records out
4194304 bytes (4.2 MB) copied, 0.00397497 seconds, 1.1 GB/s

also changing scheduler does not matter...


so by using blktrace, page cache is enabled...

any idea?   if need more data or test run, let me know


-- 
Ming Zhang


@#$%^ purging memory... (*!%
http://blackmagic02881.wordpress.com/
http://www.linkedin.com/in/blackmagic02881
--------------------------------------------

