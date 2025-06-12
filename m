Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5AF79E1
	for <linux-btrace@vger.kernel.org>; Thu, 12 Jun 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713368; cv=none; b=fGb7I0TuEzUUHFxlBZUxqNDHeQn5w6Bcb8nJkR71MGfEZIzKfUDLDUrD69Cd7ZnsF1cRPy8nSMkvhWJkbI4Jz8k/eN0YaaN5DU++c4r/3KB3FbIk+k9FM9df0PNky07KqqAss6Zmj8rNhNI4qVm1+rx9pUCyP8MiCo8eoKrx5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713368; c=relaxed/simple;
	bh=KBY0a2ppDCER7/zM8biqYWfuZGTK5i0AZmZ4UiUUHY8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=tiV5kfhj9BwitjvTAaOe5hP/5dOf2Lz9ZE2kOgWYYp9mu31nJ7igCvuBB8Lg9lN4vyBuiPtjgLWNsA3930oxPwOZ4QhvFMci6acScm4AFPF2MIaNdft8J00Y4yZ3RLnoHCC+byy/g+4eRMUVKDE4dbbJCEZ0ckWdDIDe7CG7oKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=R0/elttx; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="R0/elttx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1749713058; bh=B9UxXb7I5l321Nt6fUTplwq+QC+Hmtmys4cIzF0uNhk=;
	h=From:To:Cc:Subject:Date;
	b=R0/elttxHPFbhcRBMzn6yJTeQAyb0g620GFsmREfgxwE0ULZcPkglTJiOuMRFdcV7
	 bJsU9yP9jRbgbKP5QY+QMS23wOqpu1EsiYVDhROOZvwTc9fmPpG4SkX5H8I/thpfmz
	 SV8oP3IsZBGEbTbquZQ/5tzYMSzCOQgGBQa1F2h4=
Received: from localhost.localdomain ([1.193.57.185])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 61019840; Thu, 12 Jun 2025 15:24:16 +0800
X-QQ-mid: xmsmtpt1749713056tz3mx69ou
Message-ID: <tencent_0A74E0A0E37102B2B8A148E39F63571C8809@qq.com>
X-QQ-XMAILINFO: Mg/0DM1Zd+nHmMJjklWbbtWfdseUeD7D2n2GYbjPEJ33e5euBGnQLp8cIzOlBW
	 dYi5r25ramoikTYxkISaW7oMBY89JaYQqob0h+kz0oaifb36Ca6bb/jZYTXS0PlojZfvqfUQ+Md4
	 SwR/pSW+cr/ZR/8uRtcYm9swMQQ05KaV0ENyfMOX/UPzp9riJknXLfTPQd8NPxzFqTyyfF6zP0pE
	 LlBbHiP4B0Oc+xxPzd1gmXDd6dW43tKkHNYDoPQOqi0P7T5sC8IW9XwOWYngxKn4l4yP+gZ3Thdy
	 hG6TL2n8Te64bKMFJrhmimfhmuRRpQkVuaIqjZ0+W7MWPDu6sg8nivVXz4yLORVdKx7H+/PwZl+a
	 0Jf73SfO2/N00h7gyuVYVF2cniaw56TEv3kspjVS/schVkZT6U2f4XlhtyODPB4MLJE6nEG8yMJe
	 Z7cUKXH3Z+yu+RXpYdVH0KxRrW4+caT28U/Ru7TQx/3TFD/PMCiSWnzjvpaUBf9jzUO4oHB887Tp
	 qKXRzdK4sNorwEOw/v9c/ZhYlgdcae3SJGrC+2ksDQzx0N5cLmrsuoBHZ+EZcMsVjCEcrN/UtvrP
	 2juIXLfGFYtYq9o2aHOv+8i9HYfYhiKHI+SP46DhZAKsTcpOzh25UJotjnlqwD1+dZEfE0wSTKvj
	 CYFCTsS5KAEse4k8/WECsA09YG9DvJoluziB87dtDxExZ/KvLe+AgFYE04zZntWG1pj7rbjiPNW9
	 tVJxE2ygKFu6yuEBCoPqEb6b2P/BM+QI/TMqubrqIXyDvYP6GO0UzpjriZIQaDxfkOshvDa7Acsz
	 I+zVn51xvuqOc0dlURcRBq11pJhG3Jyqr14+cfy4Lx18LIPZPz3SJ3vXcNnXyALh+fOiK6qHVC98
	 ROMcvu/Ru0YAkJiGHGqSZcBd4Fv/pWajF13T1uj5YX4HoUnqz5b/340bX7Gh3GQtNfC4HexmUVF2
	 4JhW/qxL0=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: 303146950@qq.com
