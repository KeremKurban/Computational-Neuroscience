%analysis
%   i current_pause current_valid elapsed_time correctness deltax deltay euclidian_dist

%1: t test valid/invalid

    true_answer_ind = find(user_durations(:,5) == 1); % soru doðru cevaplanmýþ
    false_answer_ind = find(user_durations(:,5) == 0); % soru yanlýþ cevaplanmýþ
    
    valid_indices = find(user_durations(:,3) == 1); % valid trials
    invalid_indices = find(user_durations(:,3) == 0); % invalid trials
    true_valid_ind = intersect(true_answer_ind,valid_indices); % true + valid / indices
    true_invalid_ind = intersect(true_answer_ind,invalid_indices); % true + invalid / indices
    
    % from intersection indices, pull reaction times
    valids = user_durations(true_valid_ind,4);
    invalids = user_durations(true_invalid_ind,4);

    [significant_valid,p_valid] = ttest2(valids,invalids);
    
%2: delay t test

    t100_ind = find(user_durations(:,2) == 0.1);
    t300_ind = find(user_durations(:,2) == 0.3);
    t100ind_true = intersect(t100_ind,true_answer_indices);
    t300ind_true = intersect(t300_ind,true_answer_indices);
    
    % from intersection indices, pull reaction times(RT)
    t100_true = user_durations(t100ind_true,4);
    t300_true = user_durations(t300ind_true,4);
    
    [significant_delay,p_delay] = ttest2(t100_true,t300_true);
    
    
%3 distance t test (x & y & euclidian)

    %------------------ Horizontal dist:
    hor_dist_ind = user_durations(:,6); %horizontal distances
    hor_dist_ind_false = intersect(hor_dist_ind,false_answer_indices); %horizontal dist ind yanlýþ cevaplananlarda
    
    hor_dist_val_false = user_durations(hor_dist_ind_false,6); %horizontal dist vals yanlýþ cevaplananlarda
    
    %pull RT
    RT_hdvf = user_durations(hor_dist_ind_false,4);
    
    %plot hor-dist vs RT:
    horplot = figure();
    plot(hor_dist_val_false,RT_hdvf)
    
    title('Horizontal dist_false vs Reaction Times')
    xlabel('Horizontal Distance')
    ylabel('RT')
    pause;
    
    %------------------ Vertical dist:
    ver_dist_ind = user_durations(:,7);
    ver_dist_ind_false = user_durations(ver_dist_ind,false_answer_indices);
    
    ver_dist_val_false = user_durations(ver_dist_ind_false,7);
    
    %pull RT
    RT_vdvf = user_durations(ver_dist_ind_false,4);
    
    %plot ver-dist vs RT:
    verplot = figure();
    plot(ver_dist_val_false,RT_vdvf)
    
    title('Vertical dist_false vs Reaction Times')
    xlabel('Vertical Distance')
    ylabel('RT')
    pause;    
    
    
    %------------------ Total dist:
    tot_dist_ind = user_durations(:,8);
    tot_dist_ind_false = user_durations(tot_dist_ind,false_answer_indices);
    
    tot_dist_val_false = user_durations(tot_dist_ind_false,8);
    
    %pull RT
    RT_tdvf = user_durations(tot_dist_ind_false,4);
    
    %plot ver-dist vs RT:
    totplot = figure();
    plot(tot_dist_val_false,RT_tdvf)
    
    title('Total dist_false vs Reaction Times')
    xlabel('Total Distance')
    ylabel('RT')
    pause;    
    
%4 ALL anova
