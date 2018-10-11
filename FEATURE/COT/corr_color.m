function [ Result ] = corr_color( Arr,ColorX,CSA )

[M,N] = size(ColorX);
HB = zeros(CSA,1);
CS = zeros(CSA,1);
    spoints=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
    neighbors=8;
[ysize xsize] = size(ColorX);

miny=min(spoints(:,1));
maxy=max(spoints(:,1));
minx=min(spoints(:,2));
maxx=max(spoints(:,2));

% Block size, each LBP code is computed within a block of size bsizey*bsizex
bsizey=ceil(max(maxy,0))-floor(min(miny,0))+1;
bsizex=ceil(max(maxx,0))-floor(min(minx,0))+1;

% Coordinates of origin (0,0) in the block
origy=1-floor(min(miny,0));
origx=1-floor(min(minx,0));
% Calculate dx and dy;
dx = xsize - bsizex;
dy = ysize - bsizey;

% Fill the center pixel matrix C.

C =ColorX(origy:origy+dy,origx:origx+dx);
CE=zeros(M-2,N-2);
for i = 1:neighbors
  y = spoints(i,1)+origy;
  x = spoints(i,2)+origx;
  % Calculate floors, ceils and rounds for the x and y.
  fy = floor(y); cy = ceil(y); ry = round(y);
  fx = floor(x); cx = ceil(x); rx = round(x);
  % Check if interpolation is needed.
    % Interpolation is not needed, use original datatypes
    N = ColorX(ry:ry+dy,rx:rx+dx);
    N1=Arr(ry:ry+dy,rx:rx+dx,1);
    N2=Arr(ry:ry+dy,rx:rx+dx,2);
    N3=Arr(ry:ry+dy,rx:rx+dx,3);
    D = N == C; 
    CE=CE+double(D);
end 
% C0(:,:,1)=C1.*double(CE);
% C0(:,:,2)=C2.*double(CE);
% C0(:,:,3)=C3.*double(CE);
% imshow(C0)
for i=1:size(C,1)
    for j=1:size(C,2)
        wa = C(i,j);               
            CS(wa+1) = CS(wa+1)+CE(i,j).^(0.7);
            HB(wa+1) = HB(wa+1)+8.^(0.7);          
    end
end
Chist=[];
for i=1:CSA
    Chist(i) = CS(i)/(HB(i)+0.00001);    
end
Result = [Chist.*(HB'/sum(HB)+1)];


