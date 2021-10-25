#... ....1.... ....2.... ....3.... ....4.... ....5.... ....6.... ....7..
reset; unset key; unset surf; set grid
#set terminal gif animate delay 100 nocrop enhanced transparent size \
#    586,310 font "Times,12.0"
set terminal gif animate delay 100 nocrop enhanced size 586,310        \
    font "Times,12.0"
set xtics  60; set ytics  30; set mxtics  1; set mytics  1
set grid front mxtics mytics lw 1.0 dt 3 lt 0 lc rgb 'black'
set lmargin 6.65; set rmargin 0.65; set tmargin 1.85; set bmargin 2.85
set xrange[-2:360.0]; set yrange[-91.0:91.5];
#set cbrange[-0.00:1.20]
set cbrange[3.2:7.5]
set cblabel 'aw*10000'
set format cb "%3.1f"
set xlabel 'Longitude [degrees]'; set ylabel 'Latitude [degrees]'
set palette defined ( 0 "#000090", 1 "#000fff", 2 "#0090ff",\
                      3 "#0fffee", 4 "#90ff70", 5 "#ffee00",\
                      6 "#ff7000", 7 "#ee0000", 8 "#7f0000")
set output 'aw_animated.gif'

set title 'VMF aw*1000 (VMF3 20180101.H00.aw)';
plot "VMF3_20180101.H00.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180101.H06.aw)';
plot "VMF3_20180101.H06.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180101.H12.aw)';
plot "VMF3_20180101.H12.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180101.H18.aw)';
plot "VMF3_20180101.H18.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1

set title 'VMF aw*1000 (VMF3 20180102.H00.aw)';
plot "VMF3_20180102.H00.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180102.H06.aw)';
plot "VMF3_20180102.H06.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180102.H12.aw)';
plot "VMF3_20180102.H12.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180102.H18.aw)';
plot "VMF3_20180102.H18.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1

set title 'VMF aw*1000 (VMF3 20180103.H00.aw)';
plot "VMF3_20180103.H00.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180103.H06.aw)';
plot "VMF3_20180103.H06.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180103.H12.aw)';
plot "VMF3_20180103.H12.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180103.H18.aw)';
plot "VMF3_20180103.H18.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1

set title 'VMF aw*1000 (VMF3 20180104.H00.aw)';
plot "VMF3_20180104.H00.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180104.H06.aw)';
plot "VMF3_20180104.H06.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180104.H12.aw)';
plot "VMF3_20180104.H12.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180104.H18.aw)';
plot "VMF3_20180104.H18.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1

set title 'VMF aw*1000 (VMF3 20180105.H00.aw)';
plot "VMF3_20180105.H00.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180105.H06.aw)';
plot "VMF3_20180105.H06.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180105.H12.aw)';
plot "VMF3_20180105.H12.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180105.H18.aw)';
plot "VMF3_20180105.H18.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1

set title 'VMF aw*1000 (VMF3 20180106.H00.aw)';
plot "VMF3_20180106.H00.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180106.H06.aw)';
plot "VMF3_20180106.H06.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180106.H12.aw)';
plot "VMF3_20180106.H12.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180106.H18.aw)';
plot "VMF3_20180106.H18.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1

set title 'VMF aw*1000 (VMF3 20180107.H00.aw)';
plot "VMF3_20180107.H00.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180107.H06.aw)';
plot "VMF3_20180107.H06.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180107.H12.aw)';
plot "VMF3_20180107.H12.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180107.H18.aw)';
plot "VMF3_20180107.H18.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1

set title 'VMF aw*1000 (VMF3 20180108.H00.aw)';
plot "VMF3_20180108.H00.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180108.H06.aw)';
plot "VMF3_20180108.H06.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180108.H12.aw)';
plot "VMF3_20180108.H12.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180108.H18.aw)';
plot "VMF3_20180108.H18.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1

set title 'VMF aw*1000 (VMF3 20180109.H00.aw)';
plot "VMF3_20180109.H00.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180109.H06.aw)';
plot "VMF3_20180109.H06.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180109.H12.aw)';
plot "VMF3_20180109.H12.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180109.H18.aw)';
plot "VMF3_20180109.H18.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1

set title 'VMF aw*1000 (VMF3 20180110.H00.aw)';
plot "VMF3_20180110.H00.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180110.H06.aw)';
plot "VMF3_20180110.H06.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180110.H12.aw)';
plot "VMF3_20180110.H12.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1
set title 'VMF aw*1000 (VMF3 20180110.H18.aw)';
plot "VMF3_20180110.H18.aw" using ($1):(-(($2)-89.5)):(($3)*10000.0) matrix with image\
   notitle, "world_110m.txt" using ((($1)<0.0)?(360.0+($1)):($1)):($2)\
   with dots linestyle 1 linecolor -1


unset output

