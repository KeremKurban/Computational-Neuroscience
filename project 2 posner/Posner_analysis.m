%% Analyis part of the experiment. Load user_durations variable first then run the code.

%function [ output_args ] = Posner_analysis( user_durations )

% if nargin > 1 %multiple samples
%     
% %     for i=1:nargin
% %     eval(sprintf('true_ans_ind_%d = find(varargin{i}(:,5) == 1); ', i));
% %     end
% %     true_ans_ind_%d = 
% %     false_ans_ind_%d =
% %     valid_ind_%d =
% %     invalid_ind_%d = 
% %     
% %     
% %     user_durations = mean_user_durations;
%     
% else % one sample
% 
%     user_durations = varargin;
%     
% end

%load keremrand

%analysis

%   i current_pause current_valid elapsed_time correctness deltax deltay euclidian_dist

%%%%1: t test valid/invalid

true_answer_ind = find(user_durations(:,5) == 1); % soru dogru cevaplanmis
false_answer_ind = find(user_durations(:,5) == 0); % soru yanlýs cevaplanmýþ

valid_indices = find(user_durations(:,3) == 1); % valid trials
invalid_indices = find(user_durations(:,3) == 0); % invalid trials
true_valid_ind = intersect(true_answer_ind,valid_indices); % true + valid / indices
true_invalid_ind = intersect(true_answer_ind,invalid_indices); % true + invalid / indices

% from intersection indices, pull reaction times
valids = user_durations(true_valid_ind,4);
invalids = user_durations(true_invalid_ind,4);
valids_all = user_durations(valid_indices,4); %for anova
invalids_all = user_durations(invalid_indices,4); % for anova

[significant_valid,p_valid] = ttest2(valids,invalids);

if p_valid<0.05
    cprintf('_blue','p(%d) < 0.05, on t-test with valid and invalid targets, significant  \n\n',p_valid)
else
    cprintf('_red','p(%d) >= 0.05, on t-test with valid and invalid targets, insignificant \n\n',p_valid)
end

%%%%2: delay t test

t100_ind = find(user_durations(:,2) == 0.1);
t300_ind = find(user_durations(:,2) == 0.3);
t100ind_true = intersect(t100_ind,true_answer_ind);
t300ind_true = intersect(t300_ind,true_answer_ind);

% from intersection indices, pull reaction times(RT)
t100_true = user_durations(t100ind_true,4);
t300_true = user_durations(t300ind_true,4);
t100_all = user_durations(t100_ind,4); %for anova
t300_all = user_durations(t300_ind,4); %for anova

[significant_delay,p_delay] = ttest2(t100_true,t300_true);

if p_delay<0.05
    cprintf('_blue','p(%d) < 0.05, on t-test with 100 and 300ms temporal delay, significant  \n\n',p_delay)
else
    cprintf('_red','p(%d) >= 0.05, on t-test with 100 and 300ms temporal delay, insignificant \n\n',p_delay)
end

%%%%3 distance t test (x & y & euclidian)

