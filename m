From: Anindita Bhattacharjee <anindita@nucleodyne.com>
Date: Fri, 23 May 2014 00:07:27 +0000
Subject: missing IO from per-IO dump file
Message-Id: <CAGOmp=v_2=sqRx3QjQ1=3OdO+p2j6J4vE_vq96biwobAbQDmVw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

 I am running blktrace to analyze I/O during a workload run and
obtained seek, latency and Block numbers as well as per-I/O-dump.
 I found some of the I/Os present in seek data to be missing in
per-I/O-dump file. I have checked the binary file from blkparse and it
seems
  to be containing the missing I/O s.

 We tried to debug the issue. We observed that in case of the missing
I/O s that the function handle_issue (in trace_issue.c) does not print
 to the per-io-dump file. The reason is that in routine:

dip_alloc, __dip_find(device) does not return NULL but some of the
fields of dip_info is null.

Code snippet:

struct d_info *dip_alloc(__u32 device, struct io *iop)
{
        struct d_info *dip = __dip_find(device);

        if (dip = NULL) {
                char str[256];

                dip = malloc(sizeof(struct d_info));
                memset(dip, 0, sizeof(*di

....
}

The snippets for missing I/Os in per-io-dump file and the
corresponding seek data files are as follows.

 Seek_d2d_c.dat
   31.497678158             0 w
    31.497684314             8 w
    31.498714725      14965272 r
    31.528598546     -14965280 w    This IO is present in per-io dump
file as well.
 Following IOs in seek file, not present in per-io-dump
  ..................................................................
  31.528613109             0 w
    31.528622309             0 w
    31.528630846             0 w
    31.528634955         83160 w
    31.528642355             0 w
     31.528649434         20528 w
    31.528657480             0 w
    31.528662694             8 w
    31.528670169             0 w
    31.528677839             0 w
    31.528684786             0 w
    31.528691806             0 w
     31.528698477             0 w
    31.528705403             0 w
    31.528709002        400584 w
    31.530779561             0 w
    31.530788126             8 w
    31.530795686             0 w
    31.530802527             0 w
     31.530810438             0 w
    31.530818504             0 w
    31.530825749             0 w
    31.530833630             0 w
    31.530838950     202957448 w
    31.530843604         32328 w
    31.530850399             0 w
     31.530852766             8 w
    31.530859075             0 w
    31.530867215             0 w
    31.530873892             0 w
    31.530880583             0 w
    31.562825308             0 w
    31.562840145             0 w
     31.562852559       1122896 w
    31.562858357         32864 w
    31.562867654             8 w
    31.562877654             0 w
    31.562885449             0 w
    31.562893685             0 w
    31.562901334             0 w
     31.562909789             0 w
    31.562918216             0 w
    31.562924928             0 w
    31.562928089        556128 w
    31.562934325             8 w
    31.562942388             0 w
    31.562949731             0 w
     31.562949731             0 w
    31.564311119             0 w
    31.564320633             0 w
    31.564328996             0 w
    31.564336468             0 w
    31.564345531             0 w
    31.564350328        186288 w
     31.564427881    -206584872 w
    31.564434939     206563432 w
    31.565417543    -205184024 w
    31.565420857         11800 w
    31.565422806             8 w
    31.565430704         45240 w
    31.565438653           256 w
     31.565444983             0 w
    31.565451475          8984 w
    31.565457018             0 w
    31.599583103             0 w
    31.599595560             0 w
    31.599597558         45024 w
    31.599606906             0 w
     31.599609723            16 w
    31.599618273             0 w
    31.599625903             0 w
    31.599634923             0 w
    31.599644617             0 w
    31.599652935             0 w
    31.599655424        264976 w
     31.599662249             0 w
    31.599669961             0 w
    31.599677146             8 w
    31.599685009             0 w
    31.599691789             0 w
    31.601868207             0 w
    31.601882099             0 w
     31.601890870             0 w
    31.601893157        166704 w
    31.601900850             0 w
    31.601906925             0 w
    31.601913350             8 w
    31.601918948             0 w
    31.601921613        262144 w
     31.601926410             0 w
    31.601931174             0 w
    31.601935870             0 w
    31.601940385             0 w
    31.601943616        167472 w
    31.601948108             0 w
    31.601952759             0 w
  ...............................................................
    31.603150381      13656752 r      <= this IO is seen in the
per-io-dump file, so above IOs are not added in per-io dup file


 Per-io-dump file snippet: sda.dump
 ---------------------------------

  8,0  :   31.526714955 Q 2486689584+8
             31.526715179 M 2486689584+8
             31.528598546 D 2486688568+1024
             31.667381793 C 2486688568+1024
    8,0  :    31.526713995 Q 2486689576+8
             31.526714192 M 2486689576+8
             31.528598546 D 2486688568+1024
             31.667381793 C 2486688568+1024
 -----------------------------------------

   8,0  :    31.603144313 Q 2501586080+8                <== IO till
this is missing from the above IO at time stamp (D) 31.528598546
             31.603147310 G 2501586080+8
             31.603149032 I 2501586080+8
              31.603150381 D 2501586080+8
             31.705885488 C 2501586080+8
 -----------------------------------------
   8,0  :    31.706148511 Q 2501577624+8
             31.706149871 G 2501577624+8
              31.706150682 I 2501577624+8
             31.706151614 D 2501577624+8
             31.802181772 C 2501577624+8
 -----------------------------------------
   8,0  :    31.802552026 Q 2501552992+8
              31.802554440 G 2501552992+8
             31.802555441 I 2501552992+8
             31.802557069 D 2501552992+8
             31.895693951 C 2501552992+8
 -----------------------------------------
   8,0  :    31.895980338 Q 2501544664+8
             31.895981860 G 2501544664+8
             31.895982601 I 2501544664+8
             31.895983806 D 2501544664+8
             31.896308616 C 2501544664+8
 -----------------------------------------
   8,0  :    31.924516917 Q 2501552680+8
             31.924521388 G 2501552680+8
             31.924523914 I 2501552680+8
             31.924526197 D 2501552680+8
             31.924967038 C 2501552680+8
 ----------------------------------------------------




 Please help me to understand this discrepancy.


 Exact commands to generate seek file and per-io dump file

 1. blkparse -i sda -d sda.bin
 2. btt -i sda.bin -p sda.dump
 3. btt -i sda.bin -s sda.seek

 Thanks in advance
 Anindita
