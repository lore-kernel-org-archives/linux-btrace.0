From: Phillip Susi <psusi@ubuntu.com>
Date: Wed, 31 Dec 2014 14:36:36 +0000
Subject: Re: Events out of order
Message-Id: <54A409F4.8050007@ubuntu.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <54A355D2.5060704@ubuntu.com>
In-Reply-To: <54A355D2.5060704@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/30/2014 11:29 PM, Alireza Haghdoost wrote:
> Seems to me like you don't run blktrace and blkparse
> appropriately. blktrace stores IO trace in multiple files where
> each file is associated to a CPU core. However, you force the
> output of blktrace to redirect into a single file. This make some
> timing Confusion for blkparse in the next step. You are using live
> blkparse option (-i -) inappropriately. If you want to run live
> blkparse, you need to feed it through blktrace pipe. Like: 
> #blktrace -d /dev/sda -o - | blkparse -i -
> 
> If you want to store trace in a file then parse it offline, you
> need to use --input option of blkparse.

Whether it is piped directly, or buffered in a file on disk makes no
difference; blkparse sees exactly the same input byte for byte, and
produces the same output.  The man page recommends this interactive
method and doesn't mention that it borks up the ordering, but I
suppose I can try it the other way and see if that helps.  If the
interactive method doesn't work correctly it should either be fixed or
the man page should mention this and not recommend its use.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUpAn0AAoJENRVrw2cjl5Rt98H/R+QLa7VQ2uWIv2yJmUPQDX/
9+qExZ1lEpJ39dtzDVZJwVISNQvUtEUA42hzPetuO3NQjiamThsh4koEw2cvr46G
m809gpMy9LifkxqG8ufE+sp9FAReoRhZ/9wjFWiMcWLP4JnmssRnJCs953PzVYNF
i6kYeRXqKJS8kWE1j9lXPtFCDhjhBRVoHCevBa3IxdP5Ri83YpQdLscvoXjSNSwe
NOiJloFO0tvbO7Lj5UY1rhB8ZNLxyGqSHeiEMUWiqTZONffEBoDmNiS6om36Qpjp
2kim1Ug838a61AgGkZHR8m4CRoUMLKDprG9mKOGlZKH8pIp9Y5iO0Md17OiY48c=VgcL
-----END PGP SIGNATURE-----
