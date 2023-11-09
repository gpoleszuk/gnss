clc; clear; format long E

function Kll = make_Kll(v)
  %sdxx(m^2)       sdyy(m^2)       sdzz(m^2)       sdxy(m^2)       sdyz(m^2)       sdzx(m^2)
  Kll = [v(1,1) v(1,4) v(1,6); v(1,4) v(1,2) v(1,5); v(1,6) v(1,5) v(1,3)];
endfunction

function printCorrelations (X, Kll, text)
  printf('\n');
  printf('Baseline: %s\n', text);
  printf('dX = (%14.4f +/- %7.4f) m    %15.8E %15.8E %15.8E     %7.1f\n',             X(1,1), sqrt(Kll(1,1)), Kll(1,1), Kll(1,2), Kll(1,3), 100.0);
  printf('dY = (%14.4f +/- %7.4f) m    %15.8E %15.8E %15.8E     %7.1f %7.1f\n',       X(2,1), sqrt(Kll(2,2)), Kll(2,1), Kll(2,2), Kll(2,3), 100.0 * Kll(2,1)/sqrt(Kll(2,2)*Kll(1,1)), 100.0 );
  printf('dZ = (%14.4f +/- %7.4f) m    %15.8E %15.8E %15.8E     %7.1f %7.1f %7.1f\n', X(3,1), sqrt(Kll(3,3)), Kll(3,1), Kll(3,2), Kll(3,3), 100.0 * Kll(3,1)/sqrt(Kll(3,3)*Kll(1,1)), 100.0 * Kll(3,2)/sqrt(Kll(3,3)*Kll(2,2)), 100.0 );
endfunction

d2r  = pi / 180.0;

s02  = 0.005^2;           % fator de variancia a priori arbitrado para se obter uma matriz P proxima a unidade
k    = 29.4345422;        % fator de relaxamento da matriz de covariancia das observacoes
k    = 12.9;              % fator de relaxamento da matriz de covariancia das observacoes
k    = 6.6575;            % fator de relaxamento da matriz de covariancia das observacoes
#k    = 1.0;
alfa = 0.05;
obs  = 18;
unk  =  6;
dof  = obs - unk;

% user data
% A SPC1 4007215.1075 -4306650.1936 -2458220.5598 0.005 0.005 0.003  TRM115000.00    NONE 0.0080 (Reference)
% B SPBP 4043683.2088 -4266290.4477 -2469479.8486 0.002 0.002 0.001  TRM57971.00     NONE 0.0080 (Reference)
% 1 SPS1 3960996.5157 -4310092.4421 -2525735.0089 0.002 0.003 0.002  LEIAR10         NONE 0.0000
% 2 POLI 4010099.5048 -4259927.3030 -2533538.7990 0.003 0.003 0.002  TRM57971.00     NONE 0.0500


XA   =  4007215.1075; sXA = 0.0050;
YA   = -4306650.1936; sYA = 0.0050;
ZA   = -2458220.5598; sZA = 0.0030;

XB   =  4043683.2088; sXB = 0.0020;
YB   = -4266290.4477; sYB = 0.0020;
ZB   = -2469479.8486; sZB = 0.0010;

X1_0 = 0.0000;  % Approximated values for coordinates of point 1
Y1_0 = 0.0000;
Z1_0 = 0.0000;

X2_0 = 0.0000;  % Approximated values for coordinates of point 2
Y2_0 = 0.0000;
Z2_0 = 0.0000;

