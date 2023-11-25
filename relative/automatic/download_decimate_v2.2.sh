#!/bin/bash

# Default values for variables
clean=0    # 0 - don't delete files
garbage_file_list=""
rinex_file_list=""

print_help_old() {
    echo "Usage: ./script_name [options]"
    echo
    echo "Options:"
    echo "  -h, --help     show help message"
    echo "  -c, --clean    clean all garbage files"
    echo "  -o, --output   specify output file"
    echo "  -v, --verbose  enable verbose output"
    echo
}

print_help() {
  cat <<EOF
Usage: ./script_name [options]

Options:
  -h, --help     show help message
  -c, --clean    clean garbage files
  -o, --output   specify output file
  -v, --verbose  enable verbose output

EOF
}

# Parse the options
while getopts "hq:p:c" opt; do
    case "${opt}" in
        h)  # Help option
            print_help
            exit 0
            ;;
        q)  # Query option
            id=${OPTARG}
            # Code to query database with given id
            ;;
        p)  # Process option
            site=${OPTARG}
            # Code to process site information
            ;;
        c)  # Verbose option
            clean=1
            ;;
        *)  # Invalid option
            echo "Invalid option: -$OPTARG" >&2
            print_help
            exit 1
            ;;
    esac
done
#shift $((OPTIND-1))

# Validate and execute the provided options
#if [ -n "$id" ]; then
#    echo "Query database with id: $id"
#fi

#if [ -n "$site" ]; then
#    echo "Process site information: $site"
#fi

#if [ "$verbose" = true ]; then
#    echo "Verbose mode activated"
#fi

if [ ${clean} -eq 1 ]; then
    echo "Clean mode activated"
fi


if [ $# -eq 0 ]; then
    print_help
    exit 1
fi

# Rest of your script code goes here

convert2baseline () {
  echo "< $1" | awk '{
  # sdx(m)       sdy(m)       sdz(m)      sdxy(m)      sdyz(m)      sdzx(m) age(s)  ratio
    ref = $2;

    if(ref == "poli") {
      X0  =  4010099.5048;
      Y0  = -4259927.3030;
      Z0  = -2533538.7990;
      sX0 = 0.003;
      sY0 = 0.003;
      sZ0 = 0.002;
      ant = "TRM57971.00     NONE"
      ah  = 0.0500;
    }

    if(ref == "spbp") {
      X0  =  4043683.2088;
      Y0  = -4266290.4477;
      Z0  = -2469479.8486;
      sX0 = 0.002;
      sY0 = 0.002;
      sZ0 = 0.001;
      ant = "TRM57971.00     NONE"
      ah  = 0.0080;
    }

    if(ref == "spc1") {
      X0  =  4007215.1075;
      Y0  = -4306650.1936;
      Z0  = -2458220.5598;
      sX0 = 0.005;
      sY0 = 0.005;
      sZ0 = 0.003;
      ant = "TRM115000.00    NONE"
      ah  = 0.0080;
    }

    if(ref == "sps1") {
      X0  =  3960996.5157;
      Y0  = -4310092.4421;
      Z0  = -2525735.0089;
      sX0 = 0.002;
      sY0 = 0.003;
      sZ0 = 0.002;
      ant = "LEIAR10         NONE"
      ah  = 0.0000;
    }

    dX  = $6-X0;    dY  = $7-Y0;    dZ  = $8-Z0;
    sXX = $11^2;    sYY = $12^2;    sZZ = $13^2;
    sXY = ($14<0)?-$14^2:$14^2;
    sYZ = ($15<0)?-$15^2:$15^2;
    sZX = ($16<0)?-$16^2:$16^2;
    printf("%s %s %s %s %15.6f %15.6f %15.6f %15.8E %15.8E %15.8E %15.8E %15.8E %15.8E < ",
            ref, $3, $4, $5, dX, dY, dZ, sXX, sYY, sZZ, sXY, sYZ, sZX);
  }';
}

