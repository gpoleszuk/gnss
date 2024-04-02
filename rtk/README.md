### Tasks

- [X] Select RINEX files for the RTK data processing experiment
- P0010883.17O (base)
- P0050883.17O (rovr)

- [X] Provide good solution for the geodetic position of each point (P001 and P005)
- A small offset is applied to the CORS station position (EESC0881.17O) to update its coordinates from (2000.4) to (2017 + 88/365) such way the solution is near WGS84 for the epoch of surveying.

- [X] Convert the proprietary m00 to RINEX 3.04 by using the tool provided by manufacturer (Leica Geosystems)
- mdb2rinex_x86_32_Linux_v5.6.29.zip (for Linux 32 bits)
- mdb2rinex_x86_64_Linux_v5.6.29.zip (for Linux 64 bits)
- mdb2rinex_x86_windows_v5.6.46.zip (for Windows)

- [X] Check epochs integrity and completeness

<!-- -->

::::::::::::::
P0010883.17O
::::::::::::::
```
     3.04           OBSERVATION DATA    M: MIXED            RINEX VERSION / TYPE
Mdb2Rinex 5.6.46W                       20170714 232753 UTC PGM / RUN BY / DATE
0001                                                        MARKER NAME
2672                                                        MARKER NUMBER
GEODETIC                                                    MARKER TYPE
                                                            OBSERVER / AGENCY
472672              LEICA GX1230GG      7.53/3.054          REC # / TYPE / VERS
                    LEIAX1202GG     NONE                    ANT # / TYPE
                                                            COMMENT
  3965001.0631 -4392463.8330 -2374512.5318                  COMMENT
  3965001.0789 -4392463.1685 -2374512.5743                  APPROX POSITION XYZ
        0.0670        0.0000        0.0000                  ANTENNA: DELTA H/E/N
G    8 C1C L1C D1C S1C C2W L2W D2W S2W                      SYS / # / OBS TYPES
DBHZ                                                        SIGNAL STRENGTH UNIT
    15.000                                                  INTERVAL
  2017    04    03    13    30   00.0000000     GPS         TIME OF FIRST OBS
  2017    04    03    13    31   00.0000000     GPS         TIME OF LAST OBS
     0                                                      RCV CLOCK OFFS APPL
G L1C                                                       SYS / PHASE SHIFT
G L2W                                                       SYS / PHASE SHIFT
    18    18  1929     7                                    LEAP SECONDS
                                                            END OF HEADER
> 2017 03 29 13 30  0.0000000  0  6
G18  21580149.100   113404476.73908      -599.805          48.250    21580149.480    88367107.26506      -599.804          41.250
G20  21026587.060   110495458.70007       292.644          46.750    21026586.820    86100356.04607       292.644          42.000
G21  20930429.220   109990153.12908      -128.714          50.250    20930429.020    85706599.73007      -128.713          44.750
G25  21131113.460   111044740.99308       444.814          49.500    21131116.860    86528375.12307       444.815          43.750
G26  23069799.480   121232626.33107      -537.775          45.500    23069803.300    94467019.45806      -537.773          38.750
G29  21125742.900   111016526.89708       -31.389          49.000    21125743.240    86506384.27305       -31.389          35.500
> 2017 03 29 13 31  0.0000000  0  6
G18  21544278.280   113215975.67908      -595.936          49.500    21544279.120    88220223.30606      -595.935          41.750
G20  21044325.080   110588673.45407       298.576          47.750    21044325.080    86172990.90607       298.575          43.500
G21  20922822.780   109950180.40708      -124.891          50.500    20922822.540    85675452.15307      -124.891          44.250
G25  21157979.040   111185919.67808       450.648          49.750    21157982.560    86638384.37707       450.649          44.000
G26  23037658.720   121063726.62407      -533.635          46.000    23037662.520    94335409.29706      -533.634          40.750
G29  21123920.040   111006948.94607       -29.353          47.000    21123920.020    86498920.90605       -29.351          34.750
```

