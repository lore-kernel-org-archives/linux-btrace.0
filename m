From: Ming Zhang <blackmagic02881@gmail.com>
Date: Mon, 26 Mar 2007 02:44:56 +0000
Subject: typo?
Message-Id: <1174877096.6887.6.camel@localhost.localdomain>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

got a btt result.

       DEV |          NSEEKS            MEAN          MEDIAN | MODE
---------- | --------------- --------------- --------------- |
---------------
 (  8, 16) |            9992        109046.1               0 | 0(7133)
 (  8, 32) |              28          4061.7               0 | 0(27)
---------- | --------------- --------------- --------------- |
---------------
   Overall |          NSEEKS            MEAN          MEDIAN | MODE
   Average |           10020        108752.7               0 | 0(7160)

========== Plug Information ==========

       DEV |    # Plugs # Timer Us  | % Time Q Plugged
---------- | ---------- ----------  | ----------------
 (  8, 16) |        603(         2) |   0.005660635%
 (  8, 32) |         27(         0) |   0.000007507%
---------- | ---------- ----------  | ----------------
       DEV |    # Plugs # Timer Us  | % Time Q Plugged
   OVERALL |        315(         1) |   0.002834071%

~~~~shall this be Overall Average instead of DEV Overall? since DEV
overall is more like to get a total number instead of average.

# Total System


Thanks!

Ming

