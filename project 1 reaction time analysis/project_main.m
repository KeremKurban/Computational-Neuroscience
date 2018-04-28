% her zaman mavi o, diðer distractorlar kýrmýzý ve 5 er defa, font 15
% set size beforehand later
%v1.0 %rettype = 1; % 1 = popo, 2 = popx, 3 = conjo, 4= conjx, 5= neg. control
%v1.1  1=popo, 2=popx, 3=negpop, 4=conjo,5=conjx, 6=negconj


start = figure('units','normalized','outerposition',[0 0 1 1],'Name','Start');
title('press B if you see a blue circle','color','b');
ax = gca; % to make title bigger
ax.TitleFontSizeMultiplier = 2; % to make title bigger
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
starttext = text(0.45,0.5,'Get READY','color','b','fontsize',30);
pause;
input0 = get(gcf,'CurrentCharacter');

global count
count = 1;
%hold off

global user_durations
%user_durations = [];
user_durations = zeros(320,4);

%tekrarno = 4;

if input0 ~= '-'
    delete(starttext)
    
    for othersNo = [4,8,12,16]
    maxpopno = 20;
    maxconjno = 20;
    maxnegpop = 20;
    maxnegconj = 20;
    tekrarno = maxpopno + maxconjno + maxnegpop +maxnegconj;
    
    incoming = randi(4);
    
        %for idx=1:tekrarno
        iter = 0;
        while iter < tekrarno 
            

            if incoming == 1
                if maxpopno>0
                    mypop('o','b','r',15,othersNo);
                    maxpopno = maxpopno -1;
                    iter = iter + 1;
                    incoming = randi(4);
                    count = count +1;
                else
                    incoming = [2,3,4];
                    incoming =incoming(randi([1 numel(incoming)]));
                end
                
                    
            elseif incoming == 2
                if maxconjno>0
                    myconj('o','b','r',15,othersNo);
                    maxconjno = maxconjno - 1;
                    iter = iter + 1;
                    incoming = randi(4);
                    count = count +1;
                else
                    incoming = [1,3,4];
                    incoming =incoming(randi([1 numel(incoming)]));    
                end

                
            elseif incoming == 3
                if maxnegpop>0         
                    negpop('o','b','r',15,othersNo);
                    maxnegpop = maxnegpop - 1;
                    iter = iter + 1;
                    incoming = randi(4);
                    count = count +1;
                else
                    incoming = [1,2,4];
                    incoming =incoming(randi([1 numel(incoming)]));
                end
                
            elseif incoming == 4
                if maxnegconj>0
                    negconj('o','b','r',15,othersNo);
                    maxnegconj = maxnegconj -1;
                    iter = iter + 1;
                    incoming = randi(4);
                    count = count +1;
                else
                    incoming = [1,2,3];
                    incoming =incoming(randi([1 numel(incoming)]));
                end
            end
        
            clf(start)
    
        end
    end
    
    close ALL

    
end

final = [size(find(user_durations(:,1) == 1));
size(find(user_durations(:,1) == 2));
size(find(user_durations(:,1) == 3));
size(find(user_durations(:,1) == 4));
size(find(user_durations(:,1) == 5));
size(find(user_durations(:,1) == 6))];



