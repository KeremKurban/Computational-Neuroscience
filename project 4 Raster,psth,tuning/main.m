neuronNum = 101;


load Chapter13_CenterOutTrain
%choose a default neuron if none specified
if ~exist('neuronNum')
    neuronNum=78;
end

graph = [6 3 2 1 4 7 8 9]; 
figure
hold on
for i=1:8
    indDir=find(direction==i); %find trials in a given direction
    numTrials=length(indDir);
    subplot(3,3,graph(i)) % neye gore
    for j =1:numTrials % o directionda kac tane oldugu triallarin
        %pick one of the following:
        
        centerTime=go(indDir(j)); %to center on start of movement time
        %centerTime=instruction(indDir(j)); %to center on instruction time

        allTimes=unit(neuronNum).times-centerTime; %center spike times
        spikeTimes=allTimes(allTimes>-0.5&allTimes<0.5); %pick 2 seconds around center time

        %plot a line
        for k = 1:length(spikeTimes)
                line([spikeTimes(k) spikeTimes(k)],[j-1 j]);              
        end
    end
    ylim([0 numTrials])
end

 h=subplot(3,3,5);
set(h,'Visible','off')
chanNum=unit(neuronNum).chanNum;
unitNum=unit(neuronNum).unitNum;
text(0.25,0.5,['Channel ' num2str(chanNum) '-' num2str(unitNum)])


load Chapter13_CenterOutTrain
%choose a default neuron if none specified
if ~exist('neuronNum')
    neuronNum=78;
end

graph = [6 3 2 1 4 7 8 9]; %sets the order to plot graphs in
figure
hold on

%set edges of the PST histogram

edgesPeri = -0.5:.02:0.5;  % 20 ms bins
%edgesPeri = 0:.02:1;  % 20 ms bins

psth=zeros(length(edgesPeri),8);

%compute PSTH for each direction
for i=1:8
    indDir=find(direction==i); %find trials in a given direction
    numTrials(i)=length(indDir);
    
    for j =1:numTrials(i)
        %pick one of the following:
        
        centerTime=go(indDir(j)); %to center on start of movement time
        %centerTime=instruction(indDir(j)); %to center on instruction time

        allTimes=unit(neuronNum).times-centerTime; %center spike times
        spikeTimes=allTimes(allTimes>-0.50&allTimes<0.5); %pick 2 seconds around center time

        %add histogram of present trial to PSTH
        psth(:,i)=psth(:,i)+histc(spikeTimes,edgesPeri);
    end  
    %divide by the number of trials & bin size for a mean firing rate
    psthNorm(:,i)=psth(:,i)/numTrials(i)/.02;
end

yMax=max(max(psthNorm));
for i=1:8
    subplot(3,3,graph(i))
    bar(edgesPeri,psthNorm(:,i))
    ylim([0 yMax])
    xlim([-0.55 0.55])
end

h=subplot(3,3,5);
set(h,'Visible','off')
chanNum=unit(neuronNum).chanNum;
unitNum=unit(neuronNum).unitNum;
text(0.25,0.5,['Channel ' num2str(chanNum) '-' num2str(unitNum)])


load Chapter13_CenterOutTrain

%choose a default neuron if none specified
if ~exist('neuronNum')
    neuronNum=129;
end

%bin firing rates for each direction
spikeCount=zeros(8,1);
for i=1:8
    indDir=find(direction==i); %find trials in a given direction
    numTrials(i)=length(indDir);
    
    for j =1:numTrials(i)
        %pick one of the following:
        
        centerTime=go(indDir(j)); %to center on start of movement time
        %centerTime=instruction(indDir(j)); %to center on instruction time

        allTimes=unit(neuronNum).times-centerTime; %center spike times
        spikeCount(i)=spikeCount(i)+sum(allTimes>0&allTimes<1); %pick 2 seconds around center time
    end  
    %divide by the number of trials & bin size (2 s) for a mean firing rate
    spikeCount(i)=spikeCount(i)/numTrials(i)/2;
end

%fit a tuning curve to "spikeCount"
ang = [0:45:315];
mystring = 'p(1)+p(2)*cos(theta/180*pi-p(3))';
myfun = inline(mystring,'p','theta');
[param, error] = nlinfit(ang',spikeCount,myfun,[1 1 0]);
fit = myfun(param,[0:359]);

%plot raw data, tuning curve
figure
plot(ang,spikeCount)
xlabel('Angle')
ylabel('Avg Firing Rate')
chanNum=unit(neuronNum).chanNum;
unitNum=unit(neuronNum).unitNum;
title(['Tuning Curve: Chan ' num2str(chanNum) '-' num2str(unitNum)])
hold on
plot([0:359],fit,'r-.')
legend('Actual','Fit')
text(250,15,['mean error: ' num2str(mean(error))],'color','r')

%easiest to pick preferred direction (in degrees) from fit data
[p,prefDir]=max(fit);
prefDir
    