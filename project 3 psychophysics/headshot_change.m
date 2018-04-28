test_disp = uint8(zeros(3,3,3));

%%
figure
subplot(2,2,1)
image(test_disp)
%%
test_disp(2,2,:) = 255;
subplot(2,2,2)
image(test_disp)
%%
subplot(2,2,3)
test_disp(2,2,1) = 0;
image(test_disp)
%%
test_disp(2,2,:) = 0;
test_disp(2,2,1) = 255;
subplot(2,2,4)
image(test_disp)