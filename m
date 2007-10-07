From: Joshua Root <jmr@gelato.unsw.edu.au>
Date: Sun, 07 Oct 2007 04:44:02 +0000
Subject: [PATCH] Fix crash with btreplay -v
Message-Id: <47086412.90601@gelato.unsw.edu.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070904080207080507070809"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------070904080207080507070809
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

tip->vfp is only initialised when verbose > 1, so we must only use it
under the same circumstance.
-- 
Joshua Root,  jmr AT gelato.unsw.edu.au
http://www.gelato.unsw.edu.au

--------------070904080207080507070809
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="0001-Fix-crash-with-btreplay-v.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="0001-Fix-crash-with-btreplay-v.patch"

IGJ0cmVwbGF5L2J0cmVwbGF5LmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9idHJlcGxheS9idHJl
cGxheS5jIGIvYnRyZXBsYXkvYnRyZXBsYXkuYwppbmRleCA4OTg4MWNiLi4xODA4YjM1IDEw
MDY0NAotLS0gYS9idHJlcGxheS9idHJlcGxheS5jCisrKyBiL2J0cmVwbGF5L2J0cmVwbGF5
LmMKQEAgLTEzMjcsNyArMTMyNyw3IEBAIHN0YXRpYyB2b2lkICpyZXBsYXlfc3ViKHZvaWQg
KmFyZykKICAgICAgICBzZXRfcmVwbGF5X3JlYWR5KCk7CiAgICAgICAgd2hpbGUgKCFpc19z
ZW5kX2RvbmUodGlwKSAmJiB0aXAtPml0ZXJhdGlvbnMtLSkgewogICAgICAgICAgICAgICAg
d2FpdF9pdGVyX3N0YXJ0KCk7Ci0gICAgICAgICAgICAgICBpZiAodmVyYm9zZSkKKyAgICAg
ICAgICAgICAgIGlmICh2ZXJib3NlID4gMSkKICAgICAgICAgICAgICAgICAgICAgICAgZnBy
aW50Zih0aXAtPnZmcCwgIlxuPT09ICVkID09PVxuIiwgdGlwLT5pdGVyYXRpb25zKTsKICAg
ICAgICAgICAgICAgIHdoaWxlICghaXNfc2VuZF9kb25lKHRpcCkgJiYgbmV4dF9idW5jaCh0
aXAsICZidW5jaCkpCiAgICAgICAgICAgICAgICAgICAgICAgIHByb2Nlc3NfYnVuY2godGlw
LCAmYnVuY2gpOwo=
--------------070904080207080507070809--
