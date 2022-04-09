clear,clc
format compact
format long


minX = 200.0;
maxX = 3000.0;
M = 100;
dx = (maxX-minX)/M;

[num,txt,raw] = xlsread('Thom two-phase multiplication factors .xlsx','gravity');

row = length(num);

for i = 1:row
    k = 1;
    clearvars X Y
    for j = 1:size(txt,1)
        
        if (isempty(txt{j,i}) == 0)
            data{k} = txt{j,i};
            spl = strsplit(data{k},',');
            X(k) = str2num(spl{1});
            Y(k) = str2num(spl{2});
            k = k+1;
        end
    end
           
    [xData, yData] = prepareCurveData( X, Y );
    ft = fittype( 'power2' );
    opts = fitoptions( ft );
    opts.Display = 'Off';
    opts.Lower = [-Inf -Inf -Inf];
    opts.StartPoint = [0.011738339773575 0.520584250326946 0.00930900487501242];
    opts.Upper = [Inf Inf Inf];
    [fitresult{i}, gof] = fit( xData, yData, ft, opts );
    
end

for i = 1:row
    for j = 1:M+1
        x(i,j) = minX+(j-1)*dx;
        y(i,j) = fitresult{i}(x(i,j));
        z(i,j) = num(i);
    end
end

interp2(x,z,y,400,15,'spline')
 save ('Two-phase_multiplication_factors_gravity.mat','x', 'y', 'z', 'fitresult')





















