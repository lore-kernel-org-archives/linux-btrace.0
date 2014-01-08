From: Adam Crume <adamcrume@gmail.com>
Date: Wed, 08 Jan 2014 17:22:10 +0000
Subject: Re: btt support and queries
Message-Id: <CAFu9Dv3yw8kmoiYTaGJ+xPCPJ7p-7yGyo5n8i0BFRpiS0j57ww@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="089e01160600ac179004ef78bb1a"
List-Id: <linux-btrace.vger.kernel.org>
References: <987cd96f9dd8400485449e511699dfba@CO1PR01MB110.prod.exchangelabs.com>
In-Reply-To: <987cd96f9dd8400485449e511699dfba@CO1PR01MB110.prod.exchangelabs.com>
To: linux-btrace@vger.kernel.org

--089e01160600ac179004ef78bb1a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

You said that btt doesn't differentiate between read and write
requests.  If you use the -p option to see individual requests, I have
a patch that fixes that.  I submitted it a while ago to the mailing
list, but it was ignored.  If you're looking for aggregate statistics,
though, you'd have to compute them yourself.

The time stamps are since you started blktrace, so if there is a delay
between starting blktrace and starting your workload, the timestamps
will be larger.

As for your other concerns, someone else will have to address them.
I'm just another blktrace user, not a developer.

On Wed, Jan 8, 2014 at 3:15 AM, Abhishek Dnyate
<abhishek@cumulus-systems.com> wrote:
>
> Hi,
>
> Allow me to introduce myself- my name is Abhishek Dnyate and I work for C=
umulus Systems.
> As a background we are using  blktrace utility to add a Linux component t=
o our high level performance analysis and charge back system called MARS.
> While developing this component, we came across btt utility, which would =
allow us to process the data collected by blktrace, and the reports generat=
ed by btt looks almost exactly what we want.
> But while using btt, we faced few glitches which might defeat the very pu=
rpose of using it.
>
> (We are referring to a pdf =E2=80=9Cbtt User Guide=E2=80=9D written by Al=
an D. Brunelle (Alan.Brunelle@hp.com), dated 12 February 2008.)
>
> Any help is greatly appreciated.
>
> =E2=9E=A2  Firstly, we want to know is btt supported as of today?
>
> =E2=9E=A2 We want btt to parse only a subset of blktrace file. btt has =
=E2=80=93t and =E2=80=93T option to specify the start and end time, which w=
ould allow it, but the document says:
> 11.17 --time-start/-t and --time-end/T
> This btt capability is still under construction, results are not always c=
onsistent at this point in time.
> btt version specified in the document is 2.00 and the current version we =
are using is 2.07. We are not sure that this issue still persists. And if i=
t has been fixed, in which version of btt is it fixed ?
>
> =E2=9E=A2  As far as we understand, btt does not differentiate between re=
ad and write requests i.e. to say btt output files does not show the type o=
f request.  We kind of lose this information, collected by blktrace.
>
> =E2=9E=A2  As per the btt user guide (which we are referring to),  it say=
s the timestamp dumped in files is a relative offset since the start time o=
f the trace (ref pg no 20, last para)
>
>      But in actual we are getting timestamp values that are very high fro=
m what is expected.
>     Is it the system uptime?
> Assuming it is system uptime, we also noticed that this value looked inco=
rrect for an old kernel version (2.6.18), but matched exactly with the syst=
em uptime for a relatively later kernel version (2.6.32).
> Is there any specific kernel version , this would require?
> Command used to execute btt : btt  -i sda.blktrace.0  -a  -o <output_file=
name>
>
> Thanks in advance.
>
> Regards,
> Abhishek
>

--089e01160600ac179004ef78bb1a
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Adding-read-write-flag-to-per-io-output.patch"
Content-Disposition: attachment; 
	filename="0001-Adding-read-write-flag-to-per-io-output.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hq6utqpp0

