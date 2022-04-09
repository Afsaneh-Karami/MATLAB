
clc;
clear;
% Data input--------------------------------
T_gas_in=900;               %gas inlet temp (c)
superheater=0;              %0=false  , 1=true

% boiler input----------------------------
Boiler_capacity=30;         %(ton/hr)
p=40;                       %working pressure(bar)

% radiation section properties-------------------
a=2.4;                      %radiation section-diamention(m)-width
b=2.75;                    %radiation section-diamention(m)- height
c=6.5;                      %radiation section-diamention(m) - length
e_w=0.85;                   %wall emissivity
A_open=1*2.75;              %opening area beetween convection and radiation section (m^2)

% Fuel properties-------------------------- 
m_gas=9.4;                  %gasflow (kg/s)
p_w=0.1;                    %partial pressure of water(atm)
p_c=0.122;                  %partial pressure of co2(atm)

%tube pattern------------------------
d_out_riser=0.0508;         %riser tube outlet diameter (m)
d_in_riser=0.0444;           %riser tube inlet diameter (m)
t=3.2;                      %tube thickness (mm)
Num_riser=540;               %total num of riser
Num_riser_eachrow_1=10;       %num of riser/row-first Bundle
Num_riser_eachrow_2=13;     %num of riser/row-second Bundle 
Num_riser_eachrow_3=10;     %num of riser/row-third Bundle
Num_row_f=30;               %num of rows in first Bundle
Num_row_s=20;               %num of rows in second Bundle
Num_row_th=15;              %num of rows in third Bundle
L_riser=2.95;               %riser tube length (m)
s_T_1=120;                    %transverse pitch (mm)-first Bundle
s_L_1=80;                     %Longitudinal pitch (mm)-first Bundle
s_T_2=90;                   %transverse pitch (mm)-second Bundle
s_L_2=80;                   %Longitudinal pitch (mm)-second Bundle
s_T_3=120;                  %transverse pitch (mm)-third Bundle
s_L_3=80;                   %Longitudinal pitch (mm)-third Bundle

%calculation-------------------------
T_sat=XSteam('TSat_p',p);   %Saturated temp at p (c)
T_wall=T_sat+2*t+3+273;     % riser wall temp (k)
                                                            
%Gas outlet Temp(k) calculation--------  
T_gas_in_f=T_gas_in;                    %flame inlet temp (c) to convaction section
Num_row=Num_row_f;
Num_riser_eachrow=Num_riser_eachrow_1;
s_T=s_T_1;
s_L=s_L_1;
Q_T_R=0;
Q_T_D=0;
Q_T_radiation=0;

j=0;
while(j<(Num_row_f+Num_row_s+Num_row_th))
    i =1;

fprintf('\nrow\tT_gas_out(C)\th_c_o(w/m2.k)/\t\tQ_c(kw)\t\t\tQ_ROW(kw)\t\t\tQ_tube(kw)\n');
while ( i <= Num_row )                                                      %i=num of tubes in first bundle
    
[c_p_gas,k_gas,my_gas,Pr_mix,Rho_mix,Exp_mix]=Gas_Properties(T_gas_in,20);

A_gas_riser=3.14*d_out_riser*L_riser*Num_riser_eachrow ;                    %suraface area of tube/row subject to gas flow (m^2)
   
L_rr=1.7/(1/a+a/b+1/c);                                                     %beam length-radiation section(m)
k_r=(0.8+1.6*p_w)*(1-0.38*T_gas_in/1000)*(p_c+p_w)/sqrt((p_c+p_w)*L_rr);    % coefficient use for radiation calculation
e_g_r=(1-exp(-k_r*1*L_rr));                                                 %gas emissivity from radiation section
Q_rr=5.78*10^(-8)*e_g_r*e_w*A_open*((T_gas_in_f+273)^4-T_wall^4);           %radiant heat transfer escaping from radiation section (w)


L_N=1.08*(s_T*s_L/1000000-0.785*d_out_riser^2)/d_out_riser;                      %beam length-radiation in convection section(m)
k_N=(0.8+1.6*p_w)*(1-0.38*T_gas_in/1000)*(p_c+p_w)/sqrt((p_c+p_w)*L_N);          %coefficient used for radiation calculation
e_g_N=0.9*(1-exp(-k_N*1*L_N));                                                   %gas emissivity from gas flow
h_N=5.78*10^(-8)*e_g_N*((T_gas_in+273)^4-T_wall^4)/(T_gas_in+273-T_wall);        %radiant heat transfer coefficien from gas (w/m^k)

