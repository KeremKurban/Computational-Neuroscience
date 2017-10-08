function [user_durations ] = myneg(type,color,otherscolor,font,othersNo,user_durations) % yazýyý düzelt
%function for figure plot of type pop_out,type can be x or o
%color can be set. othersNo is the number of other stimuli.

%v1.0 %rettype = 1; % 1 = popo, 2 = popx, 3 = conjo, 4= conjx, 5= neg. control
%v1.1  1=popo, 2=popx, 3=negpop, 4=conjo,5=conjx, 6=negconj    title('press B if you see a blue circle','color','b');
    
    title('press B if you see a blue circle','color','b');
    ax = gca; % to make title bigger
    ax.TitleFontSizeMultiplier = 2; % to make title bigger
    global user_durations
    
    if type == 'x'
    rettype = 6;
    elseif type == 'o'
    rettype = 5;
    end
    
    for i=1:othersNo
    p = text(rand(1),rand(1),'o','color',otherscolor,'fontsize',font);
    q = text(rand(1),rand(1),'x','color',otherscolor,'fontsize',font);
    
        if type == 'x'
            r = text(rand(1),rand(1),'o','color',color,'fontsize',font);
        elseif type == 'o'
            r = text(rand(1),rand(1),'x','color',color,'fontsize',font);
        end
        
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
        user_durations = [user_durations;rettype toc correctness];


    else
        'too late';        
        user_durations = [user_durations;rettype 0 correctness];

    end


end