From: Alexey Egorov <alex.only.d@gmail.com>
Date: Wed, 28 Sep 2016 02:56:59 +0000
Subject: blkparse unordered entries
Message-Id: <CAJannG4_FkjqzqBVKJ6Dk48d6n1bZ8fGwFZguxztSzSOURaa2Q@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello,

I'm getting multiple entries with unordered timestamps using version
1.1.0 of blkparse:

$ verify_blkparse test.out
...
Events 184855: 127 unordered, 57773 aliases

Any chance it would be fixed? For now I'm going to use 1.0.1, which
doesn't have this problem.

Thanks.
