From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Wed, 01 Dec 2010 17:05:00 +0000
Subject: [PATCH 1/2] Added new execute-subcommand feature to blktrace
Message-Id: <4CF6803C.5010009@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080102070703030701050806"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------080102070703030701050806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------080102070703030701050806
Content-Type: text/x-patch;
 name="0001-Added-new-execute-subcommand-feature-to-blktrace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Added-new-execute-subcommand-feature-to-blktrace.patch"


Either via "-e" or "--execute-subcommand". The command itself (a single
argument) is passed directly to system(2). Utilizes a simplistic
semaphore mechanism to hold off the subcommand until the tracers are
kicked off.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blktrace.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 92 insertions(+), 1 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 4cccb7c..8bdaf01 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -49,6 +49,8 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <sys/sendfile.h>
+#include <sys/ipc.h>
+#include <sys/sem.h>
 
 #include "btt/list.h"
 #include "blktrace.h"
@@ -326,7 +328,14 @@ static int *cl_fds;
 static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
-#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
+/*
+ * Execute subcommand param
+ */
+static char *subcommand;
+static pid_t subcommand_pid;
+static int   subcommand_sem = -1;
+
+#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:e:"
 static struct option l_opts[] = {
 	{
 		.name = "dev",
@@ -431,6 +440,12 @@ static struct option l_opts[] = {
 		.val = 's'
 	},
 	{
+		.name = "execute-subcommand",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'e'
+	},
+	{
 		.name = NULL,
 	}
 };
@@ -450,6 +465,7 @@ static char usage_str[] = "\n\n" \
         "[ -p <port number>   | --port=<port number>]\n" \
         "[ -s                 | --no-sendfile]\n" \
         "[ -I <devs file>     | --input-devs=<devs file>]\n" \
+	"[ -e <command>       | --execute-subcommand=<command>\n" \
         "[ -v <version>       | --version]\n" \
         "[ -V <version>       | --version]\n" \
 
@@ -467,6 +483,7 @@ static char usage_str[] = "\n\n" \
 	"\t-p Network port to use (default 8462)\n" \
 	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
 	"\t-I Add devices found in <devs file>\n" \
+	"\t-e Execute a command, stop trace when completed\n" \
 	"\t-v Print program version info\n" \
 	"\t-V Print program version info\n\n";
 
@@ -544,6 +561,22 @@ static void t_pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
 
 static void unblock_tracers(void)
 {
+	if (subcommand) {
+		struct sembuf sembuf = {
+			.sem_num =  0,
+			.sem_op  =  1,
+			.sem_flg =  0
+		};
+
+		/*
+		 * Tell subcommand to get going...
+		 */
+		if (semop(subcommand_sem, &sembuf, 1) < 0) {
+			fprintf(stderr, "WARNING: Could not post semaphore\n");
+			(void)kill(subcommand_pid, SIGTERM);
+		}
+	}
+
 	pthread_mutex_lock(&mt_mutex);
 	tracers_run = 1;
 	pthread_cond_broadcast(&mt_cond);
@@ -1946,6 +1979,14 @@ static void exit_tracing(void)
 	wait_tracers();
 	del_tracers();
 	rel_devpaths();
+
+	if (subcommand) {
+		if (subcommand_pid > 0)
+			(void)kill(subcommand_pid, SIGTERM);
+
+		if (subcommand_sem >= 0)
+			(void)semctl(subcommand_sem, 0, IPC_RMID);
+	}
 }
 
 static void handle_sigint(__attribute__((__unused__)) int sig)
@@ -2130,6 +2171,9 @@ static int handle_args(int argc, char *argv[])
 		case 's':
 			net_use_sendfile = 0;
 			break;
+		case 'e':
+			subcommand = strdup(optarg);
+			break;
 		default:
 			show_usage(argv[0]);
 			exit(1);
@@ -2625,6 +2669,27 @@ static int run_tracers(void)
 	return 0;
 }
 
+static void exec_subcommand(char *cmd)
+{
+	subcommand_pid = fork();
+	if (subcommand_pid == 0) {
+		struct sembuf sembuf = {
+			.sem_num =  0,
+			.sem_op  = -1,
+			.sem_flg =  0
+		};
+
+		/*
+		 * Wait for semaphore to signal us starting the run
+		 */
+		if (semop(subcommand_sem, &sembuf, 1) < 0) {
+			fprintf(stderr, "Could not wait on sem\n");
+			exit(1);
+		}
+		exit(system(cmd));
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	int ret = 0;
@@ -2652,8 +2717,34 @@ int main(int argc, char *argv[])
 	signal(SIGHUP, handle_sigint);
 	signal(SIGTERM, handle_sigint);
 	signal(SIGALRM, handle_sigint);
+	signal(SIGCHLD, handle_sigint);
 	signal(SIGPIPE, SIG_IGN);
 
+	if (subcommand) {
+		int flags = IPC_CREAT | IPC_EXCL | 0666;
+		union semun {
+			int              val;
+			struct semid_ds *buf;
+			unsigned short  *array;
+			struct seminfo  *__buf;
+		} semun = {
+			.val = 0
+		};
+
+		subcommand_sem = semget(IPC_PRIVATE, 1, flags);
+		if (subcommand_sem < 0) {
+			fprintf(stderr, "Could not allocate semaphore\n");
+			ret = 1;
+			goto out;
+		}
+		if (semctl(subcommand_sem, 0, SETVAL, semun) < 0) {
+			fprintf(stderr, "Could not initialize semaphore\n");
+			ret = 1;
+			goto out;
+		}
+		exec_subcommand(subcommand);
+	}
+
 	if (kill_running_trace) {
 		struct devpath *dpp;
 		struct list_head *p;
-- 
1.7.1


--------------080102070703030701050806--
