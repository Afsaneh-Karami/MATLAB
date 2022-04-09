
%% Calculation of Cumbustion Gas Properties
function[Cp,K_mix,miu_mix,Pr_mix,Rho_mix,Exp_mix]=Gas_Properties(Tm,EAP)
 
Cp_CO2=1000*(0.81499093 + 0.00109923082*Tm - 0.0000011409298*Tm^2 + 7.11783202E-10*Tm^3 - 1.92316894E-13*Tm^4);                                            %"J/kg-K"
Cp_H2O=1000*(1.861756 + 0.000157589696*Tm + 0.00000130412231*Tm^2 - 1.24208050E-09*Tm^3 + 3.88939470E-13*Tm^4);
Cp_N2=1000*(1.04381543 - 0.000111582954*Tm + 9.33795037E-07*Tm^2 - 9.86059001E-10*Tm^3 + 3.32552135E-13*Tm^4);
Cp_O2=1000*(0.904916646 + 0.000295695614*Tm + 1.13876939E-07*Tm^2 - 3.54846584E-10*Tm^3 + 1.60382161E-13*Tm^4);

K_CO2=0.014557048 + 0.0000807209033*Tm - 5.54718270E-09*Tm^2 - 4.82341900E-12*Tm^3 - 2.99274106E-29*Tm^4;	                                               %"W/m-K"
K_H2O=0.0167130665 + 0.0000681904161*Tm + 7.94518284E-08*Tm^2 - 3.42980751E-11*Tm^3 + 6.17463428E-15*Tm^4;
K_N2=0.0238384874 + 0.0000745196816*Tm - 4.12011747E-08*Tm^2 + 2.22278300E-11*Tm^3 + 7.77274511E-29*Tm^4;
K_O2=0.024732155 + 0.000079011313*Tm - 8.45702252E-09*Tm^2 - 7.15249050E-12*Tm^3 + 3.84201440E-15*Tm^4;

miu_CO2=0.0000137507954 + 4.82820757E-08*Tm - 1.68310000E-11*Tm^2 + 3.77875400E-15*Tm^3 - 6.58547670E-32*Tm^4;	                                            %"kg/m-s"
miu_H2O=0.00000894988435 + 3.60799976E-08*Tm + 1.04325291E-11*Tm^2 - 1.03045548E-14*Tm^3 + 2.46346085E-18*Tm^4;
miu_N2=0.0000164037876 + 4.83187499E-08*Tm - 3.10279108E-11*Tm^2 + 1.50684216E-14*Tm^3 - 2.82637600E-18*Tm^4;
miu_O2=0.0000192629683 + 5.53188423E-08*Tm - 3.16100570E-11*Tm^2 + 1.97377782E-14*Tm^3 - 5.38195252E-18*Tm^4;

Pr_CO2=0.761990072 - 0.000252869712*Tm + 0.00000128966587*Tm^2 - 3.02390164E-09*Tm^3 + 3.59740704E-12*Tm^4 - 2.12765505E-15*Tm^5 + 5.00988775E-19*Tm^6;
Pr_H2O=1.00878468 - 0.000289080581*Tm + 2.33317742E-07*Tm^2 - 9.69658670E-11*Tm^3 + 8.13579564E-15*Tm^4;
Pr_N2=0.720956792 - 0.000254767719*Tm + 0.0000011183013*Tm^2 - 1.67861208E-09*Tm^3 + 1.06988558E-12*Tm^4 - 2.85520266E-16*Tm^5 + 1.18823787E-20*Tm^6;
Pr_O2=0.712028361 - 0.000174208138*Tm + 0.0000010675349*Tm^2 - 2.93306939E-09*Tm^3 + 3.92409337E-12*Tm^4 - 2.52586160E-15*Tm^5 + 6.28279365E-19*Tm^6;

Rho_CO2=1.86157253 - 0.00506532711*Tm + 0.00000822980227*Tm^2 - 6.69585548E-09*Tm^3 + 2.07905919E-12*Tm^4;	                                                %"kg/m3"
Rho_H2O=0.762056139 - 0.00207354995*Tm + 0.00000336896428*Tm^2 - 2.74102550E-09*Tm^3 + 8.51086808E-13*Tm^4;
Rho_N2=1.18491777 - 0.00322415379*Tm + 0.00000523838789*Tm^2 - 4.26200862E-09*Tm^3 + 1.32335117E-12*Tm^4;
Rho_O2=1.353521 - 0.00368292212*Tm + 0.00000598376376*Tm^2 - 4.86845443E-09*Tm^3 + 1.51165224E-12*Tm^4;

Exp_CO2=0.00351687047 - 0.00000956938237*Tm + 1.55476879E-08*Tm^2 - 1.26497657E-11*Tm^3 + 3.92774483E-15*Tm^4;	                                             %"1/K"
Exp_H2O=0.00351687047 - 0.00000956938237*Tm + 1.55476879E-08*Tm^2 - 1.26497657E-11*Tm^3 + 3.92774483E-15*Tm^4;
Exp_N2=0.00351687047 - 0.00000956938237*Tm + 1.55476879E-08*Tm^2 - 1.26497657E-11*Tm^3 + 3.92774483E-15*Tm^4;
Exp_O2=0.00351687047 - 0.00000956938237*Tm + 1.55476879E-08*Tm^2 - 1.26497657E-11*Tm^3 + 3.92774483E-15*Tm^4;

n_CO2=1.083;
n_H2O=2.083;
n_N2=2.124*(1+EAP/100)*3.76;
n_O2=2.124*EAP/100;
n_tot=n_CO2+n_H2O+n_N2+n_O2;

X_CO2=n_CO2/n_tot;
X_H2O=n_H2O/n_tot;
X_O2=n_O2/n_tot;
X_N2=n_N2/n_tot;

MW_CO2=44;
MW_H2O=18;
MW_O2=32;
MW_N2=28;

MW_mix=X_CO2*MW_CO2+X_H2O*MW_H2O+X_O2*MW_O2+X_N2*MW_N2;

Y_CO2=X_CO2*MW_CO2/MW_mix;
Y_H2O=X_H2O*MW_H2O/MW_mix;
Y_O2=X_O2*MW_O2/MW_mix;
Y_N2=X_N2*MW_N2/MW_mix;

Cp=Cp_CO2*Y_CO2+Cp_H2O*Y_H2O+Cp_O2*Y_O2+Cp_N2*Y_N2;
K_mix=K_CO2*Y_CO2+K_H2O*Y_H2O+K_O2*Y_O2+K_N2*Y_N2;
Rho_mix=Rho_CO2*Y_CO2+Rho_H2O*Y_H2O+Rho_O2*Y_O2+Rho_N2*Y_N2;
Pr_mix=Pr_CO2*Y_CO2+Pr_H2O*Y_H2O+Pr_O2*Y_O2+Pr_N2*Y_N2;
miu_mix=miu_CO2*Y_CO2+miu_H2O*Y_H2O+miu_O2*Y_O2+miu_N2*Y_N2;
Exp_mix=Exp_CO2*Y_CO2+Exp_H2O*Y_H2O+Exp_O2*Y_O2+Exp_N2*Y_N2;

end
