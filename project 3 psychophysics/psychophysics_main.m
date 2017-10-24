%notes:
% 1. +dont plot figures it gives too much light and rgb all var zaten
% 2. +main start background should be black
% 3. -buy bant for light coming from pc and windows
% 4. +make sure plots have labels and title
% 5. +rgb yi tek plot ederken label ve title koy ediceksen illa
% Release note:red_bdiff etc. was not actually bdiff but scorediff,fixed
% 6. add catch trial or signal det. theory has no implementation here


% % main script
%global filename
%filename= input('subject name?:','s');
%m_main = matfile(filename, 'Writable', true);

%part 1 : White perihepral vs foveal:

[wbrightness, wfov_normdata, wper_normdata, true_score_w_fov, false_score_w_fov...
    ,true_score_w_per, false_score_w_per] = Wfunc(2);


%part 2: RGB absolute thresholds:
%  RGBfunc(2,2); first arg is color 1:red 2:green 3:blue,  second arg is
%  time threshold in seconds

[red_brightness,red_normdata,true_score_r,false_score_r] = RGBfunc(1,2);
[green_brightness,green_normdata,true_score_g,false_score_g] = RGBfunc(2,2);
[blue_brightness,blue_normdata,true_score_b,false_score_b] = RGBfunc(3,2);

brightness = red_brightness; % all is the same

%plot so far : RGB
figure();

redplot = plot(brightness,red_normdata,'r');
hold on
greenplot = plot(brightness,green_normdata,'g');
blueplot = plot(brightness,blue_normdata,'b');
title('RGB absolute thresholds')
xlabel('Luminance')
ylabel('Prob. reported seen')
pause();

wplotfov = plot(wbrightness,wfov_normdata,'k');
wplotper = plot(wbrightness,wper_normdata,'c');
title('RGB/foveal + White/foveal + White/Peripheral absolute thresholds')
xlabel('Luminance')
ylabel('Prob. reported seen')
legend([redplot,greenplot,blueplot,wplotfov,wplotper],'red','green','blue','white fovea','white peripheral','location','SouthEast')

%Signal detection Theory:

correct_rejection = sum(false_score_w_fov)+sum(false_score_w_per)+sum(false_score_r)+sum(false_score_g)+...
    +sum(false_score_b);
correct_rejection_normalized = correct_rejection * 4; % to normalize with correct trials, since these are only 25% of them

false_alarm = 200 - correct_rejection;
false_alarm_normalized = false_alarm * 4; % to normalize

detect = sum(true_score_w_fov)+sum(true_score_w_per)+sum(true_score_r)+...
    sum(true_score_g) +sum(true_score_b);
miss = 800 - detect;
%reject edilecekler 1er fazla, therefore in total substract 4 form  corr
%rej and add 4 to false alarm


% %part 3: RGBW relative thresholds: 200 trials each
% global new_bdiff
% global sorted_new_bdiff
% global bias
% bias = 45;
% new_bdiff = [-40:10:50]; %bias 50 so max -40 to be seen, still not enough
% new_bdiff = new_bdiff(randperm(length(new_bdiff)));
% sorted_new_bdiff = sort(new_bdiff);
% 
% %v3 now saves absolute brightnesses of left&right side in 3rd&4th argument.
% [red_prop,leftside_br] = relativefunc(1,2);
% [green_prop,leftside_bg] = relativefunc(2,2);
% [blue_prop,leftside_bb] = relativefunc(3,2);
% [white_prop,leftside_bw] = relativefunc(4,2);
% 
% relative_all_fig = figure();
% 
% 
% plot(sorted_new_bdiff,red_prop(:,1),'r')
% hold on
% plot(sorted_new_bdiff,green_prop(:,1),'g')
% plot(sorted_new_bdiff,blue_prop(:,1),'b') 
% plot(sorted_new_bdiff,white_prop(:,1),'k')
% 
% title('RGBW relative thresholds')
% xlabel('difference in brightness (right - left)')
% ylabel('Proportion of reported seen - all')
% 




