function mu = f2mu(feature,center_idx, n_block_row, n_block_col)

neighbor_idx=find_neighbor(center_idx, n_block_row, n_block_col);

mu=zeros(2*size(feature,1),length(neighbor_idx));
for j=1:length(neighbor_idx)
    mu(:,j)=[feature(:,center_idx); feature(:,neighbor_idx(j))];
end
