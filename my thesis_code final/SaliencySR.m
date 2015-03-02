%%From author
%clear
%clc
function [saliencyMap]=SaliencySR(Is)
%% Read image from file 
inImg = im2double(Is);

%% Spectral Residual
myFFT = fft2(inImg); 
myLogAmplitude = log(abs(myFFT));
myPhase = angle(myFFT);
mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 5), 'replicate'); 
saliencyMap = abs(ifft2(exp(mySpectralResidual + i*myPhase))).^2; 

%% After Effect
saliencyMap = mat2gray(imfilter(saliencyMap, fspecial('gaussian', [16, 16], 10)));

end