From: "Iram, Shahzad" <iram.shahzad@jp.fujitsu.com>
Date: Thu, 02 Apr 2015 09:52:20 +0000
Subject: mismatch between blkparse and btt
Message-Id: <3F8FDA9241FECA47A7B807E40EEDE8821A3710E3@G01JPEXMBYT26>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello

I see some mismatches between the summary produced by blkparse and btt.
Please help me find out what this means.
(Please CC me because I am not a member of this list)

blkparse and btt output is given at the end of this mail.
blkparse says 9421 IOs queued and 2948 completed.
btt Q2C number is 5880 which does not match either one of the above.
What does this Q2C number refer to and why does it not match with blkparse output.

After some research with btt source code, I found that btt does not take all
the “Q”s in account. I think this causes the difference.
For example, below there are 3 Qs, but btt skips the later 2 Qs.
It seems it does so because the offset is the same.
What is the thinking behind this?

From blkparse output
-----
  8,16   5     1786     1.463926383 11710  Q  WS 0 + 64 [fio]
  8,16   5     1787     1.463930850 11710  G  WS 0 + 64 [fio]
  8,16   5     1788     1.463932084 11710  P   N [fio]
  8,16   5     1789     1.463934486 11710  I  WS 0 + 64 [fio]
  8,16   5     1790     1.463935589 11710  U   N [fio] 1
  8,16   5     1791     1.463936993 11710  D  WS 0 + 64 [fio]
  8,16   3        1     1.463976179 11713  Q  WS 0 + 64 [fio]
  8,16   3        2     1.463977977 11713  G  WS 0 + 64 [fio]
  8,16   3        3     1.463978581 11713  P   N [fio]
  8,16   3        4     1.463979938 11713  I  WS 0 + 64 [fio]
  8,16   3        5     1.463980277 11713  U   N [fio] 1
  8,16   3        6     1.463980960 11713  D  WS 0 + 64 [fio]
  8,16   5     1792     1.464070530 11709  Q  WS 0 + 64 [fio]
  8,16   5     1793     1.464071714 11709  G  WS 0 + 64 [fio]
  8,16   5     1794     1.464072083 11709  P   N [fio]
  8,16   5     1795     1.464074361 11709  I  WS 0 + 64 [fio]
  8,16   5     1796     1.464074763 11709  U   N [fio] 1
  8,16   5     1797     1.464075571 11709  D  WS 0 + 64 [fio]
-----


From blkparse summary
-----
Total (sdb):
 Reads Queued:           0,        0KiB  Writes Queued:        9421,   301472KiB
 Read Dispatches:        0,        0KiB  Write Dispatches:    12955,   301472KiB
 Reads Requeued:         0               Writes Requeued:     10007
 Reads Completed:        0,        0KiB  Writes Completed:     2948,   301472KiB
 Read Merges:            0,        0KiB  Write Merges:         5617,   179744KiB
 PC Reads Queued:        0,        0KiB  PC Writes Queued:        0,        0KiB
 PC Read Disp.:       1583,        0KiB  PC Write Disp.:          0,        0KiB
 PC Reads Req.:        592               PC Writes Req.:          0
 PC Reads Compl.:        0               PC Writes Compl.:        0
 IO unplugs:          3804               Timer unplugs:           0
-----

From btt output
-----
Q2Q               0.000000001   0.002561115   0.658425073        5879
Q2G               0.000000253   0.319168137   3.810568969        1658
S2G               0.000000450   0.248123138   2.326845231         448
G2I               0.000000056   0.003927394   0.538910707        1894
Q2M               0.000000894   0.141180655   3.745428960        5617
I2D               0.000000258   0.078672901   2.129819436        4857
M2D               0.000000760   0.016032975   0.507792441        6989
D2C               0.000165886   0.006084805   0.149684275        2881
Q2C               0.000675957   0.013519592   4.391495471        5880
-----

Best regards
Iram

