function K = blur_img(I, windowWidth)

% Whatever you want.  More blur for larger numbers.
kernel = ones(windowWidth) / windowWidth ^ 2;
K = imfilter(I, kernel); % Blur the image.
%imshow(K); % Display it.
end

