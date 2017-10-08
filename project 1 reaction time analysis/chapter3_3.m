format long; %We want to be able to see short differences in time
i = 1; %Initializing the index, i
%t = [ ]; %Initializing the matrix in which we will store the times
t = zeros(100000,1);
while i < 100000 %Starting loop
tic %Starting stop-watch
i = i + 1; %Incrementing index
t(i,1) = toc ; %Ending stop-watch and putting respective time into the matrix
end % End the loop