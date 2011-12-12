From: Sushil Mantri <sushilmantri@gmail.com>
Date: Mon, 12 Dec 2011 17:00:45 +0000
Subject: Modifying blktrace to obtain i/o contents?
Message-Id: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

I am working on de-duplication, for which i need the i/o event traces
along with its contents. I have been looking into blktrace kernel code
for some time, and have thought of a hacky solution to start with. In
all the probe functions where i have "bio" struct i could obtain the
"contents" from it, and write that in the relay channel as well. The
blkparser would have to be modified as well to take this change into
account.

Do you guys think i might be missing something or is there an
alternative way to handle this?

Thanks,
Sushil
