From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 23 May 2008 20:35:15 +0000
Subject: [RFC] Implement simple messages in blktrace stream
Message-Id: <48372A83.9040204@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following two patches (kernel + application) would allow one to
annotate parts of the blktrace stream w/ simple messages.

I've included a sample one for elevator switches:

  8,16   1   813055    20.259000000  4692  I   R 3088320 + 8 [dd]
  8,16   1   813056    20.259000000  4692  Q   R 3088328 + 8 [dd]
  8,16   1             20.259000000     0  m   N elv switch: deadline
  8,16   1   813057    20.259000000  4692  G   R 3088328 + 8 [dd]
  8,16   1   813058    20.259000000  4692  I   R 3088328 + 8 [dd]

These patches are a bit rough (but compile, and appear to work ok so
far). In particular, I'd break the kernel patch into a blktrace addition
and an elevator switch addition, plus the application patch would need
documentation updates.

My nefarious ultimate goal would be to add in the ability for user-level
insertions for (e.g.):

1. Start blktrace
2. Do some stuff...
3. Insert a tag "switching to other stuff"
4. Do other stuff
5. Insert a tag "switching to yet other stuff"
6. Do yet other stuff

This way you could study different parts of the resultant traces using
the tags to separate them time-wise. [For now, I'd just switch
schedulers back and forth to see the separators.)

Looking for comments (hence the RFC).

Alan D. Brunelle
HP OSLO S&P
