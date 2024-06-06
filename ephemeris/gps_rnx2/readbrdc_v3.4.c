#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Constants
// Updated equations based on the paper
// https://www.gps.gov/technical/icwg/meetings/2019/09/GPS-SV-velocity-and-acceleration.pdf
/* Test ephemeris
     2.11           N: GPS NAV DATA                         RINEX VERSION / TYPE
teqc  2019Feb25                         20240312 20:24:12UTCPGM / RUN BY / DATE
                                                            END OF HEADER
11 18  1  7  0  0  0.0-7.332130335271D-04-1.136868377216D-12 0.000000000000D+00
    6.600000000000D+01-9.656250000000D+00 5.838457480903D-09-2.869547033889D+00
   -3.799796104431D-07 1.678675157018D-02 2.773478627205D-06 5.153754802704D+03
    0.000000000000D+00 1.993030309677D-07-6.579604085663D-01 1.732259988785D-07
    9.037827272297D-01 2.932187500000D+02 1.731296823119D+00-8.689290515257D-09
    7.893185925733D-11 1.000000000000D+00 1.983000000000D+03 0.000000000000D+00
    2.000000000000D+00 0.000000000000D+00-1.210719347000D-08 6.600000000000D+01
   -7.182000000000D+03 4.000000000000D+00

Results for tests
----------------------------------------------------------------------------------
GPST 7 Jan 2018 00:35:00.0
Position (m)              xk              yk              zk              RSS
Broadcast Nav       3166192:017   −21511945:818   −15899623:697    26936715:065
Precise Ephemeris   3166191:446   −21511947:161   −15899624:824    26936716:607
Velocity (m/s)            x_k             y_k             z_k             RSS
Broadcast Nav          1533:973749    −1209:904136     2000:871636     2796:503314
Precise Ephemeris      1533:973891    −1209:904144     2000:871617     2796:503382
Acceleration (m/s2)       x¨k             y¨k             z¨k             RSS
Broadcast Nav            −0:224186        0:100579        0:324295        0:406870
Precise Ephem. Poly.     −0:224188        0:100577        0:324296        0:406871
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
GPST 7 Jan 2018 01:50:00.0
Position (m)              xk              yk              zk              RSS
Broadcast Nav       7847635:362   −25169173:996    −4315772:358    26715137:871
Precise Ephemeris   7847635:584   −25169175:522    −4315773:249    26715139:518
Velocity (m/s)            x_k             y_k             z_k             RSS
Broadcast Nav           595:709009     −259:303963     2970:973426     3041:182478
Precise Ephemeris       595:708923     −259:304060     2970:973219     3041:182268
Acceleration (m/s2)       x¨k             y¨k             z¨k             RSS
Broadcast Nav            −0:160162        0:305506        0:090248        0:356554
Precise Ephem. Poly.     −0:160162        0:305506        0:090249        0:356554
----------------------------------------------------------------------------------
Source: Paper, pg.17 - Table 5. Benchmark test results.
Precise ephemeris interpolated by using 12th order Chebyshev polynomial (segment 3h)
*/


#define MU             3.986005E14               // Earth's gravitational constant
#define OMEGA_E_DOT    7.2921151467E-5           // Earth's rate rotation
#define RE             6378137.0                 // WGS84 Earth equatorial radius
#define J2             0.0010826262              // Oblate Earth gravity coefficient
#define SPEED_OF_LIGHT 299792458.0               // Speed of light in meters per second
#define PI             3.14159265358979323844
#define PI_GPS         3.1415926535898

#define MAX_LINE_LENGTH 200

typedef struct {
    int set;
    int prn;
    int toc_year;
    int toc_month;
    int toc_day;
    int toc_hour;
    int toc_minute;
    double toc_second;

    double af0;
    double af1;
    double af2;

    double iode;
    double crs;
    double dn;
    double m0;

    double cuc;
    double ecc;
    double cus;
    double sqrtA;

    double toe;
    double cic;
    double OMEGA;
    double cis;

    double i0;
    double crc;
    double omega;
    double OMEGADOT;

    double idot;
    double codesL2;
    double gpsw;
    double l2p;

    double svacc;
    double svhealth;
    double tgd;
    double iodc;

    double ttom;
    double fit;
    double spr1;
    double spr2;
} GPS_ephemeris;

