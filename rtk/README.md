<!--
> [!NOTE]
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]
> Crucial information necessary for users to succeed.

> [!WARNING]
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.
-->

                    When faced with a problem you don't understand,
                    first do any part of it that you DO understand
                    and then look at it again.
                                           -- Robert Anson Heinlein
                                (from The Moon is A Harsh Mistress)
    Source: http://www.techhelpmanual.com/964-using_tech_help_.html
---

> [!IMPORTANT]
> To Do: Include equation to calculate the electronic distance atmospheric error compensation.


### Tasks

- [X] Select RINEX files for the RTK data processing experiment
- P0010883.17O (base)
- P0050883.17O (rovr)
- EESC0883.17N (GPS broadcast ephemeris)


Reference coordinates updated to 2017 + 88/365

$$
\begin{equation}
\mathbf{X_{P001}} = \begin{pmatrix}
\ \ \ 3965001.0759 \pm 0.0036 \\
-4392463.0651 \pm 0.0048 \\
-2374512.5496 \pm 0.0028 \\
\end{pmatrix}_{(m)}
\end{equation}
$$
<!-- 1   6   0.0026   0.0044   0.0023  -0.0030   0.0029  -0.0021   0.00  456.6 -->

$$
\begin{equation}
\mathbf{X_{P005}} = \begin{pmatrix}
\ \ \ 3964449.8316 \pm 0.0036 \\
-4392492.9754 \pm 0.0048 \\
-2375390.2131 \pm 0.0028 \\
\end{pmatrix}_{(m)}
\end{equation}
$$
<!--   1   7   0.0036   0.0048   0.0028  -0.0038   0.0033  -0.0027   0.00   56.6 -->

$$
\begin{equation}
\mathbf{X_{EESC}} = \begin{pmatrix}
\ \ \ 3967006.9982 \pm 0.00?? \\
-4390247.4550 \pm 0.00?? \\
-2375229.7383 \pm 0.00?? \\
\end{pmatrix}_{(m)}
\end{equation}
$$



> [!IMPORTANT]  
> Proof that the quality of broadcast ephemeris does not affect the solution of relative positioning.

In theory (Wells et al., 1986)

$$
\begin{equation}
\Delta b = \frac{b}{r} \Delta r
\end{equation}
$$

where:

- $b$ - baseline length
- $r$ - slope distance between antennas satellite-receiver
- $\Delta b$ - resulting error in the baseline
- $\Delta r$ - satellite position error

In the practice

Considering a precise ephemeris with a nominal position error equal to 1 cm and a baseline with 10 km. Consider 22000 km as approximated distance between antennas satellite-receiver. The resulting error in the baseline is about 1.8 mm.

```
Processing with broadcast ephemeris
./rtklib243b34/app/consapp/rnx2rtkp/gcc/rnx2rtkp -k brdc_P001_P005.conf -x 5 P0050883.17O P0010883.17O EESC0880.17N 2>/dev/null | grep ^2017
2017/03/29 13:30:00.000   3964449.8475  -4392493.0031  -2375390.2217   1   6   0.0147   0.0216   0.0118  -0.0171   0.0153  -0.0124   0.00    6.2
2017/03/29 13:31:00.000   3964449.8452  -4392492.9938  -2375390.2170   1   6   0.0105   0.0154   0.0084  -0.0122   0.0109  -0.0089   0.00    9.4

Processing with broadcast ephemeris + precise ephemeris (why both?)
./rtklib243b34/app/consapp/rnx2rtkp/gcc/rnx2rtkp -k prec_P001_P005.conf -x 5 P0050883.17O P0010883.17O EESC0880.17N igs19423.sp3 2>/dev/null | grep ^2017
2017/03/29 13:30:00.000   3964449.8485  -4392493.0043  -2375390.2223   1   6   0.0147   0.0216   0.0118  -0.0171   0.0153  -0.0124   0.00    6.3
2017/03/29 13:31:00.000   3964449.8457  -4392492.9945  -2375390.2174   1   6   0.0105   0.0154   0.0084  -0.0122   0.0109  -0.0089   0.00    9.5

```


- [X] Select TPS files for the topographic surveying

P001 to P005
- Horizontal direction: 
- Vertical angle: 
- Slope electronic distance: 
- Atmospheric parameters: 
- Topographic azimuth: 

 P005 to P001
- Horizontal direction: 
- Vertical angle: 
- Slope electronic distance: 
- Atmospheric parameters: 
- Topographic azimuth: 

```
Day 1:
		1700002,	"4",	29-03-2017/11:02:56.0,	22.000000,	913.276256,	0.130000;
		1700019,	"4-16",	2,	359.592270,	90.231880,	1036.850149,	1.500000,	29-03-2017/11:26:09.0,	37.083409,	100,	00000000;
		1700020,	"4-17",	2,	179.591720,	269.364500,	1036.849248,	1.500000,	29-03-2017/11:27:11.0,	37.083409,	100,	00000001;

Day 2:
		1700031,	"4-27",	3,	56.312980,	89.370830,	1036.850744,	1.500000,	03-04-2017/17:35:48.0,	41.323228,	100,	00000000;
		1700032,	"4-28",	3,	236.311300,	270.224360,	1036.850444,	1.500000,	03-04-2017/17:37:10.0,	41.323228,	100,	00000001;

Day 2: (no atm correction applied)
		1700034,	"4-29",	4,	56.312200,	89.372090,	1036.807000,	1.500000,	03-04-2017/17:38:33.0,	0.000000,	100,	00000000;
		1700035,	"4-30",	4,	236.311130,	270.224070,	1036.807800,	1.500000,	03-04-2017/17:39:38.0,	0.000000,	100,	00000001;
```

<!--

HEADER
	VERSION 1.20	
	SYSTEM	"0"
	UNITS
		ANGULAR DMS
		LINEAR  METRE
		TEMP    CELSIUS
		PRESS   HPA
		TIME    DMY
	END UNITS
	PROJECT
		NAME	"ERRO"
		OPERATOR	"CFG"
		CREATION_DATE	29-03-2017/11:02:56.0
	END PROJECT
