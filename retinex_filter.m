function output_image = retinex_filter(image)
lum = calculate_luminance(image);

lum_clip = lum;
lum_clip(lum_clip < 0) = 0;
lum_clip(lum_clip > 1) = 1;

lum_ave = bilateralFilter(lum_clip, lum_clip, 0.0, 1.0, 16.0, (3.0 / 255.0));
reflectance = lum ./ lum_ave;

output_image = zeros(size(image));

for i=1:size(image, 3)
    output_image(:,:,i) = image(:,:,i).*reflectance;
end

output_image(isnan(output_image) | isinf(output_image)) = 0;
end