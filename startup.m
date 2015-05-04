% add path
incl = {'utils', 'vis', 'model', 'gdetect',...
'features', 'bin', 'test'};

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
