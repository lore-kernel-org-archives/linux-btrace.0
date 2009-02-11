From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 11 Feb 2009 19:22:11 +0000
Subject: Updates today...
Message-Id: <49932563.1090708@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030708030607010509050608"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------030708030607010509050608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I've updated blktrace w/ the following commits. It has enabled me to
handle a moderate load on a 32-way ia64 box w/ 88 disks being used. (The
load is to build an Oracle database w/ 5000 warehouses onto the volume
constructed from those 88 disks.) I used both local & networked modes,
and had _zero_ drops over a 400 second period. (The load was generating
about 44,500 traces per second.)


--------------030708030607010509050608
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

commit e6855475478967e7cf92f8beece05ea55d31e6f1
Author: Alan D. Brunelle <alan.brunelle@hp.com>
Date:   Wed Feb 11 13:40:09 2009 -0500

    btt: fixed open in setup_ifile
    
    Took my_open & my_fopen code from blktrace 2.0: needed to add in open
    resource limit increasing stuff.
    
    Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>

commit 6488ca487c5695b784db56c79b67007e92eeb2ac
Author: Alan D. Brunelle <alan.brunelle@hp.com>
Date:   Wed Feb 11 13:23:21 2009 -0500

    Synchronized trace gathering
    
    Previously, each tracer thread would start gathering traces as soon as
    it got going - which might slow down later thread start ups. This change
    allows each thread to be ready to gather traces, and then the main
    thread starts all the threads gathering at the same time.

commit e58f3937548ed115ac5104817f2a9df53830f381
Author: Alan D. Brunelle <alan.brunelle@hp.com>
Date:   Wed Feb 11 13:10:13 2009 -0500

    Invoke gethostbyname once, handle errors better
    
    Instead of invoking gethostbyname once per client, we only need to do it
    once at initialization time. Plus: gethostbyname has a non-standard
    errno reporting mechanism, handle this better.

commit d5302b03b2728a27f14c4f260ce6a5247ea87c6e
Author: Alan D. Brunelle <alan.brunelle@hp.com>
Date:   Wed Feb 11 11:42:09 2009 -0500

    Added accept as a system call needing resource increases
    
    accept(2) opens a socket, and thus needs to handle EMFILE/ENFILE errors
    like other system calls.

--------------030708030607010509050608--