void nop() {}

// Function to calculate Julian day number
int getJulianDay(int day, int month, int year) {
    int a, b, c, d, jd;

    if (month < 3) {
        year--;
        month += 12;
    }

    a = year / 100;
    b = a / 4;
    c = 2 - a + b;
    d = (int)(365.25 * (year + 4716));
    jd = d + (int)(30.6001 * (month + 1)) + day + c - 1524.5;

    return jd;
}

double ymd2jd(double year, double month, double day, double* gpsweek, double* dow) {
  double A, B, C, jd, mm, yyyy;
  yyyy = year;
  mm = month;
  if(mm < 3.0) {
    yyyy--;
    mm += 12;
  }
  A = floor(yyyy / 100.0);
  B = 2.0 - A + floor(A / 4.0);
  jd = floor(yyyy * 365.25) + floor(30.6001 * (mm + 1.0)) + day + B + 1720994.5;
  *gpsweek = floor((jd - 2444244.5) / 7.0);
  *dow = fmod(floor(jd - 2444244.5), 7.0);

  return jd;
}

int eph2pos(GPS_ephemeris *ephs, int prn, double t) {
  double F, X, Y, Z, dtrel, dtsv, dtsv_tgd;
  GPS_ephemeris *eph;
  eph = &ephs[prn];

  double gpsweek = 0.0;
  double dow = 0.0;
  double jd  = ymd2jd(eph->toc_year, eph->toc_month, eph->toc_day, &gpsweek, &dow);
  double toc = dow * 86400.0 + eph->toc_hour *3600.0 + eph->toc_minute *60.0 + eph->toc_second;

  //printf("jd: %.1f %04.0f %0.0f\n", jd, gpsweek, dow);

  double tk = t - eph->toe;
  if(fabs(tk < 7200.0)) {
    //printf("t < 7200.0 [%19.12E - %19.12E = %0.1f]s\n", t, eph->toe, fabs(tk));

    /* SV POSITION */
    double A = eph->sqrtA * eph->sqrtA;
    //double n0 = sqrt( ((MU/A)/A)/A );
    //double n  = sqrt(MU/(A*A*A)) + eph->dn;

    // Correct for week crossover
    if (tk > 302400.0) {
        tk -= 604800.0;
    } else if (tk < -302400.0) {
        tk += 604800.0;
    }

    //double mk = eph->m0 + ( sqrt(MU/(A*A*A)) + eph->dn) * tk;
    double n0 = sqrt(MU/A)/A;
    double n  = n0 + eph->dn;
    //double mk = eph->m0 + ( sqrt(MU/A)/A + eph->dn) * tk;
    double mk = eph->m0 + n * tk;

    // Iteratively solve for eccentric anomaly
    double ek = mk;
    /*
    double ek_old;
    while (1) {
        ek_old = ek;
        ek = mk + eph->ecc * sin(ek_old);
        if (fabs(ek - ek_old) < 1e-15) {
            break;
        }
    }
    */
    double ej[5];  /* Refined value, three iterations, (j = 1; 2; 3) Here are done 4*/
    ej[0] = mk;
    for(int i=1;i<5;i++){
      ej[i] = ej[i-1] + (mk - ej[i-1] + eph->ecc * sin(ej[i-1]) )/(1.0 - eph->ecc * cos(ej[i-1]));
    }
    ek = ej[3];
    double vk = 2.0 * atan( sqrt((1.0 + eph->ecc) / (1.0 - eph->ecc)) * tan(ek / 2.0) ); // True anomaly
    //double vk = atan2(sqrt(1.0 - pow(eph->ecc, 2)) * sin(ek), cos(ek) - eph->ecc); // True anomaly

    double phik = vk + eph->omega;

    double dsvk = sin(2.0 * phik);
    double dcvk = cos(2.0 * phik);

    double duk  = eph->cus * dsvk + eph->cuc * dcvk;
    double drk  = eph->crs * dsvk + eph->crc * dcvk;
    double dik  = eph->cis * dsvk + eph->cic * dcvk;

    double uk   = phik + duk;
    double rk   = A * (1.0 - eph->ecc * cos(ek)) + drk;
    double ik   = eph->i0 + dik + eph->idot * tk;

    // Satellite position in orbital plane
    double xk = rk * cos(uk);
    double yk = rk * sin(uk);

    // Satellite position in Earth-centered Earth-fixed coordinates
    double dt = fmod(tk, 86400.0); // Time of day in seconds

    double omegak = eph->OMEGA + (eph->OMEGADOT - OMEGA_E_DOT) * dt - OMEGA_E_DOT * eph->toe;

    X = xk * cos(omegak) - yk * cos(ik) * sin(omegak);
    Y = xk * sin(omegak) + yk * cos(ik) * cos(omegak);
    Z = yk * sin(ik);

    /* SV VELOCITY */
    double ekdot   = n / (1.0 - eph->ecc * cos(ek));
    double vkdot   = ekdot * sqrt(1.0 - (eph->ecc * eph->ecc)) / (1.0 - eph->ecc * cos(ek));
    double dikdt   =                      eph->idot + 2.0 * vkdot * (eph->cis * dcvk - eph->cic * dsvk);
    double ukdot   =                          vkdot + 2.0 * vkdot * (eph->cus * dcvk - eph->cuc * dsvk);
    double rkdot   = eph->ecc * A * ekdot * sin(ek) + 2.0 * vkdot * (eph->crs * dcvk - eph->crc * dsvk);
    double omgkdot = eph->OMEGADOT - OMEGA_E_DOT;
    double xkp     = rkdot * cos(uk) - rk * ukdot * sin(uk);
    double ykp     = rkdot * sin(uk) + rk * ukdot * cos(uk);

    double Xdot    = -xk * omgkdot * sin(omegak) + xkp * cos(omegak) - ykp * sin(omegak) * cos(ik) - yk*(omgkdot * cos(omegak) * cos(ik) - dikdt * sin(omegak) * sin(ik));
    double Ydot    =  xk * omgkdot * cos(omegak) + xkp * sin(omegak) + ykp * cos(omegak) * cos(ik) - yk*(omgkdot * sin(omegak) * cos(ik) + dikdt * cos(omegak) * sin(ik));
    double Zdot    =  yk * dikdt * cos(ik)       + ykp * sin(ik);

    /* SV ACCELERATION */
    double invrk   = 1.0 / rk;
    double tmp     = -(MU / rk) * invrk;
    double Xork    = X * invrk;
    double York    = Y * invrk;
    double Zork    = Z * invrk;
    double Zork2   = Zork * Zork;
    double O       = (3.0/2.0) * J2 * tmp * (RE * invrk) * (RE * invrk); /* F in the paper, replaced here per O to avoid confusion with other F */
    double Xddot   = tmp * Xork + O * (1.0 - 5.0*Zork2) * Xork + OMEGA_E_DOT * ( 2.0 * Ydot + X * OMEGA_E_DOT);
    double Yddot   = tmp * York + O * (1.0 - 5.0*Zork2) * York + OMEGA_E_DOT * (-2.0 * Xdot + Y * OMEGA_E_DOT);
    double Zddot   = tmp * Zork + O * (3.0 - 5.0*Zork2) * Zork;


    F = (-2.0 * sqrt(MU) / SPEED_OF_LIGHT) / SPEED_OF_LIGHT;
    dtrel = F * eph->ecc * eph->sqrtA * sin(ek);
    //printf("F: %20.12E  dtrel: %20.12E\n", F, dtrel);
    //printf("t: %20.12E toc: %20.12E t-toc: %20.12E\n", t, toc, t-toc);
    dtsv = eph->af0 + (eph->af1 + eph->af2 * (t - toc)) * (t - toc);
    /* printf("af0: %24.16E  af1: %24.16E  af2: %24.16E  t-toc: %24.16E  dtsv: %24.16E\n", eph->af0, eph->af1, eph->af2, (t - toc), dtsv); */
    dtsv = dtsv + dtrel;
    dtsv_tgd = dtsv - eph->tgd;
    /* printf("dtrel: %24.16E  tgd: %24.16E  dtsv_dtrel: %24.16E  dtsv_dtreltgd: %24.16E\n", dtrel, eph->tgd, dtsv, dtsv_tgd); */

    /*
    double X_sp3   =   5353731.739;
    double Y_sp3   =  18464148.803;
    double Z_sp3   = -18497514.598;
    double clk_sp3 =        -0.000373476369;
    */

    //printGPSeph(eph, 0);
    //printf("Warning: dow is hardcoded!\n");
    //printf("X   : %16.6f m\nY   : %16.6f m\nZ   : %16.6f m\nclk : %20.12E s\n", X, Y, Z, dtsv);
    //printf("dX  : %16.6f m\ndY  : %16.6f m\ndZ  : %16.6f m\ndclk: %20.12E s\n", X-X_sp3, Y-Y_sp3, Z-Z_sp3, dtsv-clk_sp3 );
    printf("PRN  YYYY mm dd HH MM SS.ssssssss       t                  X                Y                Z           t-toc                   dtsv                   dtsv_tgd                   Xdot           Ydot           Zdot          Xddot          Yddot          Zddot\n");
    printf("PG%02d %04d %02d %02d %02d %02d %11.8f %11.8f %16.6f %16.6f %16.6f %22.16f %22.16f %22.16f | %14.6f %14.6f %14.6f | %14.9f %14.9f %14.9f\n", \
            eph->prn, eph->toc_year, eph->toc_month, eph->toc_day, eph->toc_hour, eph->toc_minute, eph->toc_second, \
            t, X, Y, Z, t-toc, dtsv, dtsv_tgd, Xdot, Ydot, Zdot, Xddot, Yddot, Zddot);
    return 0;
  } else {
    printf("t > 7200.0 [%0.1f]s\n", fabs(t - eph->toe));
    return -1;
  }
}

