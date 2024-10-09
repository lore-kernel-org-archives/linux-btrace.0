Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0B19068E
	for <linux-btrace@vger.kernel.org>; Wed,  9 Oct 2024 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475218; cv=none; b=Ds2j2rJ3RXQ59GCqxMebvzMFyqzP2DRyM9U1XvoRimJoLng3NmXHPPd4IWCWq0pWznjGpLGoPkWRbyICEbZqFaE7yj4YYmKiSERKTIHfkkkAZ7FuTIBde+HTOLfVhHdkundm44V5VqhTmCQ4JJs9hAltrfe7ZvQsP4D+IxuuhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475218; c=relaxed/simple;
	bh=MYEqzVBPx3QtT9S3XO+zKlYp0fW1wjsZqPoYVdUJ/Zo=;
	h=Subject:From:To:Message-Id:Date; b=cmB7TyIqBM9gSSAEjE7eLTfppBAH0sEzG56SZpGOHE5ubGTTgFEHIABDEF4ca6Syt2Ix9yGQRguhH90RYqQOaSVdiKFGmsZjC4xkUyV3O1Y0BxYZHRX95R3LPJi+EKixFtVjeZyc0BMxjGcfwv8Wxt6Pu46v2OT05Fqis0n1fm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=fail smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WfXgW+8I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WfXgW+8I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Date:Message-Id:To:From:Subject:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=9qSNYPmDubv144SstOqCm8Iy7SbMVQJBMONz/bu6HFw=; b=WfXgW+8ImxikrgvZvMUjgxk6Fa
	I9FTubaG7RjuMBkYBdXZCymuB9nI5C2rui7q1hdYh4UBWNAfL8eRnrFogPmf/QZMvVzpO6ASaL8Ye
	SfHYuGMtF+vbzdeYjzCvWmp3kglsqKVMXYM+9YfA5cjTB588PnGex7nh3RzEsH3uAmiMK7fb2q5Hy
	vwCpCVlNXYfDd3JoXxfjB2SEtYlGM/Ua/vXvMZBSRkHjJw35XEC9P+SCpKiWOfrpUcokvC7SaOrkH
	RZwuceDp2MM4k61GmxPfgwq0MDWKHVWbSkBlo71Ebe4+ft7b1a2A1fRNvKdBHwHV9J1juMjhpurkS
	Td1Ag3kw==;
Received: from [96.43.243.2] (helo=kernel.dk)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syVMR-00000004lJf-49KX
	for linux-btrace@vger.kernel.org;
	Wed, 09 Oct 2024 12:00:12 +0000
Received: by kernel.dk (Postfix, from userid 1000)
	id 132AE1BC014D; Wed,  9 Oct 2024 06:00:02 -0600 (MDT)
Subject: Recent changes (master)
From: Jens Axboe <axboe@kernel.dk>
To: <linux-btrace@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 3.7)
Message-Id: <20241009120002.132AE1BC014D@kernel.dk>
Date: Wed,  9 Oct 2024 06:00:02 -0600 (MDT)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>

The following changes since commit 1836be5d99c9362f1e2b39206c95270f19cb7faa:

  fix hang when BLKTRACESETUP fails and "-o -" is used (2024-06-12 14:45:58 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to f49e7ded6405bcecd10846a614f40061ca6301c8:

  iowatcher: Calculate ios_in_flight per trace (2024-10-08 07:40:39 -0600)

----------------------------------------------------------------
Igor Pylypiv (1):
      iowatcher: Calculate ios_in_flight per trace

 iowatcher/blkparse.c | 13 ++++++-------
 iowatcher/blkparse.h |  1 +
 2 files changed, 7 insertions(+), 7 deletions(-)

---

Diff of recent changes:

diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index 6203854..0518083 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -41,7 +41,6 @@
 #define IO_HASH_TABLE_BITS  11
 #define IO_HASH_TABLE_SIZE (1 << IO_HASH_TABLE_BITS)
 static struct list_head io_hash_table[IO_HASH_TABLE_SIZE];
-static u64 ios_in_flight = 0;
 
 #define PROCESS_HASH_TABLE_BITS 7
 #define PROCESS_HASH_TABLE_SIZE (1 << PROCESS_HASH_TABLE_BITS)
@@ -1037,8 +1036,8 @@ void add_pending_io(struct trace *trace, struct graph_line_data *gld)
 		return;
 	}
 	if (action == __BLK_TA_REQUEUE) {
-		if (ios_in_flight > 0)
-			ios_in_flight--;
+		if (trace->ios_in_flight > 0)
+			trace->ios_in_flight--;
 		return;
 	}
 	if (action != __BLK_TA_ISSUE)
@@ -1054,10 +1053,10 @@ void add_pending_io(struct trace *trace, struct graph_line_data *gld)
 	}
 
 account_io:
-	ios_in_flight++;
+	trace->ios_in_flight++;
 
 	seconds = SECONDS(io->time);
-	gld->data[seconds].sum += ios_in_flight;
+	gld->data[seconds].sum += trace->ios_in_flight;
 	gld->data[seconds].count++;
 
 	avg = (double)gld->data[seconds].sum / gld->data[seconds].count;
@@ -1088,8 +1087,8 @@ void add_completed_io(struct trace *trace,
 	if (!pio)
 		return;
 
-	if (ios_in_flight > 0)
-		ios_in_flight--;
+	if (trace->ios_in_flight > 0)
+		trace->ios_in_flight--;
 	if (io->time >= pio->dispatch_time) {
 		latency = io->time - pio->dispatch_time;
 		latency_gld->data[seconds].sum += latency;
diff --git a/iowatcher/blkparse.h b/iowatcher/blkparse.h
index fce9d01..f828763 100644
--- a/iowatcher/blkparse.h
+++ b/iowatcher/blkparse.h
@@ -57,6 +57,7 @@ struct trace {
 	int mpstat_fd;
 	int mpstat_seconds;
 	int mpstat_num_cpus;
+	u64 ios_in_flight;
 
 	char *fio_start;
 	char *fio_cur;
