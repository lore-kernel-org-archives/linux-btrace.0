From: Bastian Blank <bastian@waldi.eu.org>
Date: Fri, 26 Sep 2008 19:34:34 +0000
Subject: Re: [Patch] include blktrace_api.h in headers_install
Message-Id: <20080926193434.GA16003@wavehammer.waldi.eu.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207465.26621.80.camel@kitka.ibm.com>
In-Reply-To: <1216207465.26621.80.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Jul 16, 2008 at 01:24:25PM +0200, Martin Peschke wrote:
> +#ifdef __KERNEL__
> +	char name[BDEVNAME_SIZE];	/* output */
> +#else
> +	char name[32];			/* output */
> +#endif

Bad idea. BDEVNAME_SIZE is not exported and therfor not part of the
public API. As this defines a userspace API it must not change anyway.

Bastian

-- 
No one can guarantee the actions of another.
		-- Spock, "Day of the Dove", stardate unknown
