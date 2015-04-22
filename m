From: Mansour Shafaei Moghaddam <mansoor.shafaei@gmail.com>
Date: Wed, 22 Apr 2015 18:08:23 +0000
Subject: Problem with btt's output
Message-Id: <CAGGT8x42dfXcTVfD2mhvG8dZPH6uxaD+C4+sTsJ9mL0R6kE8ew@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Running btt with -p option on the binary output of blkparse, I noticed
the following two weird cases and would appreciate it if anyone can
come up with an explanation for them.

1) In some IOs the time reported for C is earlier than for example
D!!!Here is an example:

 8,16 :   159.151387465 Q   75313664+256
           159.183107850 G   75313664+256
           159.183108979 I   75313664+256
           159.183109762 D   75313664+256
           159.169694274 C   75313664+256

2) In some others there are very very long (say hundreds of seconds)
delays between (Q I G D C) steps. Example of this case:

 8,16 : 34386.651240899 Q  106649088+256
         34386.651241669 G  106649088+256
         34386.651243565 I  106649088+256
         34386.651244370 D  106649088+256
         35548.738015688 C  106649088+256
