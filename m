From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Mon, 12 Jan 2009 09:38:12 +0000
Subject: Re: Missing pictures in "btt.pdf" when building from the git repo
Message-Id: <496B0F84.90504@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4969608E.9020400@cesmail.net>
In-Reply-To: <4969608E.9020400@cesmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

M. Edward (Ed) Borasky wrote:
> I've got an openSUSE 11.1 system with some of the later "factory"
> software installed. I've downloaded "blktrace" from the Git repo with
> "git clone". Everything seems to be building correctly, but the
> "btt.pdf" file isn't getting the figures. The LaTeX processing is
> generating errors. I've attached the log of the "make docs" step.
> 
> I'm guessing that I have the wrong versions of some of the LaTeX tools.
> Is anyone else having problems like this?

Hello Ed -

I'm not having any problems compiling the doc with LaTeX & DVIPDFM
versions:

$ latex --version
pdfTeX using libpoppler 3.141592-1.40.3-2.2 (Web2C 7.5.6)
kpathsea version 3.5.6
Copyright 2007 Peter Breitenlohner (eTeX)/Han The Thanh (pdfTeX).
Kpathsea is copyright 2007 Karl Berry and Olaf Weber.
There is NO warranty.  Redistribution of this software is
covered by the terms of both the pdfTeX using libpoppler copyright and
the Lesser GNU General Public License.
For more information about these matters, see the file
named COPYING and the pdfTeX using libpoppler source.
Primary author of pdfTeX using libpoppler: Peter Breitenlohner
(eTeX)/Han The Thanh (pdfTeX).
Kpathsea written by Karl Berry, Olaf Weber, and others.

Compiled with libpng 1.2.27; using libpng 1.2.27
Compiled with zlib 1.2.3.3; using zlib 1.2.3.3
Compiled with libpoppler version 3.00

$ dvipdfm --version

dvipdfm, version 0.13.2c, Copyright (C) 1998, 1999 by Mark A. Wicks

What versions are you running?

Regards,
Alan
