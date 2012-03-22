From: Nathan McCorkle <nmz787@gmail.com>
Date: Thu, 22 Mar 2012 15:09:12 +0000
Subject: Re: Does btrace dump actual i/o data?
Message-Id: <CA+82U9+-t4z6X0SXHzDuihb+1JnwbbhCkL-DiD9BLHh_kFW=cQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I'm trying to reverse engineer some device communication protocols....
Basically this device shows up as a usb drive, and commands are written to a
fake file in the root directory. Responses are read from the same fake file.

Does btrace have the ability to dump the data being written and read from
the device, or just aggregate i/o statistics?



-- 
Nathan McCorkle
Rochester Institute of Technology
College of Science, Biotechnology/Bioinformatics
