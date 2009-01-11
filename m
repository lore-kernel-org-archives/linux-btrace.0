From: "M. Edward (Ed) Borasky" <znmeb@cesmail.net>
Date: Sun, 11 Jan 2009 02:59:26 +0000
Subject: Missing pictures in "btt.pdf" when building from the git repo on
Message-Id: <4969608E.9020400@cesmail.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060903070506020600010909"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------060903070506020600010909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I've got an openSUSE 11.1 system with some of the later "factory"
software installed. I've downloaded "blktrace" from the Git repo with
"git clone". Everything seems to be building correctly, but the
"btt.pdf" file isn't getting the figures. The LaTeX processing is
generating errors. I've attached the log of the "make docs" step.

I'm guessing that I have the wrong versions of some of the LaTeX tools.
Is anyone else having problems like this?

--
M. Edward (Ed) Borasky, FBG, AB, PTA, PGS, MS, MNLP, NST, ACMC(P), WOM

I've never met a happy clam. In fact, most of them were pretty steamed.

--------------060903070506020600010909
Content-Type: text/x-log;
 name="docs.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="docs.log"

make -C doc all
make[1]: Entering directory `/home/Projects/linux_perf_viz/blktrace-howto/blktrace/doc'
This is pdfTeXk, Version 3.1415926-1.40.9 (Web2C 7.5.7)
 %&-line parsing enabled.
entering extended mode
(./blktrace.tex
LaTeX2e <2005/12/01>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, german-x-2008-06-18, ngerman-x-2008-06-18, ancientgreek, ibycus, ar
abic, basque, bulgarian, catalan, pinyin, coptic, croatian, czech, danish, dutc
h, esperanto, estonian, farsi, finnish, french, galician, german, ngerman, mono
greek, greek, hungarian, icelandic, indonesian, interlingua, irish, italian, la
tin, mongolian, mongolian2a, bokmal, nynorsk, polish, portuguese, romanian, rus
sian, sanskrit, serbian, slovak, slovenian, spanish, swedish, turkish, ukenglis
h, ukrainian, uppersorbian, welsh, loaded.
(/usr/share/texmf/tex/latex/base/article.cls
Document Class: article 2005/09/16 v1.4f Standard LaTeX document class
(/usr/share/texmf/tex/latex/base/size10.clo))
No file blktrace.aux.
[1]
Overfull \hbox (69.74638pt too wide) in paragraph at lines 71--71
[]\OT1/cmtt/m/n/10 % git clone git://git.kernel.org/pub/scm/linux/kernel/git/ax
boe/blktrace.git bt[] 

Overfull \hbox (59.24648pt too wide) in paragraph at lines 100--100
[]\OT1/cmtt/m/n/10 % make menuconfig                    or make xconfig, or edi
t .config, or ...[] 
[2]
Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        1     0.000000000   697  G   W 223490 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        3     0.000002197   697  Q   W 223490 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        4     0.000005533   697  M   W 223498 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        5     0.000008607   697  M   W 223506 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        6     0.000011569   697  M   W 223514 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        7     0.000014407   697  M   W 223522 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        8     0.000017367   697  M   W 223530 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        9     0.000020161   697  M   W 223538 + 8 
[kjournald][] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3       10     0.000024062   697  D   W 223490 + 56
 [kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    1       12     0.009538995   697  G   W 223546 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    1       14     0.009540313   697  Q   W 223546 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    1       15     0.009542980   697  D   W 223546 + 8 
[kjournald][] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Queued:           0,        0KiB  Writes Queued:     
      7,      128KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Dispatches:        0,        0KiB  Write Dispatches:  
      7,      128KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
     11,      168KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
     25[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      0[] 
[3]
Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Queued:           0,        0KiB  Writes Queued:     
      1,       28KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Dispatches:        0,        0KiB  Write Dispatches:  
      1,       28KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
      0,        0KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
      6[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      0[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Queued:           0,        0KiB  Writes Queued:     
     11,      168KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Dispatches:        0,        0KiB  Write Dispatches:  
     11,      168KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
     11,      168KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
     31[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      3[] 

Overfull \hbox (80.24629pt too wide) in paragraph at lines 211--211
[]  \OT1/cmtt/m/n/10 3,0    0       26     0.004890361 13528  I   R 56 (12 00 0
0 00 38 ..) [inquiry][] 

Overfull \hbox (80.24629pt too wide) in paragraph at lines 211--211
[]  \OT1/cmtt/m/n/10 3,0    0       28     0.004893250 13528  D   R 56 (12 00 0
0 00 38 ..) [inquiry][] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 211--211
[]  \OT1/cmtt/m/n/10 3,0    0       29     0.005344910     0  C   R (12 00 00 0
0 38 ..) [0][] 
[4]
Overfull \hbox (69.74638pt too wide) in paragraph at lines 262--262
[]        \OT1/cmtt/m/n/10 32768, 98304, 163840, 229376, 294912, 819200, 884736
, 1605632, 2654208,[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 262--262
[]\OT1/cmtt/m/n/10 180 days, whichever comes first.  Use tune2fs -c or -i to ov
erride.[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   1        1     0.000000000  9728  G   R 384 + 32 [m
kfs.ext3][] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   1        3     0.000002446  9728  Q   R 384 + 32 [m
kfs.ext3][] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   1        4     0.000005110  9728  D   R 384 + 32 [m
kfs.ext3][] 
[5]
Overfull \hbox (17.24684pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,224  3        1     0.021658989  9728  G   R 384 + 32 [m
kfs.ext3][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163392    41.117070504     0  C   W 87469088 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   3   163374    41.122683668     0  C   W 88168160 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163393    41.129952433     0  C   W 87905984 + 
1376 [0][] 

Overfull \hbox (43.49661pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163394    41.130049431     0  D   W 89129344 + 
1376 [swapper][] 

Overfull \hbox (43.49661pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163395    41.130067135     0  D   W 89216704 + 
1376 [swapper][] 

Overfull \hbox (43.49661pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163396    41.130083785     0  D   W 89304096 + 
1376 [swapper][] 

Overfull \hbox (43.49661pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163397    41.130099455     0  D   W 89391488 + 
1376 [swapper][] 

Overfull \hbox (43.49661pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163398    41.130114732     0  D   W 89478848 + 
1376 [swapper][] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163399    41.130128885     0  D   W 89481536 + 
64 [swapper][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   3   163375    41.134758196     0  C   W 86333152 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163400    41.142229726     0  C   W 89129344 + 
1376 [0][] 

Overfull \hbox (1.49698pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163401    41.144952314     0  C   W 89481536 + 
64 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   3   163376    41.147441930     0  C   W 88342912 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163402    41.155869604     0  C   W 89478848 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   3   163377    41.159466082     0  C   W 86245760 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163403    41.166944976     0  C   W 89216704 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163404    41.178968252     0  C   W 89304096 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163405    41.191860173     0  C   W 89391488 + 
1376 [0][] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Queued:           0,        0KiB  Writes Queued:     
      9,    5,520KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Dispatches:        0,        0KiB  Write Dispatches:  
      0,        0KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
      0,        0KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
    336[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      0[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Queued:       2,411,   38,576KiB  Writes Queued:     
    769,  425,408KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Dispatches:    2,407,   38,512KiB  Write Dispatches:  
    118,   61,680KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
      0,        0KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
 25,819[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      4[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Queued:           2,       32KiB  Writes Queued:     
     18,   10,528KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Dispatches:        2,       32KiB  Write Dispatches:  
      3,    1,344KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
      0,        0KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
    640[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      0[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Queued:      20,572,  329,152KiB  Writes Queued:     
    594,  279,712KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Dispatches:   20,576,  329,216KiB  Write Dispatches:  
  1,474,  740,720KiB[] 
[6]
Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Completed:   22,985,  367,760KiB  Writes Completed:  
  1,390,  721,168KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
 16,888[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      0[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Queued:      22,985,  367,760KiB  Writes Queued:     
  1,390,  721,168KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Dispatches:   22,985,  367,760KiB  Write Dispatches:  
  1,595,  803,744KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Completed:   22,985,  367,760KiB  Writes Completed:  
  1,390,  721,168KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
 43,683[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      4[] 
[7] (/usr/share/texmf/tex/latex/base/omscmr.fd)
Overfull \hbox (90.2456pt too wide) in paragraph at lines 384--399
[] 
[8] [9]

LaTeX Warning: Reference `sec:blkparse-format' on page 10 undefined on input li
ne 460.

