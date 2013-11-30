function loglh=loglikelihood(theta,feature,groundtruth,n_block_row, n_block_col)
tau=0.001;
h=f2h(feature);
w=theta(1:size(h,1));
v=theta(size(h,1)+1:end);
%%
loglh=0;
for i=1:size(feature,2)
    part1=log(sigma_func(groundtruth(i)*w'*h(:,i)));
    part2=0;
    neighbor_idx=find_neighbor(i, n_block_row, n_block_col);
    mu_i=f2mu(feature,i, n_block_row, n_block_col);
    for j=1:length(neighbor_idx)
        part2=part2+groundtruth(i)*groundtruth(neighbor_idx(j))*v'*mu_i(:,j);
    end
    
    loglh=loglh+part1+part2;
    zi_part1=exp(part1+part2);
    %% zi_part2
    groundtruth_i=-groundtruth(i);
    part1=log(sigma_func(groundtruth_i*w'*h(:,i)));
    part2=0;
    neighbor_idx=find_neighbor(i, n_block_row, n_block_col);
    mu_i=f2mu(feature,i, n_block_row, n_block_col);
    for j=1:length(neighbor_idx)
        part2=part2+groundtruth(i)*groundtruth(neighbor_idx(j))*v'*mu_i(:,j);
    end
    zi_part2=exp(part1+part2);
    
    zi=zi_part1+zi_part2;
    loglh=loglh-log(zi);
end
loglh=loglh-1/(2*tau^2)*(v'*v);
end

function y=sigma_func(x)
exp_x=exp(x);
y=exp_x/(1+exp_x);
end