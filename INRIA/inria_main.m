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
th = tic;
model = pascal_train(cls, 1, timestamp);
toc(th);

% Free the feature vector cache memory
%fv_cache('free');
