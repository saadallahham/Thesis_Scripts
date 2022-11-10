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
response = inputTable.PERMEABILITY;
isCategoricalPredictor = [false, false, false, false];

% Train a regression model
% This code specifies all the model options and trains the model.
concatenatedPredictorsAndResponse = predictors;
concatenatedPredictorsAndResponse.PERMEABILITY = response;
linearModel = stepwiselm(...
    concatenatedPredictorsAndResponse, ...
    'linear', ...
    'Upper', 'interactions', ...
    'NSteps', 1000, ...
    'Verbose', 0);

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
linearModelPredictFcn = @(x) predict(linearModel, x);
trainedModel.predictFcn = @(x) linearModelPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedModel.RequiredVariables = {'DENSITY', 'NEUTRON', 'RESISTIVITY_log', 'SONICO'};
trainedModel.LinearModel = linearModel;
trainedModel.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appregression_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'SONICO', 'NEUTRON', 'DENSITY', 'RESISTIVITY_log'};
predictors = inputTable(:, predictorNames);
response = inputTable.PERMEABILITY;
isCategoricalPredictor = [false, false, false, false];

% Perform cross-validation
KFolds = 5;
cvp = cvpartition(size(response, 1), 'KFold', KFolds);
% Initialize the predictions to the proper sizes
validationPredictions = response;
for fold = 1:KFolds
    trainingPredictors = predictors(cvp.training(fold), :);
    trainingResponse = response(cvp.training(fold), :);
    foldIsCategoricalPredictor = isCategoricalPredictor;
    
    % Train a regression model
    % This code specifies all the model options and trains the model.
    concatenatedPredictorsAndResponse = trainingPredictors;
    concatenatedPredictorsAndResponse.PERMEABILITY = trainingResponse;
    linearModel = stepwiselm(...
        concatenatedPredictorsAndResponse, ...
        'linear', ...
        'Upper', 'interactions', ...
        'NSteps', 1000, ...
        'Verbose', 0);
    
    % Create the result struct with predict function
    linearModelPredictFcn = @(x) predict(linearModel, x);
    validationPredictFcn = @(x) linearModelPredictFcn(x);
    
    % Add additional fields to the result struct
    
    % Compute validation predictions
    validationPredictors = predictors(cvp.test(fold), :);
    foldPredictions = validationPredictFcn(validationPredictors);
    
    % Store predictions in the original order
    validationPredictions(cvp.test(fold), :) = foldPredictions;
end

% Compute validation RMSE
isNotMissing = ~isnan(validationPredictions) & ~isnan(response);
validationRMSE = sqrt(nansum(( validationPredictions - response ).^2) / numel(response(isNotMissing) ));
