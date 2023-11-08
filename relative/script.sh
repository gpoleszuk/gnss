
#sps1 spc1
#sps1 spbp
#sps1 poli

#poli sps1
#poli spc1
#poli spbp

#spc1 sps1
#spc1 spbp
#spbp poli

  from=sps1
  for to in spc1 spbp poli; do
    sed 's/out-solformat      =xyz/out-solformat      =enu/g' ${from}_${to}.conf > ${from}_${to}_enu.conf
    for doy in 006 007 008; do
      echo -ne "${from} ${to} "
      /home/gpsr/bin/RTKLIB-2.4.3-b34/app/consapp/rnx2rtkp/gcc/rnx2rtkp_orig -k ${from}_${to}_enu.conf ${to}${doy}1.23d ${from}${doy}1.23d ppte${doy}1.23n COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3 COD0OPSFIN_2023${doy}0000_01D_30S_CLK.CLK ESA0OPSFIN_20230080000_07D_01D_ERP.ERP ESA0OPSFIN_20230010000_07D_01D_ERP.ERP COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX 2>/dev/null | grep "^2023"
    done
  done

  from=poli
  for to in sps1 spc1 spbp; do
    sed 's/out-solformat      =xyz/out-solformat      =enu/g' ${from}_${to}.conf > ${from}_${to}_enu.conf
    for doy in 006 007 008; do
      echo -ne "${from} ${to} "
      /home/gpsr/bin/RTKLIB-2.4.3-b34/app/consapp/rnx2rtkp/gcc/rnx2rtkp_orig -k ${from}_${to}_enu.conf ${to}${doy}1.23d ${from}${doy}1.23d ppte${doy}1.23n COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3 COD0OPSFIN_2023${doy}0000_01D_30S_CLK.CLK ESA0OPSFIN_20230080000_07D_01D_ERP.ERP ESA0OPSFIN_20230010000_07D_01D_ERP.ERP COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX 2>/dev/null | grep "^2023"
    done
  done

  from=spc1
  for to in sps1 spbp; do
    sed 's/out-solformat      =xyz/out-solformat      =enu/g' ${from}_${to}.conf > ${from}_${to}_enu.conf
    for doy in 006 007 008; do
      echo -ne "${from} ${to} "
      /home/gpsr/bin/RTKLIB-2.4.3-b34/app/consapp/rnx2rtkp/gcc/rnx2rtkp_orig -k ${from}_${to}_enu.conf ${to}${doy}1.23d ${from}${doy}1.23d ppte${doy}1.23n COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3 COD0OPSFIN_2023${doy}0000_01D_30S_CLK.CLK ESA0OPSFIN_20230080000_07D_01D_ERP.ERP ESA0OPSFIN_20230010000_07D_01D_ERP.ERP COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX 2>/dev/null | grep "^2023"
    done
  done

  from=spbp
  for to in poli; do
    sed 's/out-solformat      =xyz/out-solformat      =enu/g' ${from}_${to}.conf > ${from}_${to}_enu.conf
    for doy in 006 007 008; do
      echo -ne "${from} ${to} "
      /home/gpsr/bin/RTKLIB-2.4.3-b34/app/consapp/rnx2rtkp/gcc/rnx2rtkp_orig -k ${from}_${to}_enu.conf ${to}${doy}1.23d ${from}${doy}1.23d ppte${doy}1.23n COD0OPSFIN_2023${doy}0000_01D_05M_ORB.SP3 COD0OPSFIN_2023${doy}0000_01D_30S_CLK.CLK ESA0OPSFIN_20230080000_07D_01D_ERP.ERP ESA0OPSFIN_20230010000_07D_01D_ERP.ERP COD0OPSFIN_2023${doy}0000_01D_01H_GIM.INX 2>/dev/null | grep "^2023"
    done
  done
