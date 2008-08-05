From: Nathan Scott <nscott@aconex.com>
Date: Tue, 05 Aug 2008 00:17:40 +0000
Subject: [patch] spec file tweak
Message-Id: <1217895460.4407.12.camel@verge.scott.net.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-g1if19/kGohztAg8DTVY"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org


--=-g1if19/kGohztAg8DTVY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I found I needed this tweak to make the spec file usable on a RHEL5
system (I hit rpmbuild errors about unpackaged files without this).
Not sure if its correct though, maybe someone with stronger rpm-fu
than I have could take a closer look?

cheers.

--
Nathan

--=-g1if19/kGohztAg8DTVY
Content-Disposition: attachment; filename=man.patch
Content-Type: text/x-patch; name=man.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/btrace.spec b/btrace.spec
index ad70957..90f88d8 100644
--- a/btrace.spec
+++ b/btrace.spec
@@ -48,6 +48,7 @@ rm -rf $RPM_BUILD_ROOT
 %defattr(-,root,root)
 %doc README doc/blktrace.pdf
 /usr/bin/*
+/usr/man/*
 
 %changelog -n btrace
 * Mon Oct 10 2005 - axboe@suse.de

--=-g1if19/kGohztAg8DTVY--

