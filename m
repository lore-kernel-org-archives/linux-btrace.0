Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF654764
	for <linux-btrace@vger.kernel.org>; Tue, 21 Jan 2025 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737501054; cv=none; b=NWn6WakPBRlkaOqCrbaIXgq5PcdVt91GQgc0vkbP3CwX1dRA84mqX2o6EUl3h3D0aQvbad907jG/45XNny2PS4glxJTqgWWBuBYgE5pd8WFZ1tmz/UDTo1vQ4liCUVFYC/kOQa0TQPdbRoWyjAFbSEmNdMETTI+EVMy4GMDIRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737501054; c=relaxed/simple;
	bh=z0uSlygOrIP7Avu8tVR+1tHhMH++hE3sb5WTEYgGqzA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fiifs4VMfurzI/psFSni/XQoOH65TEowwxaSdHfWzKFiWekVjpkv38t9FQV/TvrtcEF8uVaY3OQLEcfjaMDeqxAkhucRwkozQfkQt6xbpG24/zV6sO4fHqjuSP/bXAUScm6mXzdGj68MHbCN4NWMM2Vq6mQhY0MD8tKjHXsPcjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zh3TIuZG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zh3TIuZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737501051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZY7wG6jibFrdkFX0nqsL7tgK+jn0mPtL3nsNxkj6qrw=;
	b=Zh3TIuZGQ60JSX5+9DqYT9/hCIMJd2kKlw6p6tKdDCq3xXDAQS5qkj29crqco1wAwzDbXM
	TPj+yWnyUQ/8lNM8ghWCjm16mF1EDpo7oEVcouSuLghWKB4lyjqj9QOd2EgkVS8enO5UEW
	ZPuv5DEIhkmol05zgcuEpJ8XVLj0mIY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-OjurU-ZIMHuOghwHPJk8sA-1; Tue,
 21 Jan 2025 18:10:47 -0500
X-MC-Unique: OjurU-ZIMHuOghwHPJk8sA-1
X-Mimecast-MFC-AGG-ID: OjurU-ZIMHuOghwHPJk8sA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1648195608D;
	Tue, 21 Jan 2025 23:10:45 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.88.205])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5C1F19560AA;
	Tue, 21 Jan 2025 23:10:44 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Stephen Bates <sbates@raithlin.com>
Cc: linux-btrace@vger.kernel.org,  axboe@kernel.dk
Subject: Re: [PATCH v1 1/1] blktrace/events: Add an option to stop blktrace
 upon a number of events
References: <Zz-tpw-CsW2CHLzP@snoc-pinewood>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 21 Jan 2025 18:10:42 -0500
In-Reply-To: <Zz-tpw-CsW2CHLzP@snoc-pinewood> (Stephen Bates's message of
	"Thu, 21 Nov 2024 15:01:11 -0700")
Message-ID: <x49o6zzoj9p.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

--=-=-=
Content-Type: text/plain

Hi, Stephen,

Stephen Bates <sbates@raithlin.com> writes:

> It is useful to be able to run blktrace in a way that it stops when a
> certain number of events is reached. This patch adds a new -e/--events
> command line argument. Note this limit is per block device and can be
> used in combination with the -w/--stopwatch argument.
>
> Documentation is updated to include the new argument.
>
> Signed-off-by: Stephen Bates <sbates@raithlin.com>
> ---
>  README           |  3 ++-
>  blktrace.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
>  doc/blktrace.8   | 15 +++++++++++++--
>  doc/blktrace.tex |  7 ++++++-
>  4 files changed, 69 insertions(+), 5 deletions(-)
>

[...]

> diff --git a/blktrace.c b/blktrace.c
> index 038b2cb..bc3fe84 100644
> --- a/blktrace.c
> +++ b/blktrace.c
> @@ -282,6 +282,8 @@ static int pagesize;
>  static int act_mask = ~0U;
>  static int kill_running_trace;
>  static int stop_watch;
> +static unsigned long long  events;

I'm not sure events needs to be that large, but I guess it's fine.
There is an extra space in there, though.

> +static volatile int events_done;

[...]

