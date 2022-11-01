function [trainedModel, validationRMSE] = trainRegressionModel(trainingData)

% Use the code to training the same model with new data, or to learn how to programmatically train models.
%
%  Input:
%      trainingData: a table containing the same predictor and response
%       columns.
%
%  Output:
%      trainedModel: a struct containing the trained regression model. The
%       struct contains various fields with information about the trained
%       model.
%
%      trainedModel.predictFcn: a function to make predictions on new data.
%
%      validationRMSE: a double containing the RMSE. 


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'SONICO', 'NEUTRON', 'DENSITY', 'RESISTIVITY_log'};
predictors = inputTable(:, predictorNames);
response = inputTable.POROSITY;
isCategoricalPredictor = [false, false, false, false];

% Train a regression model
% This code specifies all the model options and trains the model.
regressionTree = fitrtree(...
    predictors, ...
    response, ...
    'MinLeafSize', 12, ...
    'Surrogate', 'off');

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
treePredictFcn = @(x) predict(regressionTree, x);
trainedModel.predictFcn = @(x) treePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedModel.RequiredVariables = {'DENSITY', 'NEUTRON', 'RESISTIVITY_log', 'SONICO'};
trainedModel.RegressionTree = regressionTree;
trainedModel.About = 'This struct is a trained model exported from Regression Learner R2019a.';
trainedModel.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appregression_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'SONICO', 'NEUTRON', 'DENSITY', 'RESISTIVITY_log'};
predictors = inputTable(:, predictorNames);
response = inputTable.POROSITY;
isCategoricalPredictor = [false, false, false, false];

% Perform cross-validation
partitionedModel = crossval(trainedModel.RegressionTree, 'KFold', 5);

% Compute validation predictions
validationPredictions = kfoldPredict(partitionedModel);

% Compute validation RMSE
validationRMSE = sqrt(kfoldLoss(partitionedModel, 'LossFun', 'mse'));
