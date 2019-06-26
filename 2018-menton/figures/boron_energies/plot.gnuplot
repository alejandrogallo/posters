#!/usr/bin/gnuplot -persist
#
#
#    	G N U P L O T
#    	Version 5.0 patchlevel 3    last modified 2016-02-21
#
#    	Copyright (C) 1986-1993, 1998, 2004, 2007-2016
#    	Thomas Williams, Colin Kelley and many others
#
#    	gnuplot home:     http://www.gnuplot.info
#    	faq, bugs, etc:   type "help FAQ"
#    	immediate help:   type "help"  (plot window: hit 'h')
# set terminal wxt 0 enhanced
# set output
unset clip points
set clip one
unset clip two
set bar 1.000000 front
set border 31 front lt black linewidth 1.000 dashtype solid
set zdata
set ydata
set xdata
set y2data
set x2data
set boxwidth
set style fill  empty border
set style rectangle back fc  bgnd fillstyle   solid 1.00 border lt -1
set style circle radius graph 0.02, first 0.00000, 0.00000
set style ellipse size graph 0.05, 0.03, first 0.00000 angle 0 units xy
set dummy x, y
set format x "% h"
set format y "% h"
set format x2 "% h"
set format y2 "% h"
set format z "% h"
set format cb "% h"
set format r "% h"
set timefmt "%d/%m/%y,%H:%M"
set angles radians
set tics back
unset grid
set raxis
set style parallel front  lt black linewidth 2.000 dashtype solid
set key title "" center
set key inside right top vertical Right noreverse enhanced autotitle nobox
set key noinvert samplen 4 spacing 1 width 0 height 0
set key maxcolumns 0 maxrows 0
set key noopaque
unset label
unset arrow
set style increment default
unset style line
unset style arrow
set style histogram clustered gap 2 title textcolor lt -1
unset object
set style textbox transparent margins  1.0,  1.0 border
unset logscale
set offsets 0, 0, 0, 0
set pointsize 1
set pointintervalbox 1
set encoding default
unset polar
unset parametric
unset decimalsign
set view 60, 30, 1, 1
set samples 100, 100
set isosamples 10, 10
set surface
unset contour
set cntrlabel  format '%8.3g' font '' start 5 interval 20
set mapping cartesian
set datafile separator whitespace
unset hidden3d
set cntrparam order 4
set cntrparam linear
set cntrparam levels auto 5
set cntrparam points 5
set size ratio 0 1,1
set origin 0,0
set style data points
set style function lines
unset xzeroaxis
unset yzeroaxis
unset zzeroaxis
unset x2zeroaxis
unset y2zeroaxis
set xyplane relative 0.5
set tics scale  1, 0.5, 1, 1, 1
set mxtics default
set mytics default
set mztics default
set mx2tics default
set my2tics default
set mcbtics default
set mrtics default
set xtics border in scale 1,0.5 mirror norotate  autojustify
set xtics  norangelimit autofreq
set ytics border in scale 1,0.5 mirror norotate  autojustify
set ytics  norangelimit autofreq
set ztics border in scale 1,0.5 nomirror norotate  autojustify
set ztics  norangelimit autofreq
unset x2tics
unset y2tics
set cbtics border in scale 1,0.5 mirror norotate  autojustify
set cbtics  norangelimit autofreq
set rtics axis in scale 1,0.5 nomirror norotate  autojustify
set rtics  norangelimit autofreq
unset paxis 1 tics
unset paxis 2 tics
unset paxis 3 tics
unset paxis 4 tics
unset paxis 5 tics
unset paxis 6 tics
unset paxis 7 tics
set title ""
set title  font "" norotate
set timestamp bottom
set timestamp ""
set timestamp  font "" norotate
set rrange [ * : * ] noreverse nowriteback
set trange [ * : * ] noreverse nowriteback
set urange [ * : * ] noreverse nowriteback
set vrange [ * : * ] noreverse nowriteback
set xlabel "State"
set xlabel  font "" textcolor lt -1 norotate
set x2label ""
set x2label  font "" textcolor lt -1 norotate
set xrange [ * : * ] noreverse nowriteback
set x2range [ * : * ] noreverse nowriteback
set ylabel "Energy (eV)"
set ylabel  font "" textcolor lt -1 rotate by -270
set y2label ""
set y2label  font "" textcolor lt -1 rotate by -270
set yrange [ * : * ] noreverse nowriteback
set y2range [ * : * ] noreverse nowriteback
set zlabel ""
set zlabel  font "" textcolor lt -1 norotate
set zrange [ * : * ] noreverse nowriteback
set cblabel ""
set cblabel  font "" textcolor lt -1 rotate by -270
set cbrange [ * : * ] noreverse nowriteback
set paxis 1 range [ * : * ] noreverse nowriteback
set paxis 2 range [ * : * ] noreverse nowriteback
set paxis 3 range [ * : * ] noreverse nowriteback
set paxis 4 range [ * : * ] noreverse nowriteback
set paxis 5 range [ * : * ] noreverse nowriteback
set paxis 6 range [ * : * ] noreverse nowriteback
set paxis 7 range [ * : * ] noreverse nowriteback
set zero 1e-08
set lmargin  -1
set bmargin  -1
set rmargin  -1
set tmargin  -1
set pm3d explicit at s
set pm3d scansautomatic
set pm3d interpolate 1,1 flush begin noftriangles noborder corners2color mean
set palette positive nops_allcF maxcolors 0 gamma 1.5 color model RGB
set palette rgbformulae 7, 5, 15
set colorbox default
set colorbox vertical origin screen 0.9, 0.2, 0 size screen 0.05, 0.6, 0 front bdefault
set style boxplot candles range  1.50 outliers pt 7 separation 1 labels auto unsorted
set loadpath
set fontpath
set psdir
set fit brief errorvariables nocovariancevariables errorscaling prescale nowrap v5
GNUTERM = "wxt"
x = 0.0








