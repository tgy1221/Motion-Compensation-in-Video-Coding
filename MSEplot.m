function MSEplot (MSE)
%%Data Processing
	fullSearch_MSE = reshape(transpose(squeeze(MSE(1,:,:))), 1,9);  
	threeStepSearch_MSE = reshape(transpose(squeeze(MSE(2,:,:))), 1,9);
%%Plot
	plot(fullSearch_MSE), hold on;
	plot(threeStepSearch_MSE), 
    hold off;
	legend('Full Search', '3-Step Search');
	xticks([1 2 3 4 5 6 7 8 9]);
	xticklabels({'8, 8x8','8, 16x16','8, 32x32','16, 8x8','16, 16x16','16, 32x32','32 8x8','32, 16x16','32, 32x32'});
	title('MSE in different combination of Block Size and Search Range');
    xlabel('Search range, Block size (r, bxb)');
    ylabel('Mean squared error');
 