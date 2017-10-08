function [user_durations ] = myconj(type,color,otherscolor,font,othersNo,user_durations) %yazýyý düzelt
%function for figure plot of type conj,type can be x or o
%color can be set. othersNo is the number of other stimuli.

%v1.1  1=popo, 2=popx, 3=negpop, 4=conjo,5=conjx, 6=negconj

    title('press B if you see a blue circle,M if not','color','b');
    ax = gca; % to make title bigger
    ax.TitleFontSizeMultiplier = 2; % to make title bigger
    set(gca,'YTickLabel',[]);
    set(gca,'XTickLabel',[]);
    global user_durations
    global count
    
    if type == 'x'
    rettype = 5;
    x = text(rand(1),rand(1),'x','color',color,'fontsize',font);
    
        %hem x/o dengesi hem renk dengesini saglanamaz, sadece x/o dengesi
        for i=1:othersNo/2 % must be an even number
            y = text(rand(1),rand(1),'o','color',otherscolor,'fontsize',font);
            z = text(rand(1),rand(1),'o','color',color,'fontsize',font);
        end

        for i=1:othersNo-1
            t = text(rand(1),rand(1),'x','color',otherscolor,'fontsize',font);
        end
    
    elseif type == 'o'
    rettype = 4;
    x = text(rand(1),rand(1),'o','color',color,'fontsize',font);
    
        %hem x/o dengesi hem renk dengesini saglanamaz, sadece x/o dengesi
        for i=1:othersNo/2
            y = text(rand(1),rand(1),'x','color',otherscolor,'fontsize',font);
            z = text(rand(1),rand(1),'x','color',color,'fontsize',font);
        end

        for i=1:othersNo-1
            t = text(rand(1),rand(1),'o','color',otherscolor,'fontsize',font);
            
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

