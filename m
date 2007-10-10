From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 10 Oct 2007 11:24:52 +0000
Subject: btreplay updated
Message-Id: <470CB684.7000302@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

commit cbb3e69ee7499d2df365e2dbc1dfd367a4d997f8
Author: Joshua Root <>
Date:   Wed Oct 10 07:17:56 2007 -0400

     Fix segfault in replay_sub when verbose is 1

     tip->vfp is only initialised when verbose > 1, so we must only use
     it under the same circumstance.

     Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>

updating 'refs/heads/master'
   from 0106d9cfa13b912042bace7bbb2d2475dfd35e10
   to   cbb3e69ee7499d2df365e2dbc1dfd367a4d997f8
updating 'refs/heads/origin'
   from d47a3fec3f4bbcf6b0c6ef757a4eb449dd81d10a
   to   0106d9cfa13b912042bace7bbb2d2475dfd35e10
Generating pack...
Done counting 12 objects.
Result has 6 objects.
Deltifying 6 objects.
  100% (6/6) done
Writing 6 objects.
  100% (6/6) done
Total 6, written 6 (delta 3), reused 0 (delta 0)
refs/heads/master: 0106d9cfa13b912042bace7bbb2d2475dfd35e10 -> 
cbb3e69ee7499d2df365e2dbc1dfd367a4d997f8
refs/heads/origin: d47a3fec3f4bbcf6b0c6ef757a4eb449dd81d10a -> 
0106d9cfa13b912042bace7bbb2d2475dfd35e10
