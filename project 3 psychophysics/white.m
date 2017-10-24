%clear all; %Emptying workspace
%close all; %Closing all figures


for periphery=1:2
    
    
    sizex = 1080;
    sizey = 1080;
    
    max_brightness = 90;
    max_trial_no = 10; %dont change
    time_threshold = 2;
    periheral_degree = 0.4; % 1.2 + 0.4 = 1.6x
    
    temp = uint8(zeros(sizex,sizey,3)); %Create a dark stimulus matrix
    temp1 = cell(10,1); %Create a cell that can hold 10 matrices

    for i = 1:10 %Filling temp1
    temp(sizex/2,sizey/2,:) = 255; %Inserting a fixation point
    
    %1.2x then 1.7x
    temp(sizex/2,(sizey/2)*1.2 + (sizey/2)*periheral_degree*(periphery-1),:) = (i-1)*10; %Inserting a test point 40 pixels right
    %of it. Brightness range 0 to 90.
    temp1{i} = temp; %Putting the respective modified matrix in cell
    end %Done doing that

    h = figure('units','normalized','outerposition',[0 0 1 1]); %Creating a figure with a handle h
    set(gcf,'MenuBar','none','Toolbar','none')
    axis off
    starttext = text(0.45,0.5,'Get READY','color','k','fontsize',30);
    pause();
    text(0.45,0.5,'Get READY 3','color','k','fontsize',30);
    pause(1);
    
    text(0.45,0.5,'Get READY 3..2','color','k','fontsize',30);
    pause(1);
    
    text(0.45,0.5,'Get READY 3..2..1','color','k','fontsize',30);
    pause(1);
    
    
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
    
    if periphery == 1
    per1score = score;
    norm_data1 = (per1score - min(per1score)) / ( max(per1score) - min(per1score) );
    brightness1 = 0:(max_brightness/max_trial_no)+1:max_brightness;
    plot(brightness1,norm_data1)
    title('Foveal vision absolute threshold')
    xlabel('Brightness')
    ylabel('Prob. reported seen')
    pause();
    
    elseif periphery == 2
    per2score = score;
    norm_data2 = (per2score - min(per2score)) / ( max(per2score) - min(per2score) );
    brightness2 = 0:(max_brightness/max_trial_no)+1:max_brightness;
    abs_per = plot(brightness2,norm_data2,'r');
    title('Peripheral vision absolute threshold')
    xlabel('Brightness')
    ylabel('Prob. reported seen')
    hold on
    pause();
    
    abs_fov = plot(brightness1,norm_data1,'b');
    title('Foveal & Peripheral vision absolute thresholds')
    legend([abs_fov abs_per],'Foveal','Peripheral')
    pause();
    
    
    end


    
end 



