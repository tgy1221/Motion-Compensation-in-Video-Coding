clear all; close all;clc;

%%Image Processing
ref_img = imread('Image67.jpg'); %read image %as reference image
target_img = imread('Image68.jpg'); %as target image
ref_img = im2double(ref_img); %modelling the image
target_img = im2double(target_img);
[height, width, channels] = size(ref_img); %size of image



%Experimenting with different parameter
strategy_list = {'fullsearch','3stepsearch'}; %search method
search_range = [8 16 32];  %search range 
block_size = [8 16 32]; %try different block size used for matching  [8x8 16x16]
MSE = zeros(length(strategy_list), length(search_range), length(block_size));  %Mean Squared Errir to evaluate the motion vector
psnr = zeros(length(strategy_list), length(search_range), length(block_size)); %for every combination of strategy, search range and block size
computations1=0;
computations2=0;
computations3=0;
%%MAIN
for index_r = 1:length(search_range) %[8 16 32]
	R = search_range(index_r);
	for index_b = 1:length(block_size) %[8 16 32]
		blockSize = block_size(index_b);
		for index_s = 1:length(strategy_list)
			searchAlgo = strategy_list(index_s); %Search Algorithm
			motionVector = zeros(height/blockSize, width/blockSize, 2); %Define motion Vector
			predicted_img = zeros(height, width, channels); %Define predicted image
			totalMSE = 0; %store total MSE
            tic;
                for h = 1:blockSize:height %1:9:192 %each location
                    for w = 1:blockSize:width%1:9:352
                        % Motion estimation in each block
                        if strcmp(searchAlgo, 'fullsearch') 
                            [predicted_block, blockMotionVector, r_MSE,computations1] = FullSearch(ref_img, target_img, h, w, width, height, R, blockSize);
                        elseif strcmp(searchAlgo, '3stepsearch')
                            [predicted_block, blockMotionVector, r_MSE,computations2] = ThreeStepSearch(ref_img, target_img, h, w, width, height, R, blockSize);
                        end
                        cost_fullsearch(index_r,index_b)=computations1; %steps required
                        cost_3stepsearch(index_r,index_b)=computations2; %steps required
                        predicted_img(h:h+blockSize-1, w:w+blockSize-1, :) = predicted_block;  %predicted image
                        blockIndex = [(h-1)/blockSize+1 (w-1)/blockSize+1];
                        motionVector(blockIndex(1), blockIndex(2), :) = blockMotionVector; %store into motionVector
                        totalMSE = totalMSE + r_MSE; 
                    end
                end
                 toc;
                 complexity(index_r,index_b,index_s)=toc; %complexity for each case

            %%SAVING IMAGE(RESULT)
			imwrite(predicted_img, sprintf('as_range%d_b_size%d_%s_predict.jpg', R, blockSize, searchAlgo{1})); %write and save predicted image
			imshow(target_img,'InitialMagnification','fit'); hold on;
			xidx = 1:blockSize:width;
			yidx = 1:blockSize:height;
			[X,Y] = meshgrid(xidx,yidx); %X(Value of xidx and size of (rowxcol) length(y) xlength(x))
			u = squeeze(motionVector(:,:,1)); %squeeze into 2D array
			v = squeeze(motionVector(:,:,2));
			u = fliplr(v);
            %Showing motion vector
             %vectors X and Y represent the location of the base of each arrow, and U and V represent the directional components of each arrow.
			quiver(X, Y, u, v); 
            hold off; 
			F = getframe;% Capture the axes and return the image data
			RGB = frame2im(F);%Return image data associated with movie frame
			imwrite(RGB, sprintf('as_range%d_b_size%d_%s_quiver.jpg', R, blockSize, searchAlgo{1})); %save motion vector

			residual_image = sum(abs(predicted_img-target_img), 3); %show the residual image
			imshow(residual_image);
			imwrite(residual_image, sprintf('as_range%d_b_size%d_%s_residual.jpg', R, blockSize, searchAlgo{1})); %residual image
			MSE(index_s, index_r, index_b) = totalMSE; 
			psnr(index_s, index_r, index_b) = PSNR(predicted_img, target_img);
        end
	end
end
error_sq=(ref_img-target_img).^2;
MSE(3,:,:)=mean(error_sq(:))/(blockSize^2); 
figure;
MSEplot(MSE); %plot MSE
figure;
PSNRplot(psnr); %plot PSNR
figure;
complexityplot(complexity); %plot Complexity