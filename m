Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58D1DE4DE
	for <linux-btrace@vger.kernel.org>; Tue, 28 Jan 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091153; cv=none; b=ZHu2mGu3c6dGmf+d6iqGHPe5ZBn1Mrl8a/uXkintqFrjLPDs47+yfU6oxzyPkutJnib9bdoKqNePqtIkrSM0CgGvMlY9sF+qcyXRO2LqXysqUX4ZESnFxjuAwzqe6VTxRrjSbNIkMKoXEmBc0tiAUdI4DnaD6VB2tPCnwg92NnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091153; c=relaxed/simple;
	bh=/RPJDnmj1wnLOuXHIz8Zu67qn30P9XLcfUh27OAyoSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWUUxhsAOxtnZxzYyHwqo1kjDdQC6F5NlHwfUyehJRv6GzdpAK+dViKZffHy91bFjruXy8ecJGTeBBbrD2hysSeY8ThCjCE7RQRK5BBYT2sJbuEOLw9Rko33Uc+xPDWXyU1lP+c3qLnCFuUy5MftSicpTW7NYFf0SkJkGYD4C3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/BJqA+9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/BJqA+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738091151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JolcGbOSGzp6eu5YkbFpK9S0KiOkAPqtM0kc2Ch20+Q=;
	b=e/BJqA+9H7BVJ6gAjwe87xyA8xURSNKzeJcQ0s7wzwsq9csKG/j6XJl8ci8MdW3uVXd+mA
	tIVuebxVUX1TB63+GC8ZZFBniS7u8YDs8jeygnj48hSxeT+PD4rtG9RLF1oz1wC6xtCNwl
	Z+0Nb1LuUekHLbAssAiriuCfSH8GWL8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-82sw22yqOA-XVs3ptyD7Sg-1; Tue,
 28 Jan 2025 14:05:47 -0500
X-MC-Unique: 82sw22yqOA-XVs3ptyD7Sg-1
X-Mimecast-MFC-AGG-ID: 82sw22yqOA-XVs3ptyD7Sg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64CCB1956083;
	Tue, 28 Jan 2025 19:05:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.195])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6489218008D8;
	Tue, 28 Jan 2025 19:05:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-btrace@vger.kernel.org
Cc: Jeff Moyer <jmoyer@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2] doc: update RWBS descriptions
Date: Tue, 28 Jan 2025 14:05:44 -0500
Message-ID: <20250128190544.113575-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

New RWBS flags have been added. Document them.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 doc/blkparse.1   | 37 ++++++++++++++++++++++++++++++++++---
 doc/blktrace.tex | 21 ++++++++++++++++++---
 2 files changed, 52 insertions(+), 6 deletions(-)

v2:
- Keep the barrier operation in case the tool is run against old
  kernels [Jeff Moyer]

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 4c26baf..93aa449 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -435,10 +435,41 @@ Split
 
 .SH "RWBS DESCRIPTION"
 
-This is a small string containing at least one character ('R' for read, 'W'
-for write, or 'D' for block discard operation), and optionally either
-a 'B' (for barrier operations) or 'S' (for synchronous operations).
+This is a small string containing characters in the following order:
 
+.IP F
+Flush
+
+.IP R
+Read
+
+.IP W
+Write
+
+.IP D
+Discard
+
+.IP B
+Barrier
+
+.IP N
+Other operation
+
+.IP F
+Force Unit Access (FUA)
+
+.IP A
+Readahead
+
+.IP S
+Synchronous
+
+.IP M
+Meta
+
+.PP
+One of 'R', 'W', 'D', or 'N' is always present. The other characters are
+optional. Note that 'F' has two meanings, depending on its position.
 
 .SH "DEFAULT OUTPUT"
 
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 836ac4a..d747de7 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -653,9 +653,24 @@ X & Split \\ \hline
 \end{tabular}
 
 \subsubsection{\label{sec:act-table}RWBS Description}
-This is a small string containing at least one character ('R' for read,
-'W' for write, or 'D' for block discard operation), and optionally either
-a 'B' (for barrier operations) or 'S' (for synchronous operations).
+This is a small string containing characters in the following order:
+
+\begin{tabular}{|l|l|}\hline
+Character & Description \\ \hline\hline
+F & Flush \\ \hline
+R & Read \\ \hline
+W & Write \\ \hline
+D & Discard \\ \hline
+B & Barrier \\ \hline
+N & Other operation \\ \hline
+F & Force Unit Access (FUA) \\ \hline
+A & Readahead \\ \hline
+S & Synchronous \\ \hline
+M & Meta \\ \hline
+\end{tabular}
+
+One of 'R', 'W', 'D', or 'N' is always present. The other characters are
+optional. Note that 'F' has two meanings, depending on its position.
 
 \subsubsection{\label{sec:default-output}Default output}
 
-- 
2.48.1

