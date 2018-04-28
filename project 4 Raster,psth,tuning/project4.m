% load Chap13_Spike
% 
% figure
% hold on
% for i=1:length(spike)%each line in unit
%     t = spike(i).times;
%     for j=1:length(t)
%         line([t(j) t(j)],[i-1 i])
%     end
% end
% 
% ylim([0 length(spike)])
% xlabel('Time (sec)')

load Chapter13_CenterOutTrain

figure
hold on

max_units_no = 1;
%max_units_no = length(unit);







%Part 2: from -0.5s to 0.5s for introductions