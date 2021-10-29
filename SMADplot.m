function SMADplot (SAD,blockSize)
%%Data Processing
	fullSearch_SAD = reshape(transpose(squeeze(SAD(1,:,:))), 1,9);  
	threeStepSearch_SAD = reshape(transpose(squeeze(SAD(2,:,:))), 1,9);
    %%SAD
	plot(fullSearch_SAD), hold on;
	plot(threeStepSearch_SAD), hold off;
	legend('Full Search', '3-Step Search');
	xticks([1 2 3 4 5 6 7 8 9]);
	xticklabels({'8, 8x8','8, 16x16','8, 32x32','16, 8x8','16, 16x16','16, 32x32','32 8x8','32, 16x16','32, 32x32'});
    title('SAD in different combination of Block Size and Search Range');
    xlabel('Search range, Block size (r, bxb)');
    ylabel('Sum Absoulute Difference');
    figure;
    %%MAD
    fullSearch_MAD=fullSearch_SAD/(blockSize.^2);
    threeStepSearch_MAD=threeStepSearch_SAD/(blockSize.^2);
    plot(fullSearch_MAD), hold on;
	plot(threeStepSearch_MAD), hold off;
	legend('Full Search', '3-Step Search');
	xticks([1 2 3 4 5 6 7 8 9]);
	xticklabels({'8, 8x8','8, 16x16','8, 32x32','16, 8x8','16, 16x16','16, 32x32','32 8x8','32, 16x16','32, 32x32'});
    title('MAD in different combination of Block Size and Search Range');
    xlabel('Search range, Block size (r, bxb)');
    ylabel('Sum Absoulute Difference');
end