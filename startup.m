% add path
incl = {'utils', 'data', 'vis', 'model', 'gdetect',...
'features', 'bin', 'train', 'evaluation', 'test', ...
'fv_cache', 'external', 'bbox_pred', 'INRIA'};

for i = 1:length(incl)
	addpath(genpath(incl{i}));
end

% directory for caching models, data, and results
cachedir = 'cache/';
bindir = 'bin/';
exists_or_mkdir(cachedir);
exists_or_mkdir(bindir);

clear i incl;

% load image package
pkg load image;
% load statistics package
pkg load statistics
