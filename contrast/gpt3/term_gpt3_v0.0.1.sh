#!/bin/bash
# Version 0.0.1 (20230517T124500Z)
echo "Under construction : )"; exit 1;
gnuplotScriptB64="H4sICLzEZGQAA3RlbXBsYXRlX3NjcmlwdC5nbnUAXZNra9swFIa/71cc2EDxlniS3TiJMxj7kI1CW0rJYFsXjC+yKypfkGWS9Nfv6JJ1zB/k87xHen0kHSs+cr2FqcMXPPPzJRwnVW/BRI0S1dYEmqsWhq6Bri9VPwDvnvKu5BVolXfjkCve4TrxwmG5TuYxo1D3qJC9aPk4Z1FIifU5aVGOkFBnf7YUe2pdknk6e7rUAbUyln6WT8sjsJBCpSEGqYGCLEE1BZBC5uWz+6Zsc9WIDpIwWTpv5RX6V9FeYeHaK4VXIqPY0nGnDX9csDROaEgPfgteXa/CZWqGg51cFk5PHWqhJQfy7X4f/c7YETIT7XcPtxlxNiXWW3AJ5MfPX/6kvHDTd43QU8XhsVH5NB78ivMln+v/0iY75JJrzaHitejwmmYUyFuKz4aSOTAHdV0jRBY21EJsAHXOEa4QjL4ya5YIRqcGEgsramGFYHQLa4RVbSGwlfSTHibshOu7++/77Ov1ze7uy+0uez2BENuKbAfZ46Q210qc/kkSmEaBbTebvWPBexakswWGEYYhXaw34TIIAFKU4uAjSgE4BzgK/QSizRuOHWtPf06OvZJVxhhtQ33Sr87G+hPeaPB5Zm/2gxHwS36MAudW9Rr7DU9z1Ge8TGbjspe9ggXbuj/HbfbNH0+b0ipZAwAA"

#Source: http://www.gnuplotting.org/data/world_110m.txt
mapfile="world_110m.txt"
echo "Checking if mapfile exists... "
if [ -e ${mapfile} ]; then echo "Mapfile ${mapfile} found"; else wget --continue --quiet --no-check-certificate http://www.gnuplotting.org/data/world_110m.txt; fi
if [ -e ${mapfile} ]; then echo "OK"; else echo "Mapfile ${mapfile} not found. Aborted!"; exit 1; fi

gridfile=gpt3_1.grd
fname=gpt2_1w_mine.grd
gridfileserver="https://vmf.geo.tuwien.ac.at/codes"

echo "Checking if grid file exists... "
if [ -e ${gridfile} ]; then echo "${gridfile} found";
else
  wget --continue --quiet --no-check-certificate ${gridfileserver}/${gridfile};
  if [ -e ${gridfile} ]; then echo "It seems OK"; else echo "Grid file not found. Aborted!"; exit 1; fi
fi

head -1 ${gridfile} > ${fname}
grep -v "^% " ${gridfile} | awk 'BEGIN{linha=0}{linha++; n=split($0, a," "); printf("%6.1f%7.1f%7.0f%6.0f%5.0f%5.0f%5.0f%6.1f%6.1f%5.1f%5.1f%5.1f%6.2f%6.2f%6.2f%6.2f%6.2f%6.1f%6.1f%5.1f%5.1f%5.1f%8.2f%9.2f%7.4f%8.4f%8.4f%8.4f%8.4f%8.4f%8.4f%8.4f%8.4f%8.4f%8.4f%8.4f%8.4f%8.4f%8.4f%9.1f%6.1f%5.1f%5.1f%5.1f%4s\r\n", a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20], a[21], a[22], a[23], a[24], a[25], a[26], a[27], a[28], a[29], a[30], a[31], a[32], a[33], a[34], a[35], a[36], a[37], a[38], a[39], a[40], a[41], a[42], a[43], a[44], "    ")}' >> ${fname}

