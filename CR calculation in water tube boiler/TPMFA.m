function [ R ] = TPMFA( Pressure,Quality,fname )
load(fname);

R = interp2(x,z,y,Pressure,Quality,'spline');

end

