From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 10 Feb 2009 17:51:37 +0000
Subject: Re: Blktrace - does a copy exists for Linux? Fedora?
Message-Id: <4991BEA9.6000501@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <000B351FECDA9F46A8C796980F321808275C11@CORPUSMX100B.corp.emc.com>
In-Reply-To: <000B351FECDA9F46A8C796980F321808275C11@CORPUSMX100B.corp.emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Melman_Yael@emc.com wrote:
> How can I get a copy of the blktrace and blkparse programs?
> Best regards,
> Yael

Fedora may have these in some repo somewhere, and: from the README file:

blktrace was integrated into the mainline kernel between 2.6.16 and
2.6.17-rc1. The target trace needs to run on a kernel at least that new.

git://git.kernel.dk/blktrace.git

If you don't have git, you can get hourly snapshots from:

http://brick.kernel.dk/snaps/

The snapshots include the full git object database as well. kernel.org
has excessively long mirror times, so if you have git installed, you can
pull the master tree from:

git://git.kernel.dk/blktrace.git

For browsing the repo over http and viewing history etc, you can direct
your browser to:

http://git.kernel.dk/