#echo $(grep "List of" -A 42 term_A1.sh | tail -42 | cut -d' ' -f1)
terms="pa0 pA1 pB1 pA2 pB2 Ta0 TA1 TB1 TA2 TB2 Qa0 QA1 QB1 QA2 QB2 dta0 dtA1 dtB1 dtA2 dtB2 undu Hs ha0 hA1 hB1 hA2 hB2 wa0 wA1 wB1 wA2 wB2 la0 lA1 lB1 lA2 lB2 tma0 tmA1 tmB1 tmA2 tmB2"

for term in ${terms}; do
  startEnd=$(grep "^${term}" $0 | cut -d' ' -f2)
  echo "${startEnd}"
  #sleep 1;
  output=matrix_${term}; echo Creating file ${output}; echo -ne "" > ${output};
  for lat in $(seq 895 -10 -895); do
    lat="$(echo ${lat} | awk '{printf("%6.1f",$1/10.0)}')";
    echo -ne "[${lat}]\r\c";
    echo $(grep "^${lat}" ${fname} | cut -c${startEnd}) >> ${output};
#    echo $(grep "^${lat}" ${fname} | awk '{printf("%s ", $4)}') >> ${output};
  done
  echo Created file ${output}
  if [ -e template_script.gnu ]; then
    echo "Gnuplot script template ok"
  else
    echo "${gnuplotScriptB64}" |  base64 -d -w 99999 | gzip -d > template_script.gnu
  fi
  #sed "s/_GPT2TERM_/${term}/g" template_script.gnu > grid_template_${term}.gnu
  #gnuplot grid_template_${term}.gnu
  gnuTempScript=$(sed "s/_GPT2TERM_/${term}/g" template_script.gnu)
  gnuplot -e "${gnuTempScript}"
done
exit 0;

output=${fname}.B1; echo Creating file ${output}; echo -ne "" > ${output};
for lat in $(seq 895 -10 -895); do
  lat="$(echo ${lat} | awk '{printf("%6.1f",$1/10.0)}')";
  echo -ne "[${lat}]\r\c";
  echo $(grep "^${lat}" ${fname} | awk '{printf("%s ", $5)}') >> ${output};
done
echo Created file ${output}

exit 0;

#GPT3
%  lat    lon   p:a0    A1   B1   A2   B2  T:a0   A1    B1   A2   B2  Q:a0   A1    B1    A2    B2    dT:a0   A1   B1   A2   B2  undu      Hs    a_h:a0     A1       B1        A2      B2     a_w:a0     A1       B1       A2       B2    lambda:a0  A1     B1      A2     B2    Tm:a0   A1   B1   A2   B2    Gn_h:a0   A1    B1     A2     B2   Ge_h:a0   A1    B1     A2     B2   Gn_w:a0   A1    B1     A2     B2   Ge_w:a0   A1    B1     A2     B2
  89.5    0.5 101472   114  431 -221 -128 259.2 -13.3 -6.1  2.4  0.3  1.64 -1.63 -0.68  0.51  0.35   1.3   7.0  3.1 -0.5  1.9   15.05     0.00  1.18358 -0.03603 -0.00983  0.00517  0.00391  0.57737  0.00991  0.01040  0.00014  0.00333 1.6682 -0.7893 -0.3329  0.0769 -0.1810 254.8  -9.8 -4.3  2.2  1.1   -2.32   4.33   2.38  -1.04  -1.39  -4.01   2.80   1.57   1.61   1.91  -0.10  -0.57   0.20   0.08  -0.19   0.41   0.09  -0.27  -0.18   0.01 
#        1         2         3         4         5         6         7
#234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
%  lat    lon   p:a0    A1   B1   A2   B2  T:a0   A1    B1   A2   B2  Q:a0   A1    B1    A2    B2    dT:a0   A1   B1   A2   B2  undu      Hs    a_h:a0     A1       B1        A2      B2     a_w:a0     A1       B1       A2       B2    lambda:a0  A1     B1      A2     B2    Tm:a0   A1   B1   A2   B2    Gn_h:a0   A1    B1     A2     B2   Ge_h:a0   A1    B1     A2     B2   Gn_w:a0   A1    B1     A2     B2   Ge_w:a0   A1    B1     A2     B2
  89.5
    0.5
 101472
   114
  431
 -221
 -128
 259.2
 -13.3
 -6.1
  2.4
  0.3
  1.64
 -1.63
 -0.68
  0.51
  0.35
   1.3
   7.0
  3.1
 -0.5
  1.9
   15.05
     0.00
  1.18358
 -0.03603
 -0.00983
  0.00517
  0.00391
  0.57737
  0.00991
  0.01040
  0.00014
  0.00333
 1.6682
 -0.7893
 -0.3329
  0.0769
 -0.1810
 254.8
  -9.8
 -4.3
  2.2
  1.1
   -2.32
   4.33
   2.38
  -1.04
  -1.39
  -4.01
   2.80
   1.57
   1.61
   1.91
  -0.10
  -0.57
   0.20
   0.08
  -0.19
   0.41
   0.09
  -0.27
  -0.18
   0.01

