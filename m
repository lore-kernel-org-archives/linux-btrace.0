From: Amirali Shambayati <amirali.shambayati@gmail.com>
Date: Thu, 28 Oct 2010 20:14:43 +0000
Subject: Question about btreplay and btrecord
Message-Id: <AANLkTi=-NtC-CAiBD+tsCvATALUYNV9dj+=L3PCFGrLX@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello,
We are an academic group and we are working on developing a new Linux
IO scheduler suitable for SSDs.
First we want to find out a way to extract a reproducible trace to use
it for comparison between common different IO schedulers.
We found out btrecord and btreplay useful for our job but we had problem.
First we run our benchmark and blktrace with -queue, and then we use
btrecord to record queued requests. Then we used the recorded trace,
by running btreplay and simultaneously running blktrace with -issue ,
to extract dispached requests trace(resulted by queued requests) for
the current scheduler. We use the recorded trace of queued requests
for other schedulers and we expect to observe different dispatched
requests trace for different schedulers, but all traces are same.
Moreover as we extracted requests related to our benchmark from trace,
resulted by running btreplay, incredibbly we found out that all write
requests had been changed to read requests!
We want to know that whether our consideration from btrecord and
btreplay functionality is correct or not.

Thanks in advance,
