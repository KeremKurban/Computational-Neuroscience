function [user_durations ] = negpop(type,color,otherscolor,font,othersNo,user_durations) % yazýyý düzelt
%function for figure plot of type pop_out,type can be x or o
%color can be set. othersNo is the number of other stimuli.
% negpop needs to be handled if type = x

%v1.0 %rettype = 1; % 1 = popo, 2 = popx, 3 = conjo, 4= conjx, 5= neg. control
%v1.1  1=popo, 2=popx, 3=negpop, 4=conjo,5=conjx, 6=negconj    title('press B if you see a blue circle','color','b');
    
    title('press B if you see a blue circle','color','b');
    ax = gca; % to make title bigger
    ax.TitleFontSizeMultiplier = 2; % to make title bigger
    set(gca,'YTickLabel',[]);
    set(gca,'XTickLabel',[]);
    global user_durations
    global count
    
    
    rettype = 3;
    
    for i=1:othersNo
    p = text(rand(1),rand(1),'o','color',otherscolor,'fontsize',font);
    q = text(rand(1),rand(1),'x','color',otherscolor,'fontsize',font);
         
    end
    
    tic;pause;
    press = get(gcf,'CurrentCharacter');
    toc;
    
    falseanswer = 'b';
    if press == falseanswer
        correctness = 0;
    else
        correctness = 1;
    end
    
    if toc<4
        user_durations(count,:) = [rettype toc correctness othersNo];

    else
        'too late';        
        user_durations(count,:) = [rettype 0 correctness othersNo];

    end

end