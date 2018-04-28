%% OLD formulas

%% OLD ISI : using a threshold find the first point where thr is passed to find refractory period

% a simple voltage threshold won't help need to utilize derivatives or when reached 40%
% of the min value , can be 34% 30% up to you.

%zeros matrix beforehand:
signal_start_idx_big = zeros(length(ap_d1_big),1);

for i=1:length(ap_d1_big)
    current_signal = ap_d1_big(i,:);
    min_val = min(current_signal);
    thr = min_val * 0.4;
    %find the first idx where thr is passed
    passed_idx = find(current_signal < thr, 1, 'first') - 1;
    signal_start_idx_big(i,1) =  passed_idx;
end
%diff(ap_d1_big(1,:),2)

%% OLD ISI: Do it for small cluster too
signal_start_idx_small = zeros(length(ap_d1_small),1);

for i=1:length(ap_d1_small)
    current_signal = ap_d1_small(i,:);
    min_val = min(current_signal);
    thr = min_val * 0.4;
    %find the first idx where thr is passed
    passed_idx = find(current_signal < thr, 1, 'first') - 1;
    signal_start_idx_small(i,1) =  passed_idx;
end