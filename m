From: Edward Shishkin <edward@redhat.com>
Date: Mon, 04 Jul 2011 12:30:38 +0000
Subject: [PATCH 1/1] blktrace: disable blktrace kill option carefully
Message-Id: <1309782638.8616.24.camel@zeta.englab.brq.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Disable blktrace kill option, which works incorrectly:

Description of problem:
'blktrace -d <device> -k' does not kill a running trace.
blktrace process is still running. Moreover something
bad happens, because after executing 'blktrace -d
<device> -k' for the second time blktrace works improperly.

Steps to reproduce the problem (example):

# mount -t debugfs debugfs /sys/kernel/debug/
# cat /proc/partitions
major minor  #blocks  name

   8     0   78150744 sda
   8     1     104391 sda1
   8     2   78043770 sda2
 253     0   76218368 dm-0
 253     1    1802240 dm-1
# blktrace -d /dev/sda &
[1] 2770
# ps -o pid,user,args -C blktrace
  PID USER     COMMAND
 2770 root     blktrace -d /dev/sda
# blktrace -d /dev/sda -k
# ps -o pid,user,args -C blktrace
  PID USER     COMMAND
 2770 root     blktrace -d /dev/sda
# blktrace -d /dev/sda -k
BLKTRACETEARDOWN: Invalid argument
# ps -o pid,user,args -C blktrace
  PID USER     COMMAND
 2770 root     blktrace -d /dev/sda

Signed-off-by: Edward Shishkin <edward@redhat.com>
---
 blktrace.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: blktrace/blktrace.c
=================================--- blktrace.orig/blktrace.c	2011-07-04 14:02:02.000000000 +0200
+++ blktrace/blktrace.c	2011-07-04 14:36:26.197174682 +0200
@@ -364,12 +364,14 @@
 		.flag = NULL,
 		.val = 'o'
 	},
+#if 0
 	{
 		.name = "kill",
 		.has_arg = no_argument,
 		.flag = NULL,
 		.val = 'k'
 	},
+#endif
 	{
 		.name = "stopwatch",
 		.has_arg = required_argument,
@@ -2089,9 +2091,11 @@
 		case 'o':
 			output_name = optarg;
 			break;
+#if 0
 		case 'k':
 			kill_running_trace = 1;
 			break;
+#endif
 		case 'w':
 			stop_watch = atoi(optarg);
 			if (stop_watch <= 0) {


