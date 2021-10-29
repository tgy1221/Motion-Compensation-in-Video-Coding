function [predicted_block, motionVector, finalMSE,computations] = FullSearch(ref_img, target_img, h, w, width, height, p, blockSize)
	finalMSE = realmax; %make it as large number
	motionVector = zeros(1, 2);
	ref_block = ref_img(h:h+blockSize-1, w:w+blockSize-1, :);
    computations=0;
	for dh = -p:p %every single pixel
		if (h+dh>=1)&&(((h+dh)+blockSize-1)<=height)
			for dw = -p:p
				if (w+dw>=1)&&(((w+dw)+blockSize-1)<=width)
					target_block = target_img(h+dh:((h+dh)+blockSize-1), w+dw:((w+dw)+blockSize-1), :);
                    sqr_error=(target_block-ref_block).^2;
                       MSE=mean(sqr_error(:));
%                     MSE=sum(sqr_error(:))/(blockSize^2);
                    computations=computations+1;

					if MSE <= finalMSE %Calculate MSE to define next origin
						finalMSE = MSE;
						motionVector = [dh dw];
					end
				end
			end
		end
	end
	dh = motionVector(1);
	dw = motionVector(2);
	predicted_block = target_img(h+dh:((h+dh)+blockSize-1), w+dw:((w+dw)+blockSize-1), :);
end

