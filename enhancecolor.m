function K = enhancecolor(color_img, value)

b = im2bw(color_img, 0.5);
[row, col] = size(b);
K = uint8(ones(row,col,3));

for i = 1:row
    for j = 1:col
        %when edge is bw
        if color_img(i,j,1) >= value  &&  color_img(i,j,2) >= value &&  color_img(i,j,3) >= value
            K(i,j,1) = color_img(i,j,1)-10; 
            K(i,j,2) = color_img(i,j,2)-10; 
            K(i,j,3) = color_img(i,j,3)-10; 
          
        else
            K(i,j,1) = color_img(i,j,1); 
            K(i,j,2) = color_img(i,j,2); 
            K(i,j,3) = color_img(i,j,3); 
           
                    
        end
    end
end


end

