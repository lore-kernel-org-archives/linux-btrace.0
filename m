From: Phillip Susi <psusi@ubuntu.com>
Date: Wed, 31 Dec 2014 15:09:22 +0000
Subject: Re: Events out of order
Message-Id: <54A411A2.1060605@ubuntu.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <54A355D2.5060704@ubuntu.com>
In-Reply-To: <54A355D2.5060704@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/31/2014 9:58 AM, Chris Mason wrote:
> It's been a while since I looked at this, but looks like blkparse
> has a pipeline mode and a more exact mode.  In pipeline mode, it's
> really trying to get data to the screen quickly and without using a
> huge amount of resources.  In order to put things in order, it
> would need to buffer the entire stream before outputting anything.
> So instead it works in chunks, which is what you're seeing.

Makes sense; it would be nice if the man page mentioned this drawback.

> It enables pipeline mode when the input file from -i is a pipe.
> You'll get better results if you allow blktrace to output into a
> collection of files and pass the prefix to blkparse.
>=20
> instead of blktrace -o - use blktrace -o prefix ; blkparse -i
> prefix
>=20
> For multiple devices, iowatcher uses a directory to store all of
> them, which is easier.
>=20
> If you really want a single file result, take the per-cpu files
> from blktrace, run them through blkparse and add -d dumpfile, which
> will sort and pack all the results into a single binary file.  It's
> compressable and you can then delete all the per-cpu files.

Thanks; I thought I read something like that at one point but couldn't
find it in the man page last night.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUpBGiAAoJENRVrw2cjl5R5EcH/AoLTOH7JzM62//2/V4Ely5U
OTnDkD4Aq2ydS7SQ3otidPnCJ46zCwlACZxJHknxM3RkLkXQUsqjXJ9J0l6Bitav
u06jZHyr07d9ysRexeLMpPJsdzFzrY41G8ZjTNFJJBGgNv/y8zlqT1gXZ8QjJYjw
XSsBVy+8D7yPJRAwX7eXbrfwKRfe16N+ujQC1DXnVOVKDKeP1inG7vRDdUuzjciA
63Gf8Kdk8E4Rlh9zyR8QWSB15Tp92/bLIeoJjZIoqsLlrRFoizREyPLpVXhg3Zhn
M6C+/H9cm+wB2KDiDESLm7uNyokYeAyQGbesj7/WTj/Lccv29drFMF9cCYLk4nk=BFZz
-----END PGP SIGNATURE-----