# Create a TXT database with reference coordinates
database=$(cat <<EOD
#        1         2         3         4         5         6         7         8         9
#234.6789 1234.6789 1234.6789 1234.6789 1234.6789 1234.6789 1234.6789 1234.6789 1234.6789 1234.6789
POLI  4010099.5048 -4259927.3030 -2533538.7990  0.0030  0.0030  0.0020 TRM57971.00     NONE  0.0500
SPS1  3960996.5157 -4310092.4421 -2525735.0089  0.0020  0.0030  0.0020 LEIAR10         NONE  0.0000
SPC1  4007215.1075 -4306650.1936 -2458220.5598  0.0050  0.0050  0.0030 TRM115000.00    NONE  0.0080
SPBP  4043683.2088 -4266290.4477 -2469479.8486  0.0020  0.0020  0.0010 TRM57971.00     NONE  0.0080
EOD
)

# Create a FES2014b.blq file
echo -ne "Creating a FES2014b.blq file from embedded package... "
FES2014b="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"
echo -ne ${FES2014b} | base64 -d | gzip -d --stdout > FES2014b.blq
test $? && echo "Done!" || echo "Failed!"
if [ ${clean} -eq 1 ]; then garbage_file_list="${garbage_file_list} FES2014b.blq"; fi

template_conf () {
  if ! [ $# -eq 4 ]; then
    exit 1;
  fi
  ref=$1;
  rov=$2;
  database=$3;
  template_file=$4
  status=0;

  echo "$database}" | grep -qi "^${ref}" 2>/dev/null
  if [ $? -eq 0 ]; then  status=$((status+1)); else echo "${ref} not found in database!"; fi
  echo "$database}" | grep -qi "^${rov}" 2>/dev/null
  if [ $? -eq 0 ]; then status=$((status+1)); else echo "${ref} not found in database!"; fi

  if [ ${status} -eq 2 ]; then
    #echo -ne "Reference: ${ref}   Rover: ${rov}  found in database. "
    #echo -ne "Creating a template with configurations for processing... "
    echo "# rtkpost options (2010/08/07 09:24:29, v.2.4.0)" > ${template_file}
    echo "pos1-posmode       =3          # (0:single,1:dgps,2:kinematic,3:static,4:movingbase,5:fixed,6:ppp-kine,7:ppp-static)" >> ${template_file}
    echo "pos1-frequency     =2          # (1:l1,2:l1+l2,3:l1+l2+l5)" >> ${template_file}
    echo "pos1-soltype       =0          # (0:forward,1:backward,2:combined)" >> ${template_file}
    echo "pos1-elmask        =10         # (deg)" >> ${template_file}
    echo "pos1-snrmask       =0          # (dBHz)" >> ${template_file}
    echo "pos1-dynamics      =off        # (0:off,1:on)" >> ${template_file}
    echo "pos1-tidecorr      =1          # (0:off,1:on)" >> ${template_file}
    echo "pos1-ionoopt       =3          # (0:off,1:brdc,2:sbas,3:dual-freq,4:est-stec)" >> ${template_file}
    echo "pos1-tropopt       =3          # (0:off,1:saas,2:sbas,3:est-ztd,4:est-ztdgrad)" >> ${template_file}
    echo "pos1-sateph        =1          # (0:brdc,1:precise,2:brdc+sbas,3:brdc+ssrapc,4:brdc+ssrcom)" >> ${template_file}
    echo "pos1-exclsats      =           # (prn ...)" >> ${template_file}
    echo "pos1-navsys        =1          # (1:gps+2:sbas+4:glo+8:gal+16:qzs+32:comp)" >> ${template_file}
    echo "pos2-armode        =0          # (0:off,1:continous,2:instantaneous,3:fix-and-hold)" >> ${template_file}
    echo "pos2-gloarmode     =off        # (0:off,1:on,2:autocal)" >> ${template_file}
    echo "pos2-arthres       =5" >> ${template_file}
    echo "pos2-arlockcnt     =0" >> ${template_file}
    echo "pos2-arelmask      =15         # (deg)" >> ${template_file}
    echo "pos2-aroutcnt      =5" >> ${template_file}
    echo "pos2-arminfix      =10" >> ${template_file}
    echo "pos2-slipthres     =0.05       # (m)" >> ${template_file}
    echo "pos2-maxage        =30         # (s)" >> ${template_file}
    echo "pos2-rejionno      =30         # (m)" >> ${template_file}
    echo "pos2-niter         =1" >> ${template_file}
    echo "pos2-baselen       =0          # (m)" >> ${template_file}
    echo "pos2-basesig       =0          # (m)" >> ${template_file}
    echo "out-solformat      =xyz        # (0:llh,1:xyz,2:enu,3:nmea)" >> ${template_file}
    echo "out-outhead        =on         # (0:off,1:on)" >> ${template_file}
    echo "out-outopt         =on         # (0:off,1:on)" >> ${template_file}
    echo "out-timesys        =gpst       # (0:gpst,1:utc,2:jst)" >> ${template_file}
    echo "out-timeform       =hms        # (0:tow,1:hms)" >> ${template_file}
    echo "out-timendec       =3" >> ${template_file}
    echo "out-degform        =deg        # (0:deg,1:dms)" >> ${template_file}
    echo "out-fieldsep       =" >> ${template_file}
    echo "out-height         =ellipsoidal # (0:ellipsoidal,1:geodetic)" >> ${template_file}
    echo "out-geoid          =internal   # (0:internal,1:egm96,2:egm08_2.5,3:egm08_1,4:gsi2000)" >> ${template_file}
    echo "out-solstatic      =single     # (0:all,1:single)" >> ${template_file}
    echo "out-nmeaintv1      =0          # (s)" >> ${template_file}
    echo "out-nmeaintv2      =0          # (s)" >> ${template_file}
    echo "out-outstat        =off        # (0:off,1:state,2:residual)" >> ${template_file}
    echo "stats-errratio     =100" >> ${template_file}
    echo "stats-errphase     =0.003      # (m)" >> ${template_file}
    echo "stats-errphaseel   =0.003      # (m)" >> ${template_file}
    echo "stats-errphasebl   =0          # (m/10km)" >> ${template_file}
    echo "stats-errdoppler   =10         # (Hz)" >> ${template_file}
    echo "stats-stdbias      =30         # (m)" >> ${template_file}
    echo "stats-stdiono      =0.03       # (m)" >> ${template_file}
    echo "stats-stdtrop      =0.3        # (m)" >> ${template_file}
    echo "stats-prnaccelh    =1          # (m/s^2)" >> ${template_file}
    echo "stats-prnaccelv    =0.1        # (m/s^2)" >> ${template_file}
    echo "stats-prnbias      =0.0001     # (m)" >> ${template_file}
    echo "stats-prniono      =0.001      # (m)" >> ${template_file}
    echo "stats-prntrop      =0.0001     # (m)" >> ${template_file}
    echo "stats-clkstab      =5e-12      # (s/s)" >> ${template_file}


    echo "${database}" | grep -v "^#" | grep -i "^${ref}" | awk '{
         site = substr($0,1,4);
         X = substr($0,6,13);
         Y = substr($0,19,14);
         Z = substr($0,33,14);
         antType = substr($0,72,20);
         antHgt = substr($0,93,7);
         printf("#Site: %s\n", site);
         printf("ant1-postype       =1\n");
         printf("ant1-pos1          =%0.4f\n", X);
         printf("ant1-pos2          =%0.4f\n", Y);
         printf("ant1-pos3          =%0.4f\n", Z);
         printf("ant1-anttype       =%-20s\n", antType);
         printf("ant1-antdele       =%0.4f\n", 0.0000);
         printf("ant1-antdeln       =%0.4f\n", 0.0000);
         printf("ant1-antdelu       =%0.4f\n", antHgt);
      }'>> ${template_file}

    echo "${database}" | grep -v "^#" | grep -i "^${rov}" | awk '{
         site = substr($0,1,4);
         X = substr($0,6,13);
         Y = substr($0,19,14);
         Z = substr($0,33,14);
         antType = substr($0,72,20);
         antHgt = substr($0,93,7);
         printf("#Site: %s\n", site);
         printf("ant2-postype       =1\n");
         printf("ant2-pos1          =%0.4f\n", X);
         printf("ant2-pos2          =%0.4f\n", Y);
         printf("ant2-pos3          =%0.4f\n", Z);
         printf("ant2-anttype       =%-20s\n", antType);
         printf("ant2-antdele       =%0.4f\n", 0.0000);
         printf("ant2-antdeln       =%0.4f\n", 0.0000);
         printf("ant2-antdelu       =%0.4f\n", antHgt);
      }' >> ${template_file}

    echo "misc-timeinterp    =off        # (0:off,1:on)" >> ${template_file}
    echo "misc-sbasatsel     =0          # (0:all)" >> ${template_file}
    echo "file-satantfile    =/home/gpsr/bin/igs20_2274.atx" >> ${template_file}
    echo "file-rcvantfile    =/home/gpsr/bin/igs20_2274.atx" >> ${template_file}
    echo "file-staposfile    =../../../data/stations.pos" >> ${template_file}
    echo "file-geoidfile     =" >> ${template_file}
    echo "file-dcbfile       =/home/gpsr/bin/P1C1_ALL.DCB" >> ${template_file}
    echo "file-tempdir       =" >> ${template_file}
    echo "file-geexefile     =" >> ${template_file}
    echo "file-solstatfile   =" >> ${template_file}
    echo "file-tracefile     =" >> ${template_file}
    #echo "Done!"
  else
    echo "Some site was not found in the database. Be sure to check it before to continue"
  fi
}

