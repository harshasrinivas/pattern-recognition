load QUESTIONAIRE

x = DATA;
%disp(size(x));

m = 25;
n = 10;
p = 2; % tuning parameter

rnd = randperm(n);

% Number of clusters
K = 3;

% Random assignment of cluster indexes
c = zeros(K, 1);
c = rnd(:,1:K);

% Random assignment of clusters
mu = zeros(K, n);
mu(:) = x(c(:),:);

cent = zeros(m, 1);

for loop = 1:1:8
    
    for i = 1:1:m
        dist = zeros(K, 1);
        for k = 1:1:K
            dist(k) = sum((x(i,:) - mu(k,:)).^2);
        end
        % index of closest centroid to the sample 'i'
        [val, index] = min(dist);    
        cent(i) = index;
    end

    prob = ones(m, K);

    for i = 1:1:m
        for j = 1:1:K
            for k = 1:1:K
                if k ~= j
                    prob(i,j) = prob(i,j) + ((sum((x(i,:) - mu(j,:)).^2)/sum((x(i,:) - mu(k,:)).^2)).^(1/(p-1)));
                end
            end
            prob(i,j) = 1/(prob(i,j));
        end
    end

    nr = zeros(1, n);
    dr = 0;

    for j = 1:1:K
        for i = 1:1:m
            nr = nr + x(i,:)*(prob(i,j).^p);
            dr = dr + (prob(i,j).^p);
        end
        %disp(sum((mu(j,:)-(nr/dr)).^2));
        mu(j,:) = nr/dr;
    end
end

for k = 1:1:K
    fprintf('Cluster: ');
    for i = 1:1:m
        if cent(i) == k
            fprintf('%d ',i);
        end
    end
    fprintf('\n');
end