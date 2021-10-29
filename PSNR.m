function [result] = PSNR(img_1, img_2)
	
	S_error = (double(img_1) - double(img_2)).^2; % convert to double so that it matches built-in-function
	MSE = mean(S_error(:)); %first, we find MSE(Mean-square error)
	result = 10 * log10((255^2)/(MSE)); %find PSNR
end

