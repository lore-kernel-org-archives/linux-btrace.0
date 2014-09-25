From: Andrew Price <anprice@redhat.com>
Date: Thu, 25 Sep 2014 21:04:12 +0000
Subject: [GIT PULL] blktrace: iowatcher integration tweaks
Message-Id: <1411679056-32596-1-git-send-email-anprice@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

Here are some trivial tweaks which I found were needed or desirable while
adding iowatcher to the blktrace packaging in Fedora. They improve the
integration of iowatcher into the tree and reduce duplication of docs.

The following changes since commit fe311e7c01593444f397d6d012ec212c4b22f514:

  Makefile: ensure that iowatcher gets cleaned (2014-09-24 14:49:04 -0600)

are available in the git repository at:

  https://github.com/andyprice/blktrace.git for-upstream

for you to fetch changes up to a92868dc2a78b394a27925991bb7845a68d5c27d:

  Add iowatcher requirements to README (2014-09-25 21:18:25 +0100)

Cheers,
Andy

----------------------------------------------------------------

Andrew Price (4):
  iowatcher: Add iowatcher to .gitignore
  iowatcher: Move iowatcher.1 into doc directory
  iowatcher: Remove iowatcher/README
  Add iowatcher requirements to README

 .gitignore            |   1 +
 README                |   2 +
 doc/iowatcher.1       | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++
 iowatcher/README      |  97 ------------------------------
 iowatcher/iowatcher.1 | 162 --------------------------------------------------
 5 files changed, 165 insertions(+), 259 deletions(-)
 create mode 100644 doc/iowatcher.1
 delete mode 100644 iowatcher/README
 delete mode 100644 iowatcher/iowatcher.1

-- 
1.9.3

