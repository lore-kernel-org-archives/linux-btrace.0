From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 03 Mar 2010 14:05:33 +0000
Subject: Re: accuracy of btt result on btreplay?
Message-Id: <1267625133.2926.13.camel@cail>
List-Id: <linux-btrace.vger.kernel.org>
References: <398d69301003022341r5840a9e1g492c243c330bd398@mail.gmail.com>
In-Reply-To: <398d69301003022341r5840a9e1g492c243c330bd398@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


Hi Xuekun - 

Not sure why they Q2Q N value is down 5%, but the AVG Q2Q is pretty
close - only 11msec (again, about 5%). After that, things are affected
by merge rates most likely - note that there were 262882 merges on the
first run whilst there were only 8970 on the second run. Perhaps you
could look at the blkparse output from both and get a feel for the vast
reduction in merges. [Any changes on the system between the runs?]

Regards,
Alan

