
clc;
clear;
% Data input-------------------------
% boiler parameter
BoilerCapacity=30;  % ton/hr
p=40;               %working pressure (bar)

%CR parameter
CR=12;      %circulation ratio
p_cr=190;   %critical pressure_at this pressure we can not have natural circulation because density differential of saturated water and saturted steam is zero (bar)

%Inlet water to steam drum parameter
T_DrumInletWater=120; % temprature of inlet water in steam drum (0C)

% downcomer parameter
V_downcomer=1;       % velocity of water in downcomer tube (m/s)
n_downcomer=160;      % number of downcomer
L_downcomer=3.2;       % effective length (including bends) of the downcomer piping(m) 

% risertube parameter
D_OutRiserTube=51;  % outer diameter of riser tube (mm)
t_OutRiserTube=3.2;  % tickness of riser tube (mm)
U=30*10^-3;           % heat transfer coffecient(kj/m^2.s.0C)
T_gc=1000;            % tempreture of gas in convection part(oC)
L_RiserTube=3.6;        % the total lenght of riser tube (m)
H_RiserTube=3.1;        % the vertical height of riser tube (m)

% enthalpy(h_L), internal energy(E_L),dynamic viscosity(vis_L) and density (den_l)tabel--------------------------
% properties of water for p=20,25,30,35,40,50 bar and T=100,120,140,160,180,200,220,260
 
T_all=[100 120 140 160 180 200 220 240 260;100 120 140 160 180 200 220 240 260;100 120 140 160 180 200 220 240 260;100 120 140 160 180 200 220 240 260;100 120 140 160 180 200 220 240 260;100 120 140 160 180 200 220 240 260]; %(0C)
h_L=[420.59 505.08 590.22 676.28 763.56 852.45 2821.6 2877.2 2928.5;420.97 505.43 590.55 676.57 763.81 852.65 943.63 2852.3 2908.2;421.34 505.75 590.87 676.87 764.06 852.86 943.76 2824.5 2886.4;421.72 506.14 591.20 677.16 764.32 853.06 943.90 1037.6 2862.9;422.10 506.49 591.53 677.45 764.57 853.27 944.04 1037.6 2837.1;422.85 507.19 592.18 678.04 765.08 853.68 944.32 1037.7 1134.9]; %(kj/kg)
vis_L=10^-3*[0.282 0.232 0.197 0.170 0.15 0.134 0.122 0.111 0.102 ]; %(kg/m.s)
den_L=[959.24 944.01 927.02 908.27 887.67 865 9.7870 9.2165 8.7404 ;959.47 944.26 927.29 908.57 888 865.38 840.38 11.842 11.165;959.71 944.5 927.56 908.87 888.33 865.76 840.82 14.656 13.718;959.94 944.75 927.83 909.16 888.66 866.13 841.26 813.53 16.424;960.17 945.00 928.10 909.46 888.99 866.51 841.70 814.06 19.314; 960.63 945.49 928.63 910.05 889.65 867.26 842.58 815.10 784.03];   %(kg/m^3)

%saturated liquid specific volume(V_f), saturated steam specific volume(V_v),enthalpy of saturated water(h_f) and enthalpy of saturated steam(h_v)--------------------------
pt=[20 25 30 35 40 50];                                         %working pressure (bar)
V_f_t=[0.001177 0.001197 0.001217 0.001235 0.001252 0.001286];  %specific volume of steam at P bar (m^3/kg)
V_v_t=[0.09963 0.07998 0.06668 0.05707 0.04978 0.03944];        %specific volume of steam at P bar (m^3/kg)
h_f_t=[908.79 962.11 1008.42 1049.75 1087.31 1154.23];          %enthalpy of saturated water at p bar (kj/kg)
h_v_t=[2799.5 2803.1 2804.2 2803.4 2801.4 2794.3];              %enthalpy of saturated steam at p bar (kj/kg)
h_fv_t=[1890.7 1841.0 1795.7 1753.7 1714.1 1640.1];             %enthalpy of saturated steam at p bar (kj/kg)
V_LS_t=10^-3*[0.128 0.122 0.1132 0.109 0.106 0.1];              %dynamic viscosity of saturated liquid(kg/m.s)
V_GS_t=10^-5*[1.606 1.641 1.6978 1.721 1.749 1.887];            %dynamic viscosity of saturated steam(kg/m.s)
T_s_t=[212 224 234 242 250 264];                                %saturated tempreture at p bar(0C)

