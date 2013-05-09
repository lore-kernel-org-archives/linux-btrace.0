From: Jeff Moyer <jmoyer@redhat.com>
Date: Thu, 09 May 2013 14:00:11 +0000
Subject: Re: [PATCH] blktrace: document -k option
Message-Id: <x49r4hg9rtg.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <518B0355.3030905@redhat.com>
In-Reply-To: <518B0355.3030905@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Eric Sandeen <sandeen@redhat.com> writes:

> The -k option was missing from the usage() output and was present
> only in the man page synopsis.  Say a few more words about it.
>

Hmm.  See:

commit fb7f86674a516ddff0d60bfab3bd284a4812075f
Author: Edward Shishkin <edward@redhat.com>
Date:   Tue Apr 20 15:41:14 2010 +0200

    blktrace: disable kill option - take 2