char* replaceChar(char *str, char orig, char rep) {
    char *ix = str; int n = 0;
    while((ix = strchr(ix, orig)) != NULL) {
      *ix++ = rep;  n++; }
    return str;
}

char* extractField(char* line, int start, int finish, char* field) {
    int length = finish - start + 1;
    strncpy(field, line + start - 1, length); field[length] = '\0';
    return field;
}

void printGPSeph(const GPS_ephemeris *eph, int prn) {

  if(eph[prn].set == 0xFADE) {
    nop();
    /*
    */

    printf("%02d %04d %02d %02d %02d %02d %04.1f%19.12E%19.12E%19.12E\n", eph[prn].prn,
                                                                          eph[prn].toc_year, eph[prn].toc_month,  eph[prn].toc_day,
                                                                          eph[prn].toc_hour, eph[prn].toc_minute, eph[prn].toc_second,
                                                                eph[prn].af0,      eph[prn].af1,   eph[prn].af2      );
    printf("   %19.12E%19.12E%19.12E%19.12E\n", eph[prn].iode,  eph[prn].crs,      eph[prn].dn,    eph[prn].m0       );
    printf("   %19.12E%19.12E%19.12E%19.12E\n", eph[prn].cuc,   eph[prn].ecc,      eph[prn].cus,   eph[prn].sqrtA    );
    printf("   %19.12E%19.12E%19.12E%19.12E\n", eph[prn].toe,   eph[prn].cic,      eph[prn].OMEGA, eph[prn].cis      );
    printf("   %19.12E%19.12E%19.12E%19.12E\n", eph[prn].i0,    eph[prn].crc,      eph[prn].omega, eph[prn].OMEGADOT );
    printf("   %19.12E%19.12E%19.12E%19.12E\n", eph[prn].idot,  eph[prn].codesL2,  eph[prn].gpsw,  eph[prn].l2p      );
    printf("   %19.12E%19.12E%19.12E%19.12E\n", eph[prn].svacc, eph[prn].svhealth, eph[prn].tgd,   eph[prn].iodc     );
    printf("   %19.12E%19.12E\n",               eph[prn].ttom,  eph[prn].fit);
  } else {
    printf("PRN %02d not set.\n", prn);
  }
}

