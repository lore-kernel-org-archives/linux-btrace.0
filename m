Return-Path: <linux-btrace-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199F4C4332F
	for <linux-btrace@archiver.kernel.org>; Mon, 30 Oct 2023 21:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjJ3VAu (ORCPT <rfc822;linux-btrace@archiver.kernel.org>);
        Mon, 30 Oct 2023 17:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjJ3VAu (ORCPT
        <rfc822;linux-btrace@vger.kernel.org>);
        Mon, 30 Oct 2023 17:00:50 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ADBE1
        for <linux-btrace@vger.kernel.org>; Mon, 30 Oct 2023 14:00:46 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3575b6d3080so1853615ab.1
        for <linux-btrace@vger.kernel.org>; Mon, 30 Oct 2023 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698699646; x=1699304446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEFlmJ3HuSWRykVLtyva6FsVWVuyLGnY1o0eslIfrdI=;
        b=mftJZJs4t+x8wYL/8+8XfukhYhWTiL33EetQi4j5LjeFwKouN3nCgPZSJV2Z7XCYKA
         Q1Xule8vv+T2NUo7J6cg1WlSUu9VIxU6BSCiPPacVRzumPN+De8ix8gdzn4ElSqLavuD
         EvcgXd9G+2f51pNn5+pWRstbn+3Kbtt6A9qHfbjJ19VNny8p4fiy6v67Zp3+k7IGHW6C
         sA4VS1DPeoqrqz71435DWvm+VyuDGeizluaEGczG0Tez8QRvt5BYAXt2VnPNZaLklXEY
         fhCXhWFl34lTjtIu62m2Sm2jWWj5cxYfFo+x7/qmq9E75ypu1CmrjfsZPdjdtavuFB90
         afRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699646; x=1699304446;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEFlmJ3HuSWRykVLtyva6FsVWVuyLGnY1o0eslIfrdI=;
        b=tzuxYWtF/KkckmHGO8cmHkf7CilglOZXUG9CBmAJnYt54vw+Ak9TNKL2IDBTWO4B+O
         4xO44nDKIv2oqDhUMB9X1e4HNvSHJqhgb7FJwuiGwUYA1z2P68xlywlG59VW10AK+Uxa
         wbebAmoC5uxo8XFq7Apv/miXILPAjPCxYyPyiyJlr2jmcQMEbTL+sFIiVZyd7Yeek0MF
         bBJmhAABmHrU5e/nSS36mBFFB42XN3ClysWP+ztJbVt2KKePbxjN8u7I4sHoevNpA6Dn
         19Wjcj6rol9latVI3Dtx9dNTeKS5C3R5sa63X6T+Hqx4ee8DMaZ7VRvAbBP4MxB60vsD
         CNYw==
X-Gm-Message-State: AOJu0Yw/4l24dArn/kdYcJcQLuCmSae2eJ9qrPi2q/duWMNLGHH8eaS7
        /GryJrRNT7mhGWYJRoa9oDAnnub2ds+vVrw6xM7Zkg==
X-Google-Smtp-Source: AGHT+IG2dFW1g5wQtxxIBA8TvOt/AMspoYJOPNnzfrL4NWbxw6uwRSCeiGzzHu1W8uUeDFsiAuRJ5g==
X-Received: by 2002:a92:c24f:0:b0:34f:b824:5844 with SMTP id k15-20020a92c24f000000b0034fb8245844mr13229046ilo.3.1698699645904;
        Mon, 30 Oct 2023 14:00:45 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l2-20020a056e02066200b003580ba53423sm2575083ilt.53.2023.10.30.14.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 14:00:45 -0700 (PDT)
Message-ID: <af7b7ef9-301b-4634-b063-f9bc0cd2d74e@kernel.dk>
Date:   Mon, 30 Oct 2023 15:00:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PSA: migrating linux-btrace to new vger infrastructure
Content-Language: en-US
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-btrace@vger.kernel.org
References: <20231030-amaranth-curassow-of-penetration-85fb4e@nitro>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231030-amaranth-curassow-of-penetration-85fb4e@nitro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrace.vger.kernel.org>
X-Mailing-List: linux-btrace@vger.kernel.org

On 10/30/23 2:33 PM, Konstantin Ryabitsev wrote:
> Good day!
> 
> I plan to migrate the linux-btrace@vger.kernel.org list to the new
> infrastructure this week. We're still doing it list-by-list to make sure that
> we don't run into scaling issues with the new infra.
> 
> The migration will be performed live and should require any downtime.
> 
> Please speak up if you have any objections.

Go ahead, thanks.

-- 
Jens Axboe


