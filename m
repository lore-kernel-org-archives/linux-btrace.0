From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 13 Jun 2019 20:29:32 +0000
Subject: Re: [PATCH 1/8] block: add a helper function to read nr_setcs
Message-Id: <1560457772.3329.81.camel@HansenPartnership.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190613145955.4813-1-chaitanya.kulkarni@wdc.com>
         <20190613145955.4813-2-chaitanya.kulkarni@wdc.com>
         <9abfc2b8-4496-db7a-fcbb-b52102a67f8e@acm.org>
         <f8ab9587-309b-79a0-e6fc-f6683176f498@interlog.com>
         <1560443321.3329.42.camel@HansenPartnership.com>
         <9b7f2892-d8bf-8b95-c782-51b775d175ed@interlog.com>
In-Reply-To: <9b7f2892-d8bf-8b95-c782-51b775d175ed@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dgilbert@interlog.com, Bart Van Assche <bvanassche@acm.org>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-scsi@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com

On Thu, 2019-06-13 at 15:26 -0400, Douglas Gilbert wrote:
> On 2019-06-13 12:28 p.m., James Bottomley wrote:
> > On Thu, 2019-06-13 at 12:07 -0400, Douglas Gilbert wrote:
> > > On 2019-06-13 11:31 a.m., Bart Van Assche wrote:
> > 
> > [...]
> > > > Please explain what makes you think that part_nr_sects_read()
> > > > must
> > > > be protected
> > > > by an RCU read lock.
> > > 
> > > Dear reviewer,
> > > Please rephrase the above sentence without the accusative tone.
> > > Specifically, please do not use the phrase "what makes you think"
> > > in this or any other code review. For example: "I believe
> > > that..." is more accurate and less provocative.
> > 
> > Imputing "tone" to email is something we try to avoid because it
> > never ends well, particularly for non-native speakers. Some
> > languages (Russian) have no articles and if you take any English
> > phrase and strip out all the articles it sounds a lot more
> > aggressive.
> 
> Like you, I am not a native North American English speaker but I
> have lived here long enough to realize that "what makes you think
> ..." is not a pleasantry and it may be fishing for an emotive
> reaction. It is not the type of expression that professionals would
> use to make a point in a public forum.

I'm not so sure of that, for instance what makes you think I don't do
it in my own reviews?

> I'm not talking about articles (e.g. "a" and "the"), I'm talking
> about pronouns like "you" and "I". I'm not aware of any languages
> without pronouns. IMO Bart uses expressions with "you" in them too
> often when he is expressing _his_ opinion to the contrary.

It's a grammatical tick not an insult and seeing it as such would help
defuse the situation.  I know this is difficult; my own pet grammatical
foible is having to contain it when I see "avoid that" in a patch
subject, but I've managed (so far).

> > > Observation: as a Canadian citizen when crossing the US border I
> > > believe contradicting a US border official with the phrase "what
> > > makes you think ..." could lead to a rather bad outcome :-)
> > > Please make review comments with that in mind.
> > 
> > Different situation: we aren't profiling reviewers ...
> 
> Would you have used that expression when addressing a teacher at
> high school or university? I'm looking for a yardstick of where
> a reviewer should "pitch" their responses. The way you address
> someone who has the ability to make your life uncomfortable (e.g.
> by refusing you entry into their country) may just be such a
> yardstick.
> 
> > > P.S. Do we have any Linux code-of-conduct for reviewers?
> > 
> > It's the same one for all interactions:
> > 
> > Documentation/process/code-of-conduct-interpretation.rst
> > 
> > But I would remind everyone that diversity isn't just a
> > gender/race/LGBT issue it also means being understanding of the
> > potential difficulties non-native speakers have with email in
> > English.
> 
> To quote
>    https://www.contributor-covenant.org/version/1/4/code-of-conduct.h
> tml
> to which your above reference indirectly refers:
> 
>     It calls for a "harassment-free experience for everyone,
>     regardless of ... expression ..."

OK, we picked a code of conduct which is Anglo biased and doesn't take
into account the linguistic diversity of the community; the various
problems with the current code of conduct are why we have to have the
interpretation document.

> So informing someone (not for the first time) that readers of the
> language in which they are writing, may take offence at their
> expression is: not showing an "understanding of the potential
> difficulties non-native speakers have" and thus is harassment?
> Balance that with the angle of a reviewer trying to intimidate
> the person presenting the code. Could that also be harassment?
> In this case I see little evidence of the "potential difficulties"
> to which you refer.

The problem, as I see it, is that you're assuming malice where I
wouldn't, even if linguistic issues weren't a potential issue.

> More generally:
> IMO those who have power speak in a condescending fashion and act
> unilaterally in the matter of reviewing and applying patches. A
> select few are allowed to apply patches seemingly without any
> review and ignore error reports or attempts at public review.
> It certainly does not look like a system based on merit.

Is there, perhaps, some other deeper underlying issue for which this is
serving as a proxy?

James