%Experimento 2
%sps1 spc1  1A 2023/01/07 15:30:00.000    46218.611394     3442.261024    67514.461922  3.24381507E-05  3.06489568E-05  8.63078635E-06  2.69705075E-06  7.12244006E-06 -5.06092512E-06
%sps1 spbp  1B 2023/01/07 15:30:00.000    82686.714523    43801.999098    56255.196407  3.71460995E-05  3.80480483E-05  9.83443328E-06  2.48150708E-06  9.18647605E-06 -6.38517307E-06
%sps1 poli  12 2023/01/07 15:30:00.000    49103.012747    50165.158713    -7803.775996  3.21366540E-05  3.03152652E-05  8.54164921E-06  3.00003184E-06  7.36438479E-06 -5.47882968E-06
%poli sps1  21 2023/01/08 15:30:00.000   -49103.023432   -50165.148751     7803.783709  3.10314729E-05  2.95745631E-05  8.34135266E-06  2.21667432E-06  6.98137937E-06 -5.86889386E-06
%poli spc1  2A 2023/01/08 15:30:00.000    -2884.382438   -46722.885419    75318.227307  3.17220148E-05  2.98345364E-05  8.52511525E-06  1.71688609E-06  6.70141946E-06 -5.69862835E-06
%poli spbp  2B 2023/01/08 15:30:00.000    33583.679489    -6363.147623    64058.970535  3.65634274E-05  3.52388266E-05  9.74188944E-06  3.97667411E-06  8.35036609E-06 -5.87975203E-06
%spc1 sps1  A1 2023/01/06 15:30:00.000   -46218.670774    -3442.335404   -67514.486085  3.70392743E-05  3.40093081E-05  9.59723224E-06  3.62053367E-06  8.39011776E-06 -4.74594939E-06
%spc1 spbp  AB 2023/01/06 15:30:00.000    36468.088925    40359.746288   -11259.251281  3.58147190E-05  3.45915717E-05  9.67197560E-06  3.80780585E-06  8.23202172E-06 -6.80515917E-06
%spbp poli  B2 2023/01/06 15:30:00.000   -33583.693173     6363.133000   -64058.984942  3.88928097E-05  3.73340552E-05  1.02818988E-05  4.88998037E-06  8.97781369E-06 -5.83439870E-06

%Experimento 3
%from  to  bl       date         time      dx-ecef(m)      dy-ecef(m)      dz-ecef(m)       sdxx(m^2)       sdyy(m^2)       sdzz(m^2)       sdxy(m^2)       sdyz(m^2)       sdzx(m^2)
%---- ---- --- ---------- ------------ --------------- --------------- --------------- --------------- --------------- --------------- --------------- --------------- ---------------
%sps1 spc1  1A 2023/01/08 15:30:00.000    46218.644111     3442.258509    67514.448006  3.13848689E-05  2.97199426E-05  8.47205806E-06  1.85850509E-06  6.71872320E-06 -5.38815514E-06
%sps1 spbp  1B 2023/01/08 15:30:00.000    82686.693571    43802.006083    56255.190257  3.51841158E-05  3.45802803E-05  9.34745017E-06  3.92661966E-06  8.17616836E-06 -5.96434084E-06
%sps1 poli  12 2023/01/08 15:30:00.000    49103.023586    50165.149185    -7803.783632  3.10733779E-05  2.95262911E-05  8.35267801E-06  2.19176181E-06  6.97139532E-06 -5.90028390E-06
%poli sps1  21 2023/01/07 15:30:00.000   -49103.012403   -50165.158356     7803.775944  3.20720608E-05  3.03626347E-05  8.52932025E-06  3.00939226E-06  7.37725353E-06 -5.44671579E-06
%poli spc1  2A 2023/01/07 15:30:00.000    -2884.406960   -46722.894217    75318.234862  3.12436282E-05  2.95665150E-05  8.51326506E-06  1.41343565E-06  6.75896004E-06 -5.59970698E-06
%poli spbp  2B 2023/01/07 15:30:00.000    33583.692527    -6363.152559    64058.972483  3.48515484E-05  3.31463881E-05  9.75806396E-06  7.31555196E-07  8.11896638E-06 -6.43804353E-06
%spc1 sps1  A1 2023/01/06 15:30:00.000   -46218.670774    -3442.335404   -67514.486085  3.70392743E-05  3.40093081E-05  9.59723224E-06  3.62053367E-06  8.39011776E-06 -4.74594939E-06
%spc1 spbp  AB 2023/01/06 15:30:00.000    36468.088925    40359.746288   -11259.251281  3.58147190E-05  3.45915717E-05  9.67197560E-06  3.80780585E-06  8.23202172E-06 -6.80515917E-06
%spbp poli  B2 2023/01/06 15:30:00.000   -33583.693173     6363.133000   -64058.984942  3.88928097E-05  3.73340552E-05  1.02818988E-05  4.88998037E-06  8.97781369E-06 -5.83439870E-06


d1A = [  46218.644111     3442.258509    67514.448006 ]';
d1B = [  82686.693571    43802.006083    56255.190257 ]';
d12 = [  49103.023586    50165.149185    -7803.783632 ]';

