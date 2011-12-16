From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 16 Dec 2011 19:15:54 +0000
Subject: [PATCH 6/10] Fix several leaks on error paths
Message-Id: <4EEB98EA.3050901@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

In several cases space is allocated for a filename but
not freed if open of that file fails.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

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
diff --git a/btt/seek.c b/btt/seek.c
index abdb0ee..dba0071 100644
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
@@ -226,9 +227,10 @@ void *seeki_alloc(struct d_info *dip, char *post)
 
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