ZGlmZiAtLWdpdCBhL2J0dC90cmFjZV9jb21wbGV0ZS5jIGIvYnR0L3RyYWNlX2NvbXBsZXRlLmMK
aW5kZXggNDQ3MzJjNS4uYWMxMDQ4MCAxMDA2NDQKLS0tIGEvYnR0L3RyYWNlX2NvbXBsZXRlLmMK
KysrIGIvYnR0L3RyYWNlX2NvbXBsZXRlLmMKQEAgLTIxLDMxICsyMSwzMiBAQAogI2luY2x1ZGUg
Imdsb2JhbHMuaCIKIAogc3RhdGljIGlubGluZSB2b2lkIF9fb3V0KEZJTEUgKm9mcCwgX191NjQg
dG0sIGVudW0gaW9wX3R5cGUgdHlwZSwKLQkJCQkJX191NjQgc2VjLCBfX3UzMiBuc2VjLCBpbnQg
aW5kZW50KQorCQkJCQlfX3U2NCBzZWMsIF9fdTMyIG5zZWMsIGludCB3cml0ZSwgaW50IGluZGVu
dCkKIHsKIAlpZiAodG0gIT0gKF9fdTY0KS0xKSB7CiAJCWlmIChpbmRlbnQpCiAJCQlmcHJpbnRm
KG9mcCwgIiAgICAgICAgICIpOwotCQlmcHJpbnRmKG9mcCwgIiU1ZC4lMDlsdSAlYyAlMTBsbHUr
JS00dVxuIiwKKwkJZnByaW50ZihvZnAsICIlNWQuJTA5bHUgJWMgJTEwbGx1KyUtNHUgJWNcbiIs
CiAJCQkoaW50KVNFQ09ORFModG0pLCAodW5zaWduZWQgbG9uZylOQU5PX1NFQ09ORFModG0pLAot
CQkJdHlwZTJjKHR5cGUpLCAodW5zaWduZWQgbG9uZyBsb25nKXNlYywgbnNlYyk7CisJCQl0eXBl
MmModHlwZSksICh1bnNpZ25lZCBsb25nIGxvbmcpc2VjLCBuc2VjLCB3cml0ZT8nVyc6J1InKTsK
IAl9CiB9CiAKIHN0YXRpYyB2b2lkIGRpc3BsYXlfaW9fdHJhY2soRklMRSAqb2ZwLCBzdHJ1Y3Qg
aW8gKmlvcCkKIHsKKwlpbnQgdyA9IChpb3AtPnQuYWN0aW9uICYgQkxLX1RDX0FDVChCTEtfVENf
V1JJVEUpKSAhPSAwOwogCWZwcmludGYob2ZwLCAiJTNkLCUtM2Q6ICIsIE1BSk9SKGlvcC0+dC5k
ZXZpY2UpLCBNSU5PUihpb3AtPnQuZGV2aWNlKSk7Ci0JX19vdXQob2ZwLCBpb3AtPnQudGltZSwg
SU9QX1EsIGlvcC0+dC5zZWN0b3IsIHRfc2VjKCZpb3AtPnQpLCAwKTsKKwlfX291dChvZnAsIGlv
cC0+dC50aW1lLCBJT1BfUSwgaW9wLT50LnNlY3RvciwgdF9zZWMoJmlvcC0+dCksIHcsIDApOwog
CiAJaWYgKGlvcC0+Z190aW1lICE9IChfX3U2NCktMSkKLQkJX19vdXQob2ZwLCBpb3AtPmdfdGlt
ZSwgSU9QX0csIGlvcC0+dC5zZWN0b3IsIHRfc2VjKCZpb3AtPnQpLDEpOworCQlfX291dChvZnAs
IGlvcC0+Z190aW1lLCBJT1BfRywgaW9wLT50LnNlY3RvciwgdF9zZWMoJmlvcC0+dCksIHcsIDEp
OwogCWlmIChpb3AtPmlfdGltZSAhPSAoX191NjQpLTEpCi0JCV9fb3V0KG9mcCwgaW9wLT5pX3Rp
bWUsIElPUF9JLCBpb3AtPnQuc2VjdG9yLCB0X3NlYygmaW9wLT50KSwxKTsKKwkJX19vdXQob2Zw
LCBpb3AtPmlfdGltZSwgSU9QX0ksIGlvcC0+dC5zZWN0b3IsIHRfc2VjKCZpb3AtPnQpLCB3LCAx
KTsKIAlpZiAoaW9wLT5tX3RpbWUgIT0gKF9fdTY0KS0xKQotCQlfX291dChvZnAsIGlvcC0+bV90
aW1lLCBJT1BfTSwgaW9wLT50LnNlY3RvciwgdF9zZWMoJmlvcC0+dCksMSk7CisJCV9fb3V0KG9m
cCwgaW9wLT5tX3RpbWUsIElPUF9NLCBpb3AtPnQuc2VjdG9yLCB0X3NlYygmaW9wLT50KSwgdywg
MSk7CiAKLQlfX291dChvZnAsIGlvcC0+ZF90aW1lLCBJT1BfRCwgaW9wLT5kX3NlYywgaW9wLT5k
X25zZWMsIDEpOwotCV9fb3V0KG9mcCwgaW9wLT5jX3RpbWUsIElPUF9DLCBpb3AtPmNfc2VjLCBp
b3AtPmNfbnNlYywgMSk7CisJX19vdXQob2ZwLCBpb3AtPmRfdGltZSwgSU9QX0QsIGlvcC0+ZF9z
ZWMsIGlvcC0+ZF9uc2VjLCB3LCAxKTsKKwlfX291dChvZnAsIGlvcC0+Y190aW1lLCBJT1BfQywg
aW9wLT5jX3NlYywgaW9wLT5jX25zZWMsIHcsIDEpOwogCWZwcmludGYob2ZwLCAiXG4iKTsKIH0K
IAo=
--089e01160600ac179004ef78bb1a--