> @@ -1862,6 +1872,34 @@ static void *thread_main(void *arg)
>  		else if (ndone < 0 && errno != EINTR)
>  			fprintf(stderr, "Thread %d poll failed: %d/%s\n",
>  				tp->cpu, errno, strerror(errno));
> +
> +		if (ndone && events) {
> +			struct list_head *p;
> +			unsigned long long nevents;
> +
> +			__list_for_each(p, &devpaths) {
> +				int cpu;
> +				struct pdc_stats *sp;
> +				struct devpath *dpp = list_entry(p, struct devpath, head);
> +				nevents = 0;
> +
> +				for (cpu = 0, sp = dpp->stats; cpu < dpp->ncpus; cpu++, sp++) {

> +					/*
> +					 * Estimate events if not known...
> +					 */
> +					if (sp->nevents == 0) {
> +						nevents += sp->data_read /
> +							sizeof(struct blk_io_trace);
> +					} else
> +						nevents += sp->nevents;

That bit was copied from show_stats() and can probably be factored out.

> +
> +				}
> +				if (events && (nevents >= events))

redundant check for non-zero 'events'.

> +					events_done = 1;

Why continue to loop if you've already established that the event count
was reached?

> +			}
> +			if (events_done)
> +				tp->is_done = 1;
> +		}
>  	}

It would be nice to keep to 80 columns.  This whole stanza could
probably be its own function.

More importantly, I think you may run into trouble, here.  tp->is_done
is set to 1, which breaks out of the loop, but then this code runs:

	/*
	 * Trace is stopped, pull data until we get a short read
	 */
	while (handle_pfds(tp, ndevs, 1) > 0)
		;

which has the potential to run indefinitely if your storage is busy, I
think.  Have a look at what stop_tracers() does (which is currently the
only place tp->is_done gets set).  I just tested your patch and
confirmed that blktrace does not exit for me, even after I stop my
workload.

Next, the code is reading through per-cpu data without any coordination
with the writers.  I think it's fine, but I do expect a comment
explaining what it's doing and why it is safe.

