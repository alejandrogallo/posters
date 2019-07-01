#! /usr/bin/env gnuplot -p

set term pdfcairo
pdfout = system('echo '.ARG0.' |  sed s/gnuplot/pdf/g')
print pdfout
set output pdfout
set key outside bottom horizontal
#set xlabel 'State number'
set ylabel 'Energy (eV)'

plot \
  3.95 title 'Gwaltney et al.' ls 0, \
  7.06 notitle ls 0, \
  7.89 notitle ls 0, \
  8.00 notitle ls 0, \
  8.23 notitle ls 0, \
  9.07 notitle ls 0, \
  9.26 notitle ls 0, \
  9.27 notitle ls 0, \
  9.40 notitle ls 0, \
  10.00 notitle ls 0, \
  4.07 title 'Exp.' ls 2, \
  7.11 notitle ls 2, \
  7.97 notitle ls 2, \
  8.14 notitle ls 2, \
  8.37 notitle ls 2, \
  8.88 notitle ls 2, \
  "dz.dat" u 4:6 title "aug-cc-pvdz", \
  "dz-poscar20.dat" u 4:6 title "aug-cc-pvdz 20Å", \
  "tz-refresh250-it108.dat" u 4:6 title "aug-cc-pvtz", \
  #"tz.dat" u 4:6
  #"tz-refresh250.dat" u 4:6 , \


refresh

#vim-run: gnuplot %
