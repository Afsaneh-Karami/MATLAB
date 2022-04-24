## Circulation ratio in water tube boiler:
I wrote this code in Matlab for the calculation of CR (circulation ratio) for the natural circulation of water in a water tube boiler. I mostly used articles and books by Viswanathan Ganapathy for the thermal equation I implemented in this code. The general idea for this code is that at first estimate an initial value for CR based on the boiler capacity and working pressure and then calculate thermal head and pressure losses in the system if they are equal your first estimation of CR would be correct, otherwise you should change it by the step +-.1 to reach an equivalent among thermal head and pressure drop. This is a trial and error procedure. I assumed the same CR for all tubes but in my new program written in C++, I calculated CR for each tube separately. The flowchart of thid program is available (GOTO [flowchart link](https://github.com/Afsaneh-Karami/MATLAB/blob/main/CR%20calculation%20in%20water%20tube%20boiler/Folder/CR%20flowchart.pdf)).<br /> 
The order of the program is the following:
1. Enter some information as input which are shown in the tabel:
 ![image](https://user-images.githubusercontent.com/78735911/164958801-67bcac91-16af-4e68-a731-cc5ddc144da2.png)
2. Some thermal properties of water for p=20,25,30,35,40,50 bar and T=100,120,140,160,180,200,220,260 like:
* enthalpy(h_L) 
* internal energy(E_L)
* dynamic viscosity(vis_L)
* density (den_l)
* saturated liquid specific volume(V_f)
* saturated steam specific volume(V_v)
* enthalpy of saturated water(h_f)
* enthalpy of saturated steam(h_v)