#rm ????[0-3][0-9][0-9]1.??[dglno]
# ????[0-3][0-9][0-9]1.??g ????[0-3][0-9][0-9]1.??l  ????[0-3][0-9][0-9]1.??n ????[0-3][0-9][0-9]1.??o

sites="poli spbp spc1 sps1"
years="2023"
doys="007 008"

# Bug - if year is different of 2023

for year in ${years}; do
  for site in ${sites}; do
    for doy in ${doys}; do
      zipfile=${site}${doy}1.zip
      if [ -e ${zipfile} ]; then
        echo "${zipfile} exist! Inflating ${zipfile}..."
        unzip -q ${zipfile} 2> /dev/null
      else
        wget -c https://geoftp.ibge.gov.br/informacoes_sobre_posicionamento_geodesico/rbmc/dados/${year}/${doy}/${zipfile}
        if [ $? -eq 0 ]; then
          echo "${zipfile} downloaded! Inflating ${zipfile}..."
          unzip -q ${zipfile} 2> /dev/null
        fi
      fi
    done
  done
done


for file in *.23n; do
   mv ${file} brdc${file:4:12}
done

for file in brdc????.23n; do
   rinex_file_list="${rinex_file_list} brdc${file:4:12}"
done


for file in *.23d; do
  echo -ne "${file:0:12} to ${file:0:11}o ";
  crx2rnx - ${file:0:12} > tmpfile;
  if [ -e ${file:0:11}d ]; then rm ${file:0:11}d; fi
  if [ -e ${file:0:11}g ]; then rm ${file:0:11}g; fi
  if [ -e ${file:0:11}h ]; then rm ${file:0:11}h; fi
  if [ -e ${file:0:11}l ]; then rm ${file:0:11}l; fi
  #teqc -st 153000 -e 235945 -O.dec 15 -R -E -C -S -I -O.obs L1L2C1P2 tmpfile > ${file:0:11}o 2>/dev/null;
  teqc -st 153000 -e 235945 -O.dec 15 -R -E -C -S -I -O.obs L1L2C1P2 tmpfile > ${file:0:11}o 2>/dev/null;
  teqc +qc -plot -st 153000 -e 235959 -nav brdc${file:4:3}1.23n ${file:0:11}o 2>/dev/null | grep "^SUM ";
  if [ -e ${file:0:11}S ]; then rm ${file:0:11}S; fi
  if [ -e ${file:0:11}o ]; then rinex_file_list="${rinex_file_list} ${file:0:11}o"; fi
done; rm tmpfile


year=2023
doys="007 008"
code_server="http://ftp.aiub.unibe.ch/CODE"
for doy in ${doys}; do
  echo "Downloading ephemeris for DOY: ${doy}"
  wget -c ${code_server}/${year}/COD0OPSFIN_2023${doy}0000_01D_01D_ERP.ERP.gz 2>/dev/null; gzip -d --stdout COD0OPSFIN_2023${doy}0000_01D_01D_ERP.ERP.gz > COD0OPSFIN_2023${doy}0000_01D_01D_ERP.ERP
  wget -c ${code_server}/${year}/COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX.gz 2>/dev/null; gzip -d --stdout COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX.gz > COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX
  wget -c ${code_server}/${year}/COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3.gz 2>/dev/null; gzip -d --stdout COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3.gz > COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3
  wget -c ${code_server}/${year}/COD0OPSFIN_2023${doy}0000_01D_05S_CLK.CLK.gz 2>/dev/null; gzip -d --stdout COD0OPSFIN_2023${doy}0000_01D_05S_CLK.CLK.gz > COD0OPSFIN_2023${doy}0000_01D_05S_CLK.CLK
  garbage_file_list="${garbage_file_list} COD0OPSFIN_2023${doy}0000_01D_01D_ERP.ERP COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3 COD0OPSFIN_2023${doy}0000_01D_05S_CLK.CLK"
