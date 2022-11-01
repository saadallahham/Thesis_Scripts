
%%% this process to predict new data from the trained ML models %%%
% w_x represents the new well that will predict new results %
% change x number to same loaded well number %
% the new results will be saved in the name of yfit_01_"name of the ML
% technique used" %%

yfit_01_finetree = finetree.predictFcn(w_x)
yfit_01_mediumtree = mediumtree.predictFcn(w_x)
yfit_01_coarsetree = coarsetree.predictFcn(w_x)
yfit_01_lineardiscriminant = lineardiscriminant.predictFcn(w_x)
yfit_01_quadraticdiscriminant = quadraticdiscriminant.predictFcn(w_x)
yfit_01_gaussiannaivebayes = gaussiannaivebayes.predictFcn(w_x)
yfit_01_kernalnaivebayes = kernalnaivebayes.predictFcn(w_x)
yfit_01_linearSVM = linearSVM.predictFcn(w_x)
yfit_01_quadraticSVM = quadraticSVM.predictFcn(w_x)
yfit_01_cubicSVM = cubicSVM.predictFcn(w_x)
yfit_01_finegaussianSVM = finegaussianSVM.predictFcn(w_x)
yfit_01_mediumgaussianSVM = mediumgaussianSVM.predictFcn(w_x)
yfit_01_coarsegaussianSVM = coarsegaussianSVM.predictFcn(w_x)
yfit_01_fineKNN = fineKNN.predictFcn(w_x)
yfit_01_mediumKNN = mediumKNN.predictFcn(w_x)
yfit_01_coarseKNN = coarseKNN.predictFcn(w_x)
yfit_01_cosineKNN = cosineKNN.predictFcn(w_x)
yfit_01_cubicKNN = cubicKNN.predictFcn(w_x)
yfit_01_weightedKNN = weightedKNN.predictFcn(w_x)
yfit_01_boostedtrees = boostedtrees.predictFcn(w_x)
yfit_01_baggedtrees = baggedtrees.predictFcn(w_x)
yfit_01_subspacediscriminant = subspacediscriminant.predictFcn(w_x)
yfit_01_subspaceknn = subspaceknn.predictFcn(w_x)
yfit_01_rusboostedtrees = rusboostedtrees.predictFcn(w_x)

