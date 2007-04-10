From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Tue, 10 Apr 2007 00:43:48 +0000
Subject: Re: [BTT PATCH] Clean up all memory leaks
Message-Id: <461ADDC4.8040103@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060008030700070803020600"
List-Id: <linux-btrace.vger.kernel.org>
References: <461A4CA0.10808@hp.com>
In-Reply-To: <461A4CA0.10808@hp.com>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008030700070803020600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan D. Brunelle wrote:
> This has a "small" bug in it - for some reason the .dat file 
> containing "ranges" now contains every IO.
>
> Looking into it...
>
> Alan


--------------060008030700070803020600
Content-Type: text/plain;
 name="fix-ranges"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-ranges"

From: Alan D. Brunelle <Alan.Brunelle@hp.com>

Fix range check: use proper data type for comparison

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---

 btt/inlines.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/btt/inlines.h b/btt/inlines.h
index 3c8deac..edb2182 100644
--- a/btt/inlines.h
+++ b/btt/inlines.h
@@ -52,7 +52,7 @@ static inline void update_range(struct list_head *head_p, __u64 time)
 		if (time < rip->end)
 			return;
 
-		if ((time - rip->end) < range_delta) {
+		if (BIT_TIME(time - rip->end) < range_delta) {
 			rip->end = time;
 			return;
 		}

--------------060008030700070803020600--