set terminal pdfcairo
set output "plot.pdf"
set yrange [-0.5:7]
set xrange [1:30]

set label at 30.5, 0 '^2P'
set label at 30.5, 3.55183 '^4P'
set label at 30.5, 4.9642889 '^2S'
set label at 30.5, 5.6335272 '^2D'
set label at 30.5, 6.1273242 '^2P'

plot "energies.dat" u 2:4 title "eom-ccsd energies", \
      0.00000000 title "" lc 0,\
      0.0018953 title "" lc 0,\
      3.55183 title "" lc 0,\
      3.55240 title "" lc 0,\
      3.55319 title "" lc 0,\
      4.9642889 title "" lc 0,\
      5.9334881 title "" lc 0,\
      5.9335272 title "" lc 0,\
      6.0271032 title "" lc 0,\
      6.0273242 title "" lc 0,\
      #6.7903286 title "" ,\
      #6.7903465 title "" ,\
      #6.8203997 title "" ,\
      #7.1646046 title "" ,\
      #7.1646833 title "" ,\
      #7.438240 title "" ,\
      #7.438240 title "" ,\
      #7.4429048 title "" ,\
      #7.4429055 title "" ,\
      #7.4572049 title "" ,\
      #7.61679 title "" ,\
      #7.746801 title "" ,\
      #7.747215 title "" ,\
      #7.747215 title "" ,\
      #7.7510654 title "" ,\
      #7.7510654 title "" ,\
      #7.84364 title "" ,\
      #7.880515 title "" ,\
      #7.915811 title "" ,\
      #7.915811 title "" ,\
      #7.918415 title "" ,\
      #7.918415 title "" ,\
      #7.954332 title "" ,\
      #7.97322 title "" ,\
      #8.017482 title "" ,\
      #8.017482 title "" ,\
      #8.019266 title "" ,\
      #8.019266 title "" ,\
      #8.033195 title "" ,\
      #8.05455 title "" ,\
      #8.083434 title "" ,\
      #8.083434 title "" ,\
      #8.084685 title "" ,\
      #8.084685 title "" ,\
      #8.092472 title "" ,\
      #8.10865 title "" ,\
      #8.128612 title "" ,\
      #8.129514 title "" ,\
      #8.134526 title "" ,\
      #8.160905 title "" ,\
      #8.161540 title "" ,\
      #8.184766 title "" ,\
      #8.185267 title "" ,\
      #8.202911 title "" ,\
      #8.217013 title "" ,\
      #8.228200 title "" ,\
      #8.237217 title "" ,\
      #8.244597 title "" ,\
      #8.250713 title "" ,\
      #8.255835 title "" ,\
      #8.260166 title "" ,\
      #8.263862 title "" ,\
      #8.267041 title "" ,\
      #8.269799 title "" ,\
      #8.272202 title "" ,\
      #8.274317 title "" ,\
      #8.276199 title "" ,\
      #8.277831 title "" ,\
      #8.279304 title "" ,\
      #8.280617 title "" ,\
      #8.28181 title "" ,\
      #8.282847 title "" ,\
      #8.283842 title "" ,\
      #8.284757 title "" ,\
      #8.28550 title "" ,\
      #8.28620 title "" ,\
      #8.28690 title "" ,\
      #8.28752 title "" ,\
      #8.28807 title "" ,\
      #8.28860 title "" ,\
      #8.28904 title ""
