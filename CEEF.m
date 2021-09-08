function result = CEEF(img)

img_haze = im2double(img);
[H, W, C] = size(img_haze);
I = zeros(H, W, C, 5);
range = linspace(1, 5, 5);
%% GC
% I(:, :, :, 5) = img_haze;
for i = 2:5
     I(:, :, :, i) = img_haze .^ range(i);
end
%% CP-AHE
imageIn = img;
sizeIn = size(imageIn);
width = sizeIn(2);
height = sizeIn(1);

imageInComb = zeros(height, width*3);
imageInComb(:, 1:3:end) = imageIn(:, :, 1);
imageInComb(:, 2:3:end) = imageIn(:, :, 2);
imageInComb(:, 3:3:end) = imageIn(:, :, 3);

imageOutComb = adapthisteq(uint8(imageInComb));

imageOut = zeros(height, width, 3);
imageOut(:, :, 1) = imageOutComb(:, 1:3:end);
imageOut(:, :, 2) = imageOutComb(:, 2:3:end);
imageOut(:, :, 3) = imageOutComb(:, 3:3:end);
I(:, :, :, 1) = im2double(uint8(imageOut));

%%
%% FSPD-MEF
%% the finest scale
r1 = 5;
[ D1,i_mean1,aa1,N1] = scale_fine(I,r1);

%% the intermediate  scale
[w,h,~,~]=size(I);
nlev = floor(log(min(w,h)) / log(2))-3;
D2 = cell(nlev,1);
aa2= cell(nlev,1);
N2= cell(nlev,1);

r2 = 4;
r2_reconstruct = zeros(1,nlev);
for ii=1:nlev
    r2_reconstruct(ii) = r2;
    [ D2{ii},i_mean2,aa2{ii},N2{ii}] = scale_interm(i_mean1,r2);
    i_mean1=i_mean2;
    r2 = max(r2-1,1);
end


%% the coarsest  scale
r3=max(r2-1,1);
[fI3,i_mean3,aa3,N3] = scale_coarse(i_mean2,r3);

%% reconstruct
%% Intermediate layers
for ii = nlev:-1:1
    temp=aa2{ii};
    fI=zeros(size(temp));
    fI(1:2:size(temp,1),1:2:size(temp,2))=fI3;
    B2=boxfilter(fI, r2_reconstruct(ii))./ N2{ii}+D2{ii};
    
    fI3=B2;
end
%% finest layers
fI=zeros(size(aa1));
fI(1:2:size(aa1,1),1:2:size(aa1,2))=B2;
B1=boxfilter(fI, r1)./ N1;
result = repmat(B1,[1 1 3])+D1;
end