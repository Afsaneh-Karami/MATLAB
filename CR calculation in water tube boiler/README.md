## Circulation ratio in water tube boiler:
I wrote this code in Matlab for the calculation of CR (circulation ratio) for the natural circulation of water in a water tube boiler. I mostly used articles and books by Viswanathan Ganapathy for the thermal equation I implemented in this code. The general idea for this code is that at first estimate an initial value for CR based on the boiler capacity and working pressure and then calculate thermal head and pressure drop in the system if they are equal your first estimation of CR would be correct, otherwise you should change it by the step +-.1 to reach an equivalent among thermal head and pressure drop. I assumed the same CR for all tubes but in my new program written in C++, I calculated CR for each tube separately. 
The order of the program is the following:
1. 


