% The script computes norms and condition numbers for a given matrix
function [ConA1, ConAInf, ConAInv1, ConAInvInf]= TEAM34PS04Q1()
A = [100 0 -100; 0 100 -100; -100 -100 300];
ConA1 = CondA1 (A);
ConAInf = CondInf(A);
AInv = inv(A);
ConAInv1 = CondA1 (AInv);
ConAInvInf = CondInf (AInv);
end

function x = CondA1(a)
% This subfunction CalcA1 takes a matrix a as the input
% and x as the output which is the max absolute column sum
absa = abs(a);
aInv = abs(inv(a));
[r,c] = size(a);
ColumnSum = [];
for k = 1:r
    SumCurr = sum(absa(:,k));        % Compute the sum of each column
    ColumnSum = [ColumnSum SumCurr]; % Store the sum into a vector
end
% x is the max absolute column sum
a1 = max(ColumnSum);
ColumnSum = [];
for k = 1:r
    SumCurr = sum(aInv(:,k));        % Compute the sum of each column
    ColumnSum = [ColumnSum SumCurr]; % Store the sum into a vector
end
% x is the max absolute column sum
aInv1 = max(ColumnSum);
x = a1 * aInv1;
end

function x = CondInf (a)
% This subfunction CalcInf takes a matrix a as the input
% and x as the output which is the max absolute column sum

absa = abs(a);
aInv = abs(inv(a));
[r,c] = size(a);
RowSum = [];
for k = 1:c
    SumCurr = sum(absa(k,:));        % Compute the sum of each row
    RowSum = [RowSum SumCurr];       % Store the sum into a vector
end
% x is the max absolute row sum
aInf = max(RowSum);
RowSum = [];
for k = 1:c
    SumCurr = sum(aInv(k,:));        % Compute the sum of each row
    RowSum = [RowSum SumCurr];       % Store the sum into a vector
end
% x is the max absolute row sum
aInvInf = max(RowSum);
x = aInf * aInvInf;
end



