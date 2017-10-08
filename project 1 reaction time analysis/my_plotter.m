function [  ] = my_plotter(my_handle,z)
%  Not the best plotter v1.0 ( question 4)
%  give a 2D matrix plotting handle as a first argument,
%  the first column would be X values while the second is Y
%  second argument(z-axis) could be a matrix with suitable dimensions
%    example z: 
%  matgen2 = @(x) randi(x^2+5*x,x)
%  my_plotter(matgen2(10),matgen2(10))
%
% Note : hold on active as I understand from the question
x = my_handle(:,1);
y = my_handle(:,2);
surf(x,y,z)
hold on
end