done
echo -ne "Downloading ERP files... "
wget -c http://ftp.aiub.unibe.ch/CODE/2023/COD0OPSFIN_20230010000_07D_01D_ERP.ERP.gz 2>/dev/null; gzip -d --stdout COD0OPSFIN_20230010000_07D_01D_ERP.ERP.gz > COD0OPSFIN_20230010000_07D_01D_ERP.ERP
wget -c http://ftp.aiub.unibe.ch/CODE/2023/COD0OPSFIN_20230080000_07D_01D_ERP.ERP.gz 2>/dev/null; gzip -d --stdout COD0OPSFIN_20230080000_07D_01D_ERP.ERP.gz > COD0OPSFIN_20230080000_07D_01D_ERP.ERP
wget -c http://ftp.aiub.unibe.ch/CODE/2023/COD0OPSFIN_20230150000_07D_01D_ERP.ERP.gz 2>/dev/null; gzip -d --stdout COD0OPSFIN_20230150000_07D_01D_ERP.ERP.gz > COD0OPSFIN_20230150000_07D_01D_ERP.ERP
garbage_file_list="${garbage_file_list} COD0OPSFIN_20230010000_07D_01D_ERP.ERP COD0OPSFIN_20230080000_07D_01D_ERP.ERP COD0OPSFIN_20230150000_07D_01D_ERP.ERP"
echo "Done!"


#wget -c ${code_server}/${year}/COD0OPSFIN_20230070000_01D_01D_GIM.RNX.gz
#wget -c ${code_server}/${year}/COD0OPSFIN_20230070000_01D_01D_OSB.BIA.gz
#wget -c ${code_server}/${year}/COD0OPSFIN_20230070000_01D_01H_GIM.ION.gz
#wget -c ${code_server}/${year}/COD0OPSFIN_20230070000_01D_01H_TRO.TRO.gz
#wget -c ${code_server}/${year}/COD0OPSFIN_20230070000_01D_05S_CLK.CLK_V2.gz
#wget -c ${code_server}/${year}/COD0OPSFIN_20230070000_01D_30S_ATT.OBX.gz
#wget -c ${code_server}/${year}/COD0OPSFIN_20230070000_01D_30S_CLK.CLK.gz
#wget -c ${code_server}/${year}/COD0OPSFIN_20230070000_01D_30S_CLK.CLK_V2.gz


stime="15:30:00"
etime="23:59:45"
elevation=10
interval=15

rtklib_app="/home/gpsr/bin/RTKLIB-2.4.3-b34/app/consapp/rnx2rtkp/gcc/rnx2rtkp_enu"
rtklib_app="./rnx2rtkp_enu"
erp_files="COD0OPSFIN_20230010000_07D_01D_ERP.ERP COD0OPSFIN_20230080000_07D_01D_ERP.ERP"

echo "Starting processing..."
from=sps1
for to in spc1 spbp poli; do
  for doy in 007 008; do
    template_conf ${to} ${from} "${database}" template_ini.conf
    sed 's/out-solformat      =xyz/out-solformat      =xyz/g' template_ini.conf > ${from}_${to}_xyz.conf
    sed -i "s/pos1-elmask        =10/pos1-elmask        =${elevation}/g" ${from}_${to}_xyz.conf
    convert2baseline "${from} ${to} $(${rtklib_app} -ts 2023/01/${doy:1:2} ${stime} -te 2023/01/${doy:1:2} ${etime} -ti ${interval} -k ${from}_${to}_xyz.conf ${to}${doy}1.23o ${from}${doy}1.23o brdc${doy}1.23n FES2014b.blq COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3 COD0OPSFIN_2023${doy}0000_01D_30S_CLK.CLK ${erp_files} COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX 2>/dev/null | grep "^2023")"
    echo ${from}_${to}_xyz.conf; if [ ${clean} -eq 1 ]; then garbage_file_list="${garbage_file_list} ${from}_${to}_xyz.conf"; fi
  done
done

