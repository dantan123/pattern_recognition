clear;
close all;
load('lab2_3.mat');

J = 5;
limit = 20;
step = 1;

lowx = min([min(a(:,1)), min(b(:,1))]) - 10;
lowy = min([min(a(:,2)), min(b(:,2))]) - 10;
highx = max([max(a(:,1)), max(b(:,1))]) + 10;
highy = max([max(a(:,1)), max(b(:,1))]) + 10;

[X1, Y1] = meshgrid(lowx:step:highx, lowy:step:highy);

discriminant_list = zeros(J,limit,size(X1,1), size(X1,2));

num_tries = ones(J,1);

misclassified = zeros(J, limit);

set_a = a;
set_b = b;

n_ab = ones(J,1);
n_ba = ones(J,1);

for j=1:J
    while(n_ab(j) > 0 && n_ba(j) > 0 && num_tries(j) <= limit && ~isempty(set_a) && ~isempty(set_b))       
        r1 = randi([1 length(set_a)]);
        r2 = randi([1 length(set_b)]);
        mu_a = a(r1,:);
        mu_b = b(r2,:);
        disc = MED(mu_a,mu_b,X1,Y1);
        n_ab(j) = 0;
        for i=1:length(set_a)
            if interp2(X1,Y1,disc,set_a(i,1),set_a(i,2)) > 0
                n_ab(j) = n_ab(j) + 1;
            end
        end        
        n_ba(j) = 0;
        for i=1:length(set_b)
            if interp2(X1,Y1,disc,set_b(i,1),set_b(i,2)) < 0
                n_ba(j) = n_ba(j) + 1;
            end
        end
        misclassified(j, num_tries(j)) = n_ab(j) + n_ba(j);                
        num_tries(j)
        num_tries(j) = num_tries(j) + 1;
        
        discriminant_list(j,num_tries(j),:,:) = disc;
    end
    if (n_ab(j) == 0)
        set_b = set_b(interp2(X1,Y1,disc,set_b(:,1),set_b(:,2)) < 0,:);
    end
    if (n_ba(j) == 0)
        set_a = set_a(interp2(X1,Y1,disc,set_a(:,1),set_a(:,2)) > 0,:);
    end
    
    n_ab(j)
    n_ba(j)
    length(set_a)
    length(set_b)
end

Avgerrorrate = zeros(1,J); 
Minerrorrate = zeros(1,J); 
Maxerrorrate = zeros(1,J); 
Stderrorrate = zeros(1,J);
total = length(a)+length(b);
wrong = zeros(J,limit);
test_a = zeros(1, length(a));
test_b = zeros(1, length(b));

for j=1:J
    for k = 1:num_tries(j)
        for i=1:length(a)
            disc = squeeze(discriminant_list(j,k,:,:));
            if test_a(i) == 0 && interp2(X1,Y1,disc,a(i,1),a(i,2)) < 0 && n_ba(j) == 0
                test_a(i) = 1;
            end
            if test_b(i) == 0 && interp2(X1,Y1,disc,b(i,1),b(i,2)) > 0 && n_ab(j) == 0
                test_b(i) = 1;
            end
        end
        wrong(j,k) = length(test_a(test_a == 0)) + length(test_b(test_b==0));
    end
    Avgerrorrate(j) = sum(wrong(j,1:num_tries(j)))/num_tries(j)/total;
    Minerrorrate(j) = min(wrong(j,1:num_tries(j)))/total;
    Maxerrorrate(j) = max(wrong(j,1:num_tries(j)))/total;
    Stderrorrate(j) = std(wrong(j,1:num_tries(j)));
end

figure(1);
hold on;
plot(1:J, Avgerrorrate);
title('Avg Error Rate');

figure(2);
hold on;
plot(1:J, Minerrorrate);
title('Min Error Rate');

figure(3);
hold on;
plot(1:J, Maxerrorrate);
title('Max Error Rate');

figure(4);
hold on;
plot(1:J, Stderrorrate);
title('Standard Dev of Errors');

