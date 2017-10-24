function [ brightness,norm_data,score,score_falsealarm ] = RGBfunc( color,time_threshold )

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
temp1 = cell(10,1); %Create a cell that can hold 10 matrices

for i = 1:max_trial_no %Filling temp1
    if i == max_trial_no && i == max_trial_no-1
    temp(sizex/2,sizey/2,color) = 255; %Inserting a fixation point
    else
    temp(sizex/2,sizey/2,color) = 255; %Inserting a fixation point    
    %1.2x then 1.7x
    temp(sizex/2,(sizey/2)*1.2,color) = (i-1)*((max_brightness/max_trial_no)+1); %Inserting a test point 40 pixels right
    %of it. Brightness range 0 to 90.
    temp1{i} = temp; %Putting the respective modified matrix in cell
    end
    
        
end %Done doing that

h = figure('units','normalized','outerposition',[0 0 1 1]); %Creating a figure with a handle h
hFig = gcf;
hAx  = gca;
set(hFig,'units','normalized','outerposition',[0 0 1 1]);
set(hFig,'units','normalized','outerposition',[0 0 1 1]);
set(hAx,'Unit','normalized','Position',[0 0 1 1]);
set(hFig,'menubar','none')
set(hFig,'NumberTitle','off');
set(gcf,'MenuBar','none','Toolbar','none')
axis off


starttext = text(0.35,0.5,'RGB test, Get READY','color','w','fontsize',30);
pause();
set(starttext,'Visible','off')

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
score = zeros(8,1); %Keeping score. How many stimuli were reported seen
score_falsealarm = zeros(2,1);
%false_or_true = randperm(400);

for i = 1:200 %200 trials, 20 per condition
    image(temp1{stimulusorder(1,i)}) %Image the respective matrix. As
    %designated by stimulusorder
    i %Give subject feedback about which trial we are in. No other feedback.
    pause; %Get the keypress
    tic;
    temp2 = get(h,'CurrentCharacter'); %Get the keypress. "." for present,
    elapsed_time = toc;
    %"," for absent.
    if stimulusorder(1,i) ~= 10 && stimulusorder(1,i) ~= 9
        if elapsed_time < time_threshold
            temp3 = strcmp('.', temp2); %Compare strings. If . (present), temp3 = 1,
            %otherwise 0.
            score(stimulusorder(1,i)) = score(stimulusorder(1,i)) + temp3; %Add up.
            % In the respective score sheet.
        else
            score(stimulusorder(1,i)) = score(stimulusorder(1,i)) + 0;
        end
    elseif stimulusorder(1,i) == 9
        if elapsed_time < time_threshold
            temp3 = strcmp('.', temp2); %Compare strings. If . (present), temp3 = 1,
            %otherwise 0.
            if temp3 == 0
                temp4 = 1;
            elseif temp3 == 1
                temp4 = 0;
            end
            
            score_falsealarm(stimulusorder(1,i)-8) = score_falsealarm(stimulusorder(1,i)-8) + temp4; %Add up.
            % In the respective score sheet.
        else
            score_falsealarm(stimulusorder(1,i)-8) = score_falsealarm(stimulusorder(1,i)-8) + 0;
        end     
    elseif stimulusorder(1,i) == 10
        if elapsed_time < time_threshold
            temp3 = strcmp('.', temp2); %Compare strings. If . (present), temp3 = 1,
            %otherwise 0.
            if temp3 == 0
                temp4 = 1;
            elseif temp3 == 1
                temp4 = 0;
            end            
            score_falsealarm(stimulusorder(1,i)-8) = score_falsealarm(stimulusorder(1,i)-9) + temp4; %Add up.
            % In the respective score sheet.
        else
            score_falsealarm(stimulusorder(1,i)-8) = score_falsealarm(stimulusorder(1,i)-9) + 0;
        end  
    end
end %End the presentation of trials, after 200 have lapsed.

bla = score;
norm_data = (bla - min(bla)) / ( max(bla) - min(bla) );
brightness = 0:(max_brightness/max_trial_no)+1:max_brightness-20;
%plot(brightness,norm_data)
pause();





end

