Based on the ATX file igs20_2247.atx

![AOAD+M_B________NONE_G01](./pcv_AOAD+M_B________NONE_G01.png)
![AOAD+M_B________NONE_G02](./pcv_AOAD+M_B________NONE_G02.png)
![AOAD+M_TA_NGS___NONE_G01](./pcv_AOAD+M_TA_NGS___NONE_G01.png)
![AOAD+M_TA_NGS___NONE_G02](./pcv_AOAD+M_TA_NGS___NONE_G02.png)
![AOAD+M_TA_NGS___NONE_R01](./pcv_AOAD+M_TA_NGS___NONE_R01.png)
![AOAD+M_TA_NGS___NONE_R02](./pcv_AOAD+M_TA_NGS___NONE_R02.png)
![AOAD+M_T________DUTD_G01](./pcv_AOAD+M_T________DUTD_G01.png)
![AOAD+M_T________DUTD_G02](./pcv_AOAD+M_T________DUTD_G02.png)
![AOAD+M_T________DUTD_R01](./pcv_AOAD+M_T________DUTD_R01.png)
![AOAD+M_T________DUTD_R02](./pcv_AOAD+M_T________DUTD_R02.png)
![AOAD+M_T________NONE_G01](./pcv_AOAD+M_T________NONE_G01.png)
![AOAD+M_T________NONE_G02](./pcv_AOAD+M_T________NONE_G02.png)
![AOAD+M_T________NONE_R01](./pcv_AOAD+M_T________NONE_R01.png)
![AOAD+M_T________NONE_R02](./pcv_AOAD+M_T________NONE_R02.png)
![AOAD+M_T_RFI_T__NONE_G01](./pcv_AOAD+M_T_RFI_T__NONE_G01.png)
![AOAD+M_T_RFI_T__NONE_G02](./pcv_AOAD+M_T_RFI_T__NONE_G02.png)
![AOAD+M_T_RFI_T__NONE_R01](./pcv_AOAD+M_T_RFI_T__NONE_R01.png)
![AOAD+M_T_RFI_T__NONE_R02](./pcv_AOAD+M_T_RFI_T__NONE_R02.png)
![AOAD+M_T_RFI_T__SCIS_G01](./pcv_AOAD+M_T_RFI_T__SCIS_G01.png)
![AOAD+M_T_RFI_T__SCIS_G02](./pcv_AOAD+M_T_RFI_T__SCIS_G02.png)
![AOAD+M_T_RFI_T__SCIS_R01](./pcv_AOAD+M_T_RFI_T__SCIS_R01.png)
![AOAD+M_T_RFI_T__SCIS_R02](./pcv_AOAD+M_T_RFI_T__SCIS_R02.png)


Powered by Shell Script under Linux

``` ls | grep pcv_AOAD | awk '{printf("![%s](./%s)\n", substr($1,5,24), $1)}'```
