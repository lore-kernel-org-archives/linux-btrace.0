Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B35A223327
	for <linux-btrace@vger.kernel.org>; Thu, 12 Jun 2025 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716182; cv=none; b=p3gwZtLOl8uBSAsIlg1hjdxrs0cgj3tKUAhhSUqk1WbzG4T0U2wtIGyalRGh/IHDms0lI2yaP2gO9PyFyLCDAWhbzt+NWOENfjU9SknbBCWQw6j2ELD2WGS77lsIy3j3grUSclT4ykTzUqEdUKOT9CXlekexN0wVsS9gPR52Xt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716182; c=relaxed/simple;
	bh=WgCsSUbk8ihMDQaG8h36biXOjNYJ1pV7ttWRzPepdxQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=OPIgyiHjPPzruKx8e9qMHCyD8qdylmN61elNRbD5cc1A29NkvM2Xu4TUn7843aAku2tIxIj6fLb6XjZ/98kA8aohIaJtf4MDOzPPtngcwDQkYOQ6AjEpOxjelh7jFcffpLy2vKL6e9mh8XC0JZ528X2NfXMB97XA65U/1KcsWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=elM94Ll+; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="elM94Ll+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1749716167; bh=vqC+k0cktBb5pzKiVbllSA0k0cUBE0KydKrNYw7Hd1U=;
	h=From:To:Cc:Subject:Date;
	b=elM94Ll+hFsOQbuWUkYws2GY/DRDUz0LZij609ZSLiEWe9DU79Upvc582hE5kL4lb
	 QWQ2Wdv5DvBHzONfWqSi5mvRonvxIK32YJGO9TgARVAgzjl5ZxZv++rDIdvWubBooI
	 qLtlpSPP9EuKr2tI97i/wty365ZPNVriEhITKR7w=
Received: from localhost.localdomain ([1.193.57.185])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 1F40B26F; Thu, 12 Jun 2025 16:07:52 +0800
X-QQ-mid: xmsmtpt1749715672tke7rmyu6
Message-ID: <tencent_20DC02A432CFB82BB844737010F1B201E908@qq.com>
X-QQ-XMAILINFO: Nr8YfRCXK4tZc2aEHZmDuNFIEQNhdVs5mNVvpNmnzyuBVqhJJlZL6yZ/UKSEZX
	 HIx37bb2nOVH+CowbxfUiqvY01m7qJwB6rR+J3/JzUEkJx8WJey6bKhME/KXFj/6C3X/z6sKHXJq
	 +b59Y0ksBcvLsVNbtj0WBmcSd5PSWx7fgWMRZEdLrJPY4OJ5oJpXQrXlonaWc/o+XsdeqAbGBnFq
	 3JfCMA8zq9ejAtzRW+b4r4UihZ9Nbdu9FneJDZnNQgIoJ0w/ANBoV31d16nqfUcabIKfDiyXDnRH
	 66uK4jDHvuzpbUbAtoyXV+9ayLbQTFmpf7fyWNTVHBpk8m4aUaP3W0fCgjp+2pSxqUEQY0Ri3eVi
	 tH/TTq881A+dcYA5TZ88CQ4hecFgGBnHbzkcFTL+Y9cL83+52FJ7eLDgMT+b2Xc3m6pSCiGyIdcV
	 YVSblKRdkFp4q0o3MOQrH5stsUwtWvQN/0XdKOkvhEfVkm9db85Y4lRi5VX0Gjt/Yc+fDQOXmY+U
	 HLC69w+YVm8dQ1EcB4AV/dGi3fvWmJtOs15GUxR5mt50XyRfjLI8spx+T4irbvpA5dUpwcr9w8fx
	 QrLN6C+actF92jITwv981lHEX4pkKDBUTr82fs+5/5ezvCfcuQZxJOk8RctYK3TXFKJeaNnv8Vg/
	 z3ZbK32te24AyCavUyFNwj9GzdeVVRdD3EVVKkWNQfF/DpWbqq+Ba6vk48TFoyt3hblkzEq4Y0zZ
	 3nGZp3Sp+Cmn3Jgm9TCyBoYe0Y/kNQIHxIR8lz9GB9iaPTu1WMQwKsm+xqUgpkXPUvp+igwHiHbg
	 HHm2Q83J49HPHEPYy1hzkB4Fwk/sDfVPV5qMhtYMK7XMepMQNrVywLk/p7irPMfQK0wr6KzXB9oR
	 hPYmmJjAxj34ls2uIGzhze5kMg8z2Q9tThmoFdaT8Ct7hcy7cOk32t0+1snUEb8DgG66z/qbnJpl
	 2S0SKtruQn3OWY4aJB4gBM8Nas0ncndf57xs9RJHVq2sV1p5xxaTPvMnmU9A8E
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: 303146950@qq.com
To: linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk,
	Kou Wenqi <kouwenqi@kylinos.cn>
Subject: [PATCH] btt: add the option -n to output latency with nanosecond precision
Date: Thu, 12 Jun 2025 16:07:49 +0800
X-OQ-MSGID: <20250612080749.3730-1-303146950@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kou Wenqi <kouwenqi@kylinos.cn>

In the output of "btt -p" the timestamp precision is in nanoseconds.
8,0  :     0.000000000 Q          0+375
           0.000005237 G          0+375
           0.000015011 I          0+375
           0.000079403 D          0+375
           0.082000679 C          0+375

In outputs like "btt -q" the precision of timestamps and latencies
is in microseconds.
0.000000 0.082001

