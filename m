From: Phillip Susi <psusi@ubuntu.com>
Date: Wed, 31 Dec 2014 01:51:51 +0000
Subject: Events out of order
Message-Id: <54A356B7.302@ubuntu.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <54A355D2.5060704@ubuntu.com>
In-Reply-To: <54A355D2.5060704@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I captured a trace with blktrace -d /dev/sde -d /dev/sdf -o - > trace,
then parsed it with blkparse -i - < trace, and I have noticed that the
events are out of order.  They appear to come in batches from one cpu,
then the other, and when transitioning from one batch to the other,
the timestamps roll backwards.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJUo1a3AAoJENRVrw2cjl5RPEYH/1q7V0fKvMXRtGWtaHrxkefp
Wzjyh8MekQL2gRROq0Fa7pjwUtGAsfuFW9K8RmFtJaNBemM+zWRXkF7vX6CPjVG+
IqO65M628b12A/GLmwPkK1vZ4qM/x2SE9h+JpUH068QUKQw+EyEVEIxrflC6al+S
LBY/mST0HOFog3dYOK7Bx6rKbRfyNOiw729xltq8Vpwn5HVHl3R3ZzvFir1ZV1VX
2foZquHEfFJsb9hHE4QZylBCqLE6txFnAW6PitqNtJyy8ow82Q+gyw2xSeTvxGJH
4KDWVbsTLYRihIf1dg+Uk7gEfIejO21H8Cb/O33RD7iHQO+uyuaE1UP9TNgyS6w=hj/D
-----END PGP SIGNATURE-----
