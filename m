From: Jeff Moyer <jmoyer@redhat.com>
Date: Tue, 04 Jan 2011 14:38:43 +0000
Subject: Re: Direct IO
Message-Id: <x49mxngag3w.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <AANLkTik7PpJCY_F9Mcd_jo-T-9xBP6e7iqe9EA2J1sqO@mail.gmail.com>
In-Reply-To: <AANLkTik7PpJCY_F9Mcd_jo-T-9xBP6e7iqe9EA2J1sqO@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

ARH <haghdoost@gmail.com> writes:

> Hello
>
> Does any one know how I can enable direct IO in Linux to bypass buffer
> and page caches ?

This isn't really the right list for this question.  Anyway, try
searching the open(2) man page for O_DIRECT.  That should get you
started.

Cheers,
Jeff
