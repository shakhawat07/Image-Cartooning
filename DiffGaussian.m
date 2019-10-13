function K = DiffGaussian(I, sigma_1, sigma_2)

gauss1 = fspecial('gaussian', round([10*sigma_1 10*sigma_1]), sigma_1);

gauss2 = fspecial('gaussian', round([10*sigma_2 10*sigma_2]), sigma_2);
%img = imread('fruit.png');
blur1 = imfilter(I, gauss1, 'replicate', 'same');
blur2 = imfilter(I, gauss2, 'replicate', 'same');
K = blur1 - blur2;
%K = imcomplement(K);
%imshow(K);
end