Add the -n option to btt to set the precision of timestamps and
latencies in outputs like "btt -q" to nanoseconds, aligning
them with the output of "btt -p".

This is particularly useful for pinpointing the exact timestamps
of the highest-latency Qs.

Signed-off-by: Kou Wenqi <kouwenqi@kylinos.cn>
---
 btt/args.c        | 12 +++++++++++-
 btt/bt_timeline.c |  1 +
 btt/globals.h     |  1 +
 btt/latency.c     | 10 ++++++++--
 doc/btt.1         | 11 ++++++++++-
 5 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/btt/args.c b/btt/args.c
index 5c5078a..beac03b 100644
--- a/btt/args.c
+++ b/btt/args.c
@@ -29,7 +29,7 @@
 
 #define SETBUFFER_SIZE	(64 * 1024)
 
-#define S_OPTS	"aAB:d:D:e:hi:I:l:L:m:M:o:p:P:q:Q:rs:S:t:T:u:VvXz:Z"
+#define S_OPTS	"aAB:d:D:e:hi:I:l:L:m:M:no:p:P:q:Q:rs:S:t:T:u:VvXz:Z"
 static struct option l_opts[] = {
 	{
 		.name = "seek-absolute",
@@ -109,6 +109,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'M'
 	},
+	{
+		.name = "output-latency-with-nanosecond-precision",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'n'
+	},
 	{
 		.name = "output-file",
 		.has_arg = required_argument,
@@ -224,6 +230,7 @@ static char usage_str[] = \
 	"[ -L <freq>        | --periodic-latencies=<freq> ]\n" \
 	"[ -m <output name> | --seeks-per-second=<output name> ]\n" \
 	"[ -M <dev map>     | --dev-maps=<dev map>\n" \
+	"[ -n               | --output-latency-with-nanosecond-precision ]\n" \
 	"[ -o <output name> | --output-file=<output name> ]\n" \
 	"[ -p <output name> | --per-io-dump=<output name> ]\n" \
 	"[ -P <output name> | --per-io-trees=<output name> ]\n" \
@@ -333,6 +340,9 @@ void handle_args(int argc, char *argv[])
 			if (dev_map_read(optarg))
 				exit(1);
 			break;
+		case 'n':
+			output_latency_with_nanosecond_precision = 1;
+			break;
 		case 'o':
 			output_name = optarg;
 			break;
diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index 295e5ee..cc847b0 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -38,6 +38,7 @@ unsigned long n_traces;
 struct avgs_info all_avgs;
 unsigned int n_devs;
 time_t genesis, last_vtrace;
+int output_latency_with_nanosecond_precision;
 LIST_HEAD(all_devs);
 LIST_HEAD(all_procs);
 LIST_HEAD(all_ios);
diff --git a/btt/globals.h b/btt/globals.h
index 22a1cb0..800b2af 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -191,6 +191,7 @@ extern __u64 iostat_interval, iostat_last_stamp;
 extern time_t genesis, last_vtrace;
 extern double t_astart, t_aend;
 extern __u64 q_histo[N_HIST_BKTS], d_histo[N_HIST_BKTS];
+extern int output_latency_with_nanosecond_precision;
 
 /* args.c */
 void handle_args(int argc, char *argv[]);
diff --git a/btt/latency.c b/btt/latency.c
index 51e6881..5c4e52f 100644
--- a/btt/latency.c
+++ b/btt/latency.c
@@ -22,8 +22,14 @@
 
 static inline void latency_out(FILE *ofp, __u64 tstamp, __u64 latency)
 {
-	if (ofp)
-		fprintf(ofp, "%lf %lf\n", TO_SEC(tstamp), TO_SEC(latency));
+	if (ofp) {
+		if (output_latency_with_nanosecond_precision)
+			fprintf(ofp, "%d.%09lu %d.%09lu\n",
+				(int)SECONDS(tstamp), (unsigned long)NANO_SECONDS(tstamp),
+				(int)SECONDS(latency), (unsigned long)NANO_SECONDS(latency));
+		else
+			fprintf(ofp, "%lf %lf\n", TO_SEC(tstamp), TO_SEC(latency));
+	}
 }
 
 FILE *latency_open(struct d_info *dip, char *name, char *post)
diff --git a/doc/btt.1 b/doc/btt.1
index 28cf912..c143f35 100644
--- a/doc/btt.1
+++ b/doc/btt.1
@@ -32,7 +32,9 @@ btt \- analyse block i/o traces produces by blktrace
 .br
 [ \-m <\fIoutput name\fR> | \-\-seeks\-per\-second=<\fIoutput name\fR> ]
 .br
-[ \-M <\fIdev map\fR>     | \-\-dev\-maps=<\fIdev map\fR>
+[ \-M <\fIdev map\fR>     | \-\-dev\-maps=<\fIdev map\fR> ]
+.br
+[ \-n               | \-\-output\-latency\-with\-nanosecond\-precision ]
 .br
 [ \-o <\fIoutput name\fR> | \-\-output\-file=<\fIoutput name\fR> ]
 .br
@@ -222,6 +224,13 @@ The \-M option takes in a file generated by the provided script
 (gen_disk_info.py), and allows for better output of device names.
 .RE
 
+.B \-n
+.br
+.B \-\-output\-latency\-with\-nanosecond\-precision
+.RS 4
+Output latency with nanosecond precision.
+.RE
+
 .B \-o <\fIoutput name\fR>
 .br
 .B \-\-output\-file=<\fIoutput name\fR>
-- 
2.43.0

