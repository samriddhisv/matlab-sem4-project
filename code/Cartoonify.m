close all;
clear;

filename = '../data/im_12.bmp';

img = imread(filename);
%original image array was stored as unsigned 8 bit integers
%Once the floating point equivalent is constructed, 1 is added to eac helement of the array.
img = double(img); 

a = 24;  % Quantization Factor
%the standard RGB color palette of 256^3 colors is reduced to a palette of [256/24]^3 unique colors.

img_smooth = img;
%% 1. Apply Median Filter to remove Salt and Pepper noise
%img(:,:,1) selects the first "pane" of the array "img".
%if the array has multiple panes (e.g., an RGB image), it selects the first of them (probably the Red pane.)
img_smooth(:,:,1) = medfilt2(img(:,:,1),[7,7]);
img_smooth(:,:,2) = medfilt2(img(:,:,2),[7,7]);
img_smooth(:,:,3) = medfilt2(img(:,:,3),[7,7]);

%%
for i=1:3
    img_smooth = myBilateralFiltering(img_smooth,10,20,3);
end
filtered = img_smooth;

edges = edgedetector(img);
edges = edges/max(edges(:));
cartoon_img = filtered;

%%
for i = 1:3
    % Quantize the Values
    t = a*floor(filtered(:,:,i)./a);
    t(edges>0.18) = 0;
    cartoon_img(:,:,i) = t;
end
% file_name = strcat(['../Results/' filename(9:length(filename)-4) '_toon.' 'png']);
% imwrite(mat2gray(cartoon_img),file_name)
% end
figure
subplot(1,3,3)
imshow(mat2gray(cartoon_img));
title('Cartoon')
subplot(1,3,1)
imshow(mat2gray(img));
title('Original')
subplot(1,3,2)
imshow(edges);
title('Edges')