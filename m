Return-Path: <linux-btrace-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3120FC4332F
	for <linux-btrace@archiver.kernel.org>; Mon, 30 Oct 2023 20:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjJ3UdE (ORCPT <rfc822;linux-btrace@archiver.kernel.org>);
        Mon, 30 Oct 2023 16:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjJ3UdE (ORCPT
        <rfc822;linux-btrace@vger.kernel.org>);
        Mon, 30 Oct 2023 16:33:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B22DF
        for <linux-btrace@vger.kernel.org>; Mon, 30 Oct 2023 13:33:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5505C433C8;
        Mon, 30 Oct 2023 20:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698697981;
        bh=nQE8M9b1x+iVivrRMkxRJD0wGbP5JDGDaf86E3pJy1o=;
        h=Date:From:To:Subject:From;
        b=cSI8KsL5DOw8CEJZhLsfoU+C6CXLXBjK/TqDtWt/UGgzzJCIhR2ya/yl9ZE186NzA
         3uixSXvR6LYCLwPdZ7B2djoC+SEsrIjhaMHqJd4z0TmUTLSjMMflVfJ25AWRgSj6eI
         yZkJEBWC/yzsSMteCM6u9Cnw0lIaCs49VFX0dFpY=
Date:   Mon, 30 Oct 2023 16:33:00 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-btrace@vger.kernel.org
Subject: PSA: migrating linux-btrace to new vger infrastructure
Message-ID: <20231030-amaranth-curassow-of-penetration-85fb4e@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrace.vger.kernel.org>
X-Mailing-List: linux-btrace@vger.kernel.org

Good day!

I plan to migrate the linux-btrace@vger.kernel.org list to the new
infrastructure this week. We're still doing it list-by-list to make sure that
we don't run into scaling issues with the new infra.

The migration will be performed live and should require any downtime.

Please speak up if you have any objections.

Best wishes,
-K
