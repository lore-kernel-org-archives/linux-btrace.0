From: Hsiao Su <Hsiao.Su@marklogic.com>
Date: Thu, 10 Feb 2011 23:27:05 +0000
Subject: replaying blktrace using fio on a different device
Message-Id: <E9E9B636B25C054B8E6B9131614B925A037FD544@EXCHG-BE.marklogic.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org


Does anyone know if this is possible?=A0 I'd like to record io workload usi=
ng blktrace for one device, and then use fio to replay it on a different de=
vice that's on a different machine.

My brief experiment seems to say no.=A0 If I record it using /dev/sda, then=
 when replaying it, /dev/sda must be there.

Basically, I'm trying to see how two different io subsystems measure up, us=
ing a real application's workload.

---
Hsiao "Shao" Su
650 287 2545 (W)


