From: karl leplat <karl.leplat@parrot.com>
Date: Fri, 23 Sep 2011 14:31:44 +0000
Subject: [PATCH] OMAP3: pmu: make CPU_HAS_PMU dependent on OMAP3_EMU
Message-Id: <4E7C9850.20406@parrot.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Patch:

CPU performance event counters on v7 cores will only operate
if either the NIDEN or DBGEN signals are driven high.

For the OMAP3 platform, these signals are driven low by default [i.e.
when a JTAG debugger is not connected] but DBGEN can be asserted in
software by selecting the OMAP3_EMU Kconfig option, which enables the
virtual clock for hardware debugging peripherals.

This patch makes CPU_HAS_PMU depend on OMAP3_EMU for OMAP3 platforms.

If i selected OMAP3_EMU option, i didn't see changes, DBGEN is already low. How can i activated the debug mode ?

Thanks !





