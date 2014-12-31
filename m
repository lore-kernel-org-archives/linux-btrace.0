From: Alireza Haghdoost <haghdoost@gmail.com>
Date: Wed, 31 Dec 2014 01:53:31 +0000
Subject: Re: Events out of order
Message-Id: <CAB-428mzo5TOyKxA5jx4rjXEROHNXgOQ=cPn6rCuh-YBnq6BRg@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <54A355D2.5060704@ubuntu.com>
In-Reply-To: <54A355D2.5060704@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Dec 30, 2014 at 7:48 PM, Phillip Susi <psusi@ubuntu.com> wrote:
>
> I captured a trace with blktrace -d /dev/sde -o - > trace, then later
> parsed it with blkparse -i - < trace, and the events are out of order.
>  It appears that they come in blocks from one cpu, then the other cpu,
> and the timestamps roll backwards when switching to the other cpu.
> Why aren't they in the proper order?

Can you please share an example ? How much time backward you observed
after switch ?

--
Alireza