d21 = [ -49103.012403   -50165.158356     7803.775944 ]';
d2A = [  -2884.406960   -46722.894217    75318.234862 ]';
d2B = [  33583.692527    -6363.152559    64058.972483 ]';

dA1 = [ -46218.670774    -3442.335404   -67514.486085 ]';
dAB = [  36468.088925    40359.746288   -11259.251281 ]';
dB2 = [ -33583.693173     6363.133000   -64058.984942 ]';

zero33 = [ 0 0 0; 0 0 0; 0 0 0 ];

lb = [ d1A(1,1); d1A(2,1); d1A(3,1)
       d1B(1,1); d1B(2,1); d1B(3,1)
       d12(1,1); d12(2,1); d12(3,1)
       d21(1,1); d21(2,1); d21(3,1)
       d2A(1,1); d2A(2,1); d2A(3,1)
       d2B(1,1); d2B(2,1); d2B(3,1)
     ];

Kll_1A = make_Kll([3.13848689E-05  2.97199426E-05  8.47205806E-06  1.85850509E-06  6.71872320E-06 -5.38815514E-06]);
Kll_1B = make_Kll([3.51841158E-05  3.45802803E-05  9.34745017E-06  3.92661966E-06  8.17616836E-06 -5.96434084E-06]);
Kll_12 = make_Kll([3.10733779E-05  2.95262911E-05  8.35267801E-06  2.19176181E-06  6.97139532E-06 -5.90028390E-06]);

Kll_21 = make_Kll([3.20720608E-05  3.03626347E-05  8.52932025E-06  3.00939226E-06  7.37725353E-06 -5.44671579E-06]);
Kll_2A = make_Kll([3.12436282E-05  2.95665150E-05  8.51326506E-06  1.41343565E-06  6.75896004E-06 -5.59970698E-06]);
Kll_2B = make_Kll([3.48515484E-05  3.31463881E-05  9.75806396E-06  7.31555196E-07  8.11896638E-06 -6.43804353E-06]);

Kll_A1 = make_Kll([3.70392743E-05  3.40093081E-05  9.59723224E-06  3.62053367E-06  8.39011776E-06 -4.74594939E-06]);
Kll_AB = make_Kll([3.58147190E-05  3.45915717E-05  9.67197560E-06  3.80780585E-06  8.23202172E-06 -6.80515917E-06]);
Kll_B2 = make_Kll([3.88928097E-05  3.73340552E-05  1.02818988E-05  4.88998037E-06  8.97781369E-06 -5.83439870E-06]);

Kll = [ Kll_1A zero33 zero33 zero33 zero33 zero33
        zero33 Kll_1B zero33 zero33 zero33 zero33
        zero33 zero33 Kll_12 zero33 zero33 zero33

        zero33 zero33 zero33 Kll_21 zero33 zero33
        zero33 zero33 zero33 zero33 Kll_2A zero33
        zero33 zero33 zero33 zero33 zero33 Kll_2B
      ];

printf('\n------\n');
printf('\n DADOS DO ENUNCIADO \n');
printf('\n------\n');

printCorrelations (d1A, Kll_1A, '1A')
printCorrelations (d1B, Kll_1B, '1B')
printCorrelations (d12, Kll_12, '12')

printCorrelations (d21, Kll_21, '21')
printCorrelations (d2A, Kll_2A, '2A')
printCorrelations (d2B, Kll_2B, '2B')


printf('\n------\n');
printf('\n MODELO MATEMATICO FUNCIONAL (PARA DEFINIR Kll, lb, l e A) \n');
printf('\n------\n');

printf('dX_1A = XA - X1\n');
printf('dY_1A = YA - Y1\n');
printf('dZ_1A = ZA - Z1\n');
printf('dX_1B = XB - X1\n');
printf('dY_1B = YB - Y1\n');
printf('dZ_1B = ZB - Z1\n');
printf('dX_12 = X2 - X1\n');
printf('dY_12 = Y2 - Y1\n');
printf('dZ_12 = Z2 - Z1\n');
printf('dX_21 = X1 - X2\n');
printf('dY_21 = Y1 - Y2\n');
printf('dZ_21 = Z1 - Z2\n');
printf('dX_2A = XA - X2\n');
printf('dY_2A = YA - Y2\n');
printf('dZ_2A = ZA - Z2\n');
printf('dX_2B = XB - X2\n');
printf('dY_2B = YB - Y2\n');
printf('dZ_2B = ZB - Z2\n');

