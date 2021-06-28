From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Jun 2021 19:42:07 +0000
Subject: Re: blktrace: exit directly when nthreads_running != ncpus in run_tracers()
Message-Id: <272f5ec1-4e51-8f33-15ae-ceb7d84f252f@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <c79af007-15eb-1ccc-5f54-ad8aa97c5c73@huawei.com>
In-Reply-To: <c79af007-15eb-1ccc-5f54-ad8aa97c5c73@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 6/28/21 7:25 AM, lijinlin wrote:
> From: lijinlin <lijinlin3@huawei.com>
> 
> We found blktrace got stuck when cgroup restricts blktrace to use cpu,
> the messages and stack is:
> [root@localhost ~]# blktrace -w 10 -o- /dev/sda
> FAILED to start thread on CPU 1: 22/Invalid argument
> FAILED to start thread on CPU 2: 22/Invalid argument
> [root@localhost ~]# cat /proc/1385110/stack
> [<0>] __switch_to+0xe8/0x150
> [<0>] futex_wait_queue_me+0xd4/0x158
> [<0>] futex_wait+0xf4/0x230
> [<0>] do_futex+0x470/0x900
> [<0>] __arm64_sys_futex+0x13c/0x188
> [<0>] el0_svc_common+0x80/0x200
> [<0>] el0_svc_handler+0x78/0xe0
> [<0>] el0_svc+0x10/0x260
> [<0>] 0xffffffffffffffff
> 
> Blktrace failed to start thread is caused by thread can't lock on the
> Restricted cpu. In this case, blktrace would't schedule an alarm after
> defined time to set variable 'done' as 1.
> We debug the code and found the call trace as bellow:
> main()
>    =>run_tracers()
>       =>wait_tracers()
>          =>process_trace_bufs()
>             =>wait_empty_entries()
>                =>t_pthread_cond_wait()
> Blktrace was set to piped output, so the process is stuck in
> wait_empty_entries() for wait variable 'done' have been set as 1.
> 
> We set variable 'done' as 1 when 'nthreads_running' is not equal to
> 'ncpus' in run_tracers() to fix the problem.

Applied, thanks.

-- 
Jens Axboe
