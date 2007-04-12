From: Ming Zhang <blackmagic02881@gmail.com>
Date: Thu, 12 Apr 2007 01:32:59 +0000
Subject: BLK_TA_ISSUE
Message-Id: <1176341579.3409.2.camel@localhost.localdomain>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi All

For this ISSUE event, currently it is in elv_next_request(), any idea
why it is not in elv_dequeue_request() which is where the request marked
as on-the-fly and send to lower level?

Thanks,

Ming


