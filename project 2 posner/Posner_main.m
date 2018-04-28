%v1.0 Notes:
% Press b if x is within the boundries, m otherwise.
% solve it with eyes focused on the fixation point.
% run Posner_analysis after you obtained the data

%with "i found"(b) and "i could not find" (m) buttons. will be removed
%since it affects mean reaction times significantly. especially in valid
%and invalid trial comparisons


% can try different randstreams for diff parameters x y pause validness
%s = RandStream('mlfg6331_64');
s= RandStream('mt19937ar','seed',sum(100*clock));


start = figure('units','normalized','outerposition',[0 0 1 1],'Name','Start');
title('Posner paradigm');
ax = gca; % to make title bigger
ax.TitleFontSizeMultiplier = 2; % to make title bigger
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
val = 8;
starttext = text(0.45,0.5,'Get READY','color','b','fontsize',30);
pause
input0 = get(gcf,'CurrentCharacter');
set(starttext,'Visible','off')


fix_cue = text(val,val,'+','color','k','fontsize',60);
hold on
wait_threshold = 5; % how much program will wait user response in secs
total = 1280; % how many epochs will there be, default = 1280 & exp is set for 1280.
user_durations = zeros(total,8);

reptime = 320;

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
    cue = rectangle('Position',[xmin, ymin, xmax-xmin, ymax-ymin],...
        'FaceColor','g');
    pause(current_pause);% will be delays instead
    set(cue,'Visible','off')
    
    %present target
    if current_valid == 0
        %valid - randomly put target at different sites in boundries of cue
        a = xmin + (xmax-xmin).*rand(1,1);
        b = ymin + (ymax-ymin).*rand(1,1);
        target = text(a,b,'x','color','r','fontsize',30);
        trueanswer = 'b';
        %val = 8 so midpoint is 8,8. calc dist of target from fix_cue
        deltax = abs(b-val);
        deltay = abs(a-val);
        euclidian_dist = sqrt(deltax^2+deltay^2);
    else
        %invalid - randomly put target at different sites outside boundries of cue
        a = xmin + (xmax-xmin).*rand(1,1);
        b = ymin + (ymax-ymin).*rand(1,1);
        target = text(16-a,16-b,'x','color','r','fontsize',30);
        trueanswer = 'm';
        %val = 8 so midpoint is 8,8. calc dist of target from fix_cue
        deltax = abs(b-val);
        deltay = abs(a-val);
        euclidian_dist = sqrt(deltax^2+deltay^2);
    end
    
    %user response
    tic
    pause;
    press = get(gcf,'CurrentCharacter');
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
        user_durations(i,:) = [i current_pause current_valid 0 correctness deltax deltay euclidian_dist];
        
    end
    
    if i == total/4
        
        pause()
        rest = text(3.5,10,'1/4 of the test is done, rest however much you want','color','b','fontsize',30);
        pause()
        set(rest,'Visible','off')
    elseif i == 2*total/4
        pause()
        rest = text(3.5,10,'2/4 of the test is done, rest however much you want','color','b','fontsize',30);
        pause()
        set(rest,'Visible','off')
    elseif i == 3*total/4
        pause()
        rest = text(3.5,10,'3/4 of the test is done, rest however much you want','color','b','fontsize',30);
        pause()
        set(rest,'Visible','off')
    end
end

clf
endtext = text(0.25,0.5,'CONGRATULATIONS,press any button to exit','color','b','fontsize',30);
press = get(gcf,'CurrentCharacter');

user_durations




