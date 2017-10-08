format long;
i = 1;
vals = [];
while i<30
a = check_halfsec;
i = i+1;
append(vals,a);
end

function [ output_args ] = chalfs( )

format long
s = 1;
while s<30
tic %Start stopwatch
pause ( 0.5 ) %Take a 0.5(?) second break
toc %End stop-watch
s = s+1;
end

end