printf('\n------\n');
printf('\n (CO)VARIANCIAS EXPANDIDAS (k = %.4f)\n', k);
printf('\n------\n');

printCorrelations (d1A, k*Kll_1A, '1A')
printCorrelations (d1B, k*Kll_1B, '1B')
printCorrelations (d12, k*Kll_12, '12')

printCorrelations (d21, k*Kll_21, '21')
printCorrelations (d2A, k*Kll_2A, '2A')
printCorrelations (d2B, k*Kll_2B, '2B')

A = [
      -1  0  0  0  0  0
       0 -1  0  0  0  0
       0  0 -1  0  0  0

      -1  0  0  0  0  0
       0 -1  0  0  0  0
       0  0 -1  0  0  0

      -1  0  0  1  0  0
       0 -1  0  0  1  0
       0  0 -1  0  0  1

       1  0  0 -1  0  0
       0  1  0  0 -1  0
       0  0  1  0  0 -1

       0  0  0 -1  0  0
       0  0  0  0 -1  0
       0  0  0  0  0 -1

       0  0  0 -1  0  0
       0  0  0  0 -1  0
       0  0  0  0  0 -1
    ];

x0   = [ X1_0; Y1_0; Z1_0; X2_0; Y2_0; Z2_0 ];

l0 = [ XA   - X1_0; YA   - Y1_0; ZA   - Z1_0
       XB   - X1_0; YB   - Y1_0; ZB   - Z1_0
       X2_0 - X1_0; Y2_0 - Y1_0; Z2_0 - Z1_0

       X1_0 - X2_0; Y1_0 - Y2_0; Z1_0 - Z2_0
       XA   - X2_0; YA   - Y2_0; ZA   - Z2_0
       XB   - X2_0; YB   - Y2_0; ZB   - Z2_0
     ];

l = lb - l0;



Kll  = k * Kll;
P    = s02 * inv(Kll);
Q    = inv(P);

N    = A' * P * A;
n    = A' * P * l;

Qxx  = inv(N);
Qla  = A * Qxx * A';
Qvv  = Q - Qla;

x    = Qxx * n;
v    = A * x - l;
s02p = v' * P * v / dof;

xa   = x0 + x;
la   = lb + v;

Kxx  = s02p * Qxx;
Kvv  = s02p * Qvv;
Kla  = s02p * Qla;


printf('\n------\n');
printf('\n TESTE ESTATISTICO \n');
printf('\n------\n');
chi_upper = chi2inv(1.0 - alfa/2, dof);
chi_lower = chi2inv(      alfa/2, dof);
chi_calc  = dof * s02p / s02;

printf('DoF: %d\n', dof);
printf('Chi2 Test: %14.9E < %14.9E < %14.9E\n', chi_lower, chi_calc, chi_upper);
if( (chi_calc >= chi_lower) && (chi_calc <= chi_upper) )
  printf('ChiSquare test: PASSED!\n')
else
  printf('ChiSquare test: FAILED!  ')
  if(chi_calc < chi_lower); printf('(Exceeded lower bound. Stdev of observations are very pessimistic)\n'); endif
  if(chi_calc > chi_upper); printf('(Exceeded upper bound. Stdev of observations are very optimistic)\n'); endif
endif
printf('s02  = %19.12E   (a priori)\ns02p = %19.12E   (a posteriori)\n', s02, s02p);
printf('s0p  = %19.12E\n', sqrt(s02p) );

printf('\n------\n');
printf('\n RESULTADOS FINAIS \n');
printf('\n------\n');

printf('\n------ xa = x0 + x\n');
for lines=1:size(xa)(1,1)
  printf('%16.4f m  +/- %7.2f mm\n', xa(lines,1), 1000.0 * sqrt(Kxx(lines,lines)) );
endfor

printf('\n------ la = lb + v\n');
for lines=1:size(Kla)(1,1)
  printf('%16.4f m  +/- %7.2f mm\n', la(lines,1), 1000.0 * sqrt(Kla(lines,lines)) );
endfor

