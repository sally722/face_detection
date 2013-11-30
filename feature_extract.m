function f=feature_extract(img_int, center, scale_i_array, scale_j_array)
    i=center(1);
    j=center(2);
    
    f=zeros(length(scale_i_array),length(scale_j_array),4);
    for ii=1:length(scale_i_array)
        scale_i=scale_i_array(ii);
        for jj=1:length(scale_j_array)
            scale_j=scale_j_array(jj);
            uplt=rectsum(img_int, i-scale_i, i, j-scale_j, j);
            uprt=rectsum(img_int, i-scale_i, i, j, j+scale_j);
            lolt=rectsum(img_int, i, i+scale_i, j-scale_j, j);
            lort=rectsum(img_int, i, i+scale_i, j, j+scale_j);
            
            f(ii,jj,1)=uplt+uprt-lolt-lort;
            f(ii,jj,2)=uplt+lolt-uprt-lort;
            f(ii,jj,3)=uplt-lort;
            f(ii,jj,4)=lolt-uprt;
        end
    end
    f=f(:);
    f=f/sum(f);
end

function s=rectsum(img_int, up, down, left, right)
    s=img_int(down,right)+img_int(up,left)-img_int(down,left)-img_int(up,right);
end