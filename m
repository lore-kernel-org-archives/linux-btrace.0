From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Tue, 10 Apr 2007 00:33:01 +0000
Subject: Re: [BTT PATCH] Clean up all memory leaks
Message-Id: <461ADB3D.4070806@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <461A4CA0.10808@hp.com>
In-Reply-To: <461A4CA0.10808@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This has a "small" bug in it - for some reason the .dat file containing 
"ranges" now contains every IO.

Looking into it...

Alan
