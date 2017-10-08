function [  ] = reactiontime_analysis( sample1,sample2 )
%plots experimental value based on correct results.
%v1.1  1=popo, 2=popx, 3=negpop, 4=conjo,5=conjx, 6=negconj
% sample1 and sample2 are user_durations

x=[4 8 12 16];

switch nargin
    case 2

        % create empty arrays for further use
        set4_denek1 = zeros(1,80);
        set8_denek1 = zeros(1,80);
        set12_denek1 = zeros(1,80);
        set16_denek1 = zeros(1,80);
        
        set4_denek1_conj = zeros(1,80);
        set8_denek1_conj = zeros(1,80);
        set12_denek1_conj = zeros(1,80);
        set16_denek1_conj = zeros(1,80);
        
        set4_denek1_popneg = zeros(1,80);
        set8_denek1_popneg = zeros(1,80);
        set12_denek1_popneg = zeros(1,80);
        set16_denek1_popneg = zeros(1,80);  

        set4_denek1_conjneg = zeros(1,80);
        set8_denek1_conjneg = zeros(1,80);
        set12_denek1_conjneg = zeros(1,80);
        set16_denek1_conjneg = zeros(1,80);         
        
        set4_denek2 = zeros(1,80);
        set8_denek2 = zeros(1,80);
        set12_denek2 = zeros(1,80);
        set16_denek2 = zeros(1,80);
        
        set4_denek2_conj = zeros(1,80);
        set8_denek2_conj = zeros(1,80);
        set12_denek2_conj = zeros(1,80);
        set16_denek2_conj = zeros(1,80);       
  
        set4_denek2_popneg = zeros(1,80);
        set8_denek2_popneg = zeros(1,80);
        set12_denek2_popneg = zeros(1,80);
        set16_denek2_popneg = zeros(1,80);  

        set4_denek2_conjneg = zeros(1,80);
        set8_denek2_conjneg = zeros(1,80);
        set12_denek2_conjneg = zeros(1,80);
        set16_denek2_conjneg = zeros(1,80);          
        
        for i=1:320
            
                % pop_out 
                
            if sample1(i,1)== 1 && sample1(i,4)== 4
                set4_denek1(1,i) =  sample1(i,2);                
            
        
            elseif sample1(i,1)== 1 && sample1(i,4)== 8
                set8_denek1(1,i) = sample1(i,2);
            

            elseif sample1(i,1)== 1 && sample1(i,4)== 12
                set12_denek1(1,i) = sample1(i,2);
            

            elseif sample1(i,1)== 1 && sample1(i,4)== 16
                set16_denek1(1,i) = sample1(i,2);
                
            
       
                % conjunction

            elseif sample1(i,1)== 4 && sample1(i,4)== 4
                set4_denek1_conj(1,i) = sample1(i,2);                
            
        
            elseif sample1(i,1)== 4 && sample1(i,4)== 8
                set8_denek1_conj(1,i) = sample1(i,2);
            

            elseif sample1(i,1)== 4 && sample1(i,4)== 12
                set12_denek1_conj(1,i) = sample1(i,2);
            

            elseif sample1(i,1)== 4 && sample1(i,4)== 16
                set16_denek1_conj(1,i) = sample1(i,2);
            
               % neg - pop

            elseif sample1(i,1)== 3 && sample1(i,4)== 4
                set4_denek1_popneg(1,i) = sample1(i,2);                
            
        
            elseif sample1(i,1)== 3 && sample1(i,4)== 8
                set8_denek1_popneg(1,i) = sample1(i,2);
            

            elseif sample1(i,1)== 3 && sample1(i,4)== 12
                set12_denek1_popneg(1,i) = sample1(i,2);
            

            elseif sample1(i,1)== 3 && sample1(i,4)== 16
                set16_denek1_popneg(1,i) = sample1(i,2); 
                
              % neg - conj
              
            elseif sample1(i,1)== 6 && sample1(i,4)== 4
                set4_denek1_conjneg(1,i) = sample1(i,2);                
            
        
            elseif sample1(i,1)== 6 && sample1(i,4)== 8
                set8_denek1_conjneg(1,i) = sample1(i,2);
            

            elseif sample1(i,1)== 6 && sample1(i,4)== 12
                set12_denek1_conjneg(1,i) = sample1(i,2);
            

            elseif sample1(i,1)== 6 && sample1(i,4)== 16
                set16_denek1_conjneg(1,i) = sample1(i,2);               

            end

            
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       %%%% NOW  SUBJECT 2
        
               %pop -out
               
            if sample2(i,1)== 1 && sample2(i,4)== 4
                set4_denek2(1,i) =  sample2(i,2);                
            
        
            elseif sample2(i,1)== 1 && sample2(i,4)== 8
                set8_denek2(1,i) = sample2(i,2);
            

            elseif sample2(i,1)== 1 && sample2(i,4)== 12
                set12_denek2(1,i) = sample2(i,2);
            

            elseif sample2(i,1)== 1 && sample2(i,4)== 16
                set16_denek2(1,i) = sample2(i,2);
            
       
                % conj

            elseif sample2(i,1)== 4 && sample2(i,4)== 4
                set4_denek2_conj(1,i) = sample2(i,2);                
            
        
            elseif sample2(i,1)== 4 && sample2(i,4)== 8
                set8_denek2_conj(1,i) = sample2(i,2);
            

            elseif sample2(i,1)== 4 && sample2(i,4)== 12
                set12_denek2_conj(1,i) = sample2(i,2);
            

            elseif sample2(i,1)== 4 && sample2(i,4)== 16
                set16_denek2_conj(1,i) = sample2(i,2);
            
               % neg - pop

            elseif sample2(i,1)== 3 && sample2(i,4)== 4
                set4_denek2_popneg(1,i) = sample2(i,2);                
            
        
            elseif sample2(i,1)== 3 && sample2(i,4)== 8
                set8_denek2_popneg(1,i) = sample2(i,2);
            

            elseif sample2(i,1)== 3 && sample2(i,4)== 12
                set12_denek2_popneg(1,i) = sample2(i,2);
            

            elseif sample2(i,1)== 3 && sample2(i,4)== 16
                set16_denek2_popneg(1,i) = sample2(i,2); 
                
              % neg - conj
              
            elseif sample2(i,1)== 6 && sample2(i,4)== 4
                set4_denek2_conjneg(1,i) = sample2(i,2);                
            
        
            elseif sample2(i,1)== 6 && sample2(i,4)== 8
                set8_denek2_conjneg(1,i) = sample2(i,2);
            

            elseif sample2(i,1)== 6 && sample2(i,4)== 12
                set12_denek2_conjneg(1,i) = sample2(i,2);
            

            elseif sample2(i,1)== 6 && sample2(i,4)== 16
                set16_denek2_conjneg(1,i) = sample2(i,2);                    
            
            
            end        
        
        end
        
        %create y axes for each subject and condition
        
        popy_1 = [mean(set4_denek1(find(set4_denek1)))...
                mean(set8_denek1(find(set8_denek1)))...
                mean(set12_denek1(find(set12_denek1)))...
                mean(set16_denek1(find(set16_denek1)))];
       
        conjy_1= [mean(set4_denek1_conj(find(set4_denek1_conj)))...
                mean(set8_denek1_conj(find(set8_denek1_conj)))...
                mean(set12_denek1_conj(find(set12_denek1_conj)))...
                mean(set16_denek1_conj(find(set16_denek1_conj)))];
            
        popnegy_1 = [mean(set4_denek1_popneg(find(set4_denek1_popneg)))...
                mean(set8_denek1_popneg(find(set8_denek1_popneg)))...
                mean(set12_denek1_popneg(find(set12_denek1_popneg)))...
                mean(set16_denek1_popneg(find(set16_denek1_popneg)))];
        
        conjnegy_1 = [mean(set4_denek1_conjneg(find(set4_denek1_conjneg)))...
                mean(set8_denek1_conjneg(find(set8_denek1_conjneg)))...
                mean(set12_denek1_conjneg(find(set12_denek1_conjneg)))...
                mean(set16_denek1_conjneg(find(set16_denek1_conjneg)))];
        
        popy_2 = [mean(set4_denek2(find(set4_denek2)))...
                mean(set8_denek2(find(set8_denek2)))...
                mean(set12_denek2(find(set12_denek2)))...
                mean(set16_denek2(find(set16_denek2)))];
       
        conjy_2= [mean(set4_denek2_conj(find(set4_denek2_conj)))...
                mean(set8_denek2_conj(find(set8_denek2_conj)))...
                mean(set12_denek2_conj(find(set12_denek2_conj)))...
                mean(set16_denek2_conj(find(set16_denek2_conj)))];     
        
        popnegy_2 = [mean(set4_denek2_popneg(find(set4_denek2_popneg)))...
                mean(set8_denek2_popneg(find(set8_denek2_popneg)))...
                mean(set12_denek2_popneg(find(set12_denek2_popneg)))...
                mean(set16_denek2_popneg(find(set16_denek2_popneg)))];
        
        conjnegy_2 = [mean(set4_denek2_conjneg(find(set4_denek2_conjneg)))...
                mean(set8_denek2_conjneg(find(set8_denek2_conjneg)))...
                mean(set12_denek2_conjneg(find(set12_denek2_conjneg)))...
                mean(set16_denek2_conjneg(find(set16_denek2_conjneg)))];           
       
        
        
        zpop = cat(3,popy_1,popy_2);
        zconj = cat(3,conjy_1,conjy_2);
        zpopneg = cat(3,popnegy_1,popnegy_2);
        zconjneg = cat(3,conjnegy_1,conjnegy_2);
        
        meanofsubjectspop = mean(zpop,3);
        meanofsubjectsconj = mean(zconj,3);
        meanofsubjectspopneg = mean(zpopneg,3);
        meanofsubjectsconjneg = mean(zconjneg,3);
        
        %plot when target is present
        target_fig = figure();
        
        popplot = plot(x,meanofsubjectspop,'x-');
        hold on
        conjplot = plot(x,meanofsubjectsconj,'o-');
        nopopplot = plot(x,meanofsubjectspopneg,'b-');
        noconjplot = plot(x,meanofsubjectsconjneg,'c-');
        legend([popplot,conjplot,nopopplot,noconjplot],'pop-out','conj-plot','pop-out abs','conjunction abs')
        
        xlabel('Set size')
        ylabel('RT')
        title('Target present and absent')
        
        
        %legend([popplot,conjplot],'pop-out p','conjunction p')
        
