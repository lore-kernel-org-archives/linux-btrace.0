From: Xuekun Hu <xuekun.hu@gmail.com>
Date: Wed, 03 Mar 2010 07:41:05 +0000
Subject: accuracy of btt result on btreplay?
Message-Id: <398d69301003022341r5840a9e1g492c243c330bd398@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi, Guys

I used blktrace to collect IOs traces on a workload. Then replayed it
on the same disk with btreplay, meanwhile I used blktrace to gather
the traces again. I would like to compare the two traces to evaluate
btreplay accuracy. For io direction, io offset, io size, the two
traces were matched. However for the btt output on average component
times across all IOs, the number of request are not matched.

Here is the btt output on the workload:

           ALL           MIN           AVG           MAX           N
--------------- ------------- ------------- ------------- -----------

Q2Q               0.000000003   0.000227312   0.302266672      438801
Q2G               0.000000368   0.000003045   0.004852484      175920
G2I               0.000000157   0.000001230   0.000056954      175920
Q2M               0.000000123   0.000000404   0.000005004      262882
I2D               0.000000286   0.000010544   0.008151437      175920
M2D               0.000001543   0.000010717   0.003731306      262882
D2C               0.000035010   0.000188685   0.117930905      438801
Q2C               0.000038161   0.000201288   0.117934610      438801

Here is the btt output on the btreplay:

            ALL           MIN           AVG           MAX           N
--------------- ------------- ------------- ------------- -----------

Q2Q               0.000000001   0.000238955   0.302027673      416343
Q2G               0.000000339   0.000017235   0.144473266      429721
S2G               0.006854780   0.079412795   0.144471318          15
G2I               0.000000023   0.000000579   0.000022893      429666
Q2M               0.000000163   0.000382036   0.028901367        8970
I2D               0.000000336   0.000672347   0.442394220      430233
M2D               0.000000707   0.067473630   0.439112467        7846
D2C               0.000000601   0.001189618   0.179906289      416325
Q2C               0.000000127   0.003043274   0.510393670      416344

Observation:
1. For both traces, blkparse reported 438802 request queued.
2. In the first btt output, seems like the number of Q2C missed one
that 438801 vs. 438802. Other number of events were correct.
3. In the second btt output, all number of events were below 438802.
And some data were misunderstanding. like the number of Q2G was
greater than the number of Q2Q, I2D > Q2C etc. However its blkparse
reported the correct 438802 request queued.

So how to explain the btt result on btreplay? Your comments are appreciated.

Thx, Xuekun
