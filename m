Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F31CA9C
	for <linux-btrace@vger.kernel.org>; Tue, 29 Apr 2025 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745891337; cv=none; b=OYv27rZXHIolOg3w1mMwVEXb+AeOa1YYeo2bXlR9XSvqPd98om+sso5q59jgN//6cJ0tGP1tL+1curKHCe8Nb7GdRZY6i7rsPk563K7dJXfLxotQlyio/2sTqNIB2mZwduMlcj43p0n6t+MvjyF09uyH1AB7Hc1mCLv0bWH6B+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745891337; c=relaxed/simple;
	bh=rNFKZWp16ZQi9NXjLlJC7KOnEV1y5pPwlkM5L6Mpl/o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YGwCrxO+FNCnb6wPDHoNpcIKlUs+Ak/a4yE1SEBwGF8uWlBhbPzm0HwYywSzyeQ8+ERJ5DX2cT8nlvbroYorVxIV4YRF1xKYWzJg17uNLEck0metSGH+bQ0jXmhUNp5lgW3xEL2hDKSt80qv3LK8RPaG3TAHMukJMORiUSfhEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pGJGro5T; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pGJGro5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1745891024; bh=rNFKZWp16ZQi9NXjLlJC7KOnEV1y5pPwlkM5L6Mpl/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pGJGro5TdjNrVNlFic0tGxISWIHK5UMeRJJgHLL9IMq+E6zCBCnr0NiEAvA3nodcu
	 HO/Ppeq8YJkqfLsMREY+upzpJp9Q1xQrSpnYTBXWx7b2eZqy4c+zApGfsV/AWaUqQz
	 u5TPTVgtBvqkMVDOUrdJ6VshVj+zSI+6378RsmMY=
Received: from localhost.localdomain ([1.193.37.185])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id AE937CBA; Tue, 29 Apr 2025 09:43:41 +0800
X-QQ-mid: xmsmtpt1745891021tr1ouvocz
Message-ID: <tencent_0D3C718002373829DC33DCCA0A5107DC5406@qq.com>
X-QQ-XMAILINFO: NoN45VbJ/ow6FutV+O19eqhKCXmKyFUtClVteqomVtDwfFDJl3EAfYqSlJZz8/
	 vzrLOFy4H4mb28WsFNw0YKS1owtEhaOihk4+wrvEWjMumBdfTSrw9nNLtQNhyETc1gwvsiBTklJQ
	 jyfrQ1BwLaiTXKnChC5swS1TXazK7aIBudjztzn2zgTyGDSFLyZne8MIxWSRC69sbX7w4iA9rhdc
	 WaeSp9ox31sawfN6KQHvOvjecDV7m3Oheq4CRqtHUO/wTzfk7KY9y4a99h5cee5LcgWpOt22ebdt
	 gGaOJv1mmwJvsvdgVypzbugwzmsDkeqGmCv6+4Z5TO4gJhg7oGxI0zkSAToyk+yzKu5uwe71WlTD
	 iDbZOpRavY5A/J5McPxTbW7xMfknfamauj3o6n05G01L9MyumAxurCy2V5HD84qgSQr5IsIuXWLV
	 sP0lXdASt+xKdBtZOsTujgMLai0uk2mz8mcgxPbsuYKIEXuJkYpW2dgyXWKk+kbWyzyKd2g6stQi
	 LmIEeblWqS5SG3gzvy0SfjR73452HUF3jyHvHXiDaDkQkw3RfODlMFbD7VDwtsQSN9QV/LNdLU9H
	 FlOHtdwzQVwHEdk35gL+uf87WLVuCF8u2AMJyMMzy8B7KU2fHBd9LjJSOgMHIysAiiBVVwqmc0kH
	 4B7HO22ij2C1g+VU5238slhE05NSKkVhGTvYcCs5/psIfkq6Yg+gk7kcfLhM0E2957bV74sNwRIK
	 N/2JS6kAiQlFD3OCNuo7f3XvRqxV3F6CSR3Vg6nzITmH22CiPGpxyQ3TZCyl7M7qSmA5fUOQBRzw
	 j36qJPjwKmkoQ+QJ3FgBo4bDl4XZxZ+1Eds0RU0oOvf+6+tv8OUhZyQ0Vg7leSgqg0xiAChkEWhP
	 NZ1uPnbOFy7gjYUpkhlMcKK1EiFYsEISK0QE/qWbC7whDXfu69MU9W2FGeSrZhue878RL3uN9/LV
	 x+6sqAEfQ=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: 303146950@qq.com
To: axboe@kernel.dk
Cc: kouwenqi@kylinos.cn,
	linux-btrace@vger.kernel.org
Subject: Re: [PATCH] btt: eliminate redundant separators in btt -p display
Date: Tue, 29 Apr 2025 05:06:04 +0800
X-OQ-MSGID: <20250428210604.5603-1-303146950@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_82C549379F3956788830E028E3AB0394B809@qq.com>
References: <tencent_82C549379F3956788830E028E3AB0394B809@qq.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kou Wenqi <kouwenqi@kylinos.cn>

Hi Jens Axboe,
I would like to kindly request your review for this bugfix patch.
Thank you for your time and guidance.

--
Best regards,
Kou Wenqi

