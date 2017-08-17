From: Gwendal Grignou <gwendal@chromium.org>
Date: Thu, 17 Aug 2017 03:42:46 +0000
Subject: Erroneous Q2G when 2 identical IOs are present in a trace.
Message-Id: <CAMHSBOWOsT_CPrNMNTXSs-Y4YFnDSuyQn5r43LubLTrcnhJ9tQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Taking a long trace (NOVA), I noticed max and average Q2G were not
correct in btt:

blkparse -i NOVA -d NOVA.bin -o NOVA.txt
btt -Ai NOVA.bin -e sdcard -t 0 -T 400 | less

...

            Q2G           MIN           AVG           MAX           N
--------------- ------------- ------------- ------------- -----------
sdcard            0.000000306  59.073180248 334.885369822        1532
....

Q2G is 334s, which is not viable.

Looking in more detail,

btt -i NOVA.bin -e sdcard -t 0 -T 400 -p sdcard_NOVA.io.txt
and
grep -e 'Q' -e 'G' sdcard_NOVA.io.txt | cut -c 10-40 | sed 's/ \+/ /g' | awk \
'BEGIN { FS=" "; Q=0 ; D=0 }
{
  if ($2 = "G") { G=$1; if ((G - Q) > D) { D = G - Q; M=$0 }}
  if ($2 = "Q") { Q=$1 }
}
END { print D," - ",M }'

One offending IO is at:
331.494  -   355.349404410 G 38345728+10 :

in sdcard_NOVA.io.txt, indded, we have this IO with unexpected timing:
259,0  :    23.855603264 Q   38345728+1024
           355.349404410 G   38345728+1024
           355.350027569 D   38345728+1024
           355.350381786 C   38345728+1024


Looking in the block trace (NOVA.txt), we have 2 IO with the same LBA:

259,0    0     1722    23.855603264 15391  Q  WS 38345728 + 1024 [dex2oat]
...
259,0    0     1725    23.855608359 15391  G  WS 38345728 + 1024 [dex2oat]
...
259,0    0     1733    23.856222064 15391  D  WS 38345728 + 1024 [dex2oat]
...
259,0    0     1736    23.856567516 15391  C  WS 38345728 + 1024 [0]

and much later:

259,0    0    55740   355.349397967 22400  Q  WS 38345728 + 1024 [dex2oat]
...
259,0    0    55743   355.349404410 22400  G  WS 38345728 + 1024 [dex2oat]
....
259,0    0    55751   355.350027569 22400  D  WS 38345728 + 1024 [dex2oat]
....
259,0    0    55754   355.350381786 22400  C  WS 38345728 + 1024 [0]

It looks like btt skipped the G/D/C of the first IO and jump to the second one.

Looking into the btt code for an explanation.

Gwendal.
