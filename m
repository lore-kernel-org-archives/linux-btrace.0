From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 29 Sep 2022 01:39:42 +0000
Subject: Re: [PATCH] bno_plot.py: Ask for python3 specifically
Message-Id: <ca44014a-5660-7f44-8416-3f202fd607c4@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20220928205539.15585-1-sakib.sajal@windriver.com>
In-Reply-To: <20220928205539.15585-1-sakib.sajal@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 9/28/22 2:55 PM, Sakib Sajal wrote:
> python2 is deprecated, use python3.

Why isn't python just python3 on a distro that has deprecated
python2? It's not like we're asking for python2, just python.

On my laptop:

axboe@m1max ~> which python
/usr/bin/python
axboe@m1max ~> /usr/bin/python --version
Python 3.10.7
axboe@m1max ~> env python
Python 3.10.7 (main, Sep  8 2022, 14:34:29) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>

-- 
Jens Axboe
