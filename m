Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB23F9A0F;
	Mon, 20 Jul 2026 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546103; cv=none; b=UbfigdOWSad3XBlL13Jn7/RZr8xnQ8cJavce0LWw8WgopOxxEk6g050/LqE0cqIA0Ngb0kbYRhiqe7NhbVW1JyVN44NFI8a2Zio6tNC/iE9FtChmwqCV2Qq4tKSOKRohw4wHcgIdhX8e6nkyTfYBUxsrjyDChJWqIZKdbBf4quY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546103; c=relaxed/simple;
	bh=4dITsj/U59Xs3BXpNSDsRxiyweprvyHfS7HWiF1HDnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rz+saAvaSuiB6GIwfXSodZUYhSjwReomXrDNwRZLruzGInYZKUYlNx2b/r/DZNR/817oBbarUCFUQRRF05DO4RSE94a1nJw4IhSMv1HF+UOTwdI0EflSAn1CIZ8tyG7a55VaCu0aXV3n3n+rkyearGFDQNboHH3fXkCUsRZ2kU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Sq53WWex; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sq53WWex"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784546101; x=1816082101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4dITsj/U59Xs3BXpNSDsRxiyweprvyHfS7HWiF1HDnQ=;
  b=Sq53WWexeQvJOW+uPNmPJB5YZu5uMEcFw5C5evWrBpqB4v8o+FXaVmrn
   TDn/iO9qb/3u9lHZXj6NnNTAzz99cIXNcPd3cZdp9gkHPh2sd2O97D8G0
   qIed1xmxVyqwk3/G1ft9v2HTk9/93QpibBt4HTz3OkqMRI+20d2x/uTYp
   UMycTUpYkqjxJ3alQ7IiXvZszqD1Kgkm2srPlOZUKMhSwBVou+CXtVTLm
   eoHc95O7jSqCm3M6Inm9dv6rwjmeqwR9fDXA5gLULDY4ycmdPcel3rgyA
   N0PiLuBwaAksK8Gjc7APj/GGiXHaYtGJ5qpKMmyGRUoGOUmNDt6oeB8tg
   g==;
X-CSE-ConnectionGUID: jv1089sqTy6FOLVx53ZlvQ==
X-CSE-MsgGUID: +ijr0dCzTUq4uW1x04NV3w==
X-IronPort-AV: E=Sophos;i="6.25,174,1779120000"; 
   d="scan'208";a="151105447"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2026 19:14:51 +0800
X-CSE-ConnectionGUID: TfdFYLKKTYSV+hGVe4wzlQ==
X-CSE-MsgGUID: NK8Ejr6qQha0SJRHuIRKMg==
IronPort-SDR: 6a5e0313_M8RPB9sTLbUtUmgbKOdCeU30kvO7Nn/jxcLj6DHUwYKh7mB
 D2/7zgbbl48Ayc6SwbR+wKjGF0g6UI4LXswEbOQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 04:14:27 -0700
X-CSE-ConnectionGUID: P1bXM0RLQauSkugGOkdwnA==
X-CSE-MsgGUID: 2MCLMCyGTbmyEBe/lvzJpQ==
WDCIronportException: Internal
Received: from wdap-kyufgunycc.ad.shared (HELO neo.fritz.box) ([10.224.19.3])
  by uls-op-esai1-o.wdc.com with ESMTP; 20 Jul 2026 04:14:26 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 03/11] blktrace: add option to request a specific trace protocol version
Date: Mon, 20 Jul 2026 13:14:09 +0200
Message-ID: <20260720111417.1658507-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
References: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the '--trace-version=<1|2>' command line option to select the trace
protocol version requested from the kernel. Requesting version 1 forces
blktrace to use the old BLKTRACESETUP ioctl, while version 2 (the
default) uses BLKTRACESETUP2.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace.c     | 24 ++++++++++++++++++++++--
 doc/blktrace.8 |  7 +++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 72562fdc9d9e..89a8f8a7dccd 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -283,6 +283,7 @@ static unsigned long long act_mask = ~0U;
 static int kill_running_trace;
 static int stop_watch;
 static int piped_output;
+static int trace_ver;
 
 static char *debugfs_path = "/sys/kernel/debug";
 static char *output_name;
@@ -329,6 +330,10 @@ static int *cl_fds;
 static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
+enum {
+	OPT_TRACE_VERSION = 256,
+};
+
 #define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
 static struct option l_opts[] = {
 	{
@@ -433,6 +438,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 's'
 	},
+	{
+		.name = "trace-version",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = OPT_TRACE_VERSION
+	},
 	{
 		.name = NULL,
 	}
@@ -455,6 +466,7 @@ static char usage_str[] = "\n\n" \
         "[ -I <devs file>     | --input-devs=<devs file>]\n" \
         "[ -v <version>       | --version]\n" \
         "[ -V <version>       | --version]\n" \
+        "[ --trace-version=<1|2> ]\n" \
 
 	"\t-d Use specified device. May also be given last after options\n" \
 	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
@@ -471,7 +483,8 @@ static char usage_str[] = "\n\n" \
 	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
 	"\t-I Add devices found in <devs file>\n" \
 	"\t-v Print program version info\n" \
-	"\t-V Print program version info\n\n";
+	"\t-V Print program version info\n" \
+	"\t--trace-version Request trace protocol version 1 or 2 from the kernel\n\n";
 
 static void clear_events(struct pollfd *pfd)
 {
@@ -2244,6 +2257,13 @@ static int handle_args(int argc, char *argv[])
 		case 's':
 			net_use_sendfile = 0;
 			break;
+		case OPT_TRACE_VERSION:
+			trace_ver = atoi(optarg);
+			if (trace_ver != 1 && trace_ver != 2) {
+				show_usage(argv[0]);
+				exit(1);
+			}
+			break;
 		default:
 			show_usage(argv[0]);
 			exit(1);
@@ -2714,7 +2734,7 @@ static int run_tracers(void)
 	if (net_mode == Net_client)
 		printf("blktrace: connecting to %s\n", hostname);
 
-	if (setup_buts2()) {
+	if (trace_ver == 1 || setup_buts2()) {
 		if (setup_buts()) {
 			done = 1;
 			return 1;
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 820b03aa4c16..c502adcfaa9d 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -191,6 +191,13 @@ Outputs version
 Sets run time to the number of seconds specified  
 .RE
 
+\-\-trace\-version=\fI1|2\fR
+.RS
+Selects the trace protocol version requested from the kernel. Requesting
+version 1 forces blktrace to use the old \fBBLKTRACESETUP\fR ioctl, while
+version 2 (the default) uses \fBBLKTRACESETUP2\fR.
+.RE
+
 
 .SH FILTER MASKS
 The following masks may be passed with the \fI\-a\fR command line
-- 
2.54.0

