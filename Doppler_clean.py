#      Original source downloaded from:
#                http://www.aholme.co.uk/GPS/SRC/2011/Python/Doppler.py
#
# ---------------------------------------------------------------------
#                                                         :: STEP  1 ::
#      Before to run this script:
#        - remember to update the gps-ops.txt TLE file on the same
#          script's folder
#        - you can donwload the latest gps-ops.txt with the wget
#          command line:
#            wget -O- "https://celestrak.org/NORAD/elements/gp.php?GROUP=gps-ops&FORMAT=tle" > gps-ops.txt
#
# or
#
# wget --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:104.0) Gecko/20100101 Firefox/104.0" \
#      --dns-timeout=3 --retry-connrefused --connect-timeout=3 --read-timeout=1 \
#      --tries=2 --waitretry=3 --timeout=3 --max-redirect=1 --limit-rate=2k \
#      --no-netrc --no-cache --referer="https://celestrak.org" \
#      --progress=dot:default --show-progress --backups=10 \
#      --output-file=- \
#      --output-document=gps-ops.txt https://celestrak.org/NORAD/elements/gp.php?GROUP=gps-ops&FORMAT=tle"
#
#         - to get the latest TLE for all gnss satellites, use the
#           following address
#             https://celestrak.org/NORAD/elements/gp.php?GROUP=gnss&FORMAT=tle"
#         - different epochs? Check celestrak.org for more information
# ---------------------------------------------------------------------
#                                                         :: STEP  2 ::
#      How to use this script.
#      Command line example:
#
#        python Doppler.py "2022-08-06 12:25:30.14680"
# ---------------------------------------------------------------------
#                                                         :: METAINF ::
#
#      Last Update: 2022Sep28 by GPSR 215522Z
#######################################################################




#######################################################################
#                                            :: IMPORT PYTHON LIBRARIES
# Note: Maybe you can install ephem since it is not a default library
#       by invoking pip install ephem
#######################################################################
import sys
import ephem
import datetime
#from datetime import datetime


#######################################################################
#                                                      :: USER LOCATION
#      Set here your approximated location
# Note: It is necessary to calculate the satellite's azimuth/elevation
#######################################################################

cb = ephem.Observer()   # cb = Position of your place
cb.long = '-51.41'     # .lon in later versions
cb.lat  = '32.11'
cb.elevation = 845.00
utcdate = datetime.datetime.utcnow()
#cb.date = utcdate



#######################################################################
#datetime_str = '2022-08-06 12:25:30.14680'
#datetime_str = sys.stdin.readline()
datetime_str = sys.argv[1]
datetime_object = datetime.datetime.strptime(datetime_str, '%Y-%m-%d %H:%M:%S.%f')

#print(type(datetime_object))
print ("PC UTC Time: ", utcdate.strftime('%Y-%m-%d %H:%M:%S.%f')[:-3])
print ("Your Input : ", datetime_object)   # printed in default format
print ("Input      : ", datetime_object.strftime('%Y-%m-%d %H:%M:%S.%f')[:-3])

cb.date = datetime_object


#######################################################################
#                                                           :: SETTINGS
#      Define some settings and load external information from tle file
#######################################################################
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

pi   = 3.1515926535897
r2g  = 180.0/pi

f    = open("gps-ops.txt")   #  For details, read the script's preamble
                             #  Get this from http://celestrak.com/GPS/
data = []

#######################################################################
#                                                               :: CORE
#      Populate the item vector with azim/elev for each satellite found
# in the TLE gps-ops.txt file.
#######################################################################
print (bcolors.HEADER + "prn      doppler    distance    azimuth  elevation  flag")
while True:
    line1 = f.readline()
    line2 = f.readline()
    line3 = f.readline()
    if not line1: break  # EOF
    sv = ephem.readtle(line1, line2, line3)
    sv.compute(cb)
    item = line1[17:19], -sv.range_velocity / 299792458  * 1575.42e6, sv.range, line1, sv.az, sv.alt
    data.append(item)
data.sort()

#######################################################################
#                                                             :: REPORT
#      Prepare results and print the calculated values in a report
#######################################################################
for s in data:
    prn, doppler, range, line1, az, el = s
#    datetime.utcnow().strftime("%Y%m%d")
    azim = az * r2g
    elev = el * r2g
    if elev >= 0.0:
        print (bcolors.OKGREEN, prn, ("{:12.5f}".format(doppler)), "  ", ("{:7.0f}".format(range)), " ", ("{:8.4f}".format(azim)), " ", ("{:8.4f}".format(elev)), " * ")
    if elev < -1.0:
        print (bcolors.OKBLUE,  prn, ("{:12.5f}".format(doppler)), "  ", ("{:7.0f}".format(range)), " ", ("{:8.4f}".format(azim)), " ", ("{:8.4f}".format(elev)), "   ")
    if (elev >= -2.0) & (elev < 0.0):
        print (bcolors.WARNING, prn, ("{:12.5f}".format(doppler)), "  ", ("{:7.0f}".format(range)), " ", ("{:8.4f}".format(azim)), " ", ("{:8.4f}".format(elev)), "   ")
#    if elev > -5 :
#        print prn, ("{:12.5f}".format(doppler)), "  ", ("{:12.3f}".format(range)), " ", ("{:10.5f}".format(azim)), " ", ("{:10.5f}".format(elev)), " * "
#    else:
#        print prn, repr(int(round(doppler))).rjust(7), "  ", int(range/1e3+0.5), " ", ("{:7.2f}".format(azim)), " ", ("{:7.2f}".format(elev)), "   "
#######################################################################
#                                                   :: THAT'S ALL FOLKS
#######################################################################
#MD5SUM : 01d64d3e5c310c24fb7c3e392183828b  Doppler_clean.py
#SHASUM : 25ef0f0d2e5a6730fd5a22a1cc92cd3536baa4ad  Doppler_clean.py
