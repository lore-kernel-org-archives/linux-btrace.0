From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 16 Dec 2011 19:36:56 +0000
Subject: [PATCH 11/10] avoid string overflows
Message-Id: <4EEB9DD8.4090609@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Several places using strcpy would benefit from strncpy
for safety.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

(sorry, miscounted!)

diff --git a/blkparse.c b/blkparse.c
index 96ad666..e156546 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -562,7 +562,9 @@ static struct process_pid_map *add_ppm_hash(pid_t pid, const char *name)
 		ppm = malloc(sizeof(*ppm));
 		memset(ppm, 0, sizeof(*ppm));
 		ppm->pid = pid;
-		strcpy(ppm->comm, name);
+		memset(ppm->comm, 0, sizeof(ppm->comm));
+		strncpy(ppm->comm, name, sizeof(ppm->comm));
+		ppm->comm[sizeof(ppm->comm) - 1] = '\0';
 		ppm->hash_next = ppm_hash_table[hash_idx];
 		ppm_hash_table[hash_idx] = ppm;
 	}
diff --git a/blktrace.c b/blktrace.c
index 6c3533e..b4436b5 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -872,8 +872,9 @@ static int net_send_header(int fd, int cpu, char *buts_name, int len)
 	memset(&hdr, 0, sizeof(hdr));
 
 	hdr.magic = BLK_IO_TRACE_MAGIC;
+	memset(hdr.buts_name, 0, sizeof(hdr.buts_name));
 	strncpy(hdr.buts_name, buts_name, sizeof(hdr.buts_name));
-	hdr.buts_name[sizeof(hdr.buts_name)-1] = '\0';
+	hdr.buts_name[sizeof(hdr.buts_name) - 1] = '\0';
 	hdr.cpu = cpu;
 	hdr.max_cpus = ncpus;
 	hdr.len = len;
@@ -981,7 +982,9 @@ retry:
 		}
 
 		memcpy(&addr->sin_addr, hent->h_addr, 4);
-		strcpy(hostname, hent->h_name);
+		memset(hostname, 0, sizeof(hostname));
+		strncpy(hostname, hent->h_name, sizeof(hostname));
+		hostname[sizeof(hostname) - 1] = '\0';
 	}
 
 	return 0;
@@ -2131,7 +2134,9 @@ static int handle_args(int argc, char *argv[])
 			break;
 		case 'h':
 			net_mode = Net_client;
-			strcpy(hostname, optarg);
+			memset(hostname, 0, sizeof(hostname));
+			strncpy(hostname, optarg, sizeof(hostname));
+			hostname[sizeof(hostname) - 1] = '\0';
 			break;
 		case 'l':
 			net_mode = Net_server;


