From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 25 Jun 2016 19:34:47 +0000
Subject: Re: Any way to output semantics of block
Message-Id: <576EDCD7.5000303@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20160625170402.GA21168@wifi-514.cs.wisc.edu>
In-Reply-To: <20160625170402.GA21168@wifi-514.cs.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 06/25/2016 11:04 AM, Jun He wrote:
> Hi all,
>
> I use the output of blktrace as the input of my block device simulator.  Now I
> want to add semantics of data stored in each block to the output, so
> my simulator can use them.  For example, I would like to know if the block is
> storing file data or file system metadata. If it is metadata, I'd like to know
> what kind of metadata it is. For example, ext4's superblock, inode table,
> blockbitmap, or extent tree block ... If it is file data, I'd like to know
> its filename.
>
> Output of blkparse may look like:
>
> op block#  semantics
> w  43      inode-table
> w  88      directory-entries
> r  48      file-data(/home/user1/data)
> w  77      extent-tree-block
> w  777     journal
>
> Statically, I can get the semantics of, for example, ext4 by debugfs and
> dumpe2fs. And this is fine for most of the cases since the format of ext4 is
> mostly fixed (blocks that store inode table will always store inode table). But
> the data semantics in a block does change over time in some case. For example, a
> block can store file data at a time and extent tree block at another time.  So I
> cannot use the statically collected semantics to feed my simulator.
>
> Is outputting semantics already supported by blktrace?
>
> If not, any suggestions for implementing it?

The kernel marks certain IO as being meta data, and blktrace/blkparse 
understands this and carries this information to user space. What you 
are looking for is a further split of meta data into categories. This 
would need to be annotated on the kernel front, and the blktrace format 
extended to understand that we have multiple kinds of meta data. 
Currently we don't have that.


-- 
Jens Axboe

