From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 13 May 2008 04:00:01 +0000
Subject: Recent changes
Message-Id: <48291241.dRIOfq/dSEXyFUoP%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 354db430eeaced3b8234668e6527910875d54e50:
  Alan D. Brunelle (1):
        Added S2G times + fixed up -X output to include X2X

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (1):
      Fixed percentage calculations for phases of an I/O

 btt/output.c |   86 +++++++++++++++++----------------------------------------
 1 files changed, 26 insertions(+), 60 deletions(-)
