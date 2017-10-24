%  figure
%  subplot(2,2,1)
%  image(uint8(bigmatrix2(:,:,:,1)))
%  subplot(2,2,2)
%  image(uint8(bigmatrix2(:,:,:,1)+50))
%  subplot(2,2,3)
%  image(uint8(bigmatrix2(:,:,:,1)-50))
%  subplot(2,2,4)
%  bigmatrix2(:,:,1,1) = bigmatrix2(:,:,1,1) + 100;
%  image(uint8(bigmatrix2(:,:,:,1)))
 
 pic = imread('hisoka_hmm.jpg');
 figure
 subplot(2,2,1)
 image(pic)
 
 %This code creates a very slightly low-pass filtered 
 %version of the image.
 filter = ones(3,3);
 lp3 = convn(pic,filter);
 lp3 = lp3./9;
 subplot(2,2,2)
 image(uint8(lp3))
 
 
 %now more radical lpf
 
filter = ones(25,25);
lp25 = convn(pic,filter);
lp25 = lp25./625;
subplot(2,2,3)
image(uint8(lp25))

% filter = ones(25,50);
% lp25 = convn(pic,filter);
% lp25 = lp25./625;
% subplot(2,2,4)
% image(uint8(lp25))

lp25cor = lp25(13:612,13:812,:);

% subplot(2,2,4)
% hp = pic-uint8(lp25cor);
% %hp = bsxfun(@minus, pic, uint8(lp25cor));
% image(hp)
% hp = hp+127;
% image(hp)

%moving 100 birim
figure
pic3= circshift(pic,[100 0 0]);
image(pic3)
%%
%movie
figure
pic4 = pic;
for i = 1:size(pic4,1)/10+1
image(pic4)
pic4 = circshift(pic4,[10 0 0]);
M(i) = getframe;
end

%%

figure
for i = 1:3
subplot(1,3,i)
image(pic)
axis equal
axis off
pic = circshift(pic,[0 0 1]);
end