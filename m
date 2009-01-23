From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 23 Jan 2009 14:06:23 +0000
Subject: [PATCH tip 1/2] ftrace: Add ftrace_vprintk
Message-Id: <20090123140623.GC21737@ghostprotocols.net>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org

Impact: New API

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/ftrace.h |    8 ++++++++
 kernel/trace/trace.c   |    9 +++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9f7880d..7840e71 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -302,6 +302,9 @@ ftrace_special(unsigned long arg1, unsigned long arg2, unsigned long arg3);
 extern int
 __ftrace_printk(unsigned long ip, const char *fmt, ...)
 	__attribute__ ((format (printf, 2, 3)));
+# define ftrace_vprintk(fmt, ap) __ftrace_printk(_THIS_IP_, fmt, ap)
+extern int
+__ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
 extern void ftrace_dump(void);
 #else
 static inline void
@@ -317,6 +320,11 @@ ftrace_printk(const char *fmt, ...)
 {
 	return 0;
 }
+static inline int
+ftrace_vprintk(const char *fmt, va_list ap)
+{
+	return 0;
+}
 static inline void ftrace_dump(void) { }
 #endif
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2129ab9..2f8ac1f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2951,6 +2951,15 @@ int __ftrace_printk(unsigned long ip, const char *fmt, ...)
 }
 EXPORT_SYMBOL_GPL(__ftrace_printk);
 
+int __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap)
+{
+	if (!(trace_flags & TRACE_ITER_PRINTK))
+		return 0;
+
+	return trace_vprintk(ip, task_curr_ret_stack(current), fmt, ap);
+}
+EXPORT_SYMBOL_GPL(__ftrace_vprintk);
+
 static int trace_panic_handler(struct notifier_block *this,
 			       unsigned long event, void *unused)
 {
-- 
1.6.0.6

