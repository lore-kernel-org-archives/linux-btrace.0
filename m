Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FE40BCB3;
	Thu, 16 Jul 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199924; cv=none; b=t+yhT/DIa/tVmDaZiuKlnP1NjU6hvGqNsk6HDgkHe99THprhSszQ1MnA7moevfMBjgwlpmoL9ITRc2SDmHJEeB8cv3E+9LmyWvyg767SzDfnMu0ukUnVDI+cLQzIMhOQc4Kx2z9zRXhYICW1+UwsEwZ26FVP6/3B/5jEQ+sYHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199924; c=relaxed/simple;
	bh=DrJ7jfYNtJVYd2uc7W9ZFRPPhlGfU85cp9SmX/41qPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2GY5CH2LVxPw17j+9R+/8tF8wuwIJfndG3TG6nbv0CYrv3Eo4S0bIoCVmoqkmjyRe9GXikyrWGIX4K6oXJicYrjCKZQ92GUBuJkdUFiqWjuH/8ZeJ486W9M4g+y/bfa3sbqmtR7+2uWcQ2JSXHIuK9KEensYCBxZVLJU+ZJRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cKCfXi/3; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cKCfXi/3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784199922; x=1815735922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DrJ7jfYNtJVYd2uc7W9ZFRPPhlGfU85cp9SmX/41qPw=;
  b=cKCfXi/3pE0lmd95PH1YR/QeIpKYNW7/l7f8ubcA7p63tqEIBiKIMP/B
   u2b6mf8VSz//q8kiXdi6abpHQ+g+7cBlsMJY3kqEicza5+ij7uMtXnCCq
   gRypZoiGV5KJfj+1xCfygwYvX5MSTG57EatgHkubt+ysRbpF+N2Mzc3r2
   KNcrc0uxj7oSV0YbsYRJALxk1uZS7hUICYTwF9U490Ala1SypI44jFFzj
   uarRJ5PgkZkBOCDI1NSw0n2SKJjgfYGc6ozLHH0ryo0xm3uAAVJ5zIieW
   SqD7KAHhlVeCBhsIqnMoMdwZv4QdiHbcqM9xvtI0MNRPQJvlAz0CZN7I4
   Q==;
X-CSE-ConnectionGUID: ebv0iKTJTPahUblZO6LaRw==
X-CSE-MsgGUID: WCpfHE8yRSGwqIuIF6+3XQ==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="146986476"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2026 19:05:19 +0800
X-CSE-ConnectionGUID: YI4uD1ItTi2w79CJxrtpAA==
X-CSE-MsgGUID: 4UccNrjOQW2VrIZqjsNxIQ==
IronPort-SDR: 6a58bad6_J1r3blgUV+O22XM6egp1Um3ducq2XccuZJl/f7wfIfueZa1
 um0Q+HnYq9N4hhww3jq1LYkIW7fkc+nWIxpvtzA==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 04:04:54 -0700
X-CSE-ConnectionGUID: YedCsd8KRfSTtq8mvodhjg==
X-CSE-MsgGUID: G3Dst/DwQkiQd/2B6hNhUA==
WDCIronportException: Internal
Received: from wdap-fln31fg1cp.ad.shared (HELO neo.wdc.com) ([10.224.28.153])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Jul 2026 04:04:52 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-btrace@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/11] blktrace: add option to request a specific trace protocol version
Date: Thu, 16 Jul 2026 13:04:34 +0200
Message-ID: <20260716110442.1291010-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
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
 blktrace.c     | 30 ++++++++++++++++++++++++++++--
 doc/blktrace.8 |  7 +++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 72562fdc9d9e..35db26fd4e23 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -283,6 +283,7 @@ static unsigned long long act_mask = ~0U;
 static int kill_running_trace;
 static int stop_watch;
 static int piped_output;
+static int v1;
 
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
@@ -2244,6 +2257,19 @@ static int handle_args(int argc, char *argv[])
 		case 's':
 			net_use_sendfile = 0;
 			break;
+		case OPT_TRACE_VERSION: {
+			int ver = atoi(optarg);
+
+			if (ver == 1)
+				v1 = 1;
+			else if (ver == 2)
+				v1 = 0;
+			else {
+				show_usage(argv[0]);
+				exit(1);
+			}
+			break;
+		}
 		default:
 			show_usage(argv[0]);
 			exit(1);
@@ -2714,7 +2740,7 @@ static int run_tracers(void)
 	if (net_mode == Net_client)
 		printf("blktrace: connecting to %s\n", hostname);
 
-	if (setup_buts2()) {
+	if (v1 || setup_buts2()) {
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

