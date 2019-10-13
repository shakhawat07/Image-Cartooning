function K = bilateralfiltering(I, sigma)

patch = imcrop(I,[180, 35, 20, 20]);
%imshow(patch);

patchVar = std2(patch)^2;

DoS = 2*patchVar;
J = imbilatfilt(I,DoS);
%imshow(J);
title(['Degree of Smoothing: ',num2str(DoS)]);
%K=J;
K = imbilatfilt(I,DoS,sigma);

%title(['Degree of Smoothing: ',num2str(DoS),', Spatial Sigma: 2']);


end

