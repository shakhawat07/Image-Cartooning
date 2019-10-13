function K = cartoon_img(I);
%I = imresize(I, [480 NaN]);
%I = enhancecolor(I, 240);%value er theke beshi hole minus
%I = hsv2rgb(rgb2hsv(I) .* cat(3, 1, 1.2, 1)); 
%figure;imshow(I);
%% Bilateral filter
bi = bilateralfiltering(I, 5);
%imshow(bi);
%% Quantization

quan = quantize_img(bi);
%imshow(quan);
quan = blur_img(quan, 1);
imwrite(quan, 'filt.jpg');
%% Differnce of Gaussian
%close all;
e = DiffGaussian(bi, 5, 0.5);%kalor upor colour edge
imwrite(e, 'diff.jpg');
e = rgb2gray(e);
e = imbinarize(e);

se = strel('line', 1,0);
e = imdilate(e, se);
%figure; imshow(e);
e = imcomplement(e);
imshow(e);
%% Combine

fin = combining(e, quan, 140);
fin = blur_img(fin, 2);
%fin = enhancecolor(fin,200);
fin = hsv2rgb(rgb2hsv(fin) .* cat(3, 1, 1.1, 1)); 
K = fin;
%fin = lab2rgb(fin);
%fin = warp(fin);
imwrite(fin, 'out.jpg');
%figure;imshow(fin);

end