To: linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk,
	Kou Wenqi <kouwenqi@kylinos.cn>
Subject: [PATCH] blkparse: add the -n option to output original IO event information.
Date: Thu, 12 Jun 2025 15:24:03 +0800
X-OQ-MSGID: <20250612072403.3195-1-303146950@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kou Wenqi <kouwenqi@kylinos.cn>

commit e81829a56516 fixes the sector and length of split completions
to match the original request.
However, the original IO event information is also required.
Add the -n option to blkparse to output original IO event information.

Signed-off-by: Kou Wenqi <kouwenqi@kylinos.cn>
---
 blkparse.c       | 17 ++++++++++++++++-
 doc/blkparse.1   |  7 +++++++
 doc/blktrace.tex |  2 ++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/blkparse.c b/blkparse.c
index d6aaa8b..4af6d1d 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -180,6 +180,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'M'
 	},
+	{
+		.name = "do-not-fix-up-for-split-completions",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'n'
+	},
 	{
 		.name = "output",
 		.has_arg = required_argument,
@@ -326,6 +332,8 @@ static unsigned long long start_timestamp;
 
 static int have_drv_data = 0;
 
+static int do_not_fix_up_for_split_completions = 0;
+
 #define JHASH_RANDOM	(0x3af5f2ee)
 
 #define CPUS_PER_LONG	(8 * sizeof(unsigned long))
@@ -1099,6 +1107,8 @@ static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
 static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
 {
 	struct io_track *iot, *split;
+	if (do_not_fix_up_for_split_completions)
+		return;
 
 	/*
 	 * With a split request, the completion event will refer to the last
@@ -2991,7 +3001,7 @@ static int get_program_sort_event(const char *str)
 	return 0;
 }
 
-#define S_OPTS  "a:A:b:D:d:f:F:hi:o:OqsS:tw:vVM"
+#define S_OPTS  "a:A:b:D:d:f:F:hi:no:OqsS:tw:vVM"
 static char usage_str[] =    "\n\n" \
 	"-i <file>           | --input=<file>\n" \
 	"[ -a <action field> | --act-mask=<action field> ]\n" \
@@ -3002,6 +3012,7 @@ static char usage_str[] =    "\n\n" \
 	"[ -f <format>       | --format=<format> ]\n" \
 	"[ -F <spec>         | --format-spec=<spec> ]\n" \
 	"[ -h                | --hash-by-name ]\n" \
+	"[ -n                | --do-not-fix-up-for-split-completions ]\n" \
 	"[ -o <file>         | --output=<file> ]\n" \
 	"[ -O                | --no-text-output ]\n" \
 	"[ -q                | --quiet ]\n" \
@@ -3022,6 +3033,7 @@ static char usage_str[] =    "\n\n" \
 	"\t-F Format specification. Can be found in the documentation\n" \
 	"\t-h Hash processes by name, not pid\n" \
 	"\t-i Input file containing trace data, or '-' for stdin\n" \
+	"\t-n Do not fix up the sector and length for split completions\n" \
 	"\t-o Output file. If not given, output is stdout\n" \
 	"\t-O Do NOT output text data\n" \
 	"\t-q Quiet. Don't display any stats at the end of the trace\n" \
@@ -3083,6 +3095,9 @@ int main(int argc, char *argv[])
 		case 'D':
 			input_dir = optarg;
 			break;
+		case 'n':
+			do_not_fix_up_for_split_completions = 1;
+			break;
 		case 'o':
 			output_name = optarg;
 			break;
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 93aa449..fc88c51 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -130,6 +130,13 @@ the CFQ I/O scheduler.)
 Hash processes by name, not by PID
 .RE
 
+\-n
+.br
+\-\-do\-not\-fix\-up\-for\-split\-completions
+.RS
+Do not fix up the sector and length for split completions
+.RE
+
 \-o \fIfile\fR
 .br
 \-\-output=\fIfile\fR
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index d747de7..504355c 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -493,6 +493,8 @@ Short              & Long                       & Description \\ \hline\hline
 
 -h                 & --hash-by-name             & Hash processes by name, not by PID\\ \hline
 
+-n                 & --do-not-fix-up-for-split-completions  & Do not fix up the sector and length for split completions\\ \hline
+
 -o \emph{file}     & --output=\emph{file}       & Output file \\ \hline
 -O                 & --no-text-output           & Do \emph{not} produce text output, used for binary (-d) only \\ \hline
 
-- 
2.43.0