%h_c_o calculation-------------------------------
if j<Num_row_f
    B=0.084;
    N=0.72;
    G_g=m_gas/((Num_riser_eachrow-1)*(s_T/1000-d_out_riser)*L_riser);             %gas mass velocity(k/m2.s)
elseif j>=Num_row_f & j<Num_row_f+Num_row_s
   B=0.175;
   N=0.66;
  G_g=m_gas/((Num_riser_eachrow-1)*(s_T/1000-d_out_riser)*L_riser); 
else
     B=0.084;
    N=0.72;
    G_g=m_gas/((Num_riser_eachrow-1)*(s_T/1000-d_out_riser)*L_riser); 
end

Re_g=G_g*d_out_riser/my_gas;
pr_gas=my_gas*c_p_gas/k_gas;                                                    %my_gas=gas Viscosity (N.s/m^2) in inlet temp--k_gas=gas conductivity(w/m.k)                                                       
Nu_c_o=B*Re_g^N;                                                                %The outlet-Nusselt 
h_c_o=Nu_c_o*k_gas/d_out_riser;                                                 %The outlet convective heat transfer coefficient (w/m2.k)
h_o=1.1*(h_N+h_c_o);                                                            %The outlet  heat transfer coefficient (w/m2.k)+10% increase(radiation from other walls)

syms T_gas_out
T_gas_out = double(solve(h_o*A_gas_riser*(T_gas_in+273-T_wall)-m_gas*c_p_gas*(T_gas_in-T_gas_out)));                                         %gas outlet temp(c)
a=3.14*d_out_riser*0.5*1000/s_L-(d_out_riser*1000/s_L)*(asin(d_out_riser*1000/s_L)+sqrt((s_L/1000/d_out_riser)^2-1)-s_L/1000/d_out_riser);   %fraction fo energy absorbed from radiation section absorbed by each row

if superheater==0
     Fraction_r=0;
else
switch i
    case i==1
       Fraction_r=a;
    case i==2
        Fraction_r=(1-a)*a;
    case i==3
        Fraction_r=(1-(a+(1-a)*a))*a;
    case i==4
        Fraction_r=(1-(a+(1-a)*a+(1-(a+(1-a)*a))*a))*a;
    otherwise 
        Fraction_r=0;
end   
end
     
                                                         
Q_ROW=(m_gas*c_p_gas*(T_gas_in-T_gas_out)+Q_rr*Fraction_r)/1000;          %heat transfer to each row(kw)
Q_tube=Q_ROW/Num_riser_eachrow;                                           %heat transfer absorbed by one tube(kw)
Q_T_radiation=(Q_T_radiation+h_N*A_gas_riser*(T_gas_in+273-T_wall)/1000+Q_rr*Fraction_r/1000);

if j<(Num_row_f+Num_row_s)
    Q_T_R=Q_ROW+Q_T_R;
else
    Q_T_D=Q_T_D+Q_ROW;
    
end


fprintf('%g\t%g\t\t\t%g\t\t\t\t%g\t\t\t\t%g\t\t\t\t%g\n',i,T_gas_out,h_c_o,h_c_o*A_gas_riser*(T_gas_in+273-T_wall)/1000,Q_ROW,Q_tube);

T_gas_in=T_gas_out;
i = i+1;
j=j+1;
   
if j> Num_row-1 & j<(Num_row_s+Num_row_f)
   s_T=s_T_2;
   s_L=s_L_2;
   Num_riser_eachrow=Num_riser_eachrow_2;
   Num_row=Num_row_s;
elseif j> (Num_row_s+Num_row_f-1)                                           %down comer
   s_T=s_T_3;
   s_L=s_L_3;
   Num_riser_eachrow=Num_riser_eachrow_3;
   Num_row=Num_row_th;
   T_wall=T_sat-2*t+273;     % downcomer wall temp (k)
else
    
  continue
    
end

    
end
    

end

fprintf('\nQ_T_riser(kw)=\t%g\t\tQ_T_Downcomer(kw)=\t%g\t\tQ_T(kw)=%g\t\tradiation%%=%g\n',Q_T_R,Q_T_D,Q_T_R+Q_T_D,Q_T_radiation*100/(Q_T_R+Q_T_D));








 








