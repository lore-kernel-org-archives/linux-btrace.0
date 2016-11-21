From: Mujtaba Tarihi <mujtaba.tarihi@gmail.com>
Date: Mon, 21 Nov 2016 12:48:22 +0000
Subject: Extracting request elapsed time values using blkparse
Message-Id: <CA+5nn1g+MjDsGdqA2JrZ_+3sk3PyfEz7vZO6Gg8ggvyxURJnyg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="001a1141352604aa610541cf12d2"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

--001a1141352604aa610541cf12d2
Content-Type: text/plain; charset=UTF-8

Dear all,

First, I would like to thank you all for your efforts.

I have been trying to use blkparse/blktrace to trace io activity for
my research.
I want to to measure IO response time to better characterize linux io.
My problem is that I am trying to use blkparse to get the request response time
for some activity.

I gave the -t switch along with %u to print it out.
While it does work for some requests. It gives "Expecting elapsed
value" and bails out. When I turn on verbose output, it also generates
"complete not found for XXYYZZ" when I request verbose results.

From what I gather. Some blocks return completion twice for synchronous writes.
But it can also happens for reads.
I am attaching an annotated excerpt from the results. In these results
I have intentionally disabled the bailout accompanying "Expecting
elapsed value" so blkparse would not exit.

For a trace that has ~1.4M requests, I have seen this error 90K times.

The arguments are:
./blkparse -v -t -F C,"COMP %D %2c %8s %16S %5T.%9t %5p %2a %3d %3u\n"
-F D,"ISSUED %D %2c %8s %16S %5T.%9t %5p %2a %3d\n" -i
./results/sda.blktrace.

NOTE: This still happens well into the tracing process. E.g. Multiple
hours into the tracing process. But you should have commented the
exit(1) after fprintf(stderr, "Expecting elapsed value\n"); Otherwise,
it will bail out at the first occurance.

Any help will be greatly appreciated.
Regards,
-Tarihi

--001a1141352604aa610541cf12d2
Content-Type: application/octet-stream; name=broken-blkparse
Content-Disposition: attachment; filename=broken-blkparse
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivs2gvx60

SVNTVUVEICAgOCwwICAgIDIgICAgNTg4NDggICAgICAgIDk2OTIyODgxNiAgIDExMS43MDg4NDE0
NzQgICAgIDAgIEQgIFdTCklTU1VFRCAgIDgsMCAgICAyICAgIDU4ODQ5ICAgICAgICAgMzAzNjMx
MDQgICAxMTEuNzA4ODkyNTk4ICAgICAwICBEICAgUgpDT01QICAgOCwwICAgIDMgICAgMzkyMjgg
ICAgICAgIDk2OTIyODgxNiAgIDExMS43MDkwMDMyMjcgICAgIDAgIEMgIFdTIDE2MQpDT01QICAg
OCwwICAgIDEgICAgODY3MDYgICAgICAgICAzMDM2MzEwNCAgIDExMS43MTAxNDE5MTkgICAgIDAg
IEMgICBSIDEyNDkKICA4LDAgICAgMSAgICA4NjcwNyAgIDExMS43MTAyNjA5MjggMjkzMzkgIEEg
ICBSIDMwMzYzNjE2ICsgMjU2IDwtICg4LDEpIDMwMzYxNTY4CiAgOCwwICAgIDEgICAgODY3MDgg
ICAxMTEuNzEwMjYyMzI1IDI5MzM5ICBRICAgUiAzMDM2MzYxNiArIDI1NiBbaW96b25lXQogIDgs
MCAgICAxICAgIDg2NzA5ICAgMTExLjcxMDI2NDAwMiAyOTMzOSAgRyAgIFIgMzAzNjM2MTYgKyAy
NTYgW2lvem9uZV0KICA4LDAgICAgMSAgICA4NjcxMCAgIDExMS43MTAyNjU2NzggMjkzMzkgIFAg
ICBOIFtpb3pvbmVdCiAgOCwwICAgIDEgICAgODY3MTEgICAxMTEuNzEwMjY2Nzk1IDI5MzM5ICBJ
ICAgUiAzMDM2MzYxNiArIDI1NiAoICAgIDI3OTMpIFtpb3pvbmVdCiAgOCwwICAgIDEgICAgODY3
MTIgICAxMTEuNzEwMjY3NjMzIDI5MzM5ICBVICAgTiBbaW96b25lXSAxCiAgOCwwICAgIDEgICAg
ODY3MTMgICAxMTEuNzEwMzM4MzEzIDI5MzM5ICBBICAgUiAzMDM2Mzg3MiArIDI1NiA8LSAoOCwx
KSAzMDM2MTgyNAogIDgsMCAgICAxICAgIDg2NzE0ICAgMTExLjcxMDMzODg3MSAyOTMzOSAgUSAg
IFIgMzAzNjM4NzIgKyAyNTYgW2lvem9uZV0KICA4LDAgICAgMSAgICA4NjcxNSAgIDExMS43MTAz
NDA1NDggMjkzMzkgIE0gICBSIDMwMzYzODcyICsgMjU2IFtpb3pvbmVdCkNPTVAgICA4LDAgICAg
MiAgICA1ODg1MCAgICAgICAgOTY5MjI4ODE2ICAgMTExLjcxNDM4OTY2NiAgICAgMCAgQyAgV1Mg
MTg0NDY3NDQwNzM3MDk1NTEgPC0tLSBwcm9ibGVtYXRpYwo=
--001a1141352604aa610541cf12d2--
