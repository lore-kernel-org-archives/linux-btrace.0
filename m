From: lijinlin <lijinlin3@huawei.com>
Date: Tue, 29 Jun 2021 03:20:45 +0000
Subject: blktrace: Fix memleak problem in get_online_cpus()
Message-Id: <21a48263-5adc-aae6-4293-d122bc2421d2@huawei.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <c98e5ed4-432a-3630-129c-bd56efbed9c5@huawei.com>
In-Reply-To: <c98e5ed4-432a-3630-129c-bd56efbed9c5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: lijinlin <lijinlin3@huawei.com>

In get_online_cpus(), after cpu_nums is alloced memory successfully,
there are two return paths which don't free(cpu_nums).

Signed-off-by: lijinlin <lijinlin3@huawei.com>
---
 blktrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/blktrace.c b/blktrace.c
index 3444fbb..f1f646a 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -2759,6 +2759,7 @@ static cpu_set_t *get_online_cpus(void)
                while (prevcpuid <= cpuid) {
                        /* More CPUs listed than configured? */
                        if (curcpu >= ncpu) {
+                               free(cpu_nums);
                                errno = EINVAL;
                                return NULL;
                        }
@@ -2774,6 +2775,7 @@ static cpu_set_t *get_online_cpus(void)
        /* Now that we have maximum cpu number, create a cpuset */
        set = CPU_ALLOC(max_cpus);
        if (!set) {
+               free(cpu_nums);
                errno = ENOMEM;
                return NULL;
        }
--
2.23.0
