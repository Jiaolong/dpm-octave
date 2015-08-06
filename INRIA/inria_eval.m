% evaluate and plot precision recall curve
startup;

cls = 'inriaperson';
testset = 'testpos';

conf = voc_config();

global VOC_CONFIG_OVERRIDE;
VOC_CONFIG_OVERRIDE = @voc_config_inriaperson;

cachedir = conf.path.model_dir;

method = 'dpm-cascade';
data_dir = [conf.path.data_dir 'INRIA_PASCAL/VOCdevkit/VOC2007/'];
res_dir = sprintf('%s/results/%s/', cachedir, method);

VOCopts = inria_voc_init(data_dir, res_dir, testset);

[recall, prec, ap] = VOCevaldet(VOCopts, 'comp3', cls, true);

fprintf('Average precision = %0.2f', ap);

print(gcf, '-djpeg', '-r0', [res_dir 'pr.jpg']);
