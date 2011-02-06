From: Mehrnoosh Sameki <mehrnush89@gmail.com>
Date: Sun, 06 Feb 2011 17:58:36 +0000
Subject: Questions about btreplay
Message-Id: <AANLkTim+DS8x4=04YNMfZAtYJFycZgy54YsrWYEhTZa-@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello,

I am currently using "btreplay and btrecord" along with "blktrace" in
order to replay the traces taken by blktrace.
Since both reads and writes are important for me to cover,I use the -W
option of btreplay to enable the writes.While replaying big traces,I
faced the problem of its huge number of files written in a place I
don't know and thus it made my file system unknown.
Where does btreplay do the writing transactions while we enable its
write option?
Your reply will be appreciated.

Regards
-- 
Mehrnoosh Sameki
Bachelor Student,
Computer Engineering Department,
Sharif University of Technology,
Tehran, Iran
