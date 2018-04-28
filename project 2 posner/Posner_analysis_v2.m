%Posner analysis v2 notes

%+1. mean of reaction times was changed to nanmean function

%+2. for question 3, the program was using uncorrect trials instead of invalids

%3. (in analysis part) There was a problem when running anovan function. Anovan takes every RT
% as a one category so 1.234 and 1.235 are classified in different groups.
% Hence the would be as many groups as trial number unless some RT are
% exactly the same. To solve this issue, RT's were categorized into several
% clusters which is determined by clustering algorithm.


%---------------------------------------------------------------


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
sprintf('valid invalid comparison test')
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

situations = {'valids';'invalids'};
[Maxmeanvals,ind_mmv] = max([mean(valids) mean(invalids)]);
bigger_case_vi = cell2mat(situations(ind_mmv));

if p_valid<0.05
    cprintf('_blue','significant p(%.2f) < 0.05, on t-test in valid(%.2f) and invalid(%.2f) targets with mean of %s is higher,   \n\n',...
        p_valid,mean(valids),mean(invalids),bigger_case_vi)
else
    cprintf('_red','insignificant p(%.2f) >= 0.05, on t-test in valid(%.2f) and invalid(%.2f) targets with mean of %s is higher,  \n\n',p_valid,bigger_case_vi)
end

figure()
bar([0 1],[mean(invalids) mean(valids)])
axis([0 1 0.8 0.9])
xlabel('invalids - valids')
ylabel('mean RT')
title('valid/invalid diference plot')

%%%%2: delay t test
sprintf('delay test')
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


situations2 = {'100ms';'300ms'};
[Maxmeandur,ind_mmd] = max([mean(t100_true) mean(t300_true)]);
bigger_case_delay = cell2mat(situations2(ind_mmd));

if p_delay<0.05
    cprintf('_blue','significant p(%.2f) < 0.05, on t-test with 100(%.2f) and 300ms(%.2f) temporal delay,(%s) is bigger   \n\n',...
        p_delay,mean(t100_true),mean(t300_true),bigger_case_delay)
else
    cprintf('_red','insignificant p(%.2f) >= 0.05, on t-test with 100(%.2f) and 300ms(%.2f) temporal delay,(%s) is bigger  \n\n',...
        p_delay,mean(t100_true),mean(t300_true),bigger_case_delay)
end


figure()
bar([0 1],[mean(t100_true) mean(t300_true)])
axis([0 1 0.5 0.96])
xlabel('t100 - t300')
ylabel('mean RT')
title('mean delay diference plot')

%%%%3 distance t test (x & y & euclidian)

if false_answer_ind ~= 0
    %------------------ Horizontal dist:
    ind_invalid = find(user_durations(:,3) == 0);
    

    hor_dist_val_invalid = user_durations(ind_invalid,6);

    %pull RT
    RT_hdvi = user_durations(ind_invalid,4); %v2: invalid not false

    
    %plot hor-dist vs RT:
    horplot = figure();
    ordered_hor = sort([hor_dist_val_invalid RT_hdvi]); % v2:changed from false to all
    phor = plot(ordered_hor(:,1),ordered_hor(:,2),'r');
    title('Horizontal dist-false vs Reaction Times')
    xlabel('Horizontal Distance')
    ylabel('RT')
    pause;
    
    hold on

    %------------------ Vertical dist:


    %ind_invalid = find(user_durations(:,3) == 0);
    

    ver_dist_val_invalid = user_durations(ind_invalid,7);

    %pull RT
    RT_vdvi = user_durations(ind_invalid,4); %v2: invalid not false

    %plot dist vs RT:
    ordered_ver = sort([ver_dist_val_invalid RT_vdvi]); %v2: changed from false to all
    pver = plot(ordered_ver(:,1),ordered_ver(:,2),'k');


    %------------------ Total dist:
    %tot_dist_ind = find(user_durations(:,8));
    %tot_dist_ind_false = intersect(tot_dist_ind,false_answer_ind);
    %ind_invalid = find(user_durations(:,3) == 0);
    

    %tot_dist_val_false = user_durations(tot_dist_ind_false,8);
    %tot_dist_val_all = user_durations(tot_dist_ind,8);
    tot_dist_val_invalid = user_durations(ind_invalid,8);

    %pull RT
    RT_tdvi = user_durations(ind_invalid,4); %v2: invalid not false

    %plot dist vs RT:
    %totplot = figure();
    ordered_tot = sort([tot_dist_val_invalid RT_tdvi]); %v2: changed from false to all
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

% %%%%%%% %4 ALL anova
% 
% % [p,t,stats,terms] = anova1(t100_true,t300_true,valids,invalids,...
% %     'model','full')
% p_delay_anova = anova1([t100_all t300_all]);
% 
% if p_delay_anova<0.05
%     cprintf('_blue','Anova p(%d) < 0.05, RT differences between 100ms and 300ms delays are significant \n\n',p)
% else
%     cprintf('_red','Anova p(%d) >= 0.05, RT differences between 100ms and 300ms delays are not significant \n\n',p)
% end
% pause();
% 
% % Two-way ANOVA : Valid,delay
% 
% validdelay = user_durations(:,2:3);
% [p_valid_delay,tbl_valid_delay,stats_valid_delay] = anova2(validdelay);
% 
% if p_valid_delay<0.05
%     cprintf('_blue','Anova p(%d) < 0.05, Two-way ANOVA with validness and delay \n\n',p_valid_delay)
% else
%     cprintf('_red','Anova p(%d) >= 0.05, Two-way ANOVA with validness and delay \n\n',p_valid_delay)
% end
% pause();

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

average_time = nanmean(user_durations(:,4));

euclidian_speed = average_euclidian_distance / average_time;
hor_speed = average_hor_distance / average_time;
ver_speed = average_ver_distance / average_time;

cprintf('_red','euclidian speed = %d units/sec   hor_speed = %d units/sec    ver_speed = %d units/sec',...
    euclidian_speed,hor_speed,ver_speed);
