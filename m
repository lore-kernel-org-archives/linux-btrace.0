From: Krzysztof Lichota <krzysiek@lichota.net>
Date: Tue, 12 Jun 2007 10:15:02 +0000
Subject: blktrace crashing with 2.6.22-rc3
Message-Id: <466E7226.7060609@lichota.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigA05F480E9C8CB281E56A30A9"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA05F480E9C8CB281E56A30A9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello!
I am trying to use blktrace on latest Ubuntu kernel for Gutsy
(2.6.22-rc3, git tree is at
git://kernel.ubuntu.com/ubuntu/ubuntu-gutsy.git and web frontend at
http://kernel.ubuntu.com/git).

I have compiled it with blktrace enabled and when I try to run
blktrace -k to stop tracing, it doesn't do anything, but in dmesg I can
see the messages:
[  239.499614] DebugFS rmdir on hda failed : directory not empty.
[  239.499637] DebugFS rmdir on block failed : directory not empty.

If I try to kill it afterwards using ^C, it shows message "BLKTRACESTOP:
invalid argument", crashes with segmentation fault (core file is empty)
and I cannot start it again.

This happens if I run blktrace using: blktrace -d /dev/hda -o somefile
(on the same partition which is traced).

If I use network mode, it works fine.

blktrace tools are pulled today using git:
$ cat .git/remotes/origin
URL: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git
Pull: refs/heads/master:refs/heads/origin

Should I investigate it further or is it a known issue?

Regards

	Krzysztof Lichota



--------------enigA05F480E9C8CB281E56A30A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGbnIsSHJB/1EhaUwRAtOCAJ0Y5YabOVJnTLZg76HN6N5IbPTJcgCg1u1F
K9+QBuPxBp38YNSwqVsb/fw=
=LGIc
-----END PGP SIGNATURE-----

--------------enigA05F480E9C8CB281E56A30A9--
