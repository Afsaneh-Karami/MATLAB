## Circulation ratio in water tube boiler:
I wrote this code in Matlab for the calculation of CR (circulation ratio) for the natural circulation of water in a water tube boiler. I mostly used articles and books by Viswanathan Ganapathy for the thermal equation I implemented in this code. The general idea for this code is that at first estimate an initial value for CR based on the boiler capacity and working pressure and then calculate thermal head and pressure losses in the system if they are equal your first estimation of CR would be correct, otherwise you should change it by the step +-.1 to reach an equivalent among thermal head and pressure drop. This is a trial and error procedure. I assumed the same CR for all tubes but in my new program written in C++, I calculated CR for each tube separately. The flowchart of thid program is available (GOTO [flowchart link](https://github.com/Afsaneh-Karami/MATLAB/blob/main/CR%20calculation%20in%20water%20tube%20boiler/Folder/CR%20flowchart.pdf)).<br /> 
The order of the program is the following:
1. Enter some information as input which are shown in the tabel:
 ![image](https://user-images.githubusercontent.com/78735911/164958801-67bcac91-16af-4e68-a731-cc5ddc144da2.png)
2. Some thermal properties of water for p=20,25,30,35,40,50 bar and T=100,120,140,160,180,200,220,260 like by interpolation:
* enthalpy(h_L) 
* internal energy(E_L)
* dynamic viscosity(vis_L)
* density (den_l)
* saturated liquid specific volume(V_f)
* saturated steam specific volume(V_v)
* enthalpy of saturated water(h_f)
* enthalpy of saturated steam(h_v)
3. Calculation the max and min velocity in the riser tube based on Froude number to prevent stratifing of two phase
4. Calcaulation of enthalpy:
* enthalpy in riser tube based on steam quality
* enthalpyn of DrumInletWater based on tempreture of inlet water
Note:function "y=LI(p,variable,matrix,matrix2)" is used to find y in matrix2 by linear interpolation based on variable in matrix at pressure p <br /> 
* enthalpy in downcomer tube based on the balance of enthalpy in water drum 
5. After calcualtion of enthalpy in downcomer you can have tempreture of downcomer based on the enthalpy. This tempreture should be %8 lower than the saturated point at presure p.  
6. Calculation of density in downcomer based on tempreture (den_downcomer).
7. Calculation of viscosity in downcomer based on tempreture 
Note: we need it for the reynolds number in downcomer
8. Calculation of downcomer diameter based on the velocity, number of downcomer, and density.
9. Calculation of the min and max of the numer of riser tube to prevent DNB. the programm asked the user to enter a appropriate number of it.
Note: DNB is Abbreviation of Departure from Nucleate Boiling which can damage the boiler. All thr liquid in the riser tube evaporated and tempreture increased so much and can disturbe the tube.
10. Calculation of heat fluxe between riser tube and water in convection side to compare with critical heat fluxe that cause DNB 
11. Calculation of critical quality of steam caused DNB and compare with our steam quality
12. Calculation of pressure drop which include downcomer, drum, riser:
* Pressure drop in downcomer caused by friction
Note: at first calculate the reynolds number in downcomer, then based on moddy chart the friction is entered by the user. At last the pressure drop in downcomer was calculated.
* Pressure drop in riser caused by friction, gravity, and acceleration:<br />
First: Pressure drop caused by friction<br />
It is the same as pressure drop in downcomer but there is a coefficient r3 in the formula that can get from the Thom two-phase multiplication factors for friction chart which is based on pressure and steam quality. the picture of the graph is available (GOTO [Thom two-phase multiplication factors for friction link](https://github.com/Afsaneh-Karami/MATLAB/blob/main/CR%20calculation%20in%20water%20tube%20boiler/Folder/Thom%20two-phase%20multiplication%20factors%20for%20friction.jpg)). for more convinient access to this parameter (r3) I digitalize the graph by an online WebPlotDigitizer ( https://apps.automeris.io/wpd/) and load the result in MATLAB which can be called by TPMFA function ans some other properties. <br />
Second: Pressure drop caused by acceleration <br />
Slipping of liquid and vapor phases regarding each other causes this pressure loss. the same as befor r2 coeeficient obtain from the two_phase_multiplication_factors_acceleration by TPMFA function.<br />
Third: Pressure drop caused by gravity <br /> 
When the fluid flows upward inside the tube, it causes the gravity loss. In this eqaution the r4 coefficient comes from Two-phase_multiplication_factors_gravity chart.
13.Calculation of thermal head:




