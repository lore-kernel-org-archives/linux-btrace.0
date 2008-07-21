From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Date: Mon, 21 Jul 2008 18:56:14 +0000
Subject: Re: [Patch] blkiomon: repost with some fixes and improvements
Message-Id: <4884DBCE.8000308@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050700050203060203000402"
List-Id: <linux-btrace.vger.kernel.org>
References: <1216377086.8497.4.camel@kitka.ibm.com>
In-Reply-To: <1216377086.8497.4.camel@kitka.ibm.com>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------050700050203060203000402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 2008-07-21 21:45, Alan D. Brunelle wrote:
> Hi Edwin -
>
> With the patches sent out today (kernel & application), you can then use
> the updated script attached here. It only asks for getrq & sleeprq
> traces - so it will cut down a lot, but most likely there will still be
> a lot of getrq's (in particular).
>
> Will now have some time to look at the more general issue concerning how
> to see the effects of the sleeprq's...
>   

Thanks Alan.

I have been using a slightly modified version of your qsg.py script, I
want the time delta between
a sleep, and it's corresponding get. Your initial script gave me time
between sleep and *first* get (which probably was a write anyway).
I have attached my qsg.py, after applying your recent modifications.

I noticed something, the longest latency occurs when preload *and* find
is running, so I guess it has something to do with readaheads.
I used the attached iotime.stp script to show process and latency of
get_request_wait:
28199122: latency: 1135ms, pid: 6386 (dd)
60057798: latency: 28232ms, pid: 2918 (preload)
60063004: latency: 25904ms, pid: 6503 (find)
61159927: latency: 1346ms, pid: 211 (kswapd0)

I've been also trying some stuff in blk-core.c, namely forcing READA to
be put on sleep if queue is congested,
and modified mpage.c to actually pass readaheads as READA, and made
page_cache_sync_readahead, and force_page_cache_readahead to
congestion_wait if the bdi is congested.
However all this had no effect.

So either:
- my READA hacks are totally wrong, and readaheads do still end up in
the queue above the limit
- something else is causing latency in get_request_wait, but there isn't
much else there besides a spinlock, a waitqueue, and a device unplug.

I will do some more experiments with the new blktrace.

Best regards,
--Edwin

--------------050700050203060203000402
Content-Type: text/x-python;
 name="qsg.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="qsg.py"

#! /usr/bin/env python
"""
qsg.py [dev...]
"""

#
#  (C) Copyright 2008 Hewlett-Packard Development Company, L.P.
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

import os, sys

#
# Crazy stuff to get unbuffered output flowing through the pipeline -
# not a Python wiz, there are probably better ways...
#
def start_tracer(devs):
	(r, w) = os.pipe()
	pid = os.fork()
	if pid == 0:
		os.close(r)

		cmd = '/usr/local/bin/blktrace -o - -n 8 -b 1024'
		cmd = '%s -m getrq -m sleeprq' % cmd
		for dev in devs: cmd = '%s -d %s' % (cmd, dev)
		cmd = cmd.split(None)

		fw = os.fdopen(w, 'w', 0)
		os.dup2(fw.fileno(), sys.stdout.fileno())

		os.execvp(cmd[0], cmd)
		sys.exit(1)
	else:
		os.close(w)
		return (pid, r)

def start_parser(devs):
	(trace_pid, tr) = start_tracer(devs)

	(r, w) = os.pipe()
	pid = os.fork()
	if pid == 0:
		os.close(r)

		fmt = '%D %a %T.%t %p\n'
		cmd = [ '/usr/local/bin/blkparse', '-q', '-i','-', '-f', fmt]
		print cmd

		os.dup2(tr, sys.stdin.fileno())
		fw = os.fdopen(w, 'w', 0)
		os.dup2(fw.fileno(), sys.stdout.fileno())

		os.execvp(cmd[0], cmd)
		sys.exit(1)
	else:
		os.close(w)
		fr = os.fdopen(r, 'r', 0)
		return (trace_pid, pid, fr)

def parse_line(line):
	fields = line.split(None)
	return fields[0], fields[1], float(fields[2]),fields[3]

if __name__ == '__main__':
	if len(sys.argv) < 2:
		print __doc__
		sys.exit(1)

	sleepers = {}
	devs = sys.argv[1:]

	(trace_pid, parse_pid, fi) = start_parser(devs)
	for line in fi:
		(dev, act, ts, pid) = parse_line(line.rstrip())

		#if not act in ['S', 'G']: continue
		if act == 'S':
			if not sleepers.has_key(dev):	sleepers[dev] = {pid:ts}
			elif not sleepers[dev].has_key(pid):
					sleepers[dev][pid] = ts
			continue
		elif not sleepers.has_key(dev): continue
		elif not sleepers[dev].has_key(pid): continue

		mn = mx = None
		tot = 0.0
		nsleepers = 0
		for sleeper in sleepers[dev].values():
			if ts < sleeper: continue
			nsleepers += 1

			dt = ts - sleeper
			if mn == None or dt < mn: mn = dt
			if mx == None or dt > mx: mx = dt
			tot += dt
		del sleepers[dev][pid]

		if nsleepers == 0:
			continue

		print '%17.9f %4d sleepers' % (ts, nsleepers),
		if nsleepers == 1:
			print '    %13s     %13.9f' % ('', tot)
		else:
			print 'min=%13.9f' % mn,
			print 'avg=%13.9f' % (tot / float(nsleepers)),
			print 'max=%13.9f' % mx

--------------050700050203060203000402
Content-Type: text/plain;
 name="iotime.stp"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="iotime.stp"

#! /usr/bin/env stap

global grq_time
global start

probe kernel.function("get_request_wait")
{
	grq_time[tid()] = gettimeofday_us()
}

probe kernel.function("get_request_wait").return
{
	t = gettimeofday_us()
	t0 = grq_time[tid()]
	delete grq_time[tid()]
	if(t-t0 > 800000) {
		printf("%d: latency: %dms, pid: %d (%s)\n", t - start, (t-t0)/1000, pid(),execname())
	}
}

probe begin {
 start = gettimeofday_us()
}


--------------050700050203060203000402--
