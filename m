From: Jens Axboe <jaxboe@fusionio.com>
Date: Thu, 02 Feb 2012 05:00:02 +0000
Subject: Recent changes
Message-Id: <20120202050002.C7229484005@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 7f0062f7b893a80afbe0e43f5db157c7bc1a01f9:

  blktrace 1.0.4 (2012-01-31 10:53:21 +0100)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Eric Sandeen (10):
      Check setvbuf return value
      Fix potential array overrun in act_to_str
      Free pdu_buff on bad pdu path in process()
      Close stream in 'I' switch handling
      Remove extraneous malloc in find_input routines
      Fix several leaks on error paths
      btt: close devmap file after processing
      blkparse: initialize cpu_map
      blktrace: remove unused variable
      avoid string overflows

Jens Axboe (1):
      Fix compiler warnings

 blkparse.c          |    5 ++++-
 blkrawverify.c      |    3 ++-
 blktrace.c          |   27 +++++++++++++++++++--------
 btreplay/btrecord.c |    2 +-
 btreplay/btreplay.c |    2 +-
 btt/aqd.c           |    2 ++
 btt/bno_dump.c      |    5 +++--
 btt/devmap.c        |    1 +
 btt/plat.c          |    2 ++
 btt/proc.c          |    3 +--
 btt/seek.c          |   20 +++++++++-----------
 btt/trace_queue.c   |    2 +-
 12 files changed, 46 insertions(+), 28 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 0f8d135..b0b88c3 100644
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
@@ -1962,6 +1964,7 @@ static int check_cpu_map(struct per_dev_info *pdi)
 	 * create a map of the cpus we have traces for
 	 */
 	cpu_map = malloc(pdi->cpu_map_max / sizeof(long));
