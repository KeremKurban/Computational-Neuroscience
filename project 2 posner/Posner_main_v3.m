%% Experimental Procedure
% First, reading the corresponding chapter in the book is recommended
% Press b if x is within the boundries, m otherwise.
% Solve it with eyes focused on the fixation point.
% Save your user_durations variable with "save [name]user_durations"
%    command. i.e. save subject1data user_durations
% Run Posner_analysis after you obtained the data 

%% v2 Notes:

%+1. reaction buttons were changed to only one button which is when they see
%target in the same cue space. Therefore each trial wont wait for the
%subject's response anymore. threshold = 2 seconds. Program does not look
%for correctness anymore. Only button allowed is 'b'.

%+2.background tone and the contrast diff btw background & cue/target was
%decreased

%3. (in analysis part) There was a problem when running anovan function. Anovan takes every RT
% as a one category so 1.234 and 1.235 are classified in different groups.
% Hence the would be as many groups as trial number unless some RT are
% exactly the same. To solve this issue, RT's were categorized into several
% clusters which is determined by clustering algorithm.

%+4 A delay was added after each start.

%+5. when the wait threshold is passed, the program previously added 0 which
%affected mean reaction times however less the invalid/too late trials are.
%Now it adds NaN which also requires to use nanmean function in the
%analysis step

%+6. current_valid = 1 (valid) , 0 invalid. was mixed before

%+7. A new function is used, getkeywait for user input
%-----------------------------------------------------------
%v3
%8. Cue fixation deðil cue target arasý mesafe lazým. deltax and deltay
%changed

%9. Target should also appear instantaneously
%--------------------------------------------------------------
%%
% can try different randstreams for diff parameters x y pause validness
%s = RandStream('mlfg6331_64');
s= RandStream('mt19937ar','seed',sum(100*clock));


start = figure('units','normalized','outerposition',[0 0 1 1],'Name','Start');
title('Posner paradigm');
backcolor = [.64 .64 .64];
set(gcf,'color',backcolor)
ax = gca; % to make title bigger
ax.TitleFontSizeMultiplier = 2; % to make title bigger
%c = ax.Color;
ax.Color = backcolor;
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gcf,'MenuBar','none','Toolbar','none')
axis off

val = 8; % to set the midpoint of the figure
starttext = text(0.45,0.5,'Get READY','color','k','fontsize',30);
pause
input0 = get(gcf,'CurrentCharacter');
set(starttext,'Visible','off')

tcf_color = [.44 .44 .44]; %color of target&cue&fixation, currently dark greyish
fix_cue = text(val,val,'+','color',tcf_color,'fontsize',60);
hold on
wait_threshold = 2; % how much program will wait user response in secs
pause(wait_threshold);
total = 1280; % how many epochs will there be, default = 1280 & exp is set for 1280.
user_durations = zeros(total,8);

reptime = 320; % to fit labels to user durations

xler = [0 4;4 8;8 12;12 16];
xler = repmat(xler,reptime,1); %multiply xler 80 times columnwise
size_x = size(xler);size_x = size_x(1);
mixed_x = datasample(s,xler,size_x,'replace',false);

yler = [0 4;4 8;8 12;12 16];
yler = repmat(yler,reptime,1);
size_y = size(yler);size_y = size_y(1);
mixed_y = datasample(s,yler,size_y,'replace',false);

pause_duration = [0.1;0.3];
pause_duration = repmat(pause_duration,2*reptime,1);
size_pause = size(pause_duration);size_pause = size_pause(1);
mixed_pause = datasample(s,pause_duration,size_pause,'replace',false);

validness =[0;1];
validness = repmat(validness,2*reptime,1);
size_valid = size(validness);size_valid = size_valid(1);
mixed_valid = datasample(s,validness,size_valid,'replace',false);


axis([0 16 0 16])
xlim([0 16])
ylim([0 16])



for i=1:total
    titlename = sprintf('Posner paradigm %d',i);
    title(titlename);
    curent_xler = mixed_x(i,:);
    xmin = curent_xler(1);
    xmax = curent_xler(2);
    
    curent_yler = mixed_y(i,:);
    ymin = curent_yler(1);
    ymax = curent_yler(2);
    
    current_pause = mixed_pause(i);
    current_valid = mixed_valid(i);
    
    %present cue
    cue_pos = [xmin, ymin, xmax-xmin, ymax-ymin];
    cue = rectangle('Position',cue_pos,...
        'FaceColor',tcf_color);
    pause(current_pause);
    set(cue,'Visible','off')
    
    %present target
    if current_valid == 1
        %valid - randomly put target at different sites in boundries of cue
        a = xmin + (xmax-xmin).*rand(1,1);
        b = ymin + (ymax-ymin).*rand(1,1);
        target = text(a,b,'x','color',tcf_color,'fontsize',30);
        trueanswer = 'b';
        %val = 8 so the midpoint is 8,8. calc dist of target from fix_cue
        deltax = abs(b-(xmin + (xmax-xmin)/2));
        deltay = abs(a-(ymin + (ymax-ymin)/2));
        euclidian_dist = sqrt(deltax^2+deltay^2);
    else
        %invalid - randomly put target at different sites outside boundries of cue
        a = xmin + (xmax-xmin).*rand(1,1);
        b = ymin + (ymax-ymin).*rand(1,1);
        target = text(16-a,16-b,'x','color',tcf_color,'fontsize',30);
        trueanswer = 'b';
        %val = 8 so midpoint is 8,8. calc dist of target from fix_cue
        deltax = abs(b-val);
        deltay = abs(a-val);
        euclidian_dist = sqrt(deltax^2+deltay^2);
    end
    
    %user response
    tic
    %press = get(gcf,'CurrentCharacter');
    press = getkeywait(wait_threshold);
    elapsed_time = toc;
    set(target,'Visible','off') % use reset(target) if sth unwanted happens
    
    
    if press == trueanswer
        correctness = 1;
    else
        correctness = 0;
    end
    
    if elapsed_time<wait_threshold
        user_durations(i,:) = [i current_pause current_valid elapsed_time correctness deltax deltay euclidian_dist];
    else
        %'too late'        
        user_durations(i,:) = [i current_pause current_valid elapsed_time correctness deltax deltay euclidian_dist];
        
    end
    
    if i == total/4
        
        pause()
        rest = text(3.5,10,'1/4 of the test is done, rest however much you want','color','b','fontsize',30);
        pause()
        set(rest,'Visible','off')
        pause(2);
    elseif i == 2*total/4
        pause()
        rest = text(3.5,10,'2/4 of the test is done, rest however much you want','color','b','fontsize',30);
        pause()
        set(rest,'Visible','off')
        pause(2);
    elseif i == 3*total/4
        pause()
        rest = text(3.5,10,'3/4 of the test is done, rest however much you want','color','b','fontsize',30);
        pause()
        set(rest,'Visible','off')
        pause(2);
    end
end

clf
endtext = text(0.25,0.5,'CONGRATULATIONS,press any button to exit','color','b','fontsize',30);
press = get(gcf,'CurrentCharacter');

user_durations




