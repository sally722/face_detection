function neighbor_idx=find_neighbor(center_idx, n_block_row, n_block_col)

[i,j]=ind2sub([n_block_row, n_block_col],center_idx);


if i>1
    neighbor_idx(1)=sub2ind([n_block_row, n_block_col],i-1,j);
end
if i<n_block_row
    neighbor_idx(2)=sub2ind([n_block_row, n_block_col],i+1,j);
end
if j>1
    neighbor_idx(3)=sub2ind([n_block_row, n_block_col],i,j-1);
end
if j<n_block_col
    neighbor_idx(4)=sub2ind([n_block_row, n_block_col],i,j+1);
end
    
neighbor_idx(neighbor_idx==0)=[];