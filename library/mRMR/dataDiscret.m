function tFeat = dataDiscret(tFeat)

% Q5.3 What is the best way to discretize the data?
% In our experiments we have discretized data based on their mean values and standard deviations. 
% We thresholded at mean ¡À alpha*std, where the alpha value usually range from 0.5 to 2. 
% Typically 2, 3 or no more than 5 states for each variable will produce satisfactory results that are quite robust too. 
% But you need to make a decision what would be the most meaningful way to discretize your data.
% http://penglab.janelia.org/proj/mRMR/FAQ_mrmr.htm#Q2.5

S = std(tFeat);
M = mean(tFeat);

factor = 0.5;
[num dim] = size(tFeat);
% Discretize the data into 3 states using mean and std.
for i = 1 : dim
    lowV = M(i) - factor*S(i);
    highV = M(i) + factor*S(i);
    lowIndex = find(tFeat(:,i)<lowV);
    highIndex = find(tFeat(:,i)>highV);
    tFeat(:,i) = 0;
    tFeat(lowIndex(:),i) = -2;
    tFeat(highIndex(:),i) = 2;
end