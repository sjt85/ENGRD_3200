function [ConA1, ConAInf, ConAInv1, ConAInvInf]= TEAM34PS04Q1()
% The script computes norms and condition numbers for a given matrix
A = [100 0 -100; 0 100 -100; -100 -100 300];
ConA1 = CondA1 (A);
ConAInf = CondInf(A);
AInv = inv(A);
ConAInv1 = CondA1 (AInv);
ConAInvInf = CondInf (AInv);
end

function x = CondA1(a)
% This subfunction CondA1 takes a matrix a as the input
% and returns x which is the condition number for matrix a calculated by multiplying its
% own A1 norm and the A1 norm of its inverse matrix
absa = abs(a);
aInv = abs(inv(a));
[r,c] = size(a);
ColumnSum = [];
for k = 1:r
    SumCurr = sum(absa(:,k));        % Compute the sum of each column
    ColumnSum = [ColumnSum SumCurr]; % Store the sum into a vector
end
% a1 is the 1-norm of matrix a
a1 = max(ColumnSum);
ColumnSum = [];
for k = 1:r
    SumCurr = sum(aInv(:,k));        % Compute the sum of each column
    ColumnSum = [ColumnSum SumCurr]; % Store the sum into a vector
end
% aInv1 is the 1-norm of inverse matrix a
aInv1 = max(ColumnSum);
x = a1 * aInv1;
end

function x = CondInf (a)
% This subfunction CondInf takes a matrix a as the input
% and returns x which is the condition number for matrix a calculated by multiplying its
% own infinity norm and the infinity norm of its inverse matrix

absa = abs(a);
aInv = abs(inv(a));
[r,c] = size(a);
RowSum = [];
for k = 1:c
    SumCurr = sum(absa(k,:));        % Compute the sum of each row
    RowSum = [RowSum SumCurr];       % Store the sum into a vector
end
% aInf is the infinity norm of matrix a
aInf = max(RowSum);

RowSum = [];
for k = 1:c
    SumCurr = sum(aInv(k,:));        % Compute the sum of each row
    RowSum = [RowSum SumCurr];       % Store the sum into a vector
end
% aInvInf is the infinity norm of inverse matrix a
aInvInf = max(RowSum);
x = aInf * aInvInf;
end