+	memset(cpu_map, 0, sizeof(*cpu_map));
 	n = rb_first(&rb_sort_root);
 	while (n) {
 		__t = rb_entry(n, struct trace, rb_node);
diff --git a/blkrawverify.c b/blkrawverify.c
index b6ceb9d..ed5d258 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -87,7 +87,7 @@ static char *act_to_str(__u32 action)
 	unsigned int act = action & 0xffff;
 	unsigned int trace = (action >> BLK_TC_SHIFT) & 0xffff;
 
-	if (act <= N_ACTS) {
+	if (act < N_ACTS) {
 		sprintf(buf, "%s ", acts[act].string);
 		for (i = 0; i < N_TRACES; i++)
 			if (trace & (1 << i)) {
@@ -201,6 +201,7 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 			if (n = 0) {
 				INC_BAD("bad pdu");
 				nbad_seq++;
+				free(pdu_buf);
 				break;
 			}
 			free(pdu_buf);
diff --git a/blktrace.c b/blktrace.c
index b14daf2..89aaaac 100644
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
@@ -1728,11 +1731,10 @@ static int handle_pfds_netclient(struct tracer *tp, int nevs, int force_read)
 {
 	struct stat sb;
 	int i, nentries = 0;
-	struct pdc_stats *sp;
 	struct pollfd *pfd = tp->pfds;
 	struct io_info *iop = tp->ios;
 
-	for (i = 0; i < ndevs; i++, pfd++, iop++, sp++) {
+	for (i = 0; i < ndevs; i++, pfd++, iop++) {
 		if (pfd->revents & POLLIN || force_read) {
 			if (fstat(iop->ifd, &sb) < 0) {
 				perror(iop->ifn);
@@ -2076,9 +2078,13 @@ static int handle_args(int argc, char *argv[])
 				return 1;
 			}
 
-			while (fscanf(ifp, "%s\n", dev_line) = 1)
-				if (add_devpath(dev_line) != 0)
+			while (fscanf(ifp, "%s\n", dev_line) = 1) {
+				if (add_devpath(dev_line) != 0) {
+					fclose(ifp);
 					return 1;
+				}
+			}
+			fclose(ifp);
 			break;
 		}
 
@@ -2128,7 +2134,9 @@ static int handle_args(int argc, char *argv[])
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
@@ -2183,7 +2191,10 @@ static int handle_args(int argc, char *argv[])
 		piped_output = 1;
 		handle_pfds = handle_pfds_entries;
 		pfp = stdout;
-		setvbuf(pfp, NULL, _IONBF, 0);
+		if (setvbuf(pfp, NULL, _IONBF, 0)) {
+			perror("setvbuf stdout");
+			return 1;
+		}
 	} else
 		handle_pfds = handle_pfds_file;
 	return 0;
diff --git a/btreplay/btrecord.c b/btreplay/btrecord.c
index 88ab806..3646257 100644
--- a/btreplay/btrecord.c
+++ b/btreplay/btrecord.c
@@ -365,7 +365,7 @@ static void find_input_files(char *idir)
 	}
 
 	while ((ent = readdir(dir)) != NULL) {
-		char *p, *dsf = malloc(256);
+		char *p, *dsf;
 
 		if (strstr(ent->d_name, ".blktrace.") = NULL)
 			continue;
diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index f4f5aa0..20494e0 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -596,7 +596,7 @@ static void find_input_devs(char *idir)
 	}
 
 	while ((ent = readdir(dir)) != NULL) {
-		char *p, *dsf = malloc(256);
+		char *p, *dsf;
 
 		if (strstr(ent->d_name, ".replay.") = NULL)
 			continue;
diff --git a/btt/aqd.c b/btt/aqd.c
index 3bb6f85..17ab15b 100644
--- a/btt/aqd.c
+++ b/btt/aqd.c
@@ -43,6 +43,8 @@ void *aqd_alloc(struct d_info *dip)
 	sprintf(oname, "%s_%s_aqd.dat", aqd_name, dip->dip_name);
 	if ((ap->fp = my_fopen(oname, "w")) = NULL) {
 		perror(oname);
+		free(oname);
+		free(ap);
 		return NULL;
 	}
 	add_file(ap->fp, oname);
diff --git a/btt/bno_dump.c b/btt/bno_dump.c
index 02f3811..00c9ac2 100644
--- a/btt/bno_dump.c
+++ b/btt/bno_dump.c
@@ -31,9 +31,10 @@ static FILE *bno_dump_open(struct d_info *dip, char rwc)
 
 	oname = malloc(strlen(bno_dump_name) + strlen(dip->dip_name) + 32);
 	sprintf(oname, "%s_%s_%c.dat", bno_dump_name, dip->dip_name, rwc);
-	if ((fp = my_fopen(oname, "w")) = NULL)
+	if ((fp = my_fopen(oname, "w")) = NULL) {
 		perror(oname);
-	else
+		free(oname);
+	} else
 		add_file(fp, oname);
 	return fp;
 }
diff --git a/btt/devmap.c b/btt/devmap.c
index 9c0348b..0553a9e 100644
--- a/btt/devmap.c
+++ b/btt/devmap.c
@@ -76,6 +76,7 @@ int dev_map_read(char *fname)
 			break;
 	}
 
+	fclose(fp);
 	return 0;
 }
 
diff --git a/btt/plat.c b/btt/plat.c
index e7b7dde..dff7115 100644
--- a/btt/plat.c
+++ b/btt/plat.c
@@ -42,6 +42,8 @@ void *plat_alloc(struct d_info *dip, char *post)
 	sprintf(oname, "%s%s_plat.dat", dip->dip_name, post);
 	if ((pp->fp = my_fopen(oname, "w")) = NULL) {
 		perror(oname);
+		free(oname);
+		free(pp);
 		return NULL;
 	}
 	add_file(pp->fp, oname);
diff --git a/btt/proc.c b/btt/proc.c
index aac49cb..eb44c3d 100644
--- a/btt/proc.c
+++ b/btt/proc.c
@@ -238,9 +238,8 @@ void pip_foreach_out(void (*f)(struct p_info *, void *), void *arg)
 		__foreach(root_name.rb_node, f, arg);
 	else {
 		struct p_info *pip;
-		char *exe, *p, *next, *exes_save = strdup(exes);
+		char *exe, *next, *exes_save = strdup(exes);
 
-		p = exes_save;
 		while (exes_save != NULL) {
 			exe = exes_save;
 			if ((next = strchr(exes_save, ',')) != NULL) {
diff --git a/btt/seek.c b/btt/seek.c
index abdb0ee..52f6a21 100644
--- a/btt/seek.c
+++ b/btt/seek.c
@@ -51,9 +51,10 @@ static FILE *seek_open(char *str, char rw)
 
 	oname = malloc(strlen(seek_name) + strlen(str) + 32);
 	sprintf(oname, "%s_%s_%c.dat", seek_name, str, rw);
-	if ((fp = my_fopen(oname, "w")) = NULL)
+	if ((fp = my_fopen(oname, "w")) = NULL) {
 		perror(oname);
-	else
+		free(oname);
+	} else
 		add_file(fp, oname);
 
 	return fp;
@@ -99,18 +100,14 @@ static void __destroy(struct rb_node *n)
 
 static void sps_emit(struct seeki *sip)
 {
-	double tstamp, s_p_s;
+	double s_p_s;
 	struct sps_bkt *sps = &sip->sps;
 	double delta = sps->t_last - sps->t_start;
 
-	if ((sps->nseeks = 1) || (delta < DBL_EPSILON)) {
+	if ((sps->nseeks = 1) || (delta < DBL_EPSILON))
 		s_p_s = (double)(sps->nseeks);
-		tstamp = sps->t_start;
-	} else {
-
+	else
 		s_p_s = (double)(sps->nseeks) / delta;
-		tstamp = sps->t_start + (delta / 2);
-	}
 
 	fprintf(sip->sps_fp, "%15.9lf %.2lf\n", sps->t_start, s_p_s);
 
@@ -226,9 +223,10 @@ void *seeki_alloc(struct d_info *dip, char *post)
 
 		oname = malloc(strlen(sps_name) + strlen(dip->dip_name) + 32);
 		sprintf(oname, "%s_%s.dat", sps_name, dip->dip_name);
-		if ((sip->sps_fp = my_fopen(oname, "w")) = NULL)
+		if ((sip->sps_fp = my_fopen(oname, "w")) = NULL) {
 			perror(oname);
-		else
+			free(oname);
+		} else
 			add_file(sip->sps_fp, oname);
 	} else
 		sip->sps_fp = NULL;
diff --git a/btt/trace_queue.c b/btt/trace_queue.c
index 82c5760..8edcd90 100644
--- a/btt/trace_queue.c
+++ b/btt/trace_queue.c
@@ -33,7 +33,7 @@ static void handle_queue(struct io *q_iop)
 		update_lq(&last_q, &all_avgs.q2q, q_iop->t.time);
 	}
 
-	q_iop->i_time = q_iop->g_time = q_iop->i_time = q_iop->m_time +	q_iop->i_time = q_iop->g_time = q_iop->c_time = q_iop->m_time  						q_iop->d_time = (__u64)-1;
 	q_iop->dip->n_qs++;
 
