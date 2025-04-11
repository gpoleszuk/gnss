#### Dependencies:
```bash
# apt install python3-ephem
# apt install python3
```
#### Before to run:
- [ ] update the interested position in the source code lines 60 and 61;
- [ ] update the TLE file gps-ops.txt in the same folder. Please, see detailed instructions in the header of the Python script.
- [ ] remember: very old (about 1 year) TLE cannot generate good results (different and/or new satellites, etc.). Please, download updated TLE files from https://celestrak.org/NORAD/elements

#### How to run:
```bash
$ python3 Doppler_clean.py "2025-04-11 19:20:00.00000" 
```

<details>

  <summary>Command line and output sample</summary>

```txt
$ python3 Doppler_clean.py "2025-04-11 19:20:00.00000" 
/home/psr/bin/orbit/Doppler_clean.py:66: DeprecationWarning: datetime.datetime.utcnow() is deprecated and scheduled for removal in a future version. Use timezone-aware objects to represent datetimes in UTC: datetime.datetime.now(datetime.UTC).
  utcdate = datetime.datetime.utcnow()
PC UTC Time:  2025-04-11 07:32:12.399
Your Input :  2025-04-11 19:20:00
Input      :  2025-04-11 19:20:00.000
prn      doppler    distance    azimuth  elevation  flag
 01  -2416.24808    26334320    83.3509    -3.6896    
 02  -1915.16374    28376676    99.3687   -21.7154    
 03  -3574.85912    25042830    42.5245     6.0023  * 
 04   -424.43075    22979972    68.2851    28.7050  * 
 05   3402.00200    26397720   226.8121    -4.4672    
 06    565.50503    21141372   332.2589    54.6873  * 
 07    910.44251    26763756   136.0552   -10.2615    
 08  -2684.81250    29719030   136.2563   -33.3226    
 09   1354.15391    21915618   107.8013    41.3440  * 
 10   -434.50847    32550218    63.6648   -79.4643    
 11   1802.02925    22570970   293.5687    33.2437  * 
 12   1690.30041    23807850   309.8082    16.7745  * 
 13   2359.06349    28343448   205.6541   -20.8928    
 14  -3435.44223    24251820   183.5863    12.8317  * 
 15   1602.44727    30710488   226.6971   -40.7416    
 16    980.35807    31680152    77.8049   -58.4986    
 17  -1402.60454    21137690   126.0445    58.2316  * 
 18   1098.93452    31594060   241.4176   -55.0077    
 19    208.65436    19964968    49.0749    83.0126  * 
 20   2563.68400    23045362   239.0964    27.6764  * 
 22  -2861.40626    22958806   199.9216    28.5949  * 
 23   1224.32640    32324066   214.1033   -68.8311    
 24  -1830.72475    28192360   266.8662   -18.8563    
 25   2552.98180    26242638   331.3348    -6.5931    
 26   1908.53978    30900326    44.7469   -49.8199    
 27  -1477.33067    32107840   137.1354   -60.1080    
 28    -70.78931    27606032     5.2437   -15.8638    
 29   2677.76372    29986608   311.0026   -37.0338    
 30    334.98486    26703072   167.8657    -9.2070    
 31    718.58889    27356496    27.8054   -16.0925    
 32  -2476.36169    30498864   348.7854   -42.6893
 ```

</details>

ToDo:
- [ ] Document the output flag (it means visible in the provided site position)
- [ ] Solve deprecated synthax due Python 3 update
- [ ] Print detailed information in the output header
- [ ] Include information about rise or set for each satellite
- [X] Calculate information for any satellites (include extra infos in TLE file)
- [ ] Clean code and more detailed documentation

#### Acknowledgment
- Dr. T. S. Kelso: for provide and mantain the TLE service/website provider
- Brandon Rhodes: (https://pypi.org/user/brandonrhodes) ephem developer and mantainer
- Andrew Holme: (http://www.aholme.co.uk) [original](http://www.aholme.co.uk/GPS/SRC/2011/Python/Doppler.py) Python script developer
