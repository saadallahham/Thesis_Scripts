
%%% Save all final results of each ML technique in csv file %%%


ANSWER_w_x = [DEPTH_w_x, POROSITY_W_x, yfit__x_linear_regression, yfit__x_Interactions_linear, yfit__x_Robust_linear, yfit__x_Stepwise_linear,...
    yfit__x_finetree, yfit__x_mediumtree, yfit__x_coarsetree,yfit__x_linearSVM, yfit__x_quadraticSVM, yfit__x_cubicSVM,...
    yfit__x_finegaussianSVM, yfit__x_mediumgaussianSVM, yfit__x_coarsegaussianSVM,yfit__x_boostedtrees, yfit__x_baggedtrees,...
    yfit__x_Squared_Exponential_GPR, yfit__x_Matern_GPR, yfit__x_Exponential_GPR, yfit__x_Rational_Quadratic_GPR];
 

header = {'DEPTH', 'POROSITY', 'LinearRegression', 'InteractionsLinear', 'RobustLinear', 'StepwiseLinear', 'FineTree', 'MediumTree',...
    'CoarseTree', 'LinearSVM', 'QuadraticSVM', 'CubicSVM', 'Fine_G_SVM',...
    'Medium_G_SVM', 'Coarse_G_SVM', 'BoostedTrees', 'BaggedTrees',...
    'Squared_E_GPR', 'Matern_GPR', 'Exponential_GPR', 'Rational_Q_GPR'};


output_w_x = [header; num2cell(ANSWER_w_x)]


writecell(output_w_x,'ANSWER_W_x.csv')

