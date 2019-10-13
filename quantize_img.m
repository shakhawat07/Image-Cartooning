function K = quantize_img(I)
%I = imread('fruit.png');
%imshow(I) 
%axis off
%title('RGB Image');

threshRGB = multithresh(I,7);

threshForPlanes = zeros(3,7);			

for i = 1:3
    threshForPlanes(i,:) = multithresh(I(:,:,i),7);
end
value = [0 threshRGB(2:end) 255]; 
quantRGB = imquantize(I, threshRGB, value);

quantPlane = zeros( size(I) );

for i = 1:3
    value = [0 threshForPlanes(i,2:end) 255]; 
    quantPlane(:,:,i) = imquantize(I(:,:,i),threshForPlanes(i,:),value);
end

quantPlane = uint8(quantPlane);
K = quantPlane;
%imshowpair(quantRGB,quantPlane,'montage') 
%imshow(quantPlane);
%axis off
%title('Full RGB Image Quantization        Plane-by-Plane Quantization')

end