Here's a patch that shows what I'm thinking.  It is not in final form (I
didn't modify show_stats() to used the helper function, for example),
but please feel free to work from there if it's convenient for you.  I
did test it lightly, and it at least exits after a number of events.
Note that if you want to specify a small number of events, you'll also
have to restrict the buffer size.  The default of 512k will hold over
10,000 events (per cpu).

Cheers,
Jeff


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=blktrace-add-event-option.patch

diff --git a/README b/README
index d7d1fbf..7fd803b 100644
--- a/README
+++ b/README
@@ -38,7 +38,7 @@ Usage
 -----
 
 $ blktrace -d <dev> [ -r debug_path ] [ -o output ] [ -k ] [ -w time ]
-		    [ -a action ] [ -A action mask ]
+		    [ -e events] [ -a action ] [ -A action mask ]
 
 	-d Use specified device. May also be given last after options.
 	-r Path to mounted debugfs, defaults to /sys/kernel/debug.
@@ -46,6 +46,7 @@ $ blktrace -d <dev> [ -r debug_path ] [ -o output ] [ -k ] [ -w time ]
 	-D Directory to prepend to output file names.
 	-k Kill running trace.
 	-w Stop after defined time, in seconds.
+	-e Stop after defined captured trace events.
 	-a Only trace specific actions (use more -a options to add actions).
 	   Available actions are:
 
diff --git a/blktrace.c b/blktrace.c
index 038b2cb..58d3064 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -282,6 +282,7 @@ static int pagesize;
 static int act_mask = ~0U;
 static int kill_running_trace;
 static int stop_watch;
+static unsigned long long events;
 static int piped_output;
 
 static char *debugfs_path = "/sys/kernel/debug";
@@ -329,7 +330,9 @@ static int *cl_fds;
 static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
-#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
+static void stop_tracers(void);
+
+#define S_OPTS	"d:a:A:e:r:o:kw:vVb:n:D:lh:p:sI:"
 static struct option l_opts[] = {
 	{
 		.name = "dev",
@@ -355,6 +358,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'A'
 	},
+	{
+		.name = "events",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'e'
+	},
 	{
 		.name = "relay",
 		.has_arg = required_argument,
@@ -444,6 +453,7 @@ static char usage_str[] = "\n\n" \
         "[ -o <file>          | --output=<file>]\n" \
         "[ -D <dir>           | --output-dir=<dir>\n" \
         "[ -w <time>          | --stopwatch=<time>]\n" \
+        "[ -e <events>        | --events=<number>]\n" \
         "[ -a <action field>  | --act-mask=<action field>]\n" \
         "[ -A <action mask>   | --set-mask=<action mask>]\n" \
         "[ -b <size>          | --buffer-size]\n" \
@@ -461,6 +471,7 @@ static char usage_str[] = "\n\n" \
 	"\t-o File(s) to send output to\n" \
 	"\t-D Directory to prepend to output file names\n" \
 	"\t-w Stop after defined time, in seconds\n" \
+	"\t-e Stop after defined number of trace events\n" \
 	"\t-a Only trace specified actions. See documentation\n" \
 	"\t-A Give trace mask as a single value. See documentation\n" \
 	"\t-b Sub buffer size in KiB (default 512)\n" \
@@ -1833,6 +1844,47 @@ static int handle_pfds_entries(struct tracer *tp, int nevs, int force_read)
 	return nentries;
 }
 
+unsigned long long get_events(struct pdc_stats *sp)
+{
+	unsigned long long events;
+	/*
+	 * Estimate events if not known...
+	 */
+	if (sp->nevents == 0)
+		events = sp->data_read / sizeof(struct blk_io_trace);
+	else
+		events = sp->nevents;
+
+	return events;
+}
+
+/*
+ * Check to see if we have exceeded the requested number of events.
+ * NOTE: this code reads through per-cpu data that is actively being
+ * modified by other cpus.  Given that this is a counter, and that the
+ * worst thing that happens is the program exits earlier than expected,
+ * this should be safe.
+ */
+static void check_events(void)
+{
+	struct list_head *p;
+
+	__list_for_each(p, &devpaths) {
+		int cpu;
+		struct pdc_stats *sp;
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+		unsigned long long nevents = 0;
+
+		for (cpu = 0, sp = dpp->stats; cpu < dpp->ncpus; cpu++, sp++) {
+			nevents += get_events(sp);
+			if (nevents >= events) {
+				stop_tracers();
+				return;
+			}
+		}
+	}
+}
+
 static void *thread_main(void *arg)
 {
 	int ret, ndone, to_val;
@@ -1862,6 +1914,8 @@ static void *thread_main(void *arg)
 		else if (ndone < 0 && errno != EINTR)
 			fprintf(stderr, "Thread %d poll failed: %d/%s\n",
 				tp->cpu, errno, strerror(errno));
+		if (events && ndone)
+			check_events();
 	}
 
 	/*
@@ -2155,6 +2209,15 @@ static int handle_args(int argc, char *argv[])
 			break;
 		}
 
+		case 'e':
+			events = strtoull(optarg, NULL, 10);
+			if (events == 0) {
+				fprintf(stderr,
+					"Invalid events value (%llu)\n",
+					events);
+				return 1;
+			}
+			break;
 		case 'r':
 			debugfs_path = optarg;
 			break;
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 820b03a..b32cede 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -6,7 +6,7 @@ blktrace \- generate traces of the i/o traffic on block devices
 
 
 .SH SYNOPSIS
-.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
+.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [ \-w \fItime\fR ] [ \-e \fIevents\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
 .br
 
 
@@ -69,7 +69,11 @@ The default behaviour for blktrace is to run forever until explicitly
 killed by the user (via a control-C, or sending SIGINT signal to the
 process via invocation the kill (1) utility). Also you can specify a
 run-time duration for blktrace via the \fB\-w\fR option -- then
-blktrace will run for the specified number of seconds, and then halt.
+blktrace will run for the specified number of seconds, and then
+halt. Or you can specify a number of records to capture via the
+\fB-e\fR option. Note that this will cause blktrace to stop when the
+first block device reaches this. The \fB-w\fR and \fB-e\fR options can
+be combined with the first one to be reached taking prescident.
 
 
 .SH OPTIONS
@@ -191,6 +195,13 @@ Outputs version
 Sets run time to the number of seconds specified  
 .RE
 
+\-e \fIevents\fR
+.br
+\-\-events=\fIevents\fR
+.RS
+Sets run to stop when the specifed number of events are captured for any one block device
+.RE
+
 
 .SH FILTER MASKS
 The following masks may be passed with the \fI\-a\fR command line
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 836ac4a..d78de8b 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -377,7 +377,12 @@ of the more arcane command line options:
     \item You can specify a run-time duration for blktrace via the
     \emph{-w} option -- then blktrace will run for the specified number
     of seconds, and then halt.
-  \end{enumerate}
+
+    \item You can specify a record entry duration for blktrace via the
+    \emph{-e} option -- then blktrace will run until the specified
+    number of records are captured for any of the block devices, and
+    then halt.
+\end{enumerate}
 \end{itemize}
 
 \subsection{\label{sec:blktrace-args}Command line arguments}

--=-=-=--