END HEADER
DATABASE
	POINTS(PointNo, PointID, East, North, Elevation, Code, Date, CLASS)
		1700004,	"3", , , ,"",	29-03-2017/11:03:06.0	,	MEAS;
		1700009,	"3",	983.813127,	2006.366833,	796.032949,	"",	29-03-2017/11:17:48.0	,	MEAS;
		1700011,	"4-8",	983.813127,	2006.366833,	796.032949,	"",	29-03-2017/11:17:48.0	,	MEAS;
		1700012,	"4-9",	983.763950,	2006.367103,	796.088975,	"",	29-03-2017/11:19:33.0	,	MEAS;
		1700013,	"4-10",	983.698226,	2006.367537,	796.110060,	"",	29-03-2017/11:20:47.0	,	MEAS;
		1700014,	"4-11",	983.702239,	2006.366372,	796.024526,	"",	29-03-2017/11:21:47.0	,	MEAS;
		1700015,	"4-12",	983.651497,	2006.368627,	796.063970,	"",	29-03-2017/11:22:34.0	,	MEAS;
		1700016,	"4-13",	983.664605,	2006.368545,	796.021153,	"",	29-03-2017/11:23:35.0	,	MEAS;
		1700017,	"4-14",	983.710009,	2006.366811,	796.075552,	"",	29-03-2017/11:24:29.0	,	MEAS;
		1700018,	"4-15",	983.563021,	2006.367775,	796.073753,	"",	29-03-2017/11:25:20.0	,	MEAS;
		1700019,	"4-16",	983.623041,	2006.367667,	796.055647,	"",	29-03-2017/11:26:09.0	,	MEAS;
		1700020,	"4-17",	983.595191,	2006.366891,	796.075134,	"",	29-03-2017/11:27:11.0	,	MEAS;
		1700022,	"4-18",	1848.683725,	1541.382047,	809.945288,	"",	03-04-2017/17:21:48.0	,	MEAS;
		1700023,	"4-19",	1848.657382,	1541.422173,	809.907040,	"",	03-04-2017/17:24:08.0	,	MEAS;
		1700024,	"4-20",	1848.664124,	1541.412334,	810.010808,	"",	03-04-2017/17:25:52.0	,	MEAS;
		1700025,	"4-21",	1848.604377,	1541.502858,	809.952322,	"",	03-04-2017/17:27:09.0	,	MEAS;
		1700026,	"4-22", , , ,"",	03-04-2017/17:27:31.0	,	MEAS;
		1700027,	"4-23",	1848.649474,	1541.434658,	810.011835,	"",	03-04-2017/17:29:45.0	,	MEAS;
		1700028,	"4-24",	1848.620462,	1541.478492,	809.926346,	"",	03-04-2017/17:31:28.0	,	MEAS;
		1700029,	"4-25",	1848.650459,	1541.433828,	809.943592,	"",	03-04-2017/17:32:52.0	,	MEAS;
		1700030,	"4-26",	1848.627207,	1541.467922,	809.956601,	"",	03-04-2017/17:34:12.0	,	MEAS;
		1700031,	"4-27",	1848.654550,	1541.426620,	809.982405,	"",	03-04-2017/17:35:48.0	,	MEAS;
		1700032,	"4-28",	1848.607953,	1541.497035,	809.941861,	"",	03-04-2017/17:37:10.0	,	MEAS;
		1700034,	"4-29",	1848.596813,	1541.435407,	809.918450,	"",	03-04-2017/17:38:33.0	,	MEAS;
		1700035,	"4-30",	1848.567709,	1541.480757,	809.927255,	"",	03-04-2017/17:39:38.0	,	MEAS;
		1700002,	"4",	983.810176,	969.540319,	802.926953,	"",	29-03-2017/11:03:06.0	,	FIX;
		THEMINFO(PointNo, PointID, Attribute, Value)
		END THEMINFO
		ANNOTATIONS(PointNo, PointID, Annotation)
		END ANNOTATIONS
	END POINTS
END DATABASE
METEO
	ELEMENTS(StnNo, StnID, Date, DryTemp, AtmPress, RefCoeff)
		1700002,	"4",	29-03-2017/11:02:56.0,	22.000000,	913.276256,	0.130000;
	END ELEMENTS
