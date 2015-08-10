startup;

cls = 'inriaperson';

conf = voc_config();

global VOC_CONFIG_OVERRIDE;
VOC_CONFIG_OVERRIDE = @voc_config_inriaperson;

cachedir = conf.paths.model_dir;
timestamp = datestr(datevec(now()), 'dd.mmm.yyyy:HH.MM.SS');

% Record a log of the training and testing procedure
diary(conf.training.log([cls '-' timestamp]));

% Train a model
%th = tic;
%model = pascal_train(cls, 1, timestamp);
%toc(th);

% Free the feature vector cache memory
%fv_cache('free');

load([cachedir cls '_final.mat']);
% Lower threshold to get high recall
model.thresh = min(conf.eval.max_thresh, model.thresh);
model.interval = conf.eval.interval;

testset = 'testpos';
testyear = '2007';
suffix = '2007';
% Collect detections on the test set
ds = pascal_test(model, testset, testyear, suffix);

% Evaluate the model without bounding box prediction
%ap1 = pascal_eval(cls, ds, testset, testyear, suffix);
%fprintf('AP = %.4f (without bounding box prediction)\n', ap1);

% Recompute AP after applying bounding box prediction
[ap1, ap2] = bboxpred_rescore(cls, testset, testyear, suffix);
fprintf('AP = %.4f (without bounding box prediction)\n', ap1);
fprintf('AP = %.4f (with bounding box prediction)\n', ap2);

