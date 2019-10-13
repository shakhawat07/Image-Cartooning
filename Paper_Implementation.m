clear;
%rgb = imread('coloredChips.png');
%rgb = imread('joker2.jpg');
%rgb = imread('joker.png');
%rgb = imread('peppers.png');
%rgb = imread('sk.jpg');
%rgb = imread('mou.png');
rgb = imread('meye.jpg');
rgb = imresize(rgb,[400 NaN]);
figure;
imshow(rgb);
title('Input Image');


lab = rgb2lab(rgb);
figure;
imshow(lab);
title('Cielab Image');


% lab2rgb_image = lab2rgb(lab);
% figure;
% imshow(lab2rgb_image);
% title('lab2rgb convert');

kernelver = [ -1 -1 -1 ; 0 0 0 ; 1 1 1];
%kernelver = [ -1 -2 -1 ; 0 0 0 ; 1 2 1];
filteredver = imfilter(lab,kernelver);
figure;
imshow(filteredver);
title('Vertical prewitt masking');

kernelhor = [ -1 0 1 ; -1 0 1 ; -1 0 1];
%kernelhor = [ -1 0 1 ; -2 0 2 ; -1 0 1];
filteredhor = imfilter(lab,kernelhor);
figure;
imshow(filteredhor);
title('Horizontal prewitt masking');

filtered = (filteredver.^2+filteredhor.^2).^0.5;
figure;
imshow(filtered);
title('Prewitt masking');




filteredtoRGB = lab2rgb(filtered);
figure;
imshow(filteredtoRGB);%%%input_image
title('Cielab to sRGB');

%%% gausian_filter
% sigma = 1;
% rgb_smoothed = imgaussfilt(filteredtoRGB,sigma);
% figure;
% imshow(rgb_smoothed);
% title('Gaussian_filter');


%%%Bilateral
% patch = imcrop(lab,[34,71,60,55]);
% patchSq = patch.^2;
% edist = sqrt(sum(patchSq,3));
% patchVar = std2(edist).^2;
% 
% DoS = 2*patchVar;
smoothedLAB = imbilatfilt(lab);
%smoothedLAB = uint8(smoothedLAB);
figure;
imshow(smoothedLAB);
title('Bilateral on cilab');


smoothedLAB = lab2rgb(smoothedLAB);
%rgb_smoothed = im2uint16(rgb_smoothed);
filteredtoRGB = im2uint16(filteredtoRGB);
smoothedLAB = im2uint16(smoothedLAB);


%final = bitor(rgb_smoothed,smoothedLAB);
final = bitor(filteredtoRGB,smoothedLAB);
%final = im2double(final);
%final = lab2rgb(final);
figure;
imshow(final);
title('Cartooning_ mage');