%printf('\n------ v\n');
%for lines=1:size(Kvv)(1,1)
%  printf('%16.2f mm +/- %7.2f mm\n', 1000.0 * v(lines,1), 1000.0 * sqrt(Kvv(lines,lines)) );
%endfor


printf('--- ENDE ---\n');



printf('\n------\n');
printf('\n RESULTADOS PARCIAIS PARA CONFERENCIA \n');
printf('\n------ Constantes, vetores, matrizes e resultados detalhados\n');

printf('\n------ Kll = k * Kll  (k = %.4f)\n', k);
for lines=1:size(Kll)(1,1)
  for cols=1:size(Kll)(1,2)
    printf('%12.5E ', Kll(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ lb\n');
for lines=1:size(lb)(1,1)
  for cols=1:size(lb)(1,2)
    printf('%14.4f ', lb(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ l0 = aplicado valores aproximados nas equações de observação\n');
for lines=1:size(l0)(1,1)
  for cols=1:size(l0)(1,2)
    printf('%14.4f ', l0(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ l = lb - l0\n');
for lines=1:size(l)(1,1)
  for cols=1:size(l)(1,2)
    printf('%14.4f ', l(lines,cols) );
  endfor
  printf('\n');
endfor

%printf('\n------ diag(Kll)\n');
%for lines=1:size(diag(Kll))(1,1)
%  for cols=1:size(diag(Kll))(1,2)
%    printf('%18.10E ', diag(Kll)(lines,cols) );
%  endfor
%  printf('\n');
%endfor

printf('\n------ P = s02 * inv(Kll)\n');
for lines=1:size(P)(1,1)
  for cols=1:size(P)(1,2)
    printf('%12.5E ', P(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ s0^2 (fator de variância a priori)\n%18.10E\n', s02);

%printf('\n------ diag(P)  P = s0^2 * inv(Kll)\n');
%for lines=1:size(diag(P))(1,1)
%  for cols=1:size(diag(P))(1,2)
%    printf('%18.10E ', diag(P)(lines,cols) );
%  endfor
%  printf('\n');
%endfor

printf('\n------ x0\n');
for lines=1:size(x0)(1,1)
  for cols=1:size(x0)(1,2)
    printf('%14.4f ', x0(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ A\n');
for lines=1:size(A)(1,1)
  for cols=1:size(A)(1,2)
    printf('%6.0f ', A(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ N = A^T * P * A\n');
for lines=1:size(N)(1,1)
  for cols=1:size(N)(1,2)
    printf('%18.10E ', N(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ n = A^T * P * l\n');
for lines=1:size(n)(1,1)
  for cols=1:size(n)(1,2)
    printf('%18.10E ', n(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ x = Qxx * n (metros)\n');
for lines=1:size(x)(1,1)
  for cols=1:size(x)(1,2)
    printf('%18.10E ', x(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ xa = x0 + x (metros)\n');
for lines=1:size(xa)(1,1)
  for cols=1:size(xa)(1,2)
    printf('%18.10E ', xa(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ v = Ax - l (x1000 = milimetros)\n');
for lines=1:size(v)(1,1)
  for cols=1:size(v)(1,2)
    printf('%18.10f ', v(lines,cols)*1000.0 );
  endfor
  printf('\n');
endfor

printf('\n------ s0p^2 = v^T * P * v / dof   (fator de variância a posteriori)\n%18.10E\n', s02p);

printf('\n------ Qxx = inv(N)\n');
for lines=1:size(Qxx)(1,1)
  for cols=1:size(Qxx)(1,2)
    printf('%18.10E ', Qxx(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ Kxx = s0p^2 * Qxx\n');
for lines=1:size(Kxx)(1,1)
  for cols=1:size(Kxx)(1,2)
    printf('%18.10E ', Kxx(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ Kla = s0p^2 * A * Qxx * A^T\n');
for lines=1:size(Kla)(1,1)
  for cols=1:size(Kla)(1,2)
    printf('%12.5E ', Kla(lines,cols) );
  endfor
  printf('\n');
endfor

printf('\n------ Kvv = Kll - Kla\n');
for lines=1:size(Kvv)(1,1)
  for cols=1:size(Kvv)(1,2)
    printf('%12.5E ', Kvv(lines,cols) );
  endfor
  printf('\n');
endfor

printf('Parou aqui!!!!!\n')
pause
