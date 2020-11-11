From: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Wed, 11 Nov 2020 04:26:43 +0000
Subject: Re: [RFC PATCH 37/39] blktrace: add integrity tracking support
Message-Id: <yq1o8k4ecy0.fsf@ca-mkp.ca.oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20200825221009.6457-38-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20200825221009.6457-38-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


Chaitanya,

> This patch adds support to track the integrity related information.
> We update struct blk_io_trace_ext with two new members :-
> 1. seed :- to track the integrity seed.
> 2. integrity :- to store the integrity related flags and integrity
>    size buffer.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
