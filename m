From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 13 Jun 2019 16:28:41 +0000
Subject: Re: [PATCH 1/8] block: add a helper function to read nr_setcs
Message-Id: <1560443321.3329.42.camel@HansenPartnership.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190613145955.4813-1-chaitanya.kulkarni@wdc.com>
         <20190613145955.4813-2-chaitanya.kulkarni@wdc.com>
         <9abfc2b8-4496-db7a-fcbb-b52102a67f8e@acm.org>
         <f8ab9587-309b-79a0-e6fc-f6683176f498@interlog.com>
In-Reply-To: <f8ab9587-309b-79a0-e6fc-f6683176f498@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dgilbert@interlog.com, Bart Van Assche <bvanassche@acm.org>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-scsi@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com

On Thu, 2019-06-13 at 12:07 -0400, Douglas Gilbert wrote:
> On 2019-06-13 11:31 a.m., Bart Van Assche wrote:
[...]
> > Please explain what makes you think that part_nr_sects_read() must
> > be protected 
> > by an RCU read lock.
> 
> Dear reviewer,
> Please rephrase the above sentence without the accusative tone.
> Specifically, please do not use the phrase "what makes you think"
> in this or any other code review. For example: "I believe that..."
> is more accurate and less provocative.

Imputing "tone" to email is something we try to avoid because it never
ends well, particularly for non-native speakers. Some languages
(Russian) have no articles and if you take any English phrase and strip
out all the articles it sounds a lot more aggressive.

> Observation: as a Canadian citizen when crossing the US border I
> believe contradicting a US border official with the phrase "what
> makes you think ..." could lead to a rather bad outcome :-)
> Please make review comments with that in mind.

Different situation: we aren't profiling reviewers ...

> Thanks.
> 
> Doug Gilbert
> 
> P.S. Do we have any Linux code-of-conduct for reviewers?

It's the same one for all interactions:

Documentation/process/code-of-conduct-interpretation.rst

But I would remind everyone that diversity isn't just a
gender/race/LGBT issue it also means being understanding of the
potential difficulties non-native speakers have with email in English.

James
