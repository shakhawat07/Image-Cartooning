function K = combining(edge_img, color, value)
[row, col] = size(edge_img);
K = uint8(ones(row,col,3));

for i = 1:row
    for j = 1:col
        %when edge is bw
        if edge_img(i,j) == 0 &&  color(i,j,1) <= value  &&  color(i,j,2) <= value &&  color(i,j,3) <= value
            K(i,j,1) = 0;
            K(i,j,2) = 0; 
            K(i,j,3) = 0;
          
        else
            K(i,j,1) = color(i,j,1); 
            K(i,j,2) = color(i,j,2); 
            K(i,j,3) = color(i,j,3); 
         %{ 
            %when edge is grayscale
         %if edge_img(i,j,1) == 255 && edge_img(i,j,2)==255 && edge_img(i,j,2)==255
         if edge_img(i,j) == 255 
            K(i,j,1) = color(i,j,1); 
            K(i,j,2) = color(i,j,2); 
            K(i,j,3) = color(i,j,3);
          
          else
            K(i,j,1) = edge_img(i,j); 
            K(i,j,2) = edge_img(i,j); 
            K(i,j,3) = edge_img(i,j); 
           %}   
                    
        end
    end
end

end

