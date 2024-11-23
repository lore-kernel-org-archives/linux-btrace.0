Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4831933987
	for <linux-btrace@vger.kernel.org>; Sat, 23 Nov 2024 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732394419; cv=none; b=VYlIX4hE5NDHjo2EjzDSOCa8BVr2yMERJ6E54HjXeIBPQlQfC9vZ8/a+41bErQNrD3vScum8ZKpYRDjvtrGK74KD7WtumDAYby9Sat9183Jl7PY5Q7LJ1AwZjhMujycOpQOsTpWZqv2uINEpwHGKGZS86VF5YfZ1L/ToTxM4h1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732394419; c=relaxed/simple;
	bh=LPd1J632TOt/LcBpqrp0ryZXNoiYBcUyoc+mwyglsu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j//yce3t763IiYadBRUVVYQLGIW/TOoHMR/fcfmFwefjnaedUGVU5TNiXi6/wuPgQUme00s/SNPxVYTYufkq4xpe0YEouNRj79G/L6bzxBLpIHugQesR5K/DRDpy09bJtHDdEH/wV95E3lf7FC5LxYhBXutfuX9/+siNv0bhyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QS1HTZT6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QS1HTZT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732394416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LvL9BpvGoL48+RPiiEBd01wxDbfw7PFCz77PSTIkAMc=;
	b=QS1HTZT6qNzsxCcilOrtedDKv6cry4HjK+BkcXT8dGnq4m5fl5bkpv5Wpihz1kKrYP97ct
	tPe9LSM9HTaP7twf0/tvj3QlbAU1xznoddf4Gfb0bA5h6kr/kCH9NQMZSO4RZvTn5ik7p0
	BpTQ5je6fVI9CkCPoD98y6x+fs1AiL4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-RWbVbOquPB-Fs6ZxuSMLjw-1; Sat,
 23 Nov 2024 15:40:14 -0500
X-MC-Unique: RWbVbOquPB-Fs6ZxuSMLjw-1
X-Mimecast-MFC-AGG-ID: RWbVbOquPB-Fs6ZxuSMLjw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A33631955F41;
	Sat, 23 Nov 2024 20:40:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.13])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A6671956089;
	Sat, 23 Nov 2024 20:40:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-btrace@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] doc: update RWBS descriptions
Date: Sat, 23 Nov 2024 15:40:10 -0500
Message-ID: <20241123204010.519984-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Barriers no longer exist but a number of other flags have been added.
Document them.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 doc/blkparse.1   | 34 +++++++++++++++++++++++++++++++---
 doc/blktrace.tex | 20 +++++++++++++++++---
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 4c26baf..722efff 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -435,10 +435,38 @@ Split
 
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
index 836ac4a..6a33fb6 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -653,9 +653,23 @@ X & Split \\ \hline
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
2.47.0

