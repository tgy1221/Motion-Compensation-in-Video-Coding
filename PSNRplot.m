function PSNRplot (PSNR)
%%Processing data
	fullSearch_PSNR = reshape(transpose(squeeze(PSNR(1,:,:))), [1,9]); 
	threeStepSearch_PSNR = reshape(transpose(squeeze(PSNR(2,:,:))), [1,9]);
%%Plot
	plot(fullSearch_PSNR), hold on;
	plot(threeStepSearch_PSNR)
	legend('Full Search', '3-Step Search');
	xticks([1 2 3 4 5 6 7 8 9]);
	xticklabels({'8, 8x8','8, 16x16','8, 32x32','16, 8x8','16, 16x16','16, 32x32','32 8x8','32, 16x16','32, 32x32'});
    title('PSNR in different combination of Block Size and Search Range');
    xlabel('Search range, Block size (r, bxb)');
    ylabel('PSNR (Peak Signal-to-Noise Ratio) in dB');
end

