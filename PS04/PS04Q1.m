% The script computes norms and condition numbers for a given matrix
function [ConA1, ConAInf, ConAInv1, ConAInvInf]= PS04Q1()

A = [100 0 -100; 0 100 -100; -100 -100 300];
AInv = inv(A);
A1 = CalcA1 (A);
AInf = CalcAInf (A);
AInv1 = CalcA1 (AInv);
AInvInf = CalcAInf (AInv);
ConA1 = A1 * AInv1;             % Condition Number for matrix A using A1 norm
ConAInf = AInf * AInvInf;       % Condition Number for matrix A using AInf norm
ConAInv1 = A1 * AInv1;          % Condition Number for matrix Inverse A using A1 norm
ConAInvInf = AInf * AInvInf;    % Condition Number for matrix Inverse A using AInf norm
end

function x = CalcA1(a)
% This subfunction CalcA1 takes a matrix a as the input
% and x as the output which is the max absolute column sum

AbsA = abs(a);
[r,c] = size(a);
ColumnSum = [];
for k = 1:r
    SumCurr = sum(AbsA(:,k));        % Compute the sum of each column
    ColumnSum = [ColumnSum SumCurr]; % Store the sum into a vector
end
% x is the max absolute column sum
x = max(ColumnSum);
end

function x = CalcAInf (a)
% This subfunction CalcInf takes a matrix a as the input
% and x as the output which is the max absolute column sum

AbsA = abs(a);
[r,c] = size(a);
RowSum = [];
for k = 1:c
    SumCurr = sum(AbsA(k,:));        % Compute the sum of each row
    RowSum = [RowSum SumCurr];       % Store the sum into a vector
end
% x is the max absolute row sum
x = max(RowSum);
end



