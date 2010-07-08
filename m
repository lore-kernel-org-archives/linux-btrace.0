From: Edward Shishkin <edward@redhat.com>
Date: Thu, 08 Jul 2010 13:27:31 +0000
Subject: [patch] blktrace: unblock tracers in the case of unsuccess
Message-Id: <4C35D243.3050109@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010501080808050902040504"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------010501080808050902040504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.
Please consider/apply
Thanks

-- 
Edward O. Shishkin
Principal Software Engineer
Red Hat Czech


--------------010501080808050902040504
Content-Type: text/plain;
 name="7-blktrace-fix-595356.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="7-blktrace-fix-595356.patch"

Fixup for bz 595356
Problem. Steps to Reproduce:
---
# blktrace -d /dev/sda -w 30
# rm -f sda.blktrace.0
# mkdir sda.blktrace.0
# blktrace -d /dev/sda -w 30
Open output file ./sda.blktrace.0 failed: 21/Is a directory
FAILED to start thread on CPU 0: 1/Operation not permitted

blktrace does not end after 30 seconds, it will be running
until you kill it. Moreover, next attempts to run blktrace
failed with error.

The bug:
---
If open_ios() fails, then tracer_wait_unblock() in the
thread_main() waits for event, wich will never occur:
in the case of unsuccess tracers are not unblocked.

Fixup:
---
Make sure unblock_tracers() is also called in the case on
unsuccess (when nthreads_running != ncpus).
---

Signed-off-by: Edward Shishkin <edward@redhat.com>
---

--- blktrace-1.0.1.orig/blktrace.c
+++ blktrace-1.0.1/blktrace.c
@@ -1848,7 +1848,7 @@
 
 	for (cpu = 0; cpu < ncpus; cpu++)
 		if (start_tracer(cpu))
-			break;
+			return;
 
 	wait_tracers_ready(cpu);
 
@@ -2589,8 +2589,8 @@
 	}
 
 	start_tracers();
-	if (nthreads_running == ncpus) {
-		unblock_tracers();
+	unblock_tracers();
+ 	if (nthreads_running == ncpus) {
 		start_buts();
 		if (net_mode == Net_client)
 			printf("blktrace: connected!\n");

--------------010501080808050902040504--
