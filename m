From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 06 Oct 2008 10:59:49 +0000
Subject: Re: [Patch 2/3] driver data: pass zfcp data through blktrace
Message-Id: <20081006105949.GB6303@osiris.boeblingen.de.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207558.26621.84.camel@kitka.ibm.com>
In-Reply-To: <1216207558.26621.84.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

> +	trace.flags = 0;
> +	trace.magic = cpu_to_be32(ZFCP_BLK_DRV_DATA_MAGIC);
> +	if (fsf_req->adapter->adapter_features & FSF_FEATURE_MEASUREMENT_DATA) {
> +		trace.flags |= ZFCP_BLK_LAT_VALID;
> +		lat_inf = &fsf_req->qtcb->prefix.prot_status_qual.latency_info;
> +		trace.channel_lat = cpu_to_be64(lat_inf->channel_lat * ticks);
> +		trace.fabric_lat = cpu_to_be64(lat_inf->fabric_lat * ticks);
> +	}
> +	if (fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR)
> +		trace.flags |= ZFCP_BLK_REQ_ERROR;
> +	trace.inb_usage = cpu_to_be16(fsf_req->qdio_inb_usage);
> +	trace.outb_usage = cpu_to_be16(fsf_req->qdio_outb_usage);

Could we please not add any cpu_to_be* calls to s390 only code? s390 is a big
endian architecture and therefore these calls are confusing and pointless.

> +#else
> +#define zfcp_fsf_trace_latency(fsf_req)	do { } while (0)
> +#endif

Please convert that to a static inline function for type checking.

Thanks.
