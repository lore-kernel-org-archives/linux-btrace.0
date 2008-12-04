From: Luis Useche <luis@cs.fiu.edu>
Date: Thu, 04 Dec 2008 23:06:48 +0000
Subject: BTstats
Message-Id: <20081204230648.GA22938@apu.cs.fiu.edu>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi everyone,

I just want to introduce a new blktrace analyzer I did a couple of months back
called BTstats. It generates some statistics that btt already provide plus
some other. The design is based on the research I do and it is very focused
on that purpose. It provides an extensible architecture (plugin-based) and
offers a very flexible interface to gather statistics of parts of a trace.

It can read the binary output from blktrace. I use glib to do the development
(that some people probably don't like).

As I mention in my web-page, this is not as mature as btt but it can fit the
needs of some people.

More info: http://users.cs.fiu.edu/~lusec001/moin.cgi/Software/BTstats

Best,
-- 
Luis Useche <luis@cs.fiu.edu>
Ph.D. Student
Florida International University
