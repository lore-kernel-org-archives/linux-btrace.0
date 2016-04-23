From: Roman Pen <r.peniaev@gmail.com>
Date: Sat, 23 Apr 2016 11:44:10 +0000
Subject: [PATCH 3/3] btreplay: make Ctrl-C work
Message-Id: <1461411850-25443-3-git-send-email-r.peniaev@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

is_reap_done() must also check that SIGINT or SIGTERM have come, or
we hang forever with such backtraces after Ctrl-C:

 (gdb) thr a a bt

 Thread 3 (Thread 0x7fbff8ff9700 (LWP 12607)):
 #0  pthread_cond_wait@@GLIBC_2.3.2 () at ../sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
 #1  0x0000000000402698 in replay_rec () at btreplay.c:1035
 #2  0x00007fc001fe5454 in start_thread () from /lib/x86_64-linux-gnu/libpthread.so.0
 #3  0x00007fc001d1eecd in ?? () from /lib/x86_64-linux-gnu/libc.so.6
 #4  0x0000000000000000 in ?? ()

 Thread 2 (Thread 0x7fbfea7fc700 (LWP 12611)):
 #0  pthread_cond_wait@@GLIBC_2.3.2 () at ../sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
 #1  0x0000000000402698 in replay_rec () at btreplay.c:1035
 #2  0x00007fc001fe5454 in start_thread () from /lib/x86_64-linux-gnu/libpthread.so.0
 #3  0x00007fc001d1eecd in ?? () from /lib/x86_64-linux-gnu/libc.so.6
 #4  0x0000000000000000 in ?? ()

 Thread 1 (Thread 0x7fc00282e700 (LWP 12597)):
 #0  pthread_cond_wait@@GLIBC_2.3.2 () at ../sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
 #1  0x0000000000402303 in __wait_cv () at btreplay.c:413
 #2  0x0000000000401ae8 in main () at btreplay.c:426

Signed-off-by: Roman Pen <r.peniaev@gmail.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: <linux-btrace@vger.kernel.org>
---
 btreplay/btreplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index 5bf47ff..321851c 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -275,7 +275,7 @@ static inline int is_send_done(struct thr_info *tip)
  */
 static inline int is_reap_done(struct thr_info *tip)
 {
-	return tip->send_done && tip->naios_out = 0;
+	return signal_done || (tip->send_done && tip->naios_out = 0);
 }
 
 /**
-- 
2.7.4