END METEO
THEODOLITE
	INSTRUMENTS(Name, TheoNo, EDMNo, V_TYPE)
		"TCR403",	696310,	0,	ZENITH;
	END INSTRUMENTS
	CONFIGS(CfgNo, InstrName, Date, AddConst)
		1,	"TCR403",	29-03-2017/11:03:06.0,	0.000000;
		2,	"TCR403",	29-03-2017/11:17:48.0,	0.000000;
		3,	"TCR403",	03-04-2017/17:21:48.0,	0.000000;
		4,	"TCR403",	03-04-2017/17:38:33.0,	0.000000;
	END CONFIGS
	SETUP
		STN_NO	1700002
		STN_ID	"4"
		INST_HT	1.587000;
	END SETUP
	SLOPE(TgtNo, TgtID, CfgNo, Hz, Vz, SDist, RefHt, Date, Ppm, ApplType, Flags)
		1700004,	"3",	1,	233.251330,	92.352040,	0.000000,	1.500000,	29-03-2017/11:03:06.0,	36.885474,	107,	00000000;
		1700009,	"3",	2,	0.000050,	90.232330,	1036.849448,	1.500000,	29-03-2017/11:17:48.0,	37.083409,	100,	00000000;
		1700011,	"4-8",	2,	0.000050,	90.232330,	1036.849448,	1.500000,	29-03-2017/11:17:48.0,	37.083409,	100,	00000000;
		1700012,	"4-9",	2,	179.595080,	269.364770,	1036.849348,	1.500000,	29-03-2017/11:19:33.0,	37.083409,	100,	00000001;
		1700013,	"4-10",	2,	359.593770,	90.230800,	1036.849648,	1.500000,	29-03-2017/11:20:47.0,	37.083409,	100,	00000000;
		1700014,	"4-11",	2,	179.593850,	269.363490,	1036.849048,	1.500000,	29-03-2017/11:21:47.0,	37.083409,	100,	00000001;
		1700015,	"4-12",	2,	359.592840,	90.231710,	1036.851049,	1.500000,	29-03-2017/11:22:34.0,	37.083409,	100,	00000000;
		1700016,	"4-13",	2,	179.593100,	269.363420,	1036.851249,	1.500000,	29-03-2017/11:23:35.0,	37.083409,	100,	00000001;
		1700017,	"4-14",	2,	359.594000,	90.231480,	1036.849148,	1.500000,	29-03-2017/11:24:29.0,	37.083409,	100,	00000000;
		1700018,	"4-15",	2,	179.591080,	269.364470,	1036.850149,	1.500000,	29-03-2017/11:25:20.0,	37.083409,	100,	00000001;
		1700019,	"4-16",	2,	359.592270,	90.231880,	1036.850149,	1.500000,	29-03-2017/11:26:09.0,	37.083409,	100,	00000000;
		1700020,	"4-17",	2,	179.591720,	269.364500,	1036.849248,	1.500000,	29-03-2017/11:27:11.0,	37.083409,	100,	00000001;
		1700022,	"4-18",	3,	56.314040,	89.371560,	1036.850244,	1.500000,	03-04-2017/17:21:48.0,	41.323228,	100,	00000000;
		1700023,	"4-19",	3,	236.313090,	270.223660,	1036.850144,	1.500000,	03-04-2017/17:24:08.0,	41.323228,	100,	00000001;
		1700024,	"4-20",	3,	56.313320,	89.370260,	1036.851044,	1.500000,	03-04-2017/17:25:52.0,	41.323228,	100,	00000000;
		1700025,	"4-21",	3,	236.311170,	270.224570,	1036.850744,	1.500000,	03-04-2017/17:27:09.0,	41.323228,	100,	00000001;
		1700026,	"4-22",	3,	236.311500,	270.224630,	0.000000,	1.500000,	03-04-2017/17:27:31.0,	41.323228,	100,	00000001;
		1700027,	"4-23",	3,	56.312790,	89.370240,	1036.851144,	1.500000,	03-04-2017/17:29:45.0,	41.323228,	100,	00000000;
		1700028,	"4-24",	3,	236.311750,	270.224050,	1036.850544,	1.500000,	03-04-2017/17:31:28.0,	41.323228,	100,	00000001;
		1700029,	"4-25",	3,	56.312820,	89.371600,	1036.851044,	1.500000,	03-04-2017/17:32:52.0,	41.323228,	100,	00000000;
		1700030,	"4-26",	3,	236.312000,	270.224650,	1036.850544,	1.500000,	03-04-2017/17:34:12.0,	41.323228,	100,	00000001;
		1700031,	"4-27",	3,	56.312980,	89.370830,	1036.850744,	1.500000,	03-04-2017/17:35:48.0,	41.323228,	100,	00000000;
		1700032,	"4-28",	3,	236.311300,	270.224360,	1036.850444,	1.500000,	03-04-2017/17:37:10.0,	41.323228,	100,	00000001;
		1700034,	"4-29",	4,	56.312200,	89.372090,	1036.807000,	1.500000,	03-04-2017/17:38:33.0,	0.000000,	100,	00000000;
		1700035,	"4-30",	4,	236.311130,	270.224070,	1036.807800,	1.500000,	03-04-2017/17:39:38.0,	0.000000,	100,	00000001;
	END SLOPE
END THEODOLITE
-->