void parseEphemerisFile(char* filename, GPS_ephemeris* eph) {
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        printf("Failed to open file\n");
        return;
    }

    char line[MAX_LINE_LENGTH];
    int headerEnd = 0;

    int n, prn, year, month, day, hour, minute;
    double second, af0, af1, af2;
    double a, b, c, d;
    char work[14];

    //GPS_ephemeris eph[33];

    while (fgets(line, MAX_LINE_LENGTH, file) != NULL) {
        if (headerEnd) {
            n = strlen(line);
            // Process the content of the ephemeris data
            if(n>20) {
              replaceChar(line, 'D', 'E');
              //printf("%s", line);
              //sscanf(line, "%d %d %d %d %d %d %lf %lf %lf %lf", &prn, &year, &month, &day, &hour, &minute, &second, &af0, &af1, &af2);
              prn    = atoi(extractField(line,1,2,work));
              year   = atoi(extractField(line,4,5,work)); year += (year < 80)?2000:1900;
              month  = atoi(extractField(line,7,8,work));
              day    = atoi(extractField(line,10,11,work));
              hour   = atoi(extractField(line,13,14,work));
              minute = atoi(extractField(line,16,17,work));
              second = atof(extractField(line,19,22,work));

              sscanf(extractField(line,23,41,work), "%lf", &af0);
              sscanf(extractField(line,42,60,work), "%lf", &af1);
              sscanf(extractField(line,61,79,work), "%lf", &af2);

              eph[prn].set = 0xFADE;
              eph[prn].prn = prn;
              eph[prn].toc_year = year;
              eph[prn].toc_month = month;
              eph[prn].toc_day = day;
              eph[prn].toc_hour = hour;
              eph[prn].toc_minute = minute;
              eph[prn].toc_second = second;
              eph[prn].af0 = af0;
              eph[prn].af1 = af1;
              eph[prn].af2 = af2;
            }
            // line 2
            if(fgets(line, MAX_LINE_LENGTH, file)) {
              if(n>20) {
                //printf("%s", line);
                replaceChar(line, 'D', 'E');
                sscanf(extractField(line, 4,22,work), "%lf", &a);
                sscanf(extractField(line,23,41,work), "%lf", &b);
                sscanf(extractField(line,42,60,work), "%lf", &c);
                sscanf(extractField(line,61,79,work), "%lf", &d);
                eph[prn].iode = a;
                eph[prn].crs = b;
                eph[prn].dn = c;
                eph[prn].m0 = d;
              }
            }

            // line 3
            if(fgets(line, MAX_LINE_LENGTH, file)) {
              n = strlen(line);
              if(n>20) {
                //printf("%s", line);
                replaceChar(line, 'D', 'E');
                sscanf(extractField(line, 4,22,work), "%lf", &a);
                sscanf(extractField(line,23,41,work), "%lf", &b);
                sscanf(extractField(line,42,60,work), "%lf", &c);
                sscanf(extractField(line,61,79,work), "%lf", &d);
                eph[prn].cuc = a;
                eph[prn].ecc = b;
                eph[prn].cus = c;
                eph[prn].sqrtA = d;
              }
            }

            // line 4
            if(fgets(line, MAX_LINE_LENGTH, file)) {
              n = strlen(line);
              if(n>20) {
                //printf("%s", line);
                replaceChar(line, 'D', 'E');
                sscanf(extractField(line, 4,22,work), "%lf", &a);
                sscanf(extractField(line,23,41,work), "%lf", &b);
                sscanf(extractField(line,42,60,work), "%lf", &c);
                sscanf(extractField(line,61,79,work), "%lf", &d);
                eph[prn].toe = a;
                eph[prn].cic = b;
                eph[prn].OMEGA = c;
                eph[prn].cis = d;
              }
            }

            // line 5
            if(fgets(line, MAX_LINE_LENGTH, file)) {
              n = strlen(line);
              if(n>20) {
                //printf("%s", line);
                replaceChar(line, 'D', 'E');
                sscanf(extractField(line, 4,22,work), "%lf", &a);
                sscanf(extractField(line,23,41,work), "%lf", &b);
                sscanf(extractField(line,42,60,work), "%lf", &c);
                sscanf(extractField(line,61,79,work), "%lf", &d);
                eph[prn].i0 = a;
                eph[prn].crc = b;
                eph[prn].omega = c;
                eph[prn].OMEGADOT = d;
              }
            }

            // line 6
            if(fgets(line, MAX_LINE_LENGTH, file)) {
              n = strlen(line);
              if(n>20) {
                //printf("%s", line);
                replaceChar(line, 'D', 'E');
                sscanf(extractField(line, 4,22,work), "%lf", &a);
                sscanf(extractField(line,23,41,work), "%lf", &b);
                sscanf(extractField(line,42,60,work), "%lf", &c);
                sscanf(extractField(line,61,79,work), "%lf", &d);
                eph[prn].idot = a;
                eph[prn].codesL2 = b;
                eph[prn].gpsw = c;
                eph[prn].l2p = d;
              }
            }

            // line 7
            if(fgets(line, MAX_LINE_LENGTH, file)) {
              n = strlen(line);
              if(n>20) {
                //printf("%s", line);
                replaceChar(line, 'D', 'E');
                sscanf(extractField(line, 4,22,work), "%lf", &a);
                sscanf(extractField(line,23,41,work), "%lf", &b);
                sscanf(extractField(line,42,60,work), "%lf", &c);
                sscanf(extractField(line,61,79,work), "%lf", &d);
                eph[prn].svacc = a;
                eph[prn].svhealth = b;
                eph[prn].tgd = c;
                eph[prn].iodc = d;
              }
            }

            // line 8
            if(fgets(line, MAX_LINE_LENGTH, file)) {
              n = strlen(line);
              if(n>20) {
                //printf("%s", line);
                replaceChar(line, 'D', 'E');
                sscanf(extractField(line, 4,22,work), "%lf", &a);
                sscanf(extractField(line,23,41,work), "%lf", &b);
                eph[prn].ttom = a;
                eph[prn].fit = b;
                // eph[1].spr1 = c;
                // eph[1].spr2 = d;
              }
            }
        }
        else if (strncmp(line + 60, "END OF HEADER", 13) == 0) {
            headerEnd = 1;
        }
    }
    fprintf(stderr, "Header End: %d\n", headerEnd);

    // Get file size
    fseek(file, 0, SEEK_END);
    long fileSize = ftell(file);
    //fseek(file, 0, SEEK_SET);

    fclose(file);
    fprintf(stderr, "File Name: %s\n", filename);
    fprintf(stderr, "File Size: %ld bytes\n", fileSize);

}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        printf("Usage: %s <filename> <prn> <tr>\n", argv[0]);
        return 1;
    }

    char* filename = argv[1];
    GPS_ephemeris ephs[33];

    parseEphemerisFile(filename, ephs);
    int prn = atoi(argv[2]);
    double tr = atof(argv[3]);

    printGPSeph(ephs, prn);
    eph2pos(ephs, prn, tr);
    return 0;
}

// grep "^*\|^PG03" COD0OPSFIN_20230070000_01D_05M_ORB_GPS.SP3 | sed -e ':a;N;$!ba;s/\n/ /g' -e 's/\*/\n/g' -e 's/^\n//g' | awk '{printf("%4s %04d %02d %02d %02d %02d %11.8f %14.3f %14.3f %14.3f %16.12f\n", $7, $1, $2, $3, $4, $5, $6, $8*1000.0, $9*1000.0, $10*1000.0, $11/1000000.0)}'


/*
char* replaceChar(char* str, char find, char replace) {
    while (*str) {
        if (*str == find) {
            *str = replace;
        }
        str++;
    }
    return str;
}

void extractField(char* line, int start, int finish, char* field) {
    int length = finish - start + 1;
    strncpy(field, line + start - 1, length);
    field[length] = '\0';
}

*/
