From: Krzysztof Lichota <krzysiek@lichota.net>
Date: Tue, 12 Jun 2007 15:10:27 +0000
Subject: Re: blktrace crashing with 2.6.22-rc3
Message-Id: <466EB763.5020300@lichota.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig796A75501B27300860218200"
List-Id: <linux-btrace.vger.kernel.org>
References: <466E7226.7060609@lichota.net>
In-Reply-To: <466E7226.7060609@lichota.net>
To: linux-btrace@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig796A75501B27300860218200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jens Axboe napisa=C5=82(a):
>> Should I investigate it further or is it a known issue?
>
> I think it's a known issue. Don't run blktrace -k unless the trace is
> really stuck - does it work correctly if you just ctrl-c out of
> blktrace?

Yes, it works. I just got the impression that blktrace -k is the
preferred way of terminating the trace.

Thanks for help :)

	Krzysztof Lichota



--------------enig796A75501B27300860218200
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGbrdoSHJB/1EhaUwRAkPYAJ9Vulh8UIFV2EWXcBIHYxDiM2LaogCgsosE
jNYWhHsiWO2LGzm2VoZkn78=
=v9tu
-----END PGP SIGNATURE-----

--------------enig796A75501B27300860218200--
