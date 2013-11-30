function feature_extend = f2h(feature)

[n_feature, n_site]=size(feature);

feature_extend=zeros((n_feature+1)*n_feature/2+n_feature, n_site);
i=n_feature+2;
for j1=1:n_feature
    for j2=j1:n_feature
        feature_extend(i,:)=feature(j1,:).*feature(j2,:);
        i=i+1;
    end
end
feature_extend(1,:)=1;
feature_extend(2:n_feature+1,:)=feature;