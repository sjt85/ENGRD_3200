p_new = 1;  %Initialize as 1
while p_new + 0 > 0  %Compare to zero
    p_old = p_new;  %Transfer to different variable
    p_new = p_new/2;
end
p_old = p_old*2;

%Built-in function for machine epsilon for comparison
a = eps(0);
