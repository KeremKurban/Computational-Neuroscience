function [proportion,leftside_b] = relativefunc( color,time_threshold )
global new_bdiff
global sorted_new_bdiff
global bias
get(0,'Factory')
set(0,'defaultfigurecolor',[0 0 0])

sprintf('color is: %d',color)
sprintf('time_threshold: %d',time_threshold)
pause(2);
%color = 1;
sizex = 850;
sizey = 850;

max_brightness = 90;
max_trial_no = 10; %dont change

%time_threshold = 2;
temp = uint8(zeros(sizex,sizey,3)); %Create a dark stimulus matrix
%reltemp = uint8(zeros(sizex,sizey,3));
temp1 = cell(10,1); %Create a cell that can hold 10 matrices
%reltemp1 = cell(10,1); % for relative pixel at the left side
leftside_b = zeros(1,max_trial_no);


for i = 1:max_trial_no %Filling temp1
    
    if color == 4 % white case
        temp(sizex/2,sizey/2,:) = 255;  %Inserting a fixation point
        rightside_b = bias;
        temp(sizex/2,(sizey/2)*1.2,:) = rightside_b;
        %leftside_b = bias+(i-1)*((max_brightness/max_trial_no)+1) + new_bdiff(i);
        leftside_b(i) = bias + new_bdiff(i);
        temp(sizex/2,(sizey/2)*0.8,:) =leftside_b(i);   
        
    else %RGB cases:
        temp(sizex/2,sizey/2,color) = 255;  %Inserting a fixation point
        
        %right side:  1.2x then 1.7x
        rightside_b = bias;
        temp(sizex/2,(sizey/2)*1.2,color) = rightside_b;
        %left side: should be different
        %leftside_b = bias+(i-1)*((max_brightness/max_trial_no)+1) + new_bdiff(i);
        leftside_b(i) = bias + new_bdiff(i);
        temp(sizex/2,(sizey/2)*0.8,color) = leftside_b(i);
        
    end
    
    %reltemp1{i} = reltemp;
    temp1{i} = temp; %Putting the respective modified matrix in cell
end %Done doing that

h = figure('units','normalized','outerposition',[0 0 1 1]); %Creating a figure with a handle h
set(gcf,'MenuBar','none','Toolbar','none')
axis off
hFig = gcf;
hAx  = gca;
set(hFig,'units','normalized','outerposition',[0 0 1 1]);
%set(hFig,'units','normalized','outerposition',[0 0 1 1]);
set(hAx,'Unit','normalized','Position',[0 0 1 1]);
set(hFig,'menubar','none')
set(hFig,'NumberTitle','off');

starttext = text(0.35,0.5,'Relative Th. test, Get READY','color','w','fontsize',30);
starttext2 = text(0.35,0.45,'Press . if the right side is brighter','color','w','fontsize',30);
starttext3 = text(0.35,0.40,'Press z if the left side is brighter','color','w','fontsize',30);

pause();
set(starttext,'Visible','off')
set(starttext2,'Visible','off')
set(starttext3,'Visible','off')

text(0.45,0.5,'Get READY 3','color','w','fontsize',30);
pause(1);

text(0.45,0.5,'Get READY 3..2','color','w','fontsize',30);
pause(1);

text(0.45,0.5,'Get READY 3..2..1','color','w','fontsize',30);
pause(1);



stimulusorder = randperm(200); %Creating a random order from 1 to 200.
%For the 200 trials. Allows to have
%a precisely equal number per condition.
stimulusorder = mod(stimulusorder,10); %Using the modulus function to
%create a range from 0 to 9. 20 each.
stimulusorder = stimulusorder + 1; %Now, the range is from 1 to 10, as
%desired.

relstimulusorder = randperm(200);
relstimulusorder = mod(relstimulusorder,10);
relstimulusorder = relstimulusorder + 1;

score_right = zeros(10,1); %Keeping score. How many stimuli were reported seen
score_left = zeros(10,1);
score_late = zeros(10,1);

for i = 1:200 %200 trials, 20 per condition
    image(temp1{stimulusorder(1,i)}) %Image the respective matrix. As
    %designated by stimulusorder
    %image(reltemp1{relstimulusorder(1,i)})
    i %Give subject feedback about which trial we are in. No other feedback.
    pause; %Get the keypress
    tic;
    temp2 = get(h,'CurrentCharacter'); %Get the keypress. "." for present,
    elapsed_time = toc;
    %"," for absent.
    if elapsed_time < time_threshold
        temp3 = strcmp('.', temp2); %Compare strings. If . (right bigger!!!!!!!!!), temp3 = 1,
        %otherwise 0.
        if temp3 == 1 % pressed .
            score_right(stimulusorder(1,i)) = score_right(stimulusorder(1,i)) + 1; %Add up.
            % In the respective score sheet.   
        elseif temp3 == 0 % pressed ,
            score_left(stimulusorder(1,i)) = score_left(stimulusorder(1,i)) + 1;
        end
    else % time passed
        score_late(stimulusorder(1,i)) = score_late(stimulusorder(1,i)) + 1;
    end
end %End the presentation of trials, after 200 have lapsed.


%global filename
%m = matfile(filename, 'Writable', true); %Note: writable is true by default IF the file does not exist
%first create your variable, then use m.yourvariablename = your value


score_both = [score_left score_right];
summed_score = sum(score_both,2);% row summed to be used as the denominator in plotting y axis
proportion = score_right / summed_score; % y axis


rel_plot = figure();
if color == 1
    rp = plot(sorted_new_bdiff,proportion,'r');
    title('Red relative threshold')
    xlabel('difference in brightness (right - left)')
    ylabel('Proportion of reported seen that right side is brighter')
    legend(rp,'red')    
    pause();
    %m.rp = rp;
elseif color == 2
    gp = plot(sorted_new_bdiff,proportion,'g');
    title('Green relative threshold')
    xlabel('difference in brightness (right - left)')
    ylabel('Proportion of reported seen that right side is brighter')
    legend(gp,'green')
    pause();    
    %m.gp = gp;
elseif color == 3
    bp = plot(sorted_new_bdiff,proportion,'b');
    title('Blue relative threshold')   
    xlabel('difference in brightness (right - left)')
    ylabel('Proportion of reported seen that right side is brighter')
    legend(bp,'blue')    
    pause();    
    %m.bp = bp;
elseif color == 4
    wp = plot(sorted_new_bdiff,proportion,'k');
    title('White relative threshold')    
    xlabel('difference in brightness (right - left)')
    ylabel('Proportion of reported seen that right side is brighter')
    legend(wp,'white')    
    pause();    
    %m.wp = plot(brightness_diff,proportion);
else 
    sprintf('mistake in plotting the figure in relative func %d',color)
end




end

