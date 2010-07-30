From: Edward Shishkin <edward@redhat.com>
Date: Fri, 30 Jul 2010 14:04:13 +0000
Subject: [patch 1/6] blktrace: btrecord man pages fixup
Message-Id: <4C52DBDD.5000007@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000708000800070605010601"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------000708000800070605010601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Edward O. Shishkin
Principal Software Engineer
Red Hat Czech


--------------000708000800070605010601
Content-Type: text/plain;
 name="8-blktrace-fix-595413.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8-blktrace-fix-595413.patch"

Fix up for bz 595413

Mistake in the man page for btrecord:
documented option --input-base is unsupported,
supported option --max-bunch-time is undocumented.

Signed-off-by: Edward Shishkin <edward@redhat.com>
---
--- blktrace-1.0.1.orig/doc/btrecord.8
+++ blktrace-1.0.1/doc/btrecord.8
@@ -107,7 +107,7 @@
 
 \-m <\fInanoseconds\fR>
 .br
-\-\-input\-base=<\fInanoseconds\fR>
+\-\-max\-bunch\-time=<\fInanoseconds\fR>
 .RS
 The \fI\-m\fR option requires a single parameter which specifies an
 amount of time (in nanoseconds) to include in any one bunch of IOs that

--------------000708000800070605010601--
