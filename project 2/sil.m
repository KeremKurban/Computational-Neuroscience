userds = [1 2 3 4 5;6 7 8 9 10];

% prompt = 'subject name? :';
% ad =  input(prompt,'s');
% subjects(1).name = 'ali';
% subjects(1).ud = userds;
% 
% 
% subjects(2).name = 'veli';
% subjects(2).ud = userds.*2;



prompt = 'Name of the subject1? ';
name = input(prompt,'s');

[subjects_test(name).name] = name;
[subjects_test(name).ud] = userds;


save('subjects_posner','subjects_test','-append')


% prompt2 = 'Name of the subject2?a ';
% name2 = input(prompt2,'s');
% 
% subjects_test(2).name = name2;
% subjects_test(2).ud = userds.*2;
% 
% 
% save('deneklertest','subjects_test','-append')