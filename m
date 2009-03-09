From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Mon, 09 Mar 2009 14:23:24 +0000
Subject: Re: blktrace / relay: bad trace
Message-Id: <1236608604.7354.38.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1236270223.10040.61.camel@kitka.ibm.com>
In-Reply-To: <1236270223.10040.61.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello Tom,
thanks, for your reply.

On Mon, 2009-03-09 at 00:10 -0500, Tom Zanussi wrote:
> On Thu, 2009-03-05 at 17:23 +0100, Martin Peschke wrote:
> 
> It's definitely good to see hexdumps, but it's hard to tell from a
> single one - the best way to make progress would be to provide enough
> information for anyone to be able to reproduce it on more common
> hardware ie. x86/x86_64.

I run some internal I/O workload generator against an FCP disk with 4
paths. My blktrace command line:

blktrace -a issue -a complete -o - /dev/sda /dev/sdu /dev/sdao /dev/sdbi
| blkiomon -I 100 -b blkiomon.out

> Does it only happen only on systemZ as far as
> you know (I haven't seen it on x86_64)?

Don't know yet. I am trying to reproduce the issue on my laptop... but
it's not quite the same setup.

>  Do you get dropped events every
> time it happens (which would indicate a buffer-full related condition)
> or never?

no dropped events

> Does it only happen in pipeline mode or normal to-disk
> logging?

both

> Are you using the default sub-buffer sizes or something else?

defaults

> Only logging certain event types?

issue/dispatch and complete

> Is it a recent regression, since it
> doesn't seem to have been a problem before, etc.?

no recent regression - I saw it last summer too

> It may be the relay read producing these effects, but it may also be the
> blktrace userspace buffering of that read data that has a bug.

I am quite sure it is a kernel issue. I have patched relay in order to
"poison" relay buffers - 0x55 for re-used buffers, 0x66 for padding,
0x77 for consumed buffers:

---
 kernel/relay.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -735,6 +735,8 @@ size_t relay_switch_subbuf(struct rchan_
 		old_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
 		buf->padding[old_subbuf] = buf->prev_padding;
 		buf->subbufs_produced++;
+		memset((char *)buf->data + buf->offset, 0x66,
+		       buf->prev_padding);
 		if (buf->dentry)
 			buf->dentry->d_inode->i_size + 				buf->chan->subbuf_size -
@@ -767,6 +769,8 @@ size_t relay_switch_subbuf(struct rchan_
 	if (unlikely(length + buf->offset > buf->chan->subbuf_size))
 		goto toobig;
 
+	memset(buf->data, 0x55, buf->chan->subbuf_size);
+
 	return length;
 
 toobig:
@@ -1112,6 +1116,7 @@ static int subbuf_read_actor(size_t read
 		desc->error = -EFAULT;
 		ret = 0;
 	}
+	memset(from, 0x77, ret);
 	desc->arg.data += ret;
 	desc->written += ret;
 	desc->count -= ret;


This is what I get in user space then:

--- suspiscous pdu_len ---
magic    0x65617407
sequence 0x00003baf
time     0x5555555555555555
sector   0x5555555555555555
bytes    0x55555555
action   0x55555555
pid      0x55555555
device   0x55555555
cpu      0x55555555
error    0x5555
pdu_len  0x5555

65617407 00003baf 55555555 55555555 55555555 55555555 55555555 55555555
55555555 55555555 55555555 55555555

> Also I
> see that the bad trace is one that has a large pdu payload, which is cut
> off in the second trace, which could point to erroneous pdu handling in
> blktrace userspace.

Don't worry about the bad trace. It's junk anyway, because a broken
pdu_len of the previous trace made blktrace look for the next trace at a
wrong offset.


Martin