::::::::::::::
P0050883.17O
::::::::::::::
```
     3.04           OBSERVATION DATA    M: MIXED            RINEX VERSION / TYPE
Mdb2Rinex 5.6.46W                       20170714 233015 UTC PGM / RUN BY / DATE
0002                                                        MARKER NAME
2682                                                        MARKER NUMBER
GEODETIC                                                    MARKER TYPE
                                                            OBSERVER / AGENCY
472682              LEICA GX1230GG      7.53/3.054          REC # / TYPE / VERS
                    LEIAX1202GG     NONE                    ANT # / TYPE
  3964449.5251 -4392492.9010 -2375390.5797         ORIGINAL COMMENT
  3964449.7863 -4392493.0497 -2375390.2159         APROX.   COMMENT
  3964449.8488 -4392493.0994 -2375390.2399                  APPROX POSITION XYZ
        0.0670        0.0000        0.0000                  ANTENNA: DELTA H/E/N
G    8 C1C L1C D1C S1C C2W L2W D2W S2W                      SYS / # / OBS TYPES
DBHZ                                                        SIGNAL STRENGTH UNIT
    15.000                                                  INTERVAL
  2017    04    03    13    30   00.0000000     GPS         TIME OF FIRST OBS
  2017    04    03    13    31   00.0000000     GPS         TIME OF LAST OBS
     0                                                      RCV CLOCK OFFS APPL
G L1C                                                       SYS / PHASE SHIFT
G L2W                                                       SYS / PHASE SHIFT
    18    18  1929     7                                    LEAP SECONDS
                                                            END OF HEADER
> 2017 03 29 13 30  0.0000000  0  6
G18  21580703.380   113407358.31408      -599.676          50.500    21580702.780    88369374.71207      -599.676          43.000
G20  21026489.640   110494945.27708       292.695          49.750    21026489.020    86099953.50007       292.696          45.000
G21  20929900.560   109987370.04108      -128.605          50.000    20929899.740    85704439.94707      -128.604          44.750
G25  21131711.760   111047886.17908       445.158          50.250    21131714.340    86530826.27107       445.160          45.750
G26  23068932.220   121228063.00507      -537.520          46.250    23068935.940    94463445.25306      -537.520          40.250
G29  21125457.620   111015025.46208       -31.079          50.750    21125457.740    86505214.57807       -31.078          45.250
> 2017 03 29 13 31  0.0000000  0  6
G18  21544824.940   113218815.60308      -596.125          50.250    21544824.300    88222458.32107      -596.124          42.750
G20  21044218.320   110588110.41908       298.356          49.750    21044217.920    86172549.67307       298.357          44.500
G21  20922286.960   109947360.03208      -125.090          50.250    20922286.140    85673263.26607      -125.090          44.250
G25  21158581.700   111189088.26208       450.639          49.750    21158584.340    86640853.72507       450.640          45.000
G26  23036793.220   121059170.83207      -533.676          45.500    23036796.840    94331840.96406      -533.675          41.500
G29  21123640.160   111005475.12108       -29.387          51.250    21123640.340    86497772.73607       -29.388          44.500
```

- [X] Check data processing by using RTKLib

- [X] From the real data set, create the vectors and matrices related to observations and covariance of error of observations

- [ ] Write all error equations

- [ ] Calculate the azimuth and elevation of each satellite for both sites

- [ ] Filter satellites in both sites according to the satellite elevation mask set
- [ ] Select those observations that are common between sites (base and rover) excluding those that are not
- [ ] Synchronize clock/observations (how to do it?)
- [ ] Interpolate observation to the same reception epoch in case receivers are not set to use clock steering to GPS time
- signals received at the same timestamp was transmitted in differente timestamp

- [ ] Calculate the numerical values for single differences (SD) from two sites and each satellite (prn_x_rovr - prn_x_base)

- [ ] Select the reference satellite to select the SD reference observation

- [ ] 

- [ ] 

- [ ] 
