function [predicted_block, motionVector, finalMSE,computations] = ThreeStepSearch(ref_img, target_img, h, w, width, height, R, blockSize)
	%R=search range
    h_origin = h;
	w_origin = w;
    computations=0;
    %with each time step store the motion vector until the end of 'R'
	motionVector = zeros(log2(R), 2); %xy 2 components ->2D array with log2(p)
    %segmenting the ref_img into block that is comparable with our target
	ref_block = ref_img(h:h+(blockSize-1), w:w+(blockSize-1), :); 
    %in range of h to h+blockSize-1
    
	f = @(n) (2.^n); 
	step_size = f(log2(R)-1:-1:0); % [4 2 1] or [8 4 2 1]  %step size
 
	for index_s = 1:length(step_size)   %find motion vector with least cost every time step
		finalMSE =999999999.99999999;% realmax;
		stepSize = step_size(index_s); %4 2 1

		for dh = (-1:1)*stepSize %[-4 0 4],[-2 0 2], [-1 0 1]
			if ((dh+h)>=1) && ((h+blockSize-1)+dh<=height) %after adding small step is also within the height and stepsize>=1

				for dw = (-1:1)*stepSize %[-4 0 4],[-2 0 2], [-1 0 1]
					if ((dw+w)>=1) && ((w+blockSize-1)+dw<=width)%within the width
                        target_block = target_img(h+dh:(h+dh+(blockSize-1)), w+dw:(w+dw+(blockSize-1)), :); 
                        %comparing with the previous block 
                        sqr_error=(target_block-ref_block).^2;
                        MSE=mean(sqr_error(:));
                        computations=computations+1;

                        	if MSE <= finalMSE %decide which point to choose (choose with the least cost(MSE in this case))
							finalMSE = MSE;
							motionVector(index_s, :) = [dh dw]; %add the motion vector only if the cost is the least
                        end
					end
				end

			end
		end

		h = h + motionVector(index_s, 1);  %move every step 4->2->1
		w = w + motionVector(index_s, 2);
	end

	%predicted_block = ref_img(h:h+blockSize-1, w:w+blockSize-1, :);
	predicted_block = target_img(h:h+blockSize-1, w:w+blockSize-1, :); %end when the 
	motionVector = sum(motionVector, 1); %resultant motionVector
    
end


