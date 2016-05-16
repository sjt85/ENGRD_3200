function fout = interphomecooked(xout,params)
% Computes and plots the Lagrange form of the global interpolating
% polynomial
% Computes Lagrange interpolant functions for an arbitrary dataset
% Plots L_N,i for i = 0,1,2 and i = 3,4,5
% Plots the global interpolating polynomial along with original data
% Performs a second run, sampling at xout and returns xdata

% Extract extra parameters
xdata = cell2mat(params(1));
f = cell2mat(params(2));
n = cell2mat(params(3));


% % Set up spacing for use with the plots to have 200 points
% x_points = linspace(xdata(1),xdata(length(xdata)),200);
% 
% % Evaluate those Lagrange interpolant functions at the x_points
% % Set up a matrix to contain these values, where the column vector
% % L(:,j+1) corresponds to L_n,j
% 
% L_matrix = zeros(length(x_points),n+1);
% 
% for j = 0:n    % Evaluate one L_n,i at a time
%    for k = 1:length(x_points)
%        L_matrix(k,j+1) = Lagrange(xdata,x_points(k),j,n);
%    end
% end
% 
% 
% % Construct the final polynomial!
% P = zeros(length(x_points),1);
% for i = 0:n
%     P = P + f(i+1) .* L_matrix(:,i+1);
% end
% 
% 
% %%% Plot everything %%%
% 
% close all
% figure
% % Enlarge figure to full screen.
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% 
% 
% ah1 = subplot(3,1,1);
% plot(x_points,L_matrix(:,1),x_points,L_matrix(:,2),x_points,L_matrix(:,3))
% legend('L_{5,0}','L_{5,1}','L_{5,2}','Location','NorthEastOutside')
% ylabel({'Interpolant';'Functions'})
% for i = 1:6
%     line([xdata(i); xdata(i)],[4; -4],'Color','k','LineStyle','--');
% end
%     
%     
% ah2 = subplot(3,1,2);
% plot(x_points,L_matrix(:,4),'g',x_points,L_matrix(:,5),'c',x_points,L_matrix(:,6),'m')
% legend('L_{5,3}','L_{5,4}','L_{5,5}','Location','NorthEastOutside')
% ylabel({'Interpolant';'Functions'})
% for i = 1:6
%     line([xdata(i); xdata(i)],[2; -3],'Color','k','LineStyle','--');
% end
% 
% ah3 = subplot(3,1,3);
% hold on
% plot(x_points,P)
% scatter(xdata,f)
% for i = 1:6
%     line([xdata(i); xdata(i)],[.01; -.01],'Color','k','LineStyle','--');
% end
% line([1.83; 1.93],[0; 0],'Color','k','Linestyle','--');
% box on
% axis on
% hold off
% legend('P_5','Values from RK4','Location','NorthEastOutside')
% xlabel('Time [seconds]')
% ylabel({'Sprung Mass';'Displacement [m]'})
% 
% % find current position [x,y,width,height]
% pos3 = get(ah3,'Position');
% pos2 = get(ah2,'Position');
% pos1 = get(ah1,'Position');
% 
% % set width of second axes equal to first
% pos1(3) = pos3(3);
% pos2(3) = pos3(3);
% set(ah1,'Position',pos1)
% set(ah2,'Position',pos2)
% 
% % turn off axes
% set(ah1,'XTickLabel','')
% set(ah2,'XTickLabel','')

    
%%% Now go back and find the requested values %%%

L_matrix = zeros(length(xout),n+1);

for j = 0:n    % Evaluate one L_n,i at a time
   for k = 1:length(xout)
       L_matrix(k,j+1) = Lagrange(xdata,xout(k),j,n);
   end
end


% Construct the final polynomial
fout = zeros(length(xout),1);
for i = 0:n
    fout = fout + f(i+1) .* L_matrix(:,i+1);
end


end




function L = Lagrange(x_vect,x_new,j,n)
% Computes the value of the Lagrange interpolant term L_n,j at x_new 
% based off of the values in x_vect

% n = length(x_vect);
num = 1;
den = 1;

for i = 0:n  % Take the product of all these
    if i ~= j
        num = num*(x_new - x_vect(i+1));
        den = den*(x_vect(j+1) - x_vect(i+1)); %Remember index starts at 1
    end
end

L = num/den;

end