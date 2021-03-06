function y=LI(p,variable,matrix,matrix2)
%this function find y in matrix2 by linear interpolation based on variable in matrix at pressure p
pt=[20 25 30 35 40 50];
n=min(find(p==pt));
X=matrix(n,:);
D=matrix2(n,:);
  
 A=find(variable==X);
 if (A>=1);
     E=D(A);
 else
     B=min(find(X>=variable));
     E=D(B-1)+((variable-X(B-1))*(D(B)-D(B-1))/(X(B)-X(B-1)));
 end
 
y=E; 
