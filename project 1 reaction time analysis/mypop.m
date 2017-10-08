
function [user_durations ] = mypop(type,color,otherscolor,font,othersNo) % yazýyý düzelt
%function for figure plot of type pop_out,type can be x or o
%color can be set. othersNo is the number of other stimuli.

%v1.0 %rettype = 1; % 1 = popo, 2 = popx, 3 = conjo, 4= conjx, 5= neg. control
%v1.1  1=popo, 2=popx, 3=negpop, 4=conjo,5=conjx, 6=negcon
    title('press B if you see a blue circle','color','b');
    ax = gca; % to make title bigger
    ax.TitleFontSizeMultiplier = 2; % to make title bigger
    set(gca,'YTickLabel',[]);
    set(gca,'XTickLabel',[]);
    global user_durations
    global count
    
    if type == 'x'
    rettype = 2;
    a = text(rand(1),rand(1),'x','color',color,'fontsize',font);
        
        %sadece x/o dengesini sagla
        for i=1:othersNo
            b = text(rand(1),rand(1),'o','color',otherscolor,'fontsize',font);
        end

        for i=1:othersNo-1
            c = text(rand(1),rand(1),'x','color',otherscolor,'fontsize',font);
        end
    
    elseif type == 'o'
    rettype = 1;
    a = text(rand(1),rand(1),'o','color',color,'fontsize',font);
    
        %sadece x/o dengesini sagla
        for i=1:othersNo-1
            b = text(rand(1),rand(1),'o','color',otherscolor,'fontsize',font);
        end

        for i=1:othersNo
            c = text(rand(1),rand(1),'x','color',otherscolor,'fontsize',font);
        end    
    
    end
    
    
    tic;pause;
    press = get(gcf,'CurrentCharacter');
    toc;
    
    trueanswer = 'b';
    if press == trueanswer
        correctness = 1;
    else
        correctness = 0;
    end
    
    if toc<4
        user_durations(count,:) = [rettype toc correctness othersNo];
    else
        'too late';        
        user_durations(count,:) = [rettype 0 correctness othersNo];
        
    end

end