% calculation of V_f, V_v, h_v, h_f,V_LS,V_GS besed on p (bar)
if (find(p==pt)>=1)
k=find(p==pt);    
V_f=V_f_t(k);
V_v=V_v_t(k);
h_v=h_v_t(k);
h_f=h_f_t(k);
h_fv=h_fv_t(k);
V_LS=V_LS_t(k);
V_GS=V_GS_t(k);
else
k=min(find(p>pt));
V_f=V_f_t(k-1)+((V_f_t(k)- V_f_t(k-1))/(pt(k)-pt(k-1))*(p-pt(k-1)));
V_v=V_v_t(k-1)+((V_v_t(k)- V_v_t(k-1))/(pt(k)-pt(k-1))*(p-pt(k-1))); 
h_v=h_v_t(k-1)+((h_v_t(k)- h_v_t(k-1))/(pt(k)-pt(k-1))*(p-pt(k-1)));
h_f=h_f_t(k-1)+((h_f_t(k)- h_f_t(k-1))/(pt(k)-pt(k-1))*(p-pt(k-1)));
h_fv=h_fv_t(k-1)+((h_fv_t(k)- h_fv_t(k-1))/(pt(k)-pt(k-1))*(p-pt(k-1)));
V_LS=V_LS_t(k-1)+((V_LS_t(k)- V_LS_t(k-1))/(pt(k)-pt(k-1))*(p-pt(k-1)));
V_GS=V_GS_t(k-1)+((V_GS_t(k)- V_GS_t(k-1))/(pt(k)-pt(k-1))*(p-pt(k-1)));
end
%enternig the riser tube velocity based on Froude number to prevent
%stratifing of two phase-------------------
V_RiserTube_max=(9.8*(D_OutRiserTube-2*t_OutRiserTube)*10^-3)^0.5
V_RiserTube_min=0.538*(9.8*(D_OutRiserTube-2*t_OutRiserTube)*10^-3)^0.5

for ii=CR:-0.2:5
    CR=ii;
% calcaulation of enthalpy ----------------------------------    
m_water=CR*BoilerCapacity*1000/3600;  % mass of water in circulation (kg/s)
x_s=1/CR;   % steam quality

% calcaulation of enthalpy in riser tube-----------------------
h_RiserTube=x_s*h_v+(1-x_s)*h_f; %enthalpy in riser tube (kj/kg)

% calcaulation of tempreture and enthalpy and density and viscosity in downcomer tube-----------------------

%DrumInletWater enthalpy calculation based on tempreture of inlet water (kj/kg)
h_DrumInletWater=karami(p,T_DrumInletWater,T_all,h_L);

% tempreture calculation based on enthalpy 
h_downcomer=1/CR*(h_DrumInletWater+CR*h_RiserTube-h_v); %enthalpy in downcomer tube (kj/kg)

T_downcomer=karami(p,h_downcomer,h_L,T_all);
  
  if   (T_downcomer>=(T_s_t(k)-8)) % 8 degree lesser than saturated point at presure p
     display('it is near to saturated point. please change your parameter')
  end
  
 %density calculation based on tempreture
den_downcomer=karami(p,T_downcomer,T_all,den_L); 

 %viscosity calculation based on tempreture
 T=T_all(1,:);
 J=find(T==T_downcomer);
 if (J>=1);
     vis_downcomer=vis_L(J);
 else
    I=min(find(T>=T_downcomer)); 
     vis_downcomer=vis_L(I-1)+((T_downcomer-T(I-1))*(vis_L(I)-vis_L(I-1))/(T(I)-T(I-1)));
 end 

%  calculation of downcomer diameter -----------------------------------

 d_downcomer=(4/3.14*m_water/(V_downcomer*n_downcomer*den_downcomer))^0.5
 
% numer of riser tube to prevent DNB ---------------------
a=V_v/(V_f*(CR-1)+V_v);  % volumetric quality of steam
if (a>=0.7)
    display('void fraction is bigger than permitted value, please change parameters to decrease it to lower than 0.7')
end
den_RiserTube=(1-a)*(1/V_f)+a*(1/V_v); % density of two-phase mixture in riser tube
d_RiserTube=D_OutRiserTube-2*t_OutRiserTube; %(mm)
n_RiserTube_max=floor((4/3.14*m_water)/(V_RiserTube_min*(d_RiserTube*10^-3)^2*den_RiserTube));
n_RiserTube_min=floor((4/3.14*m_water)/(V_RiserTube_max*(d_RiserTube*10^-3)^2*den_RiserTube));
n_RiserTube=input(strcat('please enter your desire riser tube number which should be between ',num2str(n_RiserTube_min),'and',num2str(n_RiserTube_max),' : '));
V_RiserTube=(4/3.14*m_water)/(n_RiserTube*(d_RiserTube*10^-3)^2*den_RiserTube);

%calculation of heat fluxe between riser tube and water in convection side-----------------------------
q=U*(T_gc-T_s_t(k))*D_OutRiserTube/d_RiserTube % heat fluxe in riser tube (kw/m^2)

% calculation of critical quality of steam caused DNB-------------
RiserTube_MassFluxe=m_water/(n_RiserTube*3.14*((d_RiserTube*10^-3)^2)/4); %water fuxe in risser tube (kg/s.m^2)
x_Dryout=10*((1-p/p_cr)/((RiserTube_MassFluxe/10)^(1/3)))-0.7994*(q*(p_cr/p)^0.4*(d_RiserTube*10^-3)^0.4)/h_fv;
x_min=0.045+(0.048/(2.3+0.01*p))+x_Dryout; % maximum allowable quality of steam
display(strcat('the maximum allowable steam quality for prevent DNB is : ', num2str(x_min)))
if (x_min<=x_s*100)
    display('please increase CR')
