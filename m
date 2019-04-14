From: Souvik Banerjee <souvik1997@gmail.com>
Date: Sun, 14 Apr 2019 13:11:06 +0000
Subject: Re: status of seekwater
Message-Id: <CAA_L7Z5LLC=G+auJWjVSEZoLXWnQxD0Yvu0MnYCM6HP=jezksw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190414114600.GA12039@lst.de>
In-Reply-To: <20190414114600.GA12039@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

I had the same problem with seekwatcher when I tried to use it. I
ended up writing my own tool to visualize blktrace files which you can
find here: https://github.com/souvik1997/blkview

It=E2=80=99s not exactly the same but it might be helpful.

Thanks,

Souvik

On 4/14/19, Christoph Hellwig <hch@lst.de> wrote:
> Has any tried to use seekwatcher lately?  For one the report on
> oss.oracle.com seems to be gone.  I found a git repo that seems
> to have the latest codebase from hg and two little fixes here:
>
> https://github.com/trofi/seekwatcher
>
> But even that doesn't seem to work in modern environments.  After
> a build with a few warnings actually trying to run it creates doesn't
> seem to actually work well:
>
>
> $ /usr/local/bin/seekwatcher -o sda2.png -t sda2
> using tracefile ./sda2
> Traceback (most recent call last):
>   File "/usr/local/bin/seekwatcher", line 983, in <module>
>     run =3D run_blkparse(x)
>   File "/usr/local/bin/seekwatcher", line 614, in run_blkparse
>     loaddata(fh, rd)
>   File "/usr/local/bin/seekwatcher", line 130, in loaddata
>     tags, options)
>   File "rundata.pyx", line 234, in seekwatcher.rundata.rundata.load_data
> (seekwatcher/rundata.c:3936)
> ValueError: The truth value of an array with more than one element is
> ambiguous. Use a.any() or a.all()
>
> With not output produces.
>
