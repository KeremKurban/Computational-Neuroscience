%% Matlab for Neuroscientist Ch:13 Neural Data Analysis:Encoding

%% Raster Plot
load Chap13_Spike
t1 = spike(1).times;
t2 = spike(2).times;

figure
hold on
for i= 1:length(t1)
    line([t1(i) t1(i)],[0 1])
end
ylim([0 5])
xlabel('Time (sec)')

%%
for i= 1:length(t2)
    line([t2(i) t2(i)],[1 2])
end

%% Peri-Stimulus Time Histogram (PSTH)
figure
hold on

edges = [-1:0.1:1]; %Define the edges of the histogram
psth = zeros(21,1); %Initialize the PSTH with zeros
for j=1:47 %Loop over all trials
%Add current trial’s spike times
psth = psth+histc(spike(j).times,edges);
end
bar(edges,psth); %Plot PSTH as a bar graph
xlim([-1.1 1]) %Set limits of X-axis
xlabel('Time (sec)') %Label x-axis
ylabel('# of spikes') %Label y-axis

%This plots the summation of all spikes in psth

%In order to look for averaged spike, each bar must be
%divided to both bin width and the number of trials

%% Curve Fitting

%linear line fitting

x = 1:20; %Create a vector with 20 elements
y = x; %Make y the same as x
z = randn(1,20); %Create a vector of random numbers with same dimensions as x
y = y + z ; %Add z to y, introducing random variation
plot(x,y, '.' ) %Plot the data as a scatter plot
xlabel('Luminance')
ylabel('Firing rate')

p = polyfit(x,y,1); %fits data to a linear, 1st degree polynomial
hold on %Allow 2 plots of the same graph
yFit = x*p(1)+p(2); %Calculate fitted regression line
plot(x,yFit) %Plot regression
pause();

%fitting Cosine function

x = 0 : 0.1 : 30; %Create a vector from 0 to 10 in steps of 0.1
y = cos (x); %Take the cosine of x, put it into y
z = randn(1,301); %Create random numbers, put it into 301 columns
y = y + z; %Add the noise in z to y
figure %Create a new figure
plot (x,y) %Plot it

%mystring = 'p(1) + p(2) * cos ( theta - p(3) )'; %Cosine function in string form
%p(1) represents the y-offset; 
%p(2), the amplitude;
%p(3), the phase.
%myfun = inline ( mystring, 'p', 'theta' ); %Converts string to a function
%This function accepts angles *theta* and parameter vector *p* and transforms them using the
%relationship stored in |mystring|.
%p = nlinfit(x, y, myfun, [1 1 0] ); %Least squares curve fit to inline function "myfun"
%x: the angle theta in radians
%y: observed y values 
%The third parameter is the name of the function to
%fit
%The last parameter is a vector with initial guesses for the three free parameters of the
%cosine function

p = nlinfit(x, y, @myfun, [1 1 0] );

hold on %allows 2 plots of the same graph
yFit = myfun(p,x); %calculates fitted regression line
plot(x,yFit,'k') %plots regression