#GPT3
#234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
%  lat    lon   p:a0    A1   B1   A2   B2  T:a0   A1    B1   A2   B2  Q:a0   A1    B1    A2    B2    dT:a0   A1   B1   A2   B2  undu      Hs    a_h:a0     A1       B1        A2      B2     a_w:a0     A1       B1       A2       B2    lambda:a0  A1     B1      A2     B2    Tm:a0   A1   B1   A2   B2    Gn_h:a0   A1    B1     A2     B2   Ge_h:a0   A1    B1     A2     B2   Gn_w:a0   A1    B1     A2     B2   Ge_w:a0   A1    B1     A2     B2
  89.5    0.5 101472   114  431 -221 -128 259.2 -13.3 -6.1  2.4  0.3  1.64 -1.63 -0.68  0.51  0.35   1.3   7.0  3.1 -0.5  1.9   15.05     0.00  1.18358 -0.03603 -0.00983  0.00517  0.00391  0.57737  0.00991  0.01040  0.00014  0.00333 1.6682 -0.7893 -0.3329  0.0769 -0.1810 254.8  -9.8 -4.3  2.2  1.1   -2.32   4.33   2.38  -1.04  -1.39  -4.01   2.80   1.57   1.61   1.91  -0.10  -0.57   0.20   0.08  -0.19   0.41   0.09  -0.27  -0.18   0.01 
#GPT2
%  lat    lon   p:a0    A1   B1   A2   B2  T:a0    A1   B1   A2   B2  Q:a0    A1    B1    A2    B2 dT:a0    A1   B1   A2   B2    undu       Hs   h:a0      A1      B1      A2      B2    w:a0      A1      B1      A2      B2  lam:a0      A1      B1      A2      B2    Tm:a0    A1   B1   A2   B2              
  89.5    0.5 101472   114  431 -221 -128 259.2 -13.3 -6.1  2.4  0.3  1.64 -1.63 -0.68  0.51  0.35   1.3   7.0  3.1 -0.5  1.9   15.05     0.00 1.1870 -0.0351 -0.0128  0.0053  0.0034  0.5796  0.0084  0.0093  0.0005  0.0042  1.6682 -0.7893 -0.3329  0.0769 -0.1810    254.8  -9.8 -4.3  2.2  1.1    

List of 43 terms
pa0 14-20 7
pA1 21-26 6
pB1 27-31 5
pA2 32-36 5
pB2 37-41 5
Ta0 42-47 6
TA1 48-53 6
TB1 54-58 5
TA2 59-63 5
TB2 64-68 5
Qa0 69-74 6
QA1 75-80 6
QB1 81-86 6
QA2 87-92 6
QB2 93-98 6
dta0 99-104 6
dtA1 105-110 6
dtB1 111-115 5
dtA2 116-120 5
dtB2 121-125 5
undu 126-133 8
Hs 134-142 9
ha0 143-149 7
hA1 150-157 8
hB1 158-165 8
hA2 166-173 8
hB2 174-181 8
wa0 182-189 8
wA1 190-197 8
wB1 198-205 8
wA2 206-213 8
wB2 214-221 8
la0 222-229 8
lA1 230-237 8
lB1 238-245 8
lA2 246-253 8
lB2 254-261 8
tma0 262-270 9
tmA1 271-276 6
tmB1 277-281 5
tmA2 282-286 5
tmB2 287-291 5


ENDE