if false_answer_ind ~= 0
    %------------------ Horizontal dist:
    hor_dist_ind = find(user_durations(:,6)); %horizontal distances
    hor_dist_ind_false = intersect(hor_dist_ind,false_answer_ind); %horizontal dist ind yanlýþ cevaplananlarda

    hor_dist_val_false = user_durations(hor_dist_ind_false,6); %horizontal dist vals yanlýþ cevaplananlarda
    hor_dist_val_all = user_durations(hor_dist_ind,6);

    %pull RT
    RT_hdvf = user_durations(hor_dist_ind_false,4);

    %plot hor-dist vs RT:
    horplot = figure();
    ordered_hor = sort([hor_dist_val_false RT_hdvf]);
    phor = plot(ordered_hor(:,1),ordered_hor(:,2),'r');
    title('Horizontal dist-false vs Reaction Times')
    xlabel('Horizontal Distance')
    ylabel('RT')
    pause;
    
    hold on

    %------------------ Vertical dist:

    ver_dist_ind = find(user_durations(:,7));
    ver_dist_ind_false = intersect(ver_dist_ind,false_answer_ind);

    ver_dist_val_false = user_durations(ver_dist_ind_false,7);
    ver_dist_val_all = user_durations(ver_dist_ind,7);

    %pull RT
    RT_vdvf = user_durations(ver_dist_ind_false,4);

    %plot ver-dist vs RT:
    %verplot = figure();
    ordered_ver = sort([ver_dist_val_false RT_vdvf]);
    pver = plot(ordered_ver(:,1),ordered_ver(:,2),'g');
    title('Vertical dist-false vs Reaction Times')
    xlabel('Vertical Distance')
    ylabel('RT')
    pause;


    %------------------ Total dist:
    tot_dist_ind = find(user_durations(:,8));
    tot_dist_ind_false = intersect(tot_dist_ind,false_answer_ind);

    tot_dist_val_false = user_durations(tot_dist_ind_false,8);
    tot_dist_val_all = user_durations(tot_dist_ind,8);

    %pull RT
    RT_tdvf = user_durations(tot_dist_ind_false,4);

    %plot ver-dist vs RT:
    %totplot = figure();
    ordered_tot = sort([tot_dist_val_false RT_tdvf]);
    ptot = plot(ordered_tot(:,1),ordered_tot(:,2),'c');

    title('Total dist-false vs Reaction Times')
    xlabel('Total Distance')
    ylabel('RT')
    
    %fit bestline
    
    fit1 = polyfit(ordered_tot(:,1),ordered_tot(:,2),1);
    fit2 = polyval(fit1,ordered_tot(:,1));
    hold on
    plot(ordered_tot(:,1),ordered_tot(:,2),'--r')
    pause;
else
    sprintf('no wrong answers')
end

%plot all in the same fig
%allplot = figure();
clf
phor = plot(ordered_hor(:,1),ordered_hor(:,2),'r');
hold on
pver = plot(ordered_ver(:,1),ordered_ver(:,2),'g');
ptot = plot(ordered_tot(:,1),ordered_tot(:,2),'c');

xlabel('Distances(mixed)')
ylabel('RT')
legend([phor,pver,ptot],'Horizontal','Vertical','Total')
pause();

%%%%%%% %4 ALL anova

% [p,t,stats,terms] = anova1(t100_true,t300_true,valids,invalids,...
%     'model','full')
p_delay_anova = anova1([t100_all t300_all]);

if p_delay_anova<0.05
    cprintf('_blue','Anova p(%d) < 0.05, RT differences between 100ms and 300ms delays are significant \n\n',p)
else
    cprintf('_red','Anova p(%d) >= 0.05, RT differences between 100ms and 300ms delays are not significant \n\n',p)
end
pause();

% Two-way ANOVA : Valid,delay

validdelay = user_durations(:,2:3);
[p_valid_delay,tbl_valid_delay,stats_valid_delay] = anova2(validdelay);

if p_valid_delay<0.05
    cprintf('_blue','Anova p(%d) < 0.05, Two-way ANOVA with validness and delay \n\n',p_valid_delay)
else
    cprintf('_red','Anova p(%d) >= 0.05, Two-way ANOVA with validness and delay \n\n',p_valid_delay)
end
pause();

% N-Way ANOVA : Valid,delay,x,y
% tek tek yap distancelarý

%  [p_anovaall,tbl,stats,terms] = anovan(user_durations(:,4),user_durations(:,[2 3 6]),...
%      'model','full','varnames',{'delay','validness','x','y','euclidian'});
% 
% if p_anovaall<0.05
%     cprintf('_blue','Anova p(%d) < 0.05, N-way ANOVA with validness and delay \n\n',p_valid_delay)
% else
%     cprintf('_red','Anova p(%d) >= 0.05, N-way ANOVA with validness and delay \n\n',p_valid_delay)
% end
% %end


average_hor_distance = mean(user_durations(:,6));
average_ver_distance = mean(user_durations(:,7));
average_euclidian_distance = mean(user_durations(:,8));

average_time = mean(user_durations(:,4));

euclidian_speed = average_euclidian_distance / average_time;
hor_speed = average_hor_distance / average_time;
ver_speed = average_ver_distance / average_time;

cprintf('_red','euclidian speed = %d units/sec   hor_speed = %d units/sec    ver_speed = %d units/sec',...
    euclidian_speed,hor_speed,ver_speed);