- [X] Provide good solution for the geodetic position of each point (P001 and P005)
- A small offset, based on the station velocity [VEMOS2017](https://www.sirgas.org/pt/velocity-model), is applied to the [CORS station position](https://geoftp.ibge.gov.br/informacoes_sobre_posicionamento_geodesico/rbmc/relatorio/Descritivo_EESC.pdf) (EESC0881.17O) to update its coordinates from (2000.4) to (2017 + 88/365) such way the solution is near WGS84 for the epoch of surveying.
```
EESC 2017 088
- cors :  3967006.9982 -4390247.4550 -2375229.7383

2017/03/29 13:30:00.000
- base :  3965001.0759  -4392463.0651  -2374512.5496   1   6   0.0026   0.0044   0.0023  -0.0030   0.0029  -0.0021   0.00  456.6
- rovr :  3964449.8214  -4392492.9641  -2375390.2063   1   7   0.0037   0.0053   0.0030  -0.0041   0.0036  -0.0029   0.00    4.9
```

- [X] Convert the proprietary m00 to RINEX 3.04 by using the tool provided by manufacturer (Leica Geosystems)
- mdb2rinex_x86_32_Linux_v5.6.29.zip (for Linux 32 bits)
- mdb2rinex_x86_64_Linux_v5.6.29.zip (for Linux 64 bits)
- mdb2rinex_x86_windows_v5.6.46.zip (for Windows)

- [X] Check epochs integrity and completeness of RINEX Observation and Navigation files (gfzrnx / rtkconv)

<!--
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

::::::::::::::
EESC0880.17N
::::::::::::::
```
     2.11           N: GPS NAV DATA                         RINEX VERSION / TYPE
teqc  2019Feb25                         20240217 00:34:12UTCPGM / RUN BY / DATE
    1.8229D-08  1.8402D-08 -3.2018D-07 -5.0209D-07          ION ALPHA
    1.1918D+05 -8.7102D+04 -1.9219D+06  8.0497D+06          ION BETA
    1.1176D-08  7.4506D-09 -5.9605D-08 -5.9605D-08          COMMENT
    9.0112D+04  1.6384D+04 -1.9661D+05 -6.5536D+04          COMMENT
   -9.313225746155D-10-2.664535259100D-15   405504     1942 DELTA-UTC: A0,A1,T,W
                                                            END OF HEADER
18 17  3 29 14  0  0.0 6.074612028897D-04 2.160049916711D-12 0.000000000000D+00
    9.600000000000D+01-7.050000000000D+01 5.573446442130D-09-1.307513476670D+00
   -3.287568688393D-06 1.786486792844D-02 9.048730134964D-06 5.153747499466D+03
    3.096000000000D+05 1.285225152969D-07-3.907825141860D-01 4.395842552185D-07
    9.257793697410D-01 1.845312500000D+02-1.820630291599D+00-8.628930858177D-09
   -5.582375385485D-10 1.000000000000D+00 1.942000000000D+03 0.000000000000D+00
    2.000000000000D+00 0.000000000000D+00-1.117587089539D-08 9.600000000000D+01
    3.024180000000D+05 4.000000000000D+00
20 17  3 29 14  0  0.0 4.660934209824D-04 1.591615728103D-12 0.000000000000D+00
    6.100000000000D+01-7.828125000000D+01 5.518086993330D-09 2.603916074436D+00
   -4.155561327934D-06 4.443777375855D-03 8.644536137581D-06 5.153651483536D+03
    3.096000000000D+05 8.754432201386D-08-4.421962595234D-01-3.911554813385D-08
    9.270796025524D-01 1.944375000000D+02 1.576712872214D+00-8.511425963627D-09
   -6.125255141463D-10 1.000000000000D+00 1.942000000000D+03 0.000000000000D+00
    2.000000000000D+00 0.000000000000D+00-8.381903171539D-09 6.100000000000D+01
    3.024180000000D+05 4.000000000000D+00
21 17  3 29 14  0  0.0-5.150497891009D-04 1.932676241267D-12 0.000000000000D+00
    7.500000000000D+01 2.868750000000D+01 5.695951544959D-09-4.060031512952D-01
    1.637265086174D-06 2.401689393446D-02 4.470348358154D-06 5.153699178696D+03
    3.096000000000D+05-2.905726432800D-07-1.431870545464D+00 2.309679985046D-07
    9.387304767038D-01 2.890000000000D+02-1.689981548618D+00-9.211097964917D-09
    4.475186409477D-10 1.000000000000D+00 1.942000000000D+03 0.000000000000D+00
    2.000000000000D+00 0.000000000000D+00-9.778887033463D-09 7.500000000000D+01
    3.085560000000D+05 4.000000000000D+00
25 17  3 29 14  0  0.0-3.607044927776D-04-6.707523425575D-12 0.000000000000D+00
    8.500000000000D+01-1.167812500000D+02 4.216247052185D-09-3.852217065560D-01
   -6.088986992836D-06 6.385402870364D-03 8.763745427132D-06 5.153613292694D+03
    3.096000000000D+05 5.774199962616D-08 2.796672730908D+00 1.136213541031D-07
    9.776435797393D-01 2.169687500000D+02 7.758697873481D-01-8.152125283026D-09
   -6.200258265644D-10 1.000000000000D+00 1.942000000000D+03 0.000000000000D+00
    2.000000000000D+00 0.000000000000D+00 5.587935447693D-09 8.500000000000D+01
    3.046860000000D+05 4.000000000000D+00
26 17  3 29 14  0  0.0-5.165822803974D-04 1.932676241267D-12 0.000000000000D+00
    7.400000000000D+01-1.170937500000D+02 4.479472302287D-09-9.313417558596D-01
   -6.085261702538D-06 1.806159736589D-03 8.175149559975D-06 5.153677631378D+03
    3.096000000000D+05 6.519258022308D-08 2.782302542206D+00-1.396983861923D-07
    9.594330482147D-01 2.232812500000D+02 2.183445609845D-02-8.171054642938D-09
   -5.893102614235D-10 1.000000000000D+00 1.942000000000D+03 0.000000000000D+00
    2.000000000000D+00 0.000000000000D+00 6.984919309616D-09 7.400000000000D+01
    3.024180000000D+05 4.000000000000D+00
29 17  3 29 14  0  0.0 6.167385727167D-04-2.955857780762D-12 0.000000000000D+00
    2.100000000000D+01 3.206250000000D+01 3.814087443480D-09-7.253886932479D-01
    1.683831214905D-06 7.111827144399D-04 1.289509236813D-05 5.153658159256D+03
    3.096000000000D+05 6.146728992462D-08-2.385589236704D+00-1.676380634308D-08
    9.805979793733D-01 1.414687500000D+02 2.870111853393D-02-7.684605808963D-09
    5.139499795082D-10 1.000000000000D+00 1.942000000000D+03 0.000000000000D+00
    2.000000000000D+00 0.000000000000D+00-1.024454832077D-08 2.100000000000D+01
    3.024180000000D+05 4.000000000000D+00
```
-->

- [X] Perform a preliminary data processing by using RTKLib [ PASSED ] :heavy_check_mark: [ NOERROR ] :x:  [ NOWARNING ] :heavy_exclamation_mark:

<!--
❌ :x:	❗ :heavy_exclamation_mark:	‼️ :bangbang:
⁉️ :interrobang:	⭕ :o:	✖️ :heavy_multiplication_x:
➕ :heavy_plus_sign:	➖ :heavy_minus_sign:	➗ :heavy_division_sign:
💮 :white_flower:	💯 :100:	✔️ :heavy_check_mark:
☑️ :ballot_box_with_check:	🔘 :radio_button:	🔗 :link:
-->



- [ ] Calculate satellite positions, velocities, acceleration and clock error on receiving time, azimuth, elevation, distance of each satellite for both sites for all epochs considering the approximated or the best position for each benchmark
```
for sat in 18 20 21 25 26  29; do ../readbrdc_v3.3.e EESC0880.17N ${sat} $(echo "" | awk '{printf("%0.14f\n", 309600-1800)}') 2>/dev/null| grep "^PG"; done
PG18 2017 03 29 14 00  0.00000000 307800.00000000   13572872.402  -22048193.152    5965634.971   0.000607509390 |     749.871884    -262.738352   -2985.184490 |   -0.254609878    0.241987569   -0.126811776
PG20 2017 03 29 14 00  0.00000000 307800.00000000   20604354.201   -7705376.019  -15030368.410   0.000466091660 |    -970.664729    1647.372332   -2196.826115 |   -0.084436797    0.262989019    0.316838677
PG21 2017 03 29 14 00  0.00000000 307800.00000000    4112993.542  -21351620.123  -14374815.170  -0.000515008752 |     887.306610    1786.551986   -2291.018876 |    0.189861346    0.237581571    0.323573056
PG25 2017 03 29 14 00  0.00000000 307800.00000000   19568947.933  -17561947.900    2630327.976  -0.000360689140 |     -69.601302     425.067992    3203.886955 |   -0.256711285    0.296168551   -0.056835604
PG26 2017 03 29 14 00  0.00000000 307800.00000000   -3190054.018  -17088378.212  -20058111.425  -0.000516588896 |    1835.350254   -1773.450410    1227.511963 |   -0.207620614    0.005649209    0.427559540
PG29 2017 03 29 14 00  0.00000000 307800.00000000   18130121.220   -7033058.596  -18075473.913   0.000616755498 |    2149.812969     803.335808    1847.068364 |   -0.172537258   -0.201153830    0.385012796

for sat in 18 20 21 25 26  29; do ../readbrdc_v3.3.e EESC0880.17N ${sat} $(echo "" | awk '{printf("%0.14f\n", 309600-1800+60)}') 2>/dev/null| grep "^PG"; done
PG18 2017 03 29 14 00  0.00000000 307860.00000000   13617407.189  -22063520.255    5786297.890   0.000607509524 |     734.633861    -248.138216   -2992.680659 |   -0.253326331    0.244674652   -0.123057442
PG20 2017 03 29 14 00  0.00000000 307860.00000000   20545964.292   -7606060.805  -15161606.014   0.000466091818 |    -975.633021    1663.126275   -2177.733275 |   -0.081182355    0.262134957    0.319578052
PG21 2017 03 29 14 00  0.00000000 307860.00000000    4166574.359  -21244001.341  -14511691.935  -0.000515009018 |     898.731688    1800.707545   -2271.507826 |    0.190966521    0.234261190    0.326787781
PG25 2017 03 29 14 00  0.00000000 307860.00000000   19564311.362  -17535909.599    2822456.395  -0.000360689645 |     -84.924734     442.893896    3200.352094 |   -0.254079015    0.298017844   -0.060993284
PG26 2017 03 29 14 00  0.00000000 307860.00000000   -3080307.740  -17194772.941  -19983692.032  -0.000516588794 |    1822.842133   -1773.005131    1253.118788 |   -0.209308023    0.009191867    0.425992638
PG29 2017 03 29 14 00  0.00000000 307860.00000000   18258797.145   -6985220.072  -17963958.199   0.000616755313 |    2139.346332     791.289305    1870.098411 |   -0.176357229   -0.200389077    0.382644363
```
> [!NOTE]
> 1. Source code to calculate GPS satellite positions and clock error is provided [here](https://github.com/gpoleszuk/gnss/blob/main/rtk/readbrdc_v0.3.3.c).
> 2. The positions presented before does not consider the Earth rotation effect (Sagnac). It consists only the instantaneous position at the reception timestamp.

- [ ] Calculate the satellite positions and clock in the transmission time instant.
```

```
- [ ] By using the pseudoranges to estimate the average of each GPS receiver clock, calculate the satellite positions and clock in the transmission time instant.
- [ ] Considering the approximate position for each site, calculate the satellite positions and clock in the transmission time instant.
- [ ] Calculate and apply the Sagnac effect for each satellite position, based on the each propagation time.

> [!TIP]
> The approximated value of the Earth's rotation rate is $\omega_E = 7.292\ 115\ 1467 \cdot 10^{-5}\ rad \cdot s^{-1}$
> Is it a iteartive process or a recursive process?
> The decrease/increase (?) of this rate according to COD19423.ERP.Z is about 7E-7 s/day


```
gzip -d --stdout COD19423.ERP.Z
VERSION 2
CODE'S 3-DAY FINAL SOLUTION FOR DAY 088, 2017                    03-APR-17 01:16
-------------------------------------------------------------------------------------------------------------------------------------------------
NUTATION MODEL       : IAU2000R06               SUBDAILY POLE MODEL: IERS2010
  MJD         X-P      Y-P   UT1UTC    LOD   S-X   S-Y  S-UT  S-LD  NR  NF  NT   X-RT   Y-RT  S-XR  S-YR C-XY C-XT C-YT   DPSI   DEPS  S-DP  S-DE
              E-6"     E-6"    E-7S E-7S/D   E-6"  E-6" E-7S E-7S/D                 E-6"/D      E-6"/D    E-2  E-2  E-2    E-6"   E-6"  E-6"  E-6"
57840.00     4904   372051  4779870  19890     7     7     1     4 274 166  55    436   1321     5     5   11    0    0      0      0     0     0
57840.50     5122   372712  4769925  19965     6     6     3     8 274 166  55    436   1321     8     8    7    7   -6      0      0     0     0
57841.00     5340   373372  4759942  20038     6     6     5     3 274 166  55     35   1651     4     4    9   -5    8      0      0     0     0
57841.50     5357   374198  4749923  19674     5     5     6     7 274 166  55     35   1651     7     7    6   -2    4      0      0     0     0
57842.00     5375   375024  4740087  18466     6     6     7     4 274 166  55   -552   1294     5     5    8   -3    3      0      0     0     0
57842.50     5099   375671  4730853  17788     6     6     9    10 274 166  55   -552   1294    10    10    6   -2    2      0      0     0     0
57843.00     4823   376318  4721959  17788     7     7    10    10 274 166  55   -552   1294    10    10    9   -3    8      0      0     0     0
```

- [X] From the real data set, create the vectors and matrices related to observations and covariance of error of observations

- [ ] Write all error equations (see the other post)

- [ ] Filter satellites in both sites according to the satellite elevation mask set
- [ ] Select those observations that are common between sites (base and rover) excluding those that are not
- [ ] Synchronize clock/observations (how to do it?)
- [ ] Interpolate observation to the same reception epoch in case receivers are not set to use clock steering to GPS time

> [!NOTE]
> Generally signals received at the same timestamp was transmitted in differente timestamp

- [ ] Calculate the numerical values for single differences (SD) from two sites and each satellite (prn_x_rovr - prn_x_base)

- [ ] Select the reference satellite to select the SD reference observation

- [ ] 

- [ ] 

- [ ] 


### Reference

Wells, Dave & Beck, N & Delikaraoglou, Demitris & Kleusberg, A & Krakiwsky, E.J. & Lachapelle, Gérard & Langley, R & Nakiboglu, M & Schwarz, K & Tranquilla, James & Vanicek, Petr. (1986). Guide to GPS Positioning. 10.13140/2.1.3771.4889. Available at <https://www.researchgate.net/publication/235652268_Guide_to_GPS_Positioning>. Accessed 04Apr2024.


---


### Draft tests

```textplain
EESC    3967006.9982  -4390247.4550  -2375229.7383
P001    3965001.0759  -4392463.0651  -2374512.5496   -21.9979283146   -47.9279747666   833.8832614139   
P005    3964449.8316  -4392492.9754  -2375390.2131   -22.0064506040   -47.9321311302   840.8250294896

             M                              N                             R0
P001   6344375.70679495371831316807   6381134.45983176182121657030   6362728.53803686717614938901
P005   6344382.29607975737909876964   6381136.66898517647556050505   6362732.94360017192874743900
AVG    6344379.00119460780061237545   6381135.56432727564343268975   6362730.74065641025702786798

```

```bash
echo "pi=4.0*a(1); g2r=pi/180.0; a=6378137.0; f=1.0/298.257223563; e2=f*(2.0-f); phi=-21.9979283146; phi=phi*g2r; sp=s(phi); sp2=sp*sp; nn=a/sqrt(1.0-e2*sp2); mm=nn*(1.0-e2)/(1.0-e2*sp2); rr=a*sqrt(1.0-e2)/(1.0-e2*sp2); rr=sqrt(mm)*sqrt(nn); mm; nn; rr" | bc -l
6344375.70679495371831316807
6381134.45983176182121657030
6362728.53803686717614938901

echo "pi=4.0*a(1); g2r=pi/180.0; a=6378137.0; f=1.0/298.257223563; e2=f*(2.0-f); phi=-22.0064506040; phi=phi*g2r; sp=s(phi); sp2=sp*sp; nn=a/sqrt(1.0-e2*sp2); mm=nn*(1.0-e2)/(1.0-e2*sp2); rr=a*sqrt(1.0-e2)/(1.0-e2*sp2); rr=sqrt(mm)*sqrt(nn); mm; nn; rr" | bc -l
6344382.29607975737909876964
6381136.66898517647556050505
6362732.94360017192874743900
```

```
UTM
P001   197672.267040272    7564507.074813491     -45.0       3951.274503538
P005   197260.949424616    7563554.648284928     -45.0       3958.348509651

               dX               dY               dZ
P001-P005    -551.244300       -29.910300      -877.663500
P005-P001     551.244300        29.910300       877.663500

                e                n                u                 s           HZ               ZA
P001-P005    -429.232170244   -943.806572980      6.857141368    1036.850097   204.4554843719    89.6210752884
P005-P001     429.257353354    943.793874705     -7.026394660    1036.850097    24.4570416564    90.3882777672
```


```bash
# Define variables to store point coordinates
E_P001=197672.267040272; N_P001=7564507.074813491;
E_P005=197260.949424616; N_P005=7563554.648284928;
```
#### Slope distance

##### By me:

Slope distances obtained by mean Electronic Distance Meters (EDM) are subject to atmospheric interference. Since the LASER beam propagates in a medium different of vacuum, the speedy of light is different from that value $c=299 792 458 m/s$ stablished considering a perfect medium of propagation (vacuum). Considering the low atmosphere composition different mathematical models are available and the documentation provided by manufacturer have to be read before to adopt different equations that relates the local atmosphere parameters and the scale factor that is calculated from them to correct the slope distance measured by EDM.

##### By AI (improved the English writing)

Measurements obtained by Electronic Distance Meters (EDM) to calculate slope distances may be influenced by atmospheric conditions. This is because the LASER beam used in EDM devices travels through a medium that is not a perfect vacuum, causing the speed of light to vary from the standard value of $c=299,792,458 m/s$. In order to account for this discrepancy, various mathematical models have been developed to adjust for atmospheric interference. It is crucial to consult the manufacturer's documentation which provides equations relating local atmospheric parameters to a scale factor, which is used to correct the slope distance measurements obtained by EDM devices.

Reference:
L. Wang, Y. K. Soh, G. K. H. Pang. "Modeling and Correction of Atmospheric Delay and Its Impact on the Accuracy of EDM Instruments in High-rise Buildings." Sensors 2019, 19, 2951.

##### Rewriting the paragraph
As distâncias obtidas com o emprego de Medidores Eletrônicos de Distância (EDM) (para determinar distâncias inclinadas) podem estar influenciadas pelas condições atmosféricas do meio de propagação da onda. Tal fato ocorre porque o feixe LASER ou MASER utilizado em dispositivos EDM (luz ou microondas) viaja através de um meio que não é um vácuo perfeito, fazendo com que a velocidade da luz varie do valor padrão estabelecido de $299792458 m/s$ para algo ligeiramente menor (contraditório, se o valor da distância obtida for menor, já que a distância se obtém pelo tempo de propagação). Para dar conta desta discrepância, vários modelos matemáticos foram desenvolvidos e propostos para remover esta interferência atmosférica levando-se em consideração alguns parâmetros que definem a composição do meio e as condições de pressão atmosférica e temperatura de bulbo seco e úmido (que leva em conta a presença da umidade na atmosfera local). Face a esta pluralidade de modelos, recomenda-se primeiro consultar a documentação oferecida pelo fabricante do equipamento para cada equipamento específico, pois geralmente fornece todas equações que relacionam os parâmetros atmosféricos locais, modo de medição (diferentes modos podem ser utilizados por um mesmo equipamento que, por exemplo, emprega um feixe com LASER. Diferentes comprimentos de onda na faixa do infravermelho ao visível podem ser escolhidos ou combinados) a um fator de escala, que é utilizado para corrigir as medidas de distância inclinada obtidas por tais dispositivos EDM.

Equations:

- Leica Geosystems:

$$
  \begin{equation}
  ppm(p,t,h,\lambda)_{red} = 286.34 - \left ( \frac{0.29525 \cdot p}{1 + \frac{t}{273.15}} - \frac{4.126 \cdot 10^{-4} \cdot h}{1 + \frac{t}{273.15}} \cdot 10^\left ( \frac{7.5 \cdot t}{237.3 + t} + 0.7857\right)  \right )
  \end{equation}
$$

Pressure mbar, air temperature in Celsius degrees, and relative humidity in %

Carrier wavelength: 658 nm and Index n: 1.0002863

Source: Leica-MS50-TS50-TM50-user-manual.pdf, pg.75, 805805-1.1.1en, 2013 [link](http://docs.onepointsurvey.com/pdf/Leica-MS50-TS50-TM50-user-manual.pdf)


```c
/*
********************************************************************************
* File: ppm.c
* Author: gpoleszuk
* Date: October 21, 2021
* Description: This program demonstrates the ppm function use.
********************************************************************************
*/
double calculate_ppm_red(double p, double t, double h);

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define LAMBDA 9.80665

/*
********************************************************************************
* Function: calculate_ppm_red
* Description: This function calculates the atmospheric ppm for Leica MS50 serie
* Parameters:
*     - p: the atmospheric pressure in hPa
*     - t: the atmospheric dry temperature in Celsius
*     - h: the relative humidity in %
* Returns: the atmospheric ppm factor
********************************************************************************
*/
double calculate_ppm_red(double p, double t, double h) {
    double b = 1.0 / (1.0 + t/273.15);
    return 286.34 - ((0.29525 * p * b) \
                  - ((4.126 * pow(10, -4) * h * b) \
                  * pow(10, (7.5 * t / (237.3 + t) + 0.7857))));
}

/*
********************************************************************************
* Function: main
* Description: This is the main function
* Parameters: none
* Returns: the return error code 0
********************************************************************************
*/
int main() {
    int i;
    double p, t, h, ppm_red;

    for (i = 1; i <= 10; i++) {
        // Randomizing values for p, t, and h
        p = (rand() / (double)RAND_MAX) * (1050.0 - 900.0) + 900.0;
        t = (rand() / (double)RAND_MAX) * (55.0 - (-20.0)) + (-20.0);
        h = (rand() / (double)RAND_MAX) * (100.0 - 0.0) + 0.0;

        ppm_red = calculate_ppm_red(p, t, h);
        printf("Scenario %d - p: %.2f, t: %.2f, h: %.2f, ppm_red: %.2f\n", i, p, t, h, ppm_red);
    }
    return 0;
}

/*
After compile this code with gcc -Wall ppm.c -o ppm.e -lm
gcc -Wall -Wextra -Wpedantic -O2 ppm.c -o ppm.e -lm

it generated the following random scenarios
Scenario  1 - p: 1026.03, t:  9.58, h: 78.31, ppm_red: -5.96
Scenario  2 - p: 1019.77, t: 48.37, h: 19.76, ppm_red: 31.34
Scenario  3 - p:  950.28, t: 37.62, h: 27.78, ppm_red: 40.38
Scenario  4 - p:  983.10, t: 15.80, h: 62.89, ppm_red: 12.40
Scenario  5 - p:  954.72, t: 18.51, h: 95.22, ppm_red: 23.13
Scenario  6 - p: 1037.43, t: 27.68, h: 71.73, ppm_red:  9.22
Scenario  7 - p:  921.24, t: 25.52, h:  1.63, ppm_red: 37.61
Scenario  8 - p:  936.43, t: -9.71, h: 80.42, ppm_red: -0.23
Scenario  9 - p:  923.50, t: 10.07, h: 12.98, ppm_red: 23.44
Scenario 10 - p:  916.32, t: 54.92, h: 21.83, ppm_red: 62.26


Scenario 1 - p: 1026.03, t:  9.58, h: 78.31, ppm_red: -5.96
Scenario 2 - p: 1019.77, t: 48.37, h: 19.76, ppm_red: 31.34
Scenario 3 - p:  950.28, t: 37.62, h: 27.78, ppm_red: 40.38
Scenario 4 - p:  983.10, t: 15.80, h: 62.89, ppm_red: 12.40
Scenario 5 - p:  954.72, t: 18.51, h: 95.22, ppm_red: 23.13
Scenario 6 - p: 1037.43, t: 27.68, h: 71.73, ppm_red:  9.22
Scenario 7 - p:  921.24, t: 25.52, h:  1.63, ppm_red: 37.61
Scenario 8 - p:  936.43, t: -9.71, h: 80.42, ppm_red: -0.23
Scenario 9 - p:  923.50, t: 10.07, h: 12.98, ppm_red: 23.44
Scenario 10 - p: 916.32, t: 54.92, h: 21.83, ppm_red: 62.26

*/


- Sokkia
$$
  \begin{equation}
  ppm(pres,temp,rh,\lambda) =  \cdots
  \end{equation}
$$
  
- Topcon Positioning
$$
  \begin{equation}
  ppm(pres,temp,rh,\lambda) = \cdots
  \end{equation}
$$

- Trimble Corporation
$$
  \begin{equation}
  ppm(pres,temp,rh,\lambda) =  \cdots
  \end{equation}
$$



#### Plane azimuth

```awk
echo ${E_P001} ${N_P001} ${E_P005} ${N_P005} | awk '
  function deg2dms(deg) {
    sig=1.0; if(deg<0.0) sig=-1.0;
    deg=sig*deg; ddd=int(deg);
    tmp=(deg-ddd)*60.0;
    mm=int(tmp); ss=(tmp-mm)*60.0;
    return sig*(ddd+(mm+ss/100.0)/100.0);
  }
  {
    pi=4.0*atan2(1,1); r2d=180.0/pi; r2s=3600.0*r2d;
    E1=$1; N1=$2; E2=$3; N2=$4; dE12=E2-E1; dN12=N2-N1;
    Az12=atan2(dE12,dN12); Az21=Az12-pi;
    if(Az12<0.0) Az12=Az12+2.0*pi;
    if(Az21<0.0) Az21=Az21+2.0*pi;
    printf("%18.14f %18.8f\n", r2d*Az12, deg2dms(Az12*r2d));
    printf("%18.14f %18.8f\n", r2d*Az21, deg2dms(Az21*r2d));
  }'
```

```plaintext
203.35772091648073       203.21277953
 23.35772091648077        23.21277953
```


#### Arc-to-chord reduction

According to "GS521 Geodetic Control Surveying: The Transverse Mercator Projection" published by
Department of Civil and Environmental Engineering and Geodetic Science: Geodetic and Geoinformation Science Section
and available at [TM_Notes.pdf](https://www.wollindina.com/images/HP-33S_PDF/TM_Notes.pdf) (161500 bytes)
the arc-to-chord reduction is calculated as follow
<!-- 0ec96eb321702cf20b63830b1e7e6b61 -->

<!--
$$
\begin{equation}
  \delta_{12} =  -\frac{(N_2 - N_1) \cdot (2E_{1}^{'} + E_{2}^{'})}{6.0 \cdot R_0^2} \cdot \left ( 1.0 - \frac{(2E_{1}^{'} + E_{2}^{'})^2}{27.0 \cdot R_0^2} \right)
\end{equation}
$$

$$
\begin{equation}
  \delta_{ij} =  -\frac{(N_j - N_i) \cdot (2E_{i}^{'} + E_{j}^{'})}{6.0 \cdot R_0^2} \cdot \left ( 1.0 - \frac{(2E_{i}^{'} + E_{j}^{'})^2}{27.0 \cdot R_0^2} \right)
\end{equation}
$$
-->

$$
\begin{equation}
  \delta_{ij} =  -\frac{(N_j - N_i) \cdot (2E_{i}^{'} + E_{j}^{'})}{6.0 \cdot M(a,f,\varphi) \cdot N(a,f,\varphi) } \cdot \left ( 1.0 - \frac{(2E_{i}^{'} + E_{j}^{'})^2}{27.0 \cdot M(a,f,\varphi) \cdot N(a,f,\varphi) } \right)
\end{equation}
$$

with:

$E_{.}^{'} = E_{.} - 500.000$ 

$M(a,f,\varphi) = a \cdot (1 - e^2) \cdot (1 - e^2 \cdot sin^2 \varphi)^{-\frac{3}{2}}$

$N(a,f,\varphi) = a \cdot (1 - e^2 \cdot sin^2 \varphi)^{-\frac{1}{2}}$




```awk
#P001-P005 and P005-P001
echo ${E_P001} ${N_P001} ${E_P005} ${N_P005} | awk '{
  pi=4.0*atan2(1,1);  r2d=180.0/pi;  r2s=3600.0*r2d;
  printf("Constants: %18.14f %18.14f %18.14f\n", pi, r2d, r2s);

  r0=6362730.7407;
  E1=$1; N1=$2; E2=$3; N2=$4; e1=E1-500000.0; e2=E2-500000.0;

  N2mN1=N2-N1; te1pe2=2.0*e1+e2;
  tmp1 = (te1pe2/r0);  cmp1=1.0-tmp1*tmp1/27.0;
  delta_12=-((N2mN1/r0)*tmp1/6.0)*cmp1;

  N1mN2=N1-N2; te2pe1=2.0*e2+e1;
  tmp2 = (te2pe1/r0);  cmp2=1.0-tmp2*tmp2/27.0;
  delta_21=-((N1mN2/r0)*tmp2/6.0)*cmp2;

  printf("delta_12 = %18.14f\" %18.14f\n", r2s*delta_12, cmp1);
  printf("delta_21 = %18.14f\" %18.14f\n", r2s*delta_21, cmp2);
}'
```

```plaintext
Constants:   3.14159265358979  57.29577951308232 206264.80624709636322
delta_12 =  -0.73330926034180"   0.99924674599999
delta_21 =   0.73364116444940"   0.99924606295231
```

Combining plane azimuth and geodetic azimuth considering the meridians convergency and arc-to-chord reduction

```bash
echo "(203.35772091648073-204.4554845160+3951.274503538/3600.0)*3600.0-(-0.73330926034180)" | bc -l
.05885452896979997200"

echo "(23.35772091648073-24.4570416644+3958.348509651/3600.0)*3600.0-(0.73364116444940)" | bc -l
.06017597717859998800"
```

Correcting the vertical angle for the effect of atmospheric refraction and earth curvature

```
               dX               dY               dZ                 s           HZ               ZA
P001-P005    -429.232170244   -943.806572980      6.857141368    1036.850097   204.4554843719    89.6210752884
P005-P001     429.257353354    943.793874705     -7.026394660    1036.850097    24.4570416564    90.3882777672

d_P001_P005 = sqrt( (-429.232170244)^2 + (-943.806572980)^2 ) = 1036.82742207786261130247 m
d_P001_P005 = sqrt( ( 429.257353354)^2 + ( 943.793874705)^2 ) = 1036.82628889277207306365 m

k_atmof = 1.0
R0_P001 = 6362728.53803686717614938901
R0_P005 = 6362732.94360017192874743900
R0_avg  = 6362730.74081851955244841400
ec = k * d / (2.0 * R0_avg) = .00008147660684636186 rad = 0.00466826570134324303 deg (16.80575652483567493535")
ec = k * d / (2.0 * R0_avg) = .00008147651779771776 rad = 0.00466826059923176451 deg (16.80573815723435224448")

P001-P005  =  89.6210752884 + 0.00466826570134324303 = 89.62574355410134324303 deg
P005-P001  =  90.3882777672 + 0.00466826059923176451 = 90.39294602779923176451 deg
```


#### P001 at same level of P005

```textplain
P005    3964449.8316  -4392492.9754  -2375390.2131   -22.0064506040   -47.9321311302   840.8250294896
P001X   3965005.3887  -4392467.8429  -2374515.1498   -21.9979283146   -47.9279747666   840.8250294899

                          e                n                u                s           az                z
From P001X to P005     -429.232174440   -943.806575908     -0.084626708   1036.827430   204.4554845160    90.0047
From P005  to P001X     429.257824460    943.794910159     -0.084626677   1036.827430    24.4570416644    90.0047
Diferença                  .025650020     -0.011665749     -0.169253385      0.000000    -5.6057342400"   16.8355"
                                                                                                         -16.8355"
R0(media P001 e P005) = 6362730.7407 m
In this case, the horizontal distances are practically the same
d15 = 1036.82742648025758874332 m
d51 = 1036.82742648049538162294 m

k_atmos = 1.0
ec = k * d / (2.0 * R0) = 16.8060"



```