end

%calculation of critical heat fluxe in riser tube----------------------
q_cr=172.7*h_fv*(d_RiserTube*10^-3)^(-0.1)*(RiserTube_MassFluxe/10^6)^0.51*(1-x_s)   %critical heat fluxe in riser tube (kw/m^2)
if (1.2*q>=q_cr)
    display('heat fluxe is high and DNB may be happen')
end
%calculation of pressure drop------------------------

%pressure drop in downcomer caused by friction--------------------
Re_downcomer=V_downcomer*d_downcomer*den_downcomer/vis_downcomer;
if (Re_downcomer<=2300)
    f=64/Re_downcomer;
else
    A = imread('Moody.png');
    image(A)
    f=input(strcat('plese enter Moody’s friction factor from picture based on e/D=',num2str(0.025*10^-3/d_downcomer),' and Re=' ,num2str(Re_downcomer),' :'));
end
% Downcomer_MassFlux=m_water/(n_downcomer*3.14*d_downcomer^2/4);    %water fuxe in downcomer tube (kg/s.m^2)
P_downcomer_f=(0.810865*f*L_downcomer*V_f*(m_water/n_downcomer)^2/(d_downcomer)^5); % (pa)

%pressure drop in riser tube caused by friction, acceleration and gravity
% friction loss-----------------------------------

vis_RiserTube=(x_s*V_GS+(1-x_s)*V_LS); %based two-phase flow Cicchitti model for viscosity
Re_RiserTube=V_RiserTube*(d_RiserTube/1000)*den_RiserTube/vis_RiserTube;
if (Re_RiserTube<=2300)
    f1=16/Re_RiserTube;
else
    A = imread('Moody.png');
    image(A)
    f1=input(strcat('plese enter Moody’s friction factor from picture based on e/D=',num2str(0.025/d_RiserTube),' and Re=' ,num2str(Re_RiserTube),' :'));
    f1=f1/4;
end
 Pressure=p*14.5;          % bar to PSI
 Quality=x_s*100;
fname = 'Two-phase_multiplication_factors_friction.mat';
r3=TPMFA( Pressure,Quality,fname );

Q_s=h_fv*(BoilerCapacity*1000/3600); % necessary absorbtion heat for producing steam (kW)
H_b=H_RiserTube*(BoilerCapacity*1000/3600)*CR*(h_f-h_downcomer)/Q_s   % The boiling height is the vertical distance that the mixture travels before the boiling process
P_RiserTube_f=2*V_f*f1*(H_RiserTube-H_b-0.3)*(RiserTube_MassFluxe)^2*r3/(d_RiserTube/1000);  % (pa)

Pressure=p*14.5;          % bar to PSI
Quality=x_s*100;
fname = 'two_phase_multiplication_factors_acceleration.mat';
r2=TPMFA( Pressure,Quality,fname );
P_RiserTube_a=V_f*(RiserTube_MassFluxe)^2*r2;   % (pa)

% gravity loss------------------------------------

Pressure=p*14.5;          % bar to PSI
Quality=x_s*100;
fname = 'Two-phase_multiplication_factors_gravity.mat';
r4=TPMFA( Pressure,Quality,fname );
P_RiserTube_g=9.8*(H_RiserTube-H_b-0.3)*r4/V_f;   % (pa)

P_RiserTube=P_RiserTube_g+P_RiserTube_a+P_RiserTube_f ;

%Losses in drum internals   ----------------------------------------------------------
P_drum=2000; %(pa) 

% Thermal Head--------------------------------------------

TTH=9.8*H_RiserTube*(den_downcomer-((den_downcomer+den_RiserTube)/2)); %(pa)
P_total=P_downcomer_f+P_RiserTube+P_drum;

 TTH
 P_total
 P_RiserTube_a
 P_RiserTube_f
 P_RiserTube_g
 P_downcomer_f

if (TTH>=P_total)
    display(strcat('CR = ',num2str(CR)));
    break
end
end

display(strcat('Downcomer tube friction loss = ',num2str(P_downcomer_f)))
display(strcat('Riser tube friction loss = ',num2str(P_RiserTube_f)))
display(strcat('Riser tube acceleration loss = ',num2str(P_RiserTube_a)))
display(strcat('Riser tube gravity loss = ',num2str(P_RiserTube_g)))
display(strcat('Riser tube loss = ',num2str(P_RiserTube)))
display(strcat('Drum internal loss = ',num2str(P_drum)))
display(strcat('total pressure loss = ',num2str(P_total)))
display(strcat('TTH = ',num2str(TTH)))
%evaluate stability of mixed flow in riser tube----------------------
x_e=(1-V_f/V_v)/((1/a)-1+V_f/V_v);  %stability factor    
if (x_e>=11)
    display('instability of flow in riser tube')
end

