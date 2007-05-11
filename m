From: "Alan D. Brunelle" <Alan.Brunelle@pobox.com>
Date: Fri, 11 May 2007 13:21:35 +0000
Subject: [PATCH btrace] Add in -r support for btrace
Message-Id: <46446DDF.7050108@pobox.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050108070000040105000700"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------050108070000040105000700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Using Ubuntu, debugfs is mounted on /debug instead of /sys/kernel/debug. 
[Perhaps, we should put in blktrace a search through "common" areas 
where debug could be mounted, and or do a simple parsing of the output 
from a 'mount' command to /find/ the directory.]


--------------050108070000040105000700
Content-Type: text/plain;
 name="btrace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="btrace"

#!/bin/sh
# Copyright (c) 2005 Silicon Graphics, Inc.
# All rights reserved.
# 
#	Nathan Scott <nathans@sgi.com>
#	14 Sep 2005	Initial version
# 

TRACEOPTS=""
PARSEOPTS="-b100000"
SUMMARIZE=""
USAGE="Usage: btrace [-s] [-t] [-S] [-w N] [-a <trace>...] [-r <dbg mnt]<dev>..."
DIRNAME=`dirname $0`

while getopts "a:r:stSw:hv" c
do
	case $c in
	a)	TRACEOPTS=$TRACEOPTS" -a "$OPTARG" ";;
	w)	TRACEOPTS=$TRACEOPTS" -w "$OPTARG" ";;
	n)	TRACEOPTS=$TRACEOPTS" -n "$OPTARG" ";;
	b)	TRACEOPTS=$TRACEOPTS" -b "$OPTARG" ";;
	r)	TRACEOPTS=$TRACEOPTS" -r "$OPTARG" ";;
	s)	PARSEOPTS=$PARSEOPTS" -s";;
	t)	PARSEOPTS=$PARSEOPTS" -t";;
	h)	PARSEOPTS=$PARSEOPTS" -h";;
	v)	PARSEOPTS=$PARSEOPTS" -v";;
	S)	SUMMARIZE="";;
	\?)	echo $USAGE 1>&2
		exit 2
		;;
	esac
done
PARSEOPTS="${PARSEOPTS} ${SUMMARIZE}"

shift `expr $OPTIND - 1`
if [ $# -eq 0 ]; then
	echo $USAGE 1>&2
	exit 2
fi

${DIRNAME}/blktrace ${TRACEOPTS} -o- $@ | ${DIRNAME}/blkparse ${PARSEOPTS} -i-

--------------050108070000040105000700--