%         pause;
%         %pause;
%         
%         %plot when target is absent
%         %no_target_fig = figure();
%         nopopplot = plot(x,meanofsubjectspopneg,'b-');
%         hold on
%         noconjplot = plot(x,meanofsubjectsconjneg,'c-');
%         xlabel('Set size')
%         ylabel('RT')
%         legend([nopopplot,noconjplot],'pop-out abs','conjunction abs')
%         title('Target absent')
        
        
        %correlation analysis
        [rpop,Ppop] = corrcoef(meanofsubjectspop,x);
        [rconj,Pconj] = corrcoef(meanofsubjectsconj,x);
        [rpopneg,Ppopneg] = corrcoef(meanofsubjectspopneg,x);
        [rconjneg,Pconjneg] = corrcoef(meanofsubjectsconjneg,x);
        
        
        cprintf('_blue','pop_out : p value:%10f \npearson correlation coef:%10f \n\n',Ppop(2),rpop(2))
        cprintf('_blue','conjunction : p value:%10f \npearson correlation coef:%10f \n\n',Pconj(2),rconj(2))
        cprintf('_blue','pop_out/target absent: p value:%10f \npearson correlation coef:%10f \n\n',Ppopneg(2),rpopneg(2))
        cprintf('_blue','conjunction/target absent: p value:%10f \npearson correlation coef:%10f \n\n',Pconjneg(2),rconjneg(2))
  
    
    
    
    
    
    
    case 1 
        % popout y getting
        set4_denek1 = zeros(1,80);
        set8_denek1 = zeros(1,80);
        set12_denek1 = zeros(1,80);
        set16_denek1 = zeros(1,80);
        
        set4_denek1_conj = zeros(1,80);
        set8_denek1_conj = zeros(1,80);
        set12_denek1_conj = zeros(1,80);
        set16_denek1_conj = zeros(1,80);
        
        for i=1:320
            
            if sample1(i,1)== 1 && sample1(i,4)== 4
                set4_denek1(1,i) =  sample1(i,2);                
            %end
        
            elseif sample1(i,1)== 1 && sample1(i,4)== 8
                set8_denek1(1,i) = sample1(i,2);
            %end

            elseif sample1(i,1)== 1 && sample1(i,4)== 12
                set12_denek1(1,i) = sample1(i,2);
            %end

            elseif sample1(i,1)== 1 && sample1(i,4)== 16
                set16_denek1(1,i) = sample1(i,2);
            %end
       
                % time for conj to be filtered

            elseif sample1(i,1)== 4 && sample1(i,4)== 4
                set4_denek1_conj(1,i) = sample1(i,2);                
            %end
        
            elseif sample1(i,1)== 4 && sample1(i,4)== 8
                set8_denek1_conj(1,i) = sample1(i,2);
            %end

            elseif sample1(i,1)== 4 && sample1(i,4)== 12
                set12_denek1_conj(1,i) = sample1(i,2);
            %end

            elseif sample1(i,1)== 4 && sample1(i,4)== 16
                set16_denek1_conj(1,i) = sample1(i,2);
            end            
        
        end
        
        
        popy_1 = [mean(set4_denek1(find(set4_denek1)))...
                mean(set8_denek1(find(set8_denek1)))...
                mean(set12_denek1(find(set12_denek1)))...
                mean(set16_denek1(find(set16_denek1)))]
       
        conjy_1= [mean(set4_denek1_conj(find(set4_denek1_conj)))...
                mean(set8_denek1_conj(find(set8_denek1_conj)))...
                mean(set12_denek1_conj(find(set12_denek1_conj)))...h
                mean(set16_denek1_conj(find(set16_denek1_conj)))]
        
        popplot = plot(x,popy_1);
        
        hold on
        conjplot = plot(x,conjy_1);
        
        xlabel('Set size')
        ylabel('RT')
        legend([popplot,conjplot],'pop-out','conjunction')
        
        
    otherwise
        fprintf(2,'too many input arguments')
end
        