from=poli
for to in sps1 spc1 spbp; do
  for doy in 007 008; do
    template_conf ${to} ${from} "${database}" template_ini.conf
    sed 's/out-solformat      =xyz/out-solformat      =xyz/g' template_ini.conf > ${from}_${to}_xyz.conf
    sed -i "s/pos1-elmask        =10/pos1-elmask        =${elevation}/g" ${from}_${to}_xyz.conf
    convert2baseline "${from} ${to} $(${rtklib_app} -ts 2023/01/${doy:1:2} ${stime} -te 2023/01/${doy:1:2} ${etime} -ti ${interval} -k ${from}_${to}_xyz.conf ${to}${doy}1.23o ${from}${doy}1.23o brdc${doy}1.23n FES2014b.blq COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3 COD0OPSFIN_2023${doy}0000_01D_30S_CLK.CLK ${erp_files} COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX 2>/dev/null | grep "^2023")"
    echo ${from}_${to}_xyz.conf; if [ ${clean} -eq 1 ]; then garbage_file_list="${garbage_file_list} ${from}_${to}_xyz.conf"; fi
  done
done

from=spc1
for to in sps1 spbp; do
  for doy in 007 008; do
    template_conf ${to} ${from} "${database}" template_ini.conf
    sed 's/out-solformat      =xyz/out-solformat      =xyz/g' template_ini.conf > ${from}_${to}_xyz.conf
    sed -i "s/pos1-elmask        =10/pos1-elmask        =${elevation}/g" ${from}_${to}_xyz.conf
    convert2baseline "${from} ${to} $(${rtklib_app} -ts 2023/01/${doy:1:2} ${stime} -te 2023/01/${doy:1:2} ${etime} -ti ${interval} -k ${from}_${to}_xyz.conf ${to}${doy}1.23o ${from}${doy}1.23o brdc${doy}1.23n FES2014b.blq COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3 COD0OPSFIN_2023${doy}0000_01D_30S_CLK.CLK ${erp_files} COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX 2>/dev/null | grep "^2023")"
    echo ${from}_${to}_xyz.conf; if [ ${clean} -eq 1 ]; then garbage_file_list="${garbage_file_list} ${from}_${to}_xyz.conf"; fi
  done
done

from=spbp
for to in poli; do
  for doy in 007 008; do
    template_conf ${to} ${from} "${database}" template_ini.conf
    sed 's/out-solformat      =xyz/out-solformat      =xyz/g' template_ini.conf > ${from}_${to}_xyz.conf
    sed -i "s/pos1-elmask        =10/pos1-elmask        =${elevation}/g" ${from}_${to}_xyz.conf
    convert2baseline "${from} ${to} $(${rtklib_app} -ts 2023/01/${doy:1:2} ${stime} -te 2023/01/${doy:1:2} ${etime} -ti ${interval} -k ${from}_${to}_xyz.conf ${to}${doy}1.23o ${from}${doy}1.23o brdc${doy}1.23n FES2014b.blq COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3 COD0OPSFIN_2023${doy}0000_01D_30S_CLK.CLK ${erp_files} COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX 2>/dev/null | grep "^2023")"
    echo ${from}_${to}_xyz.conf; if [ ${clean} -eq 1 ]; then garbage_file_list="${garbage_file_list} ${from}_${to}_xyz.conf template_ini.conf"; fi
  done
done
echo "Processing done!"

# List of files to be cleaned
#file_list=("file1.txt" "file2.txt" "file3.txt")

# Prompt the user to clean files
echo "RINEX File List  : [ ${rinex_file_list} ]"
echo "Garbage File List: [ ${garbage_file_list} ]"
read -p "Do you want to clean files in the list? (y/n): " answer
file_list="${rinex_file_list} ${garbage_file_list}"

# Check the user's response
if [[ $answer == "y" ]]; then
    # Iterate through each file in the list
    for file in ${file_list[@]}; do
        # Clean the file (perform any required operation)
        echo -ne "Cleaning $file..."
        echo -ne "                                                                                       \x0d"
        # Your clean operation goes here
        if [ -e ${file} ]; then
          rm ${file};
          # Confirm the file has been cleaned
          if [ $? -eq 0 ]; then echo -ne "${file} cleaned successfully!\x0d"; fi
          sleep .5
          echo -ne "                                                                                     \x0d"
        else
          echo "${file} not found"
        fi
    done
else
    echo "No files will be cleaned."
fi


exit 0;
