#!/bin/bash
# Version 0.0.2 (20230517T151753Z)
gnuplotScriptB64="H4sICLzEZGQAA3RlbXBsYXRlX3NjcmlwdC5nbnUAXZNra9swFIa/71cc2EDxlniS3TiJMxj7kI1CW0rJYFsXjC+yKypfkGWS9Nfv6JJ1zB/k87xHen0kHSs+cr2FqcMXPPPzJRwnVW/BRI0S1dYEmqsWhq6Bri9VPwDvnvKu5BVolXfjkCve4TrxwmG5TuYxo1D3qJC9aPk4Z1FIifU5aVGOkFBnf7YUe2pdknk6e7rUAbUyln6WT8sjsJBCpSEGqYGCLEE1BZBC5uWz+6Zsc9WIDpIwWTpv5RX6V9FeYeHaK4VXIqPY0nGnDX9csDROaEgPfgteXa/CZWqGg51cFk5PHWqhJQfy7X4f/c7YETIT7XcPtxlxNiXWW3AJ5MfPX/6kvHDTd43QU8XhsVH5NB78ivMln+v/0iY75JJrzaHitejwmmYUyFuKz4aSOTAHdV0jRBY21EJsAHXOEa4QjL4ya5YIRqcGEgsramGFYHQLa4RVbSGwlfSTHibshOu7++/77Ov1ze7uy+0uez2BENuKbAfZ46Q210qc/kkSmEaBbTebvWPBexakswWGEYYhXaw34TIIAFKU4uAjSgE4BzgK/QSizRuOHWtPf06OvZJVxhhtQ33Sr87G+hPeaPB5Zm/2gxHwS36MAudW9Rr7DU9z1Ge8TGbjspe9ggXbuj/HbfbNH0+b0ipZAwAA"

#Source: http://www.gnuplotting.org/data/world_110m.txt
mapfile="world_110m.txt"
echo "Checking if mapfile exists... "
if [ -e ${mapfile} ]; then echo "Mapfile ${mapfile} found"; else wget --continue --quiet --no-check-certificate http://www.gnuplotting.org/data/world_110m.txt; fi
if [ -e ${mapfile} ]; then echo "OK"; else echo "Mapfile ${mapfile} not found. Aborted!"; exit 1; fi

gridfile=gpt3_1.grd
fname=gpt3_1_mine.grd
gridfileserver="https://vmf.geo.tuwien.ac.at/codes"

echo "Checking if grid file exists... "
if [ -e ${gridfile} ]; then echo "${gridfile} found";
else
  wget --continue --quiet --no-check-certificate ${gridfileserver}/${gridfile};
  if [ -e ${gridfile} ]; then echo "It seems OK"; else echo "Grid file not found. Aborted!"; exit 1; fi
fi

head -1 ${gridfile} > ${fname}
grep -v "^% " ${gridfile} | awk 'BEGIN{linha=0}{linha++; n=split($0, a," "); printf("%6.1f%7.1f%7.0f%6.0f%5.0f%5.0f%5.0f%6.1f%6.1f%5.1f%5.1f%5.1f%6.2f%6.2f%6.2f%6.2f%6.2f%6.1f%6.1f%5.1f%5.1f%5.1f%8.2f%9.2f%9.5f%9.5f%9.5f%9.5f%9.5f%9.5f%9.5f%9.5f%9.5f%9.5f%7.4f%8.4f%8.4f%8.4f%8.4f%6.1f%6.1f%5.1f%5.1f%5.1f%8.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%7.2f%1s\r\n", a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20], a[21], a[22], a[23], a[24], a[25], a[26], a[27], a[28], a[29], a[30], a[31], a[32], a[33], a[34], a[35], a[36], a[37], a[38], a[39], a[40], a[41], a[42], a[43], a[44], a[45], a[46], a[47], a[48],a[49], a[50], a[51], a[52], a[53], a[54], a[55], a[56], a[57], a[58], a[59], a[60], a[61], a[62], a[63], a[64], " ")}' >> ${fname}

#echo $(grep "List of" -A 42 term_A1.sh | tail -42 | cut -d' ' -f1)
terms="pa0 pA1 pB1 pA2 pB2 Ta0 TA1 TB1 TA2 TB2 Qa0 QA1 QB1 QA2 QB2 dTa0 dTA1 dTB1 dTA2 dTB2 undu Hs aha0 ahA1 ahB1 ahA2 ahB2 awa0 awA1 awB1 awA2 awB2 la0 lA1 lB1 lA2 lB2 Tma0 TmA1 TmB1 TmA2 TmB2 Gnha0 GnhA1 GnhB1 GnhA2 GnhB2 Geha0 GehA1 GehB1 GehA2 GehB2 Gnwa0 GnwA1 GnwB1 GnwA2 GnwB2 Gewa0 GewA1 GewB1 GewA2 GewB2"

for term in ${terms}; do
  startEnd=$(grep "^${term}" $0 | cut -d' ' -f2)
  echo -ne "${startEnd}  "; #sleep 1;

  output=matrix_${term}; echo " Creating file ${output}"; echo -ne "" > ${output};
  for lat in $(seq 895 -10 -895); do
    lat="$(echo ${lat} | awk '{printf("%6.1f",$1/10.0)}')";
    echo -ne "[${lat}]\r\c";
    echo $(grep "^${lat}" ${fname} | cut -c${startEnd}) >> ${output};
#    echo $(grep "^${lat}" ${fname} | awk '{printf("%s ", $4)}') >> ${output};
  done

  echo -ne " Created file ${output} "
  if [ -e template_script.gnu ]; then echo -ne "Gnuplot script template ok "
  else
    echo -ne " Creating gnuplot script template "
    echo "${gnuplotScriptB64}" |  base64 -d -w 99999 | gzip -d > template_script.gnu
  fi

  echo "Done"
  #Avoid to write temporary files to disk
  #sed "s/_GPT2TERM_/${term}/g" template_script.gnu > grid_template_${term}.gnu; #gnuplot grid_template_${term}.gnu
  gnuTempScript=$(sed "s/_GPT2TERM_/${term}/g" template_script.gnu)
  gnuplot -e "${gnuTempScript}"
done
exit 0;


List of 64 terms
lat 1-6
lon 7-13
pa0 14-20
pA1 21-26
pB1 27-31
pA2 32-36
pB2 37-41
Ta0 42-47
TA1 48-53
TB1 54-58
TA2 59-63
TB2 64-68
Qa0 69-74
QA1 75-80
QB1 81-86
QA2 87-92
QB2 93-98
dTa0 99-104
dTA1 105-110
dTB1 111-115
dTA2 116-120
dTB2 121-125
undu 126-133
Hs 134-142
aha0 143-151
ahA1 152-160
ahB1 161-169
ahA2 170-178
ahB2 179-187
awa0 188-196
awA1 197-205
awB1 206-214
awA2 215-223
awB2 224-232
la0 233-239
lA1 240-247
lB1 248-255
lA2 256-263
lB2 264-271
Tma0 272-277
TmA1 278-283
TmB1 284-288
TmA2 289-293
TmB2 294-298
Gnha0 299-306
GnhA1 307-313
GnhB1 314-320
GnhA2 321-327
GnhB2 328-334
Geha0 335-341
GehA1 342-348
GehB1 349-355
GehA2 356-362
GehB2 363-369
Gnwa0 370-376
GnwA1 377-383
GnwB1 384-390
GnwA2 391-397
GnwB2 398-404
Gewa0 405-411
GewA1 412-418
GewB1 419-425
GewA2 426-432
GewB2 433-439

ENDE