[10]

LaTeX Warning: Reference `sec:blkparse-format' on page 11 undefined on input li
ne 479.


LaTeX Warning: Reference `sec:act-table' on page 11 undefined on input line 485
.


Overfull \hbox (107.40431pt too wide) in paragraph at lines 470--513
[] 
[11] [12]
Overfull \hbox (85.61174pt too wide) in paragraph at lines 588--612
[][] 
[13]
Overfull \hbox (27.74675pt too wide) in paragraph at lines 676--676
[]  \OT1/cmtt/m/n/10 8,0    3        1     0.000000000   697  G   W 223490 + 8 
[kjournald][] 
[14]
Overfull \hbox (1.9447pt too wide) in paragraph at lines 712--714
[]\OT1/cmr/m/n/10 The com-mand as-so-ci-ated with the event (sur-rounded by squ
are brack-

Overfull \hbox (9.27754pt too wide) in paragraph at lines 716--719
[]\OT1/cmr/m/n/10 The com-mand as-so-ci-ated with the event (sur-rounded
[15] [16]
Overfull \hbox (55.59233pt too wide) in paragraph at lines 774--779
[]

Overfull \hbox (9.5727pt too wide) in paragraph at lines 774--779
\OT1/cmr/m/n/10 Adds a trace event de-scrib-ing the state change of the passed 
in re-quest[]queue.

Overfull \hbox (9.70808pt too wide) in paragraph at lines 782--785
[]

Overfull \hbox (16.68677pt too wide) in paragraph at lines 782--785
\OT1/cmr/m/n/10 the ac-tion be-ing per-formed on the BIO, and is one of BLK[]TA
[]BACKMERGE,

Overfull \hbox (67.7356pt too wide) in paragraph at lines 788--792
[]
[17]
Overfull \hbox (21.70096pt too wide) in paragraph at lines 795--799
[]\OT1/cmr/m/n/10 Adds

Overfull \hbox (106.59454pt too wide) in paragraph at lines 802--804
[]
[18] (./blktrace.aux)

LaTeX Warning: There were undefined references.


LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)
Output written on blktrace.dvi (18 pages, 49428 bytes).
Transcript written on blktrace.log.
This is pdfTeXk, Version 3.1415926-1.40.9 (Web2C 7.5.7)
 %&-line parsing enabled.
entering extended mode
(./blktrace.tex
LaTeX2e <2005/12/01>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, german-x-2008-06-18, ngerman-x-2008-06-18, ancientgreek, ibycus, ar
abic, basque, bulgarian, catalan, pinyin, coptic, croatian, czech, danish, dutc
h, esperanto, estonian, farsi, finnish, french, galician, german, ngerman, mono
greek, greek, hungarian, icelandic, indonesian, interlingua, irish, italian, la
tin, mongolian, mongolian2a, bokmal, nynorsk, polish, portuguese, romanian, rus
sian, sanskrit, serbian, slovak, slovenian, spanish, swedish, turkish, ukenglis
h, ukrainian, uppersorbian, welsh, loaded.
(/usr/share/texmf/tex/latex/base/article.cls
Document Class: article 2005/09/16 v1.4f Standard LaTeX document class
(/usr/share/texmf/tex/latex/base/size10.clo)) (./blktrace.aux

LaTeX Warning: Label `sec:act-table' multiply defined.

) [1]
Overfull \hbox (69.74638pt too wide) in paragraph at lines 71--71
[]\OT1/cmtt/m/n/10 % git clone git://git.kernel.org/pub/scm/linux/kernel/git/ax
boe/blktrace.git bt[] 

Overfull \hbox (59.24648pt too wide) in paragraph at lines 100--100
[]\OT1/cmtt/m/n/10 % make menuconfig                    or make xconfig, or edi
t .config, or ...[] 
[2]
Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        1     0.000000000   697  G   W 223490 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        3     0.000002197   697  Q   W 223490 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        4     0.000005533   697  M   W 223498 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        5     0.000008607   697  M   W 223506 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        6     0.000011569   697  M   W 223514 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        7     0.000014407   697  M   W 223522 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        8     0.000017367   697  M   W 223530 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3        9     0.000020161   697  M   W 223538 + 8 
[kjournald][] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    3       10     0.000024062   697  D   W 223490 + 56
 [kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    1       12     0.009538995   697  G   W 223546 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    1       14     0.009540313   697  Q   W 223546 + 8 
[kjournald][] 

Overfull \hbox (27.74675pt too wide) in paragraph at lines 184--184
[]  \OT1/cmtt/m/n/10 8,0    1       15     0.009542980   697  D   W 223546 + 8 
[kjournald][] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Queued:           0,        0KiB  Writes Queued:     
      7,      128KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Dispatches:        0,        0KiB  Write Dispatches:  
      7,      128KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
     11,      168KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
     25[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      0[] 
[3]
Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Queued:           0,        0KiB  Writes Queued:     
      1,       28KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Dispatches:        0,        0KiB  Write Dispatches:  
      1,       28KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
      0,        0KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
      6[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      0[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Queued:           0,        0KiB  Writes Queued:     
     11,      168KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Dispatches:        0,        0KiB  Write Dispatches:  
     11,      168KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
     11,      168KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
     31[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 184--184
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      3[] 

Overfull \hbox (80.24629pt too wide) in paragraph at lines 211--211
[]  \OT1/cmtt/m/n/10 3,0    0       26     0.004890361 13528  I   R 56 (12 00 0
0 00 38 ..) [inquiry][] 

Overfull \hbox (80.24629pt too wide) in paragraph at lines 211--211
[]  \OT1/cmtt/m/n/10 3,0    0       28     0.004893250 13528  D   R 56 (12 00 0
0 00 38 ..) [inquiry][] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 211--211
[]  \OT1/cmtt/m/n/10 3,0    0       29     0.005344910     0  C   R (12 00 00 0
0 38 ..) [0][] 
[4]
Overfull \hbox (69.74638pt too wide) in paragraph at lines 262--262
[]        \OT1/cmtt/m/n/10 32768, 98304, 163840, 229376, 294912, 819200, 884736
, 1605632, 2654208,[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 262--262
[]\OT1/cmtt/m/n/10 180 days, whichever comes first.  Use tune2fs -c or -i to ov
erride.[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   1        1     0.000000000  9728  G   R 384 + 32 [m
kfs.ext3][] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   1        3     0.000002446  9728  Q   R 384 + 32 [m
kfs.ext3][] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   1        4     0.000005110  9728  D   R 384 + 32 [m
kfs.ext3][] 
[5]
Overfull \hbox (17.24684pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,224  3        1     0.021658989  9728  G   R 384 + 32 [m
kfs.ext3][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163392    41.117070504     0  C   W 87469088 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   3   163374    41.122683668     0  C   W 88168160 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163393    41.129952433     0  C   W 87905984 + 
1376 [0][] 

Overfull \hbox (43.49661pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163394    41.130049431     0  D   W 89129344 + 
1376 [swapper][] 

Overfull \hbox (43.49661pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163395    41.130067135     0  D   W 89216704 + 
1376 [swapper][] 

Overfull \hbox (43.49661pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163396    41.130083785     0  D   W 89304096 + 
1376 [swapper][] 

Overfull \hbox (43.49661pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163397    41.130099455     0  D   W 89391488 + 
1376 [swapper][] 

Overfull \hbox (43.49661pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163398    41.130114732     0  D   W 89478848 + 
1376 [swapper][] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163399    41.130128885     0  D   W 89481536 + 
64 [swapper][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   3   163375    41.134758196     0  C   W 86333152 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163400    41.142229726     0  C   W 89129344 + 
1376 [0][] 

Overfull \hbox (1.49698pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163401    41.144952314     0  C   W 89481536 + 
64 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   3   163376    41.147441930     0  C   W 88342912 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163402    41.155869604     0  C   W 89478848 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[]  \OT1/cmtt/m/n/10 8,32   3   163377    41.159466082     0  C   W 86245760 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163403    41.166944976     0  C   W 89216704 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163404    41.178968252     0  C   W 89304096 + 
1376 [0][] 

Overfull \hbox (11.99689pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 65,160  3   163405    41.191860173     0  C   W 89391488 + 
1376 [0][] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Queued:           0,        0KiB  Writes Queued:     
      9,    5,520KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Dispatches:        0,        0KiB  Write Dispatches:  
      0,        0KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
      0,        0KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
    336[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      0[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Queued:       2,411,   38,576KiB  Writes Queued:     
    769,  425,408KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Dispatches:    2,407,   38,512KiB  Write Dispatches:  
    118,   61,680KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
      0,        0KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
 25,819[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      4[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Queued:           2,       32KiB  Writes Queued:     
     18,   10,528KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Dispatches:        2,       32KiB  Write Dispatches:  
      3,    1,344KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Completed:        0,        0KiB  Writes Completed:  
      0,        0KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
    640[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      0[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Queued:      20,572,  329,152KiB  Writes Queued:     
    594,  279,712KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Dispatches:   20,576,  329,216KiB  Write Dispatches:  
  1,474,  740,720KiB[] 
[6]
Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Completed:   22,985,  367,760KiB  Writes Completed:  
  1,390,  721,168KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
 16,888[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      0[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Queued:      22,985,  367,760KiB  Writes Queued:     
  1,390,  721,168KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Dispatches:   22,985,  367,760KiB  Write Dispatches:  
  1,595,  803,744KiB[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Reads Completed:   22,985,  367,760KiB  Writes Completed:  
  1,390,  721,168KiB[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 Read Merges:            0               Write Merges:      
 43,683[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 330--330
[] \OT1/cmtt/m/n/10 IO unplugs:             0               Timer unplugs:     
      4[] 
[7] (/usr/share/texmf/tex/latex/base/omscmr.fd)
Overfull \hbox (90.2456pt too wide) in paragraph at lines 384--399
[] 
[8] [9] [10]
Overfull \hbox (107.40431pt too wide) in paragraph at lines 470--513
[] 
[11] [12]
Overfull \hbox (85.61174pt too wide) in paragraph at lines 588--612
[][] 
[13]
Overfull \hbox (27.74675pt too wide) in paragraph at lines 676--676
[]  \OT1/cmtt/m/n/10 8,0    3        1     0.000000000   697  G   W 223490 + 8 
[kjournald][] 
[14]
Overfull \hbox (1.9447pt too wide) in paragraph at lines 712--714
[]\OT1/cmr/m/n/10 The com-mand as-so-ci-ated with the event (sur-rounded by squ
are brack-

Overfull \hbox (9.27754pt too wide) in paragraph at lines 716--719
[]\OT1/cmr/m/n/10 The com-mand as-so-ci-ated with the event (sur-rounded
[15] [16]
Overfull \hbox (55.59233pt too wide) in paragraph at lines 774--779
[]

Overfull \hbox (9.5727pt too wide) in paragraph at lines 774--779
\OT1/cmr/m/n/10 Adds a trace event de-scrib-ing the state change of the passed 
in re-quest[]queue.

Overfull \hbox (9.70808pt too wide) in paragraph at lines 782--785
[]

Overfull \hbox (16.68677pt too wide) in paragraph at lines 782--785
\OT1/cmr/m/n/10 the ac-tion be-ing per-formed on the BIO, and is one of BLK[]TA
[]BACKMERGE,

Overfull \hbox (67.7356pt too wide) in paragraph at lines 788--792
[]
[17]
Overfull \hbox (21.70096pt too wide) in paragraph at lines 795--799
[]\OT1/cmr/m/n/10 Adds

Overfull \hbox (106.59454pt too wide) in paragraph at lines 802--804
[]
[18] (./blktrace.aux)

LaTeX Warning: There were multiply-defined labels.

 )
(see the transcript file for additional information)
Output written on blktrace.dvi (18 pages, 49412 bytes).
Transcript written on blktrace.log.
[1][2][3][4][5][6][7][8][9][10][11][12][13][14][15][16][17][18]
145027 bytes written

blktrace.dvi -> blktrace.pdf
make[1]: Leaving directory `/home/Projects/linux_perf_viz/blktrace-howto/blktrace/doc'
make -C btt docs
make[1]: Entering directory `/home/Projects/linux_perf_viz/blktrace-howto/blktrace/btt'
make -C doc all
make[2]: Entering directory `/home/Projects/linux_perf_viz/blktrace-howto/blktrace/btt/doc'
This is pdfTeXk, Version 3.1415926-1.40.9 (Web2C 7.5.7)
 %&-line parsing enabled.
entering extended mode
(./btt.tex
LaTeX2e <2005/12/01>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, german-x-2008-06-18, ngerman-x-2008-06-18, ancientgreek, ibycus, ar
abic, basque, bulgarian, catalan, pinyin, coptic, croatian, czech, danish, dutc
h, esperanto, estonian, farsi, finnish, french, galician, german, ngerman, mono
greek, greek, hungarian, icelandic, indonesian, interlingua, irish, italian, la
tin, mongolian, mongolian2a, bokmal, nynorsk, polish, portuguese, romanian, rus
sian, sanskrit, serbian, slovak, slovenian, spanish, swedish, turkish, ukenglis
h, ukrainian, uppersorbian, welsh, loaded.
(/usr/share/texmf/tex/latex/base/article.cls
Document Class: article 2005/09/16 v1.4f Standard LaTeX document class
(/usr/share/texmf/tex/latex/base/size10.clo))
(/usr/share/texmf/tex/latex/graphics/epsfig.sty
(/usr/share/texmf/tex/latex/graphics/graphicx.sty
(/usr/share/texmf/tex/latex/graphics/keyval.sty)
(/usr/share/texmf/tex/latex/graphics/graphics.sty
(/usr/share/texmf/tex/latex/graphics/trig.sty)
(/usr/lib/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf/tex/latex/graphics/dvips.def))))
(/usr/share/texmf/tex/latex/placeins/placeins.sty)
No file btt.aux.

LaTeX Warning: Reference `sec:cmd-line' on page 1 undefined on input line 55.

[1]
No file btt.toc.
[2]

LaTeX Warning: Reference `sec:o-D' on page 3 undefined on input line 78.

[3] [4]
Overfull \hbox (5.4972pt too wide) in paragraph at lines 209--209
 []       \OT1/cmtt/m/n/10 DEV |       Q2G       G2I       Q2M       I2D       
D2C[] 

Overfull \hbox (5.4972pt too wide) in paragraph at lines 209--209
 []\OT1/cmtt/m/n/10 ---------- | --------- --------- --------- --------- ------
---[] 

Overfull \hbox (5.4972pt too wide) in paragraph at lines 209--209
 [] \OT1/cmtt/m/n/10 (  8, 80) |   0.0013%   0.0004%   0.0006%  88.5005%  11.49
88%[] 

Overfull \hbox (5.4972pt too wide) in paragraph at lines 209--209
 []\OT1/cmtt/m/n/10 ---------- | --------- --------- --------- --------- ------
---[] 

Overfull \hbox (5.4972pt too wide) in paragraph at lines 209--209
 []   \OT1/cmtt/m/n/10 Overall |   0.0003%   0.0001%   0.0041%  21.4998%  78.49
58%[] 

Overfull \hbox (10.74715pt too wide) in paragraph at lines 226--226
 []       \OT1/cmtt/m/n/10 DEV |      #Q    #D Ratio | BLKmin BLKavg BLKmax   T
otal[] 

Overfull \hbox (10.74715pt too wide) in paragraph at lines 226--226
 []\OT1/cmtt/m/n/10 ---------- | ------- ----- ----- | ------ ------ ------ ---
----[] 

Overfull \hbox (10.74715pt too wide) in paragraph at lines 226--226
 [] \OT1/cmtt/m/n/10 ( 68, 64) | 2262311 18178 124.5 |      2    124    128 226
2382[] 
[5]
Overfull \hbox (5.98694pt too wide) in paragraph at lines 264--268
[]\OT1/cmr/m/n/10 During nor-mal op-er-a-tion, re-quests queues

Overfull \hbox (0.2726pt too wide) in paragraph at lines 290--293
[]\OT1/cmr/m/n/10 In this sub-sec-tion one can see
[6]
Overfull \hbox (68.49664pt too wide) in paragraph at lines 342--342
 []\OT1/cmtt/m/n/10 ==================== Active Requests At Q Information =====
===============[] 
[7] [8]

LaTeX Warning: Reference `sec:o-A' on page 9 undefined on input line 350.


LaTeX Warning: Reference `tl-defs' on page 9 undefined on input line 357.

[9]
Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 []       \OT1/cmtt/m/n/10 DEV | <.005 <.010 <.025 <.050 <.075 <.100 <.250 <.50
0 < 1.0 >=1.0[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 --------- | ===== ===== ===== ===== ===== ===== ===== ====
= ===== =====[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 ( 66, 80) |  61.2   7.9  12.1   7.9   3.0   1.4   1.5   0.
2   0.0   4.6[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 ( 65,192) |  42.3   5.0   8.7  30.0   8.9   3.0   1.8   0.
1   0.0   0.1[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 ( 65,128) |  34.3   5.3   8.9  32.0   9.7   3.7   5.3   0.
6   0.0   0.1[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 ( 65, 64) |  59.9   4.2   6.0  24.6   4.2   0.8   0.1   0.
0   0.0   0.1[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 ( 66, 64) |  62.6   8.1  12.7   7.9   2.4   0.6   0.1   0.
0   0.0   5.4[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 []\OT1/cmtt/m/n/10 ========== | ===== ===== ===== ===== ===== ===== ===== ====
= ===== =====[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 []       \OT1/cmtt/m/n/10 AVG |  52.9   6.2  10.0  20.1   5.3   1.7   1.4   0.
2   0.0   2.1[] 
[10]

LaTeX Warning: Reference `sec:activity' on page 11 undefined on input line 434.



LaTeX Warning: Reference `sec:qhist' on page 11 undefined on input line 437.


LaTeX Warning: Reference `sec:dhist' on page 11 undefined on input line 441.


LaTeX Warning: Reference `sec:o-X' on page 11 undefined on input line 453.


LaTeX Warning: Reference `sec:iostat' on page 11 undefined on input line 456.


LaTeX Warning: Reference `sec:per-io' on page 11 undefined on input line 461.


LaTeX Warning: Reference `sec:lat' on page 11 undefined on input line 465.


LaTeX Warning: Reference `sec:seek' on page 11 undefined on input line 469.


LaTeX Warning: Reference `sec:o-u' on page 11 undefined on input line 473.

[11]

LaTeX Warning: Reference `sec:o-d' on page 12 undefined on input line 521.


Overfull \hbox (8.47284pt too wide) in paragraph at lines 519--523
[]\OT1/cmr/m/n/10 What this in-di-cates is that there was q ac-tiv-ity for the 
sys-tem from 0.000000000
(/usr/share/texmf/tex/latex/base/omscmr.fd) [12]

LaTeX Warning: Reference `fig:activity' on page 13 undefined on input line 538.


<activity.eps> [13]

LaTeX Warning: Reference `fig:qhist' on page 14 undefined on input line 569.

<qhist.eps> [14]

LaTeX Warning: Reference `fig:dhist' on page 15 undefined on input line 585.

<dhist.eps> [15]
Overfull \hbox (59.24648pt too wide) in paragraph at lines 614--614
[]             \OT1/cmtt/m/n/10 rkB/s     wkB/s avgrq-sz avgqu-sz   await   svc
tm  %util   Stamp[] 

Overfull \hbox (59.24648pt too wide) in paragraph at lines 614--614
[]              \OT1/cmtt/m/n/10 0.00  76403.18   152.00    31.00    0.00    0.
00   0.00   71.79[] 

Overfull \hbox (59.24648pt too wide) in paragraph at lines 614--614
[]              \OT1/cmtt/m/n/10 2.02     27.81    42.13     0.61    0.00   21.
90   0.00   TOTAL[] 
[16] [17] [18] [19]
Overfull \hbox (55.28352pt too wide) in paragraph at lines 717--719
[]\OT1/cmr/m/n/10 An ex-am-ple name would be af-ter spec-i-fy-ing \OT1/cmtt/m/n
/10 -s seek \OT1/cmr/m/n/10 would be: \OT1/cmtt/m/n/10 seek[]065,048[]q2q[]w.da
t\OT1/cmr/m/n/10 . 

LaTeX Warning: Reference `fig:seek' on page 20 undefined on input line 740.

<seek.eps>

LaTeX Warning: `!h' float specifier changed to `!ht'.

[20] [21]

LaTeX Warning: Reference `fig:sps' on page 22 undefined on input line 789.

<sps.eps> [22]

LaTeX Warning: Reference `sec:seek' on page 23 undefined on input line 838.


LaTeX Warning: Reference `sec:detailed-data' on page 23 undefined on input line
 844.

[23]

LaTeX Warning: Reference `sec:activity' on page 24 undefined on input line 868.



LaTeX Warning: Reference `sec:cmd-line' on page 24 undefined on input line 895.



LaTeX Warning: Reference `sec:getting-started' on page 24 undefined on input li
ne 900.


LaTeX Warning: Reference `sec:iostat' on page 24 undefined on input line 906.

[24]

LaTeX Warning: Reference `sec:lat-d2c' on page 25 undefined on input line 912.


LaTeX Warning: Reference `sec:sps-spec' on page 25 undefined on input line 925.



LaTeX Warning: Reference `sec:seek' on page 25 undefined on input line 929.


LaTeX Warning: Reference `sec:output-overview' on page 25 undefined on input li
ne 939.


LaTeX Warning: Reference `sec:per-io' on page 25 undefined on input line 945.


LaTeX Warning: Reference `sec:lat-q2c' on page 25 undefined on input line 956.

[25]

LaTeX Warning: Reference `sec:seek' on page 26 undefined on input line 969.


LaTeX Warning: Reference `sec:iostat' on page 26 undefined on input line 977.

[26] [27]

LaTeX Warning: Reference `sec:lat-q2d' on page 28 undefined on input line 1109.


[28] [29]

LaTeX Warning: Reference `sec:o-B' on page 30 undefined on input line 1115.


LaTeX Warning: Reference `fig:bno_plot' on page 30 undefined on input line 1125
.


LaTeX Warning: Reference `fig:bno_plot' on page 30 undefined on input line 1126
.

<bno_plot.eps>
Overfull \hbox (52.48499pt too wide) in paragraph at lines 1158--1160
 [][] 
[30] [31] (./sample-btt-output.tex
Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]            \OT1/cmtt/m/n/10 ALL           MIN           AVG           MAX   
        N[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 --------------- ------------- ------------- ------------- --
---------[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2Qdm             0.000001260   0.000078915  14.504199709   
   491531[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2Adm             0.000000398   0.001184212  43.228889856   
   491566[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2Q               0.000000455   0.000009032   1.811181609   
   491566[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2G               0.000000466   0.002396857   0.203392940   
     8756[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 G2I               0.000000142   0.000000461   0.000096257   
     8756[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2M               0.000000230   0.000000433   0.000173083   
   482810[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 I2D               0.000000999   0.407286973   0.982146009   
     8756[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 M2D               0.000001251   0.356512650   0.982143260   
   482810[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 D2C               0.000057729   0.037337508   2.011319687   
   491566[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2C               0.000060550   0.394797701   2.035625308   
   491566[] 
[32]
Overfull \hbox (1.49698pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ==================== Device Merge Information ==============
======[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[]       \OT1/cmtt/m/n/10 DEV |       #Q       #D   Ratio |   BLKmin   BLKavg  
 BLKmax    Total[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | -------- -------- ------- | -------- -------- -
------- --------[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8,  0) |   246812     3970    62.2 |        2      497  
   1024  1974490[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8, 32) |   244754     4786    51.1 |        8      409  
    488  1958032[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | -------- -------- ------- | -------- -------- -
------- --------[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[]       \OT1/cmtt/m/n/10 DEV |       #Q       #D   Ratio |   BLKmin   BLKavg  
 BLKmax    Total[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[]     \OT1/cmtt/m/n/10 TOTAL |   491566     8756    56.1 |        2      449  
   1024  3932522[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ==================== Device Q2Q Seek Information ===========
=========[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 62--62
[]       \OT1/cmtt/m/n/10 DEV |          NSEEKS            MEAN          MEDIAN
 | MODE[] 

Overfull \hbox (64.49643pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | --------------- --------------- ---------------
 | ---------------[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  9,  0) |          491532          2693.5               0
 | 0(489746)[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8,  0) |          246812          2682.4               0
 | 0(245021)[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8, 32) |          244754          1355.3               0
 | 0(243795)[] 

Overfull \hbox (64.49643pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | --------------- --------------- ---------------
 | ---------------[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 62--62
[]   \OT1/cmtt/m/n/10 Overall |          NSEEKS            MEAN          MEDIAN
 | MODE[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 62--62
[]   \OT1/cmtt/m/n/10 Average |          983098          2357.6               0
 | 0(978562)[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ==================== Device D2D Seek Information ===========
=========[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 62--62
[]       \OT1/cmtt/m/n/10 DEV |          NSEEKS            MEAN          MEDIAN
 | MODE[] 

Overfull \hbox (64.49643pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | --------------- --------------- ---------------
 | ---------------[] 

Overfull \hbox (22.4968pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8,  0) |            3970        219326.9               0
 | 0(2177)[] 

Overfull \hbox (22.4968pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8, 32) |            4786         69254.5               0
 | 0(3828)[] 

Overfull \hbox (64.49643pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | --------------- --------------- ---------------
 | ---------------[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 62--62
[]   \OT1/cmtt/m/n/10 Overall |          NSEEKS            MEAN          MEDIAN
 | MODE[] 

Overfull \hbox (22.4968pt too wide) in paragraph at lines 62--62
[]   \OT1/cmtt/m/n/10 Average |            8756        137297.8               0
 | 0(6005)[] 
[33]
Overfull \hbox (43.49661pt too wide) in paragraph at lines 95--95
[]\OT1/cmtt/m/n/10 ==================== Active Requests At Q Information ======
==============[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[]       \OT1/cmtt/m/n/10 DEV | <.005 <.010 <.025 <.050 <.075 <.100 <.250 <.500
 < 1.0 >=1.0[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[] \OT1/cmtt/m/n/10 --------- | ===== ===== ===== ===== ===== ===== ===== =====
 ===== =====[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[] \OT1/cmtt/m/n/10 (  8,  0) |  80.5   3.5   1.0   1.0   0.7   0.6   4.0   5.3
   3.4   0.0[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[] \OT1/cmtt/m/n/10 (  8, 32) |   0.3   0.0   0.3   0.2   0.2   0.2   1.7   2.0
  95.2   0.0[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[]\OT1/cmtt/m/n/10 ========== | ===== ===== ===== ===== ===== ===== ===== =====
 ===== =====[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[]       \OT1/cmtt/m/n/10 AVG |  40.5   1.8   0.6   0.6   0.4   0.4   2.8   3.7
  49.1   0.0[] 
) [34] (./btt.aux)

LaTeX Warning: There were undefined references.


LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)
Output written on btt.dvi (34 pages, 60536 bytes).
Transcript written on btt.log.
This is pdfTeXk, Version 3.1415926-1.40.9 (Web2C 7.5.7)
 %&-line parsing enabled.
entering extended mode
(./btt.tex
LaTeX2e <2005/12/01>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, german-x-2008-06-18, ngerman-x-2008-06-18, ancientgreek, ibycus, ar
abic, basque, bulgarian, catalan, pinyin, coptic, croatian, czech, danish, dutc
h, esperanto, estonian, farsi, finnish, french, galician, german, ngerman, mono
greek, greek, hungarian, icelandic, indonesian, interlingua, irish, italian, la
tin, mongolian, mongolian2a, bokmal, nynorsk, polish, portuguese, romanian, rus
sian, sanskrit, serbian, slovak, slovenian, spanish, swedish, turkish, ukenglis
h, ukrainian, uppersorbian, welsh, loaded.
(/usr/share/texmf/tex/latex/base/article.cls
Document Class: article 2005/09/16 v1.4f Standard LaTeX document class
(/usr/share/texmf/tex/latex/base/size10.clo))
(/usr/share/texmf/tex/latex/graphics/epsfig.sty
(/usr/share/texmf/tex/latex/graphics/graphicx.sty
(/usr/share/texmf/tex/latex/graphics/keyval.sty)
(/usr/share/texmf/tex/latex/graphics/graphics.sty
(/usr/share/texmf/tex/latex/graphics/trig.sty)
(/usr/lib/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf/tex/latex/graphics/dvips.def))))
(/usr/share/texmf/tex/latex/placeins/placeins.sty) (./btt.aux) [1] (./btt.toc
[2]) [3] [4] [5]
Overfull \hbox (5.4972pt too wide) in paragraph at lines 209--209
 []       \OT1/cmtt/m/n/10 DEV |       Q2G       G2I       Q2M       I2D       
D2C[] 

Overfull \hbox (5.4972pt too wide) in paragraph at lines 209--209
 []\OT1/cmtt/m/n/10 ---------- | --------- --------- --------- --------- ------
---[] 

Overfull \hbox (5.4972pt too wide) in paragraph at lines 209--209
 [] \OT1/cmtt/m/n/10 (  8, 80) |   0.0013%   0.0004%   0.0006%  88.5005%  11.49
88%[] 

Overfull \hbox (5.4972pt too wide) in paragraph at lines 209--209
 []\OT1/cmtt/m/n/10 ---------- | --------- --------- --------- --------- ------
---[] 

Overfull \hbox (5.4972pt too wide) in paragraph at lines 209--209
 []   \OT1/cmtt/m/n/10 Overall |   0.0003%   0.0001%   0.0041%  21.4998%  78.49
58%[] 

Overfull \hbox (10.74715pt too wide) in paragraph at lines 226--226
 []       \OT1/cmtt/m/n/10 DEV |      #Q    #D Ratio | BLKmin BLKavg BLKmax   T
otal[] 

Overfull \hbox (10.74715pt too wide) in paragraph at lines 226--226
 []\OT1/cmtt/m/n/10 ---------- | ------- ----- ----- | ------ ------ ------ ---
----[] 

Overfull \hbox (10.74715pt too wide) in paragraph at lines 226--226
 [] \OT1/cmtt/m/n/10 ( 68, 64) | 2262311 18178 124.5 |      2    124    128 226
2382[] 
[6]
Overfull \hbox (5.98694pt too wide) in paragraph at lines 264--268
[]\OT1/cmr/m/n/10 During nor-mal op-er-a-tion, re-quests queues

Overfull \hbox (0.2726pt too wide) in paragraph at lines 290--293
[]\OT1/cmr/m/n/10 In this sub-sec-tion one can see
[7]
Overfull \hbox (68.49664pt too wide) in paragraph at lines 342--342
 []\OT1/cmtt/m/n/10 ==================== Active Requests At Q Information =====
===============[] 
[8] [9] [10]
Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 []       \OT1/cmtt/m/n/10 DEV | <.005 <.010 <.025 <.050 <.075 <.100 <.250 <.50
0 < 1.0 >=1.0[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 --------- | ===== ===== ===== ===== ===== ===== ===== ====
= ===== =====[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 ( 66, 80) |  61.2   7.9  12.1   7.9   3.0   1.4   1.5   0.
2   0.0   4.6[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 ( 65,192) |  42.3   5.0   8.7  30.0   8.9   3.0   1.8   0.
1   0.0   0.1[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 ( 65,128) |  34.3   5.3   8.9  32.0   9.7   3.7   5.3   0.
6   0.0   0.1[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 ( 65, 64) |  59.9   4.2   6.0  24.6   4.2   0.8   0.1   0.
0   0.0   0.1[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 [] \OT1/cmtt/m/n/10 ( 66, 64) |  62.6   8.1  12.7   7.9   2.4   0.6   0.1   0.
0   0.0   5.4[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 []\OT1/cmtt/m/n/10 ========== | ===== ===== ===== ===== ===== ===== ===== ====
= ===== =====[] 

Overfull \hbox (57.99673pt too wide) in paragraph at lines 422--422
 []       \OT1/cmtt/m/n/10 AVG |  52.9   6.2  10.0  20.1   5.3   1.7   1.4   0.
2   0.0   2.1[] 
[11] [12]
Overfull \hbox (8.47284pt too wide) in paragraph at lines 519--523
[]\OT1/cmr/m/n/10 What this in-di-cates is that there was q ac-tiv-ity for the 
sys-tem from 0.000000000
(/usr/share/texmf/tex/latex/base/omscmr.fd) [13] <activity.eps> [14]
<qhist.eps> [15] <dhist.eps> [16]
Overfull \hbox (59.24648pt too wide) in paragraph at lines 614--614
[]             \OT1/cmtt/m/n/10 rkB/s     wkB/s avgrq-sz avgqu-sz   await   svc
tm  %util   Stamp[] 

Overfull \hbox (59.24648pt too wide) in paragraph at lines 614--614
[]              \OT1/cmtt/m/n/10 0.00  76403.18   152.00    31.00    0.00    0.
00   0.00   71.79[] 

Overfull \hbox (59.24648pt too wide) in paragraph at lines 614--614
[]              \OT1/cmtt/m/n/10 2.02     27.81    42.13     0.61    0.00   21.
90   0.00   TOTAL[] 
[17] [18] [19] [20]
Overfull \hbox (55.28352pt too wide) in paragraph at lines 717--719
[]\OT1/cmr/m/n/10 An ex-am-ple name would be af-ter spec-i-fy-ing \OT1/cmtt/m/n
/10 -s seek \OT1/cmr/m/n/10 would be: \OT1/cmtt/m/n/10 seek[]065,048[]q2q[]w.da
t\OT1/cmr/m/n/10 . 
<seek.eps>

LaTeX Warning: `!h' float specifier changed to `!ht'.

[21] [22] <sps.eps> [23] [24] [25] [26] [27] [28] [29] <bno_plot.eps>
Overfull \hbox (52.48499pt too wide) in paragraph at lines 1158--1160
 [][] 
[30] [31] (./sample-btt-output.tex
Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]            \OT1/cmtt/m/n/10 ALL           MIN           AVG           MAX   
        N[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 --------------- ------------- ------------- ------------- --
---------[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2Qdm             0.000001260   0.000078915  14.504199709   
   491531[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2Adm             0.000000398   0.001184212  43.228889856   
   491566[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2Q               0.000000455   0.000009032   1.811181609   
   491566[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2G               0.000000466   0.002396857   0.203392940   
     8756[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 G2I               0.000000142   0.000000461   0.000096257   
     8756[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2M               0.000000230   0.000000433   0.000173083   
   482810[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 I2D               0.000000999   0.407286973   0.982146009   
     8756[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 M2D               0.000001251   0.356512650   0.982143260   
   482810[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 D2C               0.000057729   0.037337508   2.011319687   
   491566[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 27--27
[]\OT1/cmtt/m/n/10 Q2C               0.000060550   0.394797701   2.035625308   
   491566[] 
[32]
Overfull \hbox (1.49698pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ==================== Device Merge Information ==============
======[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[]       \OT1/cmtt/m/n/10 DEV |       #Q       #D   Ratio |   BLKmin   BLKavg  
 BLKmax    Total[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | -------- -------- ------- | -------- -------- -
------- --------[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8,  0) |   246812     3970    62.2 |        2      497  
   1024  1974490[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8, 32) |   244754     4786    51.1 |        8      409  
    488  1958032[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | -------- -------- ------- | -------- -------- -
------- --------[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[]       \OT1/cmtt/m/n/10 DEV |       #Q       #D   Ratio |   BLKmin   BLKavg  
 BLKmax    Total[] 

Overfull \hbox (53.99652pt too wide) in paragraph at lines 62--62
[]     \OT1/cmtt/m/n/10 TOTAL |   491566     8756    56.1 |        2      449  
   1024  3932522[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ==================== Device Q2Q Seek Information ===========
=========[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 62--62
[]       \OT1/cmtt/m/n/10 DEV |          NSEEKS            MEAN          MEDIAN
 | MODE[] 

Overfull \hbox (64.49643pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | --------------- --------------- ---------------
 | ---------------[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  9,  0) |          491532          2693.5               0
 | 0(489746)[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8,  0) |          246812          2682.4               0
 | 0(245021)[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8, 32) |          244754          1355.3               0
 | 0(243795)[] 

Overfull \hbox (64.49643pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | --------------- --------------- ---------------
 | ---------------[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 62--62
[]   \OT1/cmtt/m/n/10 Overall |          NSEEKS            MEAN          MEDIAN
 | MODE[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 62--62
[]   \OT1/cmtt/m/n/10 Average |          983098          2357.6               0
 | 0(978562)[] 

Overfull \hbox (17.24684pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ==================== Device D2D Seek Information ===========
=========[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 62--62
[]       \OT1/cmtt/m/n/10 DEV |          NSEEKS            MEAN          MEDIAN
 | MODE[] 

Overfull \hbox (64.49643pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | --------------- --------------- ---------------
 | ---------------[] 

Overfull \hbox (22.4968pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8,  0) |            3970        219326.9               0
 | 0(2177)[] 

Overfull \hbox (22.4968pt too wide) in paragraph at lines 62--62
[] \OT1/cmtt/m/n/10 (  8, 32) |            4786         69254.5               0
 | 0(3828)[] 

Overfull \hbox (64.49643pt too wide) in paragraph at lines 62--62
[]\OT1/cmtt/m/n/10 ---------- | --------------- --------------- ---------------
 | ---------------[] 

Overfull \hbox (6.74693pt too wide) in paragraph at lines 62--62
[]   \OT1/cmtt/m/n/10 Overall |          NSEEKS            MEAN          MEDIAN
 | MODE[] 

Overfull \hbox (22.4968pt too wide) in paragraph at lines 62--62
[]   \OT1/cmtt/m/n/10 Average |            8756        137297.8               0
 | 0(6005)[] 
[33]
Overfull \hbox (43.49661pt too wide) in paragraph at lines 95--95
[]\OT1/cmtt/m/n/10 ==================== Active Requests At Q Information ======
==============[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[]       \OT1/cmtt/m/n/10 DEV | <.005 <.010 <.025 <.050 <.075 <.100 <.250 <.500
 < 1.0 >=1.0[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[] \OT1/cmtt/m/n/10 --------- | ===== ===== ===== ===== ===== ===== ===== =====
 ===== =====[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[] \OT1/cmtt/m/n/10 (  8,  0) |  80.5   3.5   1.0   1.0   0.7   0.6   4.0   5.3
   3.4   0.0[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[] \OT1/cmtt/m/n/10 (  8, 32) |   0.3   0.0   0.3   0.2   0.2   0.2   1.7   2.0
  95.2   0.0[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[]\OT1/cmtt/m/n/10 ========== | ===== ===== ===== ===== ===== ===== ===== =====
 ===== =====[] 

Overfull \hbox (32.9967pt too wide) in paragraph at lines 95--95
[]       \OT1/cmtt/m/n/10 AVG |  40.5   1.8   0.6   0.6   0.4   0.4   2.8   3.7
  49.1   0.0[] 
) [34] (./btt.aux)

LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)
Output written on btt.dvi (34 pages, 69140 bytes).
Transcript written on btt.log.
[1][2][3][4][5][6][7][8][9][10][11][12][13][14(./activity.eps<PS>
Version of PDF file (1.3) is newer than version limit specification.
pdf_open: Not a PDF 1.[1-3] file

Corrupt PDF file?

Ignoring stream with with multiple segments
)
pdf: image inclusion failed for (activity.eps).
][15(./qhist.eps<PS>
Version of PDF file (1.3) is newer than version limit specification.
pdf_open: Not a PDF 1.[1-3] file

Corrupt PDF file?

Ignoring stream with with multiple segments
)
pdf: image inclusion failed for (qhist.eps).
][16(./dhist.eps<PS>
Version of PDF file (1.3) is newer than version limit specification.
pdf_open: Not a PDF 1.[1-3] file

Corrupt PDF file?

Ignoring stream with with multiple segments
)
pdf: image inclusion failed for (dhist.eps).
][17][18][19][20][21][22(./seek.eps<PS>
Version of PDF file (1.3) is newer than version limit specification.
pdf_open: Not a PDF 1.[1-3] file

Corrupt PDF file?

Ignoring stream with with multiple segments
)
pdf: image inclusion failed for (seek.eps).
][23(./sps.eps<PS>
Version of PDF file (1.3) is newer than version limit specification.
pdf_open: Not a PDF 1.[1-3] file

Corrupt PDF file?

Ignoring stream with with multiple segments
)
pdf: image inclusion failed for (sps.eps).
][24][25][26][27][28][29][30][31(./bno_plot.eps<PS>
Version of PDF file (1.3) is newer than version limit specification.
pdf_open: Not a PDF 1.[1-3] file

Corrupt PDF file?

Ignoring stream with with multiple segments
)
pdf: image inclusion failed for (bno_plot.eps).
][32][33][34]
197590 bytes written

btt.dvi -> btt.pdf
make[2]: Leaving directory `/home/Projects/linux_perf_viz/blktrace-howto/blktrace/btt/doc'
make[1]: Leaving directory `/home/Projects/linux_perf_viz/blktrace-howto/blktrace/btt'
make -C btreplay docs
make[1]: Entering directory `/home/Projects/linux_perf_viz/blktrace-howto/blktrace/btreplay'
make -C doc all
make[2]: Entering directory `/home/Projects/linux_perf_viz/blktrace-howto/blktrace/btreplay/doc'
This is pdfTeXk, Version 3.1415926-1.40.9 (Web2C 7.5.7)
 %&-line parsing enabled.
entering extended mode
(./btreplay.tex
LaTeX2e <2005/12/01>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, german-x-2008-06-18, ngerman-x-2008-06-18, ancientgreek, ibycus, ar
abic, basque, bulgarian, catalan, pinyin, coptic, croatian, czech, danish, dutc
h, esperanto, estonian, farsi, finnish, french, galician, german, ngerman, mono
greek, greek, hungarian, icelandic, indonesian, interlingua, irish, italian, la
tin, mongolian, mongolian2a, bokmal, nynorsk, polish, portuguese, romanian, rus
sian, sanskrit, serbian, slovak, slovenian, spanish, swedish, turkish, ukenglis
h, ukrainian, uppersorbian, welsh, loaded.
(/usr/share/texmf/tex/latex/base/article.cls
Document Class: article 2005/09/16 v1.4f Standard LaTeX document class
(/usr/share/texmf/tex/latex/base/size10.clo))
(/usr/share/texmf/tex/latex/multirow/multirow.sty)
(/usr/share/texmf/tex/latex/graphics/graphicx.sty
(/usr/share/texmf/tex/latex/graphics/keyval.sty)
(/usr/share/texmf/tex/latex/graphics/graphics.sty
(/usr/share/texmf/tex/latex/graphics/trig.sty)
(/usr/lib/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf/tex/latex/graphics/dvips.def)))
(/usr/share/texmf/tex/latex/placeins/placeins.sty)
No file btreplay.aux.
(./abstract.tex) [1]
No file btreplay.toc.
[2] (./abstract.tex)
Overfull \hbox (14.24968pt too wide) in paragraph at lines 40--44
[]\OT1/cmr/m/n/10 This doc-u-ment presents the com-mand line overview for \OT1/
cmtt/m/n/10 btrecord \OT1/cmr/m/n/10 and \OT1/cmtt/m/n/10 btreplay\OT1/cmr/m/n/
10 ,
[3]
Overfull \hbox (4.88792pt too wide) in paragraph at lines 81--85
[]\OT1/cmr/m/n/10 You ex-tract the per-ti-nent IO in-for-ma-tion from the trace
s saved by \OT1/cmtt/m/n/10 blktrace
[4]

LaTeX Warning: Reference `sec:c-o-m' on page 5 undefined on input line 146.


LaTeX Warning: Reference `sec:c-o-m' on page 5 undefined on input line 146.


LaTeX Warning: Reference `sec:c-o-M' on page 5 undefined on input line 152.


LaTeX Warning: Reference `sec:c-o-M' on page 5 undefined on input line 153.

[5]

LaTeX Warning: Reference `sec:p-o-c' on page 6 undefined on input line 177.


LaTeX Warning: Reference `sec:p-o-c' on page 6 undefined on input line 177.

[6]

LaTeX Warning: Reference `sec:p-o-M' on page 7 undefined on input line 234.


LaTeX Warning: Reference `sec:p-o-M' on page 7 undefined on input line 234.

[7]

LaTeX Warning: Reference `fig:btrecord--help' on page 8 undefined on input line
 289.


LaTeX Warning: Reference `fig:btrecord--help' on page 8 undefined on input line
 290.

[8]

LaTeX Warning: Reference `sec:c-o-m' on page 9 undefined on input line 318.


LaTeX Warning: Reference `fig:verb-out' on page 9 undefined on input line 345.


LaTeX Warning: Reference `fig:verb-out' on page 9 undefined on input line 345.


LaTeX Warning: Reference `fig:verb-defs' on page 9 undefined on input line 346.



LaTeX Warning: Reference `fig:verb-defs' on page 9 undefined on input line 347.


[9]
Overfull \hbox (64.49643pt too wide) in paragraph at lines 355--355
[]\OT1/cmtt/m/n/10 sdab:0: 580661 pkts (tot), 126030 pkts (replay), 89809 bunch
es, 1.4 pkts/bunch[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 355--355
[]\OT1/cmtt/m/n/10 sdab:1: 2559775 pkts (tot), 430172 pkts (replay), 293029 bun
ches, 1.5 pkts/bunch[] 

Overfull \hbox (69.74638pt too wide) in paragraph at lines 355--355
[]\OT1/cmtt/m/n/10 sdab:2: 653559 pkts (tot), 136522 pkts (replay), 102288 bunc
hes, 1.3 pkts/bunch[] 

Overfull \hbox (64.49643pt too wide) in paragraph at lines 355--355
[]\OT1/cmtt/m/n/10 sdab:3: 474773 pkts (tot), 117849 pkts (replay), 69572 bunch
es, 1.7 pkts/bunch[] 
[10]

LaTeX Warning: Reference `fig:btreplay--help' on page 11 undefined on input lin
e 427.


LaTeX Warning: Reference `fig:btreplay--help' on page 11 undefined on input lin
e 428.

[11] [12] [13] (./btreplay.aux)

LaTeX Warning: There were undefined references.


LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)
Output written on btreplay.dvi (13 pages, 26572 bytes).
Transcript written on btreplay.log.
This is pdfTeXk, Version 3.1415926-1.40.9 (Web2C 7.5.7)
 %&-line parsing enabled.
entering extended mode
(./btreplay.tex
LaTeX2e <2005/12/01>
Babel <v3.8l> and hyphenation patterns for english, usenglishmax, dumylang, noh
yphenation, german-x-2008-06-18, ngerman-x-2008-06-18, ancientgreek, ibycus, ar
abic, basque, bulgarian, catalan, pinyin, coptic, croatian, czech, danish, dutc
h, esperanto, estonian, farsi, finnish, french, galician, german, ngerman, mono
greek, greek, hungarian, icelandic, indonesian, interlingua, irish, italian, la
tin, mongolian, mongolian2a, bokmal, nynorsk, polish, portuguese, romanian, rus
sian, sanskrit, serbian, slovak, slovenian, spanish, swedish, turkish, ukenglis
h, ukrainian, uppersorbian, welsh, loaded.
(/usr/share/texmf/tex/latex/base/article.cls
Document Class: article 2005/09/16 v1.4f Standard LaTeX document class
(/usr/share/texmf/tex/latex/base/size10.clo))
(/usr/share/texmf/tex/latex/multirow/multirow.sty)
(/usr/share/texmf/tex/latex/graphics/graphicx.sty
(/usr/share/texmf/tex/latex/graphics/keyval.sty)
(/usr/share/texmf/tex/latex/graphics/graphics.sty
(/usr/share/texmf/tex/latex/graphics/trig.sty)
(/usr/lib/texmf/tex/latex/config/graphics.cfg)
(/usr/share/texmf/tex/latex/graphics/dvips.def)))
(/usr/share/texmf/tex/latex/placeins/placeins.sty) (./btreplay.aux)
(./abstract.tex) [1] (./btreplay.toc [2]) [3] (./abstract.tex)
Overfull \hbox (14.24968pt too wide) in paragraph at lines 40--44
[]\OT1/cmr/m/n/10 This doc-u-ment presents the com-mand line overview for \OT1/
cmtt/m/n/10 btrecord \OT1/cmr/m/n/10 and \OT1/cmtt/m/n/10 btreplay\OT1/cmr/m/n/
10 ,
[4]
Overfull \hbox (4.88792pt too wide) in paragraph at lines 81--85
[]\OT1/cmr/m/n/10 You ex-tract the per-ti-nent IO in-for-ma-tion from the trace
s saved by \OT1/cmtt/m/n/10 blktrace
[5] [6] [7] [8] [9] [10]
Overfull \hbox (64.49643pt too wide) in paragraph at lines 355--355
[]\OT1/cmtt/m/n/10 sdab:0: 580661 pkts (tot), 126030 pkts (replay), 89809 bunch
es, 1.4 pkts/bunch[] 

Overfull \hbox (74.99634pt too wide) in paragraph at lines 355--355
[]\OT1/cmtt/m/n/10 sdab:1: 2559775 pkts (tot), 430172 pkts (replay), 293029 bun
ches, 1.5 pkts/bunch[] 

Overfull \hbox (69.74638pt too wide) in paragraph at lines 355--355
[]\OT1/cmtt/m/n/10 sdab:2: 653559 pkts (tot), 136522 pkts (replay), 102288 bunc
hes, 1.3 pkts/bunch[] 

Overfull \hbox (64.49643pt too wide) in paragraph at lines 355--355
[]\OT1/cmtt/m/n/10 sdab:3: 474773 pkts (tot), 117849 pkts (replay), 69572 bunch
es, 1.7 pkts/bunch[] 
[11] [12] [13] [14] (./btreplay.aux)

LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.

 )
(see the transcript file for additional information)
Output written on btreplay.dvi (14 pages, 33848 bytes).
Transcript written on btreplay.log.
[1][2][3][4][5][6][7][8][9][10][11][12][13][14]
162917 bytes written

btreplay.dvi -> btreplay.pdf
make[2]: Leaving directory `/home/Projects/linux_perf_viz/blktrace-howto/blktrace/btreplay/doc'
make[1]: Leaving directory `/home/Projects/linux_perf_viz/blktrace-howto/blktrace/btreplay'

--------------060903070506020600010909--
