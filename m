Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546A20FA96
	for <linux-btrace@vger.kernel.org>; Fri, 21 Mar 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549748; cv=none; b=OO1xsTOhwn9doq7muTo2GaBmDc7D62JW+AtpbmFhXRZNSNdT8v90mhtknGMIfuLGId5i43W0RbJY2+uQ/ORex+dp9IRTQspJD1wXEY7nBp8wfIq99yF+DI54ug7zC27c6jqT9u7QAmjeEZPNFKzAgLJ92Fn+q1glncVmBfd6uhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549748; c=relaxed/simple;
	bh=tBS+6PEVBdtY9VWtgRPF11Z7nG3nLPBvf1Dp/u9HPvI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=jAepkvopeRMRn1sdV3z2SF3KvgVzbgV8CJ/0IJC7GaZThLYbGQ/iK68acLHMkkmfnL0B+zTNuDe7Izju+1ZFemVTLrCgiI8OtM9kR6gKBOoCcZhSUc/upXQHZGX6G8YbSoGFH3xfrnjNk3DmLj62qx3tamXR1gDKHh0wY//AlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CWGGplMI; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CWGGplMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742549433; bh=B04YKQcrGYyY8xcPc6hlCNTNkZBQRqZW9qHoeOaFuHI=;
	h=From:To:Cc:Subject:Date;
	b=CWGGplMIzlu8LT7WHpNwUe9Le2LevtglGNvKFuecMPhh31WmsigoxIeDOoxq+mN/+
	 HvXZg6xYciuGAB1Ugf6Gk0vLcrD3orYL+adajQTOK5qlW1QQZjDrHt8/HoMiwzbber
	 4yUn0Tds3oHYXAPeTsN0pVNxDhPIhkOCqypz1euY=
Received: from localhost.localdomain ([39.144.26.45])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 79F1AA0A; Fri, 21 Mar 2025 17:30:31 +0800
X-QQ-mid: xmsmtpt1742549431tzepecz0b
Message-ID: <tencent_1C78A90054EE27D2F0E78015402213388607@qq.com>
X-QQ-XMAILINFO: MjZkc9TfnG+X4RvyDLFFDtzFBI1tFD3mt1Nj4GVpgmYd0EDNUUYfBtzL43P6yT
	 E6/U6AY5ZbKiQUbKdQpchu1TE1lLR1BOyyuVYP/NEKzylBbk1bd+RyuA7OW0ZFKprYv+m7IxuJFN
	 PcbfXoZyN9AmGN21LAQ//LIIZGhCTA5oIdaffgd3DmHIKl4lujgLO0DO24aImoKcyUTEk+EMWdVS
	 2Jq+wZ0Q/v3g79MV7lCRHKNWdMz3o9kQRrcYdqUzx4dmWEUdiupHpZVV8IWZv3kwTlmd6ivudVyx
	 3n3wzFHaKB+iprjIZwhwsyhJKbdWGPuIwkEMWNqw9L4RvB6KSyK389nJWQRVh8SR9RgLLUADWypz
	 7UP3o8t3IXNoQDyjEq9cgRS+K1togvWo/Bal8UA4x5kv6VAW5sNFxJsQV6nujR+JGuCrzjusTBQN
	 Bbgf0/W5qptVsSo3DpGeVXYC4USNGx0YIiViSiUfxz+jrrHqrKFi+2g7b/2qULKPlY7c/PU0ClAy
	 PG/RnhJpaQ7LAU7L/YOJmypA+5spGxIq+0yUhAK9i2sfpHfKQ3I3wxDBMG3J6Gx4J3whg1iAz19V
	 keHY56F3u7sIQJPEVF8GXMMixZ/foYuFojyHlafyYJk5Uej9Kfb9dhEWgH2mK6L82/390ed8+oG2
	 w77MDlmqF0hV4xqRwrz0yGmzAezrH+CU3wicqGSIioi0xCoT9WnKozViRhn5gEmloLAZa3rmddKb
	 KDM5b3wWZUCFtAUs8oEicbRsV3BkifEYp1fFpeaQtK0tePwZFUfVbQldJT41YqZFPN+PWxlg5mfV
	 Agl8IXKAoa6fY8AI65wUGlp3i069qIgykztf6cQnLHunp0RrbXd/4f7xZHIbdZkBB2IhkLPjkSAY
	 yHVfNmnwd2GQ8uPEob8eg3ml83Xl49aN7cR11nAL7gZ3xkNvh77yXHSL5S0sOyiw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: 303146950@qq.com
To: linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk,
	alan.brunelle@hp.com,
	Kou Wenqi <kouwenqi@kylinos.cn>
Subject: [PATCH] btt: Fix a potential coredump issue
Date: Fri, 21 Mar 2025 03:32:01 +0800
X-OQ-MSGID: <20250320193201.6133-1-303146950@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kou Wenqi <kouwenqi@kylinos.cn>

Executing "btt -i sdb.blktrace.bin" may cause coredump due to
accessing to a page of the buffer that lies beyond the end of
the mapped file.

-rw-r--r-- 1 root root 177169768  3月 13 19:33 sdb.blktrace.bin

(gdb) b mmap.c:134 if cur >= 177169768
Breakpoint 4, move_map () at mmap.c:88
(gdb) l
83              if (cur_map != MAP_FAILED)
84                      munmap(cur_map, len);
85
86              cur_min = (cur & ~(pgsz-1));
87              len = min_len(DEF_LEN, total_size - cur_min);
88              if (len < sizeof(*next_t))
89                      return 0;
90
91              cur_map = mmap(NULL, len, PROT_READ, MAP_SHARED, fd,
92                             cur_min);

(gdb) p total_size
$1 = 177169768
(gdb) p cur
$2 = 177175095
(gdb) p cur_min
$3 = 177172480
(gdb) p cur_max
$4 = 177169768
(gdb) p len
$5 = 16777216

(gdb) c
Continuing.

Program received signal SIGBUS, Bus error.
next_trace (t=t@entry=0x418e70, pdu=pdu@entry=0x418e18) at mmap.c:141
(gdb) p cur
$11 = 177175095
(gdb) p cur_min
$12 = 177172480
(gdb) p total_size
$13 = 177169768
(gdb) l
136                             cleanup_ifile();
137                             return 0;
138                     }
139
140             next_t = cur_map + (cur - cur_min);
141             this_len = convert_to_cpu(next_t, t, pdu);
142             cur += this_len;
143
144             return 1;
145     }

Signed-off-by: Kou Wenqi <kouwenqi@kylinos.cn>
---
 btt/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/btt/mmap.c b/btt/mmap.c
index 9d4eb3d..1f9acbc 100644
--- a/btt/mmap.c
+++ b/btt/mmap.c
@@ -84,6 +84,8 @@ static int move_map(void)
 		munmap(cur_map, len);
 
 	cur_min = (cur & ~(pgsz-1));
+	if (total_size < cur_min)
+		return 0;
 	len = min_len(DEF_LEN, total_size - cur_min);
 	if (len < sizeof(*next_t))
 		return 0;
-- 
2.43.0

