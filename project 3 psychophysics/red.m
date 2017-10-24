clear all; %Emptying workspace
close all; %Closing all figures

color = 1;
sizex = 1080;
sizey = 1080;

max_brightness = 90;
max_trial_no = 10; %dont change

time_threshold = 2;
temp = uint8(zeros(sizex,sizey,3)); %Create a dark stimulus matrix
temp1 = cell(10,1); %Create a cell that can hold 10 matrices

for i = 1:max_trial_no %Filling temp1
    temp(sizex/2,sizey/2,color) = 255; %Inserting a fixation point
    
    %1.2x then 1.7x
    temp(sizex/2,(sizey/2)*1.2,color) = (i-1)*((max_brightness/max_trial_no)+1); %Inserting a test point 40 pixels right
    %of it. Brightness range 0 to 90.
    temp1{i} = temp; %Putting the respective modified matrix in cell
end %Done doing that

h = figure('units','normalized','outerposition',[0 0 1 1],'Name','Start'); %Creating a figure with a handle h

set(gcf,'MenuBar','none','Toolbar','none')
axis off

stimulusorder = randperm(200); %Creating a random order from 1 to 200.
%For the 200 trials. Allows to have
%a precisely equal number per condition.
stimulusorder = mod(stimulusorder,10); %Using the modulus function to
%create a range from 0 to 9. 20 each.
stimulusorder = stimulusorder + 1; %Now, the range is from 1 to 10, as
%desired.
score = zeros(10,1); %Keeping score. How many stimuli were reported seen


for i = 1:200 %200 trials, 20 per condition
    image(temp1{stimulusorder(1,i)}) %Image the respective matrix. As
    %designated by stimulusorder
    i %Give subject feedback about which trial we are in. No other feedback.
    pause; %Get the keypress
    tic;
    temp2 = get(h,'CurrentCharacter'); %Get the keypress. "." for present,
    elapsed_time = toc;
    %"," for absent.
    if elapsed_time < time_threshold
        temp3 = strcmp('.', temp2); %Compare strings. If . (present), temp3 = 1,
        %otherwise 0.
        score(stimulusorder(1,i)) = score(stimulusorder(1,i)) + temp3; %Add up.
        % In the respective score sheet.
    else
        score(stimulusorder(1,i)) = score(stimulusorder(1,i)) + 0;
    end
end %End the presentation of trials, after 200 have lapsed.

bla = score;
norm_data = (bla - min(bla)) / ( max(bla) - min(bla) );
brightness = 0:(max_brightness/max_trial_no)+1:max_brightness;
plot(brightness,norm_data)
pause();


