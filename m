Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531513698F
	for <linux-btrace@vger.kernel.org>; Mon,  7 Oct 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728335571; cv=none; b=pGVNdsuIgthz40/hctPywba7CtBy9+xdm3FbZ+mg/uDz3ZsPZZUiQ2pur31uazUwnfZBZHAL6V0vkyALMNi/6Z12dNMEKdj1Iw1zwlgmAAKbM6KwxvzAsUprxxhvFm1J4RrdjRsVCG75hulf1oXrpfncXMUDuwYS//S6Vs2ZRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728335571; c=relaxed/simple;
	bh=ZuohLnnC2ILqrQOUyMFsj/ANEOTpAy13BftIUmVPdio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hWYc2JJcNOgT4xVeiRNamW2z1R8wlvKJ0gPfTtl9RGIOpbKrqCTv3NWyEgmBN82eODQVGr8Bf/yKa92NsNF/yqSRQ7/9qtJjeIfGuAkGNqBSMKlLzoi+qJTTV9pV+TFbtZ7kfFX3Zc0MlsRPMW1ThSyhW1DdFlrRFeX7gkoGhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhBJJUCo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhBJJUCo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e25a6fdde8so78757867b3.2
        for <linux-btrace@vger.kernel.org>; Mon, 07 Oct 2024 14:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728335569; x=1728940369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=12gMoK5ruCKG+G5/zC7c6BxpE8VHv0YCip+lGFpzNp0=;
        b=MhBJJUCo7fifN4t0TUm7hic9vJx9yl8KGCMR0efCFY/3xHcv1UQjCz0mdPOtmD54q8
         uUMwFhAo+kxcinYOWkK1AJRZGlhP1vsKeNlK9P3cC+N5FGW5pQ91j2LsJ4mV3q5Q9yUt
         HTHTFq8tAGA2WfFGF82FIjPzQi4umqibjVGdZBFWw37IY1CwqvKybmPParFhj13xqYSo
         +pecFdjggA6imsLjuUdvGVIQvjny/IUuY2WQWx2yu+eVsT5t4LTPZzCjiekTAi3RE/NG
         XSDtoad1TfW6+Nq29Dw94NR8lzIELIS+Z7mqYgJr3uHeookCOfjVS4wmoT4NPrAKseYW
         +O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728335569; x=1728940369;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12gMoK5ruCKG+G5/zC7c6BxpE8VHv0YCip+lGFpzNp0=;
        b=G203Eek3HDyywBpWIHdWh0alJk0TpkrBp6p2KwFjdJHSVnw4K7KV+ZEOjQL+2rHMFb
         Mo2b7VZvoH10Oby/KE/d21N4u7iH/OQi71PzzQ+jfKe2JH2ScT01AKoVRUtM+XyqBMSG
         9JdTPoZdEwXluN9khjfrSa/AMGTkpvrr+22CzJFvdkd3Du63UjBLVmmMTOv4OdMqySUx
         69/BGfmHDj2KYE45cZVRcHTrFpE3ccdCE49K1ho8JWBDVXeus4t+hXZizoLXykSrZYPb
         ii2iB6ygmHGFinOFbzXffAIjZPAd6lGVAaW77NqxEszuagoXHYkUhlrhE5x/O/UJb6+M
         3JIw==
X-Gm-Message-State: AOJu0YyzdASswUunFEu2SdwTAjqeF2gYHd7S2xGPS5YnHL7hBftn/WhR
	xeKwBqVbiYKJJtTHXzAMMg0+//F7fXAX6F0DItgeZRh6gX3GQriJkFngPByC/MPQRZ//Yw0AH73
	ZBozEBcdnlA==
X-Google-Smtp-Source: AGHT+IEN/dZG/e4N/ffM191YpnF2OsCe5tMEafKmFLYvrZeemL8R+9itIXnEfe4St1DUkzMBSej+itBhT1A9Tg==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:ef:85c8:ac13:4138])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:4a8:b0:e28:e4a7:3206 with SMTP
 id 3f1490d57ef6-e28e4a732e6mr10302276.8.1728335568635; Mon, 07 Oct 2024
 14:12:48 -0700 (PDT)
Date: Mon,  7 Oct 2024 21:12:43 +0000
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241007211243.1351143-1-ipylypiv@google.com>
Subject: [PATCH] iowatcher: Calculate ios_in_flight per trace
From: Igor Pylypiv <ipylypiv@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-btrace@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

When multiple trace files are passed, the generated queue depth graph
ends up adding queue depths from previous traces.

iowatcher -t blktrace1 -t blktrace2

Assuming blktrace1 has a queue depth of 8 and blktrace2 has a queue depth
of 32, the resulting graph will display blktrace1 with a queue depth of 8
and blktrace2 with a queue depth of 40 instead of 32.

Replace global ios_in_flight with a per trace ios_in_flight to show
a correct queue depth for a given trace.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 iowatcher/blkparse.c | 13 ++++++-------
 iowatcher/blkparse.h |  1 +
 2 files changed, 7 insertions(+), 7 deletions(-)

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
-- 
2.47.0.rc0.187.ge670bccf7e-goog

