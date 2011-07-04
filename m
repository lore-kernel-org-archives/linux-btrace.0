From: Edward Shishkin <edward@redhat.com>
Date: Mon, 04 Jul 2011 12:30:26 +0000
Subject: [PATCH 0/1] blktrace: disable blktrace kill option carefully
Message-Id: <1309782626.8616.23.camel@zeta.englab.brq.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello everyone.

I have sent a patch a year ago to disable blktrace kill
option, which does work improperly:
http://marc.info/?l=linux-btrace&m7177005524997&w=2

however this patch only updates documentation and doesn't
really disable this option. Our quality assurance team
doesn't happy with this fact, so I send a more essential
fixup. Please, apply.

Thanks,
Edward.

