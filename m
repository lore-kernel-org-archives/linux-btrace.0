From: Jeff Moyer <jmoyer@redhat.com>
Date: Thu, 28 May 2009 15:52:09 +0000
Subject: [patch] return a non-zero exit status when the BLKTRACETEARDOWN ioctl fails
Message-Id: <x49ws814446.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

I'm doing some scripting, and would really like to know when things
fail.  ;)

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/blktrace.c b/blktrace.c
index b4c919d..23f3eb5 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -2634,6 +2634,7 @@ int main(int argc, char *argv[])
 				fprintf(stderr,
 					"BLKTRACETEARDOWN %s failed: %d/%s\n",
 					dpp->path, errno, strerror(errno));
+				ret = 1;
 			}
 		}
 	} else if (net_mode = Net_server) {
