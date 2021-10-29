   function complexityplot(complexity)
   %%Data Processing
	fullSearch_complexity = reshape(transpose(squeeze(complexity(:,:,1))), [1,9]);
	threeStepSearch_complexity = reshape(transpose(squeeze(complexity(:,:,2))), [1,9]);
    %Plot
	plot(fullSearch_complexity), hold on;
	plot(threeStepSearch_complexity), hold off;
	legend('Full Search', '3-Step Search');
    xticks([1 2 3 4 5 6 7 8 9]);
	xticklabels({'8, 8x8','8, 16x16','8, 32x32','16, 8x8','16, 16x16','16, 32x32','32 8x8','32, 16x16','32, 32x32'});
    title('Complexity of search method in different combination of Block Size and Search Range');
    xlabel('Search range, Block size (r, bxb)');
    ylabel('Complexity in sec');
end