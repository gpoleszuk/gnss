Some Leica Geosystems models given in the ATX file igs20_2247.atx

Raw values, no interpolation applied

![LEIATX1230+GNSS_NONE_G01](./pcv_LEIATX1230+GNSS_NONE_G01.png)
![LEIATX1230+GNSS_NONE_G02](./pcv_LEIATX1230+GNSS_NONE_G02.png)
![LEIATX1230+GNSS_NONE_R01](./pcv_LEIATX1230+GNSS_NONE_R01.png)
![LEIATX1230+GNSS_NONE_R02](./pcv_LEIATX1230+GNSS_NONE_R02.png)
![LEIAX1202GG_____NONE_G01](./pcv_LEIAX1202GG_____NONE_G01.png)
![LEIAX1202GG_____NONE_G02](./pcv_LEIAX1202GG_____NONE_G02.png)
![LEIAX1202GG_____NONE_R01](./pcv_LEIAX1202GG_____NONE_R01.png)
![LEIAX1202GG_____NONE_R02](./pcv_LEIAX1202GG_____NONE_R02.png)
![LEIAX1202_______NONE_G01](./pcv_LEIAX1202_______NONE_G01.png)
![LEIAX1202_______NONE_G02](./pcv_LEIAX1202_______NONE_G02.png)
![LEIAX1203+GNSS__NONE_G01](./pcv_LEIAX1203+GNSS__NONE_G01.png)
![LEIAX1203+GNSS__NONE_G02](./pcv_LEIAX1203+GNSS__NONE_G02.png)
![LEIAX1203+GNSS__NONE_R01](./pcv_LEIAX1203+GNSS__NONE_R01.png)
![LEIAX1203+GNSS__NONE_R02](./pcv_LEIAX1203+GNSS__NONE_R02.png)

Powered by Shell Script under Linux
```
ls | grep pcv_LEIAX | awk '{printf("![%s](./%s)\n", substr($1,5,24), $1)}'
```
```
ls | grep pcv_LEIATX | awk '{printf("![%s](./%s)\n", substr($1,5,24), $1)}'
```
