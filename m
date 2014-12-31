From: Phillip Susi <psusi@ubuntu.com>
Date: Wed, 31 Dec 2014 01:48:02 +0000
Subject: Events out of order
Message-Id: <54A355D2.5060704@ubuntu.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I captured a trace with blktrace -d /dev/sde -o - > trace, then later
parsed it with blkparse -i - < trace, and the events are out of order.
 It appears that they come in blocks from one cpu, then the other cpu,
and the timestamps roll backwards when switching to the other cpu.
Why aren't they in the proper order?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJUo1XSAAoJENRVrw2cjl5RjS8H/2fiGBHhJ9PRwjAMEBAIqtgj
Oaz3BDI/ilA9+feGs39/YWrKJbgPr3p+1Sat6I7rxwt6sSPm8+O/NkwEQDZQAund
R5Urinh0Yov5I0mxUawhJs24YzrWiA8IfEdb7Nu772ihfKge6j32h734RvG9HSDh
SaSAOFAoAdDQx2aMR/AFdq9VlO2/dwpUgW2CxyehO341lHwpE6qjAITQ6aLtOJr9
lMAwTxifBdzsnGjafe/bawTqmwCj0ZA+SVTsDHJYFDcO1EpCo6llt3CG4bgXHXB0
Kk6RBHS+7aXlQybCPg5J2/jvfED0ohX4CFqGxuKU5t1+ZJKcYDCDZtd2rp7C6b4=qZgI
-----END PGP SIGNATURE-----
