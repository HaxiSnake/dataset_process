function colorhist = SC_colorhist(rgb)
% input:
%   MxNx3 image data, in RGB
% output:
%   1x256 colorhistogram <== (HxSxV = 16x4x4)
% check input
if size(rgb,3)~=3
    error('3 components is needed for histogram');
end
% globals
H_BITS = 4;
S_BITS = 2;
V_BITS = 2;
% convert to hsv
hsv = uint8((2^(H_BITS+S_BITS+V_BITS)-1)*rgb2hsv(rgb));
imgsize = size(hsv);
% get rid of irrelevant boundaries
i0=round(0.05*imgsize(1));  i1=round(0.95*imgsize(1));
j0=round(0.05*imgsize(2));  j1=round(0.95*imgsize(2));
hsv = hsv(i0:i1, j0:j1, :);

% histogram
for i = 1 : 2^H_BITS
    for j = 1 : 2^S_BITS
        for k = 1 : 2^V_BITS
            colorhist(i,j,k) = sum(sum( ...
                bitshift(hsv(:,:,1),-((H_BITS+S_BITS+V_BITS)-H_BITS))==i-1 &...
                bitshift(hsv(:,:,2),-((H_BITS+S_BITS+V_BITS)-S_BITS))==j-1 &...
                bitshift(hsv(:,:,3),-((H_BITS+S_BITS+V_BITS)-V_BITS))==k-1 ));            
        end        
    end
end

% 统计多少
colorhist = reshape(colorhist, 1, 2^(H_BITS+S_BITS+V_BITS));
% normalize 统计比例（为了消除图像大小带来的问题（尺度问题））
colorhist = colorhist/sum(colorhist);