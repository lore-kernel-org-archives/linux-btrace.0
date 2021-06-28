From: lijinlin <lijinlin3@huawei.com>
Date: Mon, 28 Jun 2021 13:25:40 +0000
Subject: blktrace: exit directly when nthreads_running != ncpus in run_tracers()
Message-Id: <c79af007-15eb-1ccc-5f54-ad8aa97c5c73@huawei.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: lijinlin <lijinlin3@huawei.com>

We found blktrace got stuck when cgroup restricts blktrace to use cpu,
the messages and stack is:
[root@localhost ~]# blktrace -w 10 -o- /dev/sda
FAILED to start thread on CPU 1: 22/Invalid argument
FAILED to start thread on CPU 2: 22/Invalid argument
[root@localhost ~]# cat /proc/1385110/stack
[<0>] __switch_to+0xe8/0x150
[<0>] futex_wait_queue_me+0xd4/0x158
[<0>] futex_wait+0xf4/0x230
[<0>] do_futex+0x470/0x900
[<0>] __arm64_sys_futex+0x13c/0x188
[<0>] el0_svc_common+0x80/0x200
[<0>] el0_svc_handler+0x78/0xe0
[<0>] el0_svc+0x10/0x260
[<0>] 0xffffffffffffffff

Blktrace failed to start thread is caused by thread can't lock on the
Restricted cpu. In this case, blktrace would't schedule an alarm after
defined time to set variable 'done' as 1.
We debug the code and found the call trace as bellow:
main()
   =>run_tracers()
      =>wait_tracers()
         =>process_trace_bufs()
            =>wait_empty_entries()
               =>t_pthread_cond_wait()
Blktrace was set to piped output, so the process is stuck in
wait_empty_entries() for wait variable 'done' have been set as 1.

We set variable 'done' as 1 when 'nthreads_running' is not equal to
'ncpus' in run_tracers() to fix the problem.

Signed-off-by: lijinlin <lijinlin3@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Lixiaokeng <lixiaokeng@huawei.com>
---
 blktrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/blktrace.c b/blktrace.c
index 82a6aad..3444fbb 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -2705,8 +2705,10 @@ static int run_tracers(void)
                        printf("blktrace: connected!\n");
                if (stop_watch)
                        alarm(stop_watch);
-       } else
+       } else {
                stop_tracers();
+               done = 1;
+       }

        wait_tracers();
        if (nthreads_running = ncpus)
--
2.23.0
