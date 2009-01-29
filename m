From: "M. Edward (Ed) Borasky" <znmeb@cesmail.net>
Date: Thu, 29 Jan 2009 18:24:35 +0000
Subject: Documentation on the binary file format?
Message-Id: <4981F463.1050905@cesmail.net>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Is there some documentation on the binary file format out of "blktrace"?
I'm interested in writing some post-processing routines that extend what
"blkparse" and "btt" do, and there is a substantial disk space hit if I
generate the "blkparse" output and post-process that. I'm also
considering a network server that takes the binary data from a
"blktrace" client and does the analysis "on the fly", rather than saving
off a binary trace.

A side question ... how likely are changes in the binary format? The
language(s) I want to use -- Perl and/or Ruby -- are pretty flexible at
re-factoring to match format changes, but I'd like to have a clue on how
much maintenance activity I'm taking on.
-- 
M. Edward (Ed) Borasky

I've never met a happy clam. In fact, most of them were pretty steamed.
