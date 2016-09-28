From: Alexey Egorov <alex.only.d@gmail.com>
Date: Wed, 28 Sep 2016 13:07:39 +0000
Subject: Re: blkparse unordered entries
Message-Id: <CAJannG5OhtPHL_xpQXWO7u8pv17QOan7zn4b4ZSuuJ-wWPU9Fg@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAJannG4_FkjqzqBVKJ6Dk48d6n1bZ8fGwFZguxztSzSOURaa2Q@mail.gmail.com>
In-Reply-To: <CAJannG4_FkjqzqBVKJ6Dk48d6n1bZ8fGwFZguxztSzSOURaa2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

More info on this:

I can observe this bug only when piping blktrace output to blkparse.
When I use temporary files all seems to be OK.
Also, I found that this particular commit causes this bug:
http://git.kernel.org/cgit/linux/kernel/git/axboe/blktrace.git/commit/?id=
=9Bf422b17cb2330f94376f8ca82a6e6cc496f9a3


2016-09-28 7:56 GMT+05:00 Alexey Egorov <alex.only.d@gmail.com>:
> Hello,
>
> I'm getting multiple entries with unordered timestamps using version
> 1.1.0 of blkparse:
>
> $ verify_blkparse test.out
> ...
> Events 184855: 127 unordered, 57773 aliases
>
> Any chance it would be fixed? For now I'm going to use 1.0.1, which
> doesn't have this problem.
>
> Thanks.
