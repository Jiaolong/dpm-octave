function VOCopts = inria_voc_init(datadir, resdir, testset)

% change this path to point to your copy of the PASCAL VOC data
VOCopts.datadir=datadir;

% change this path to a writable directory for your results
VOCopts.resdir=resdir;

% change this path to a writable local directory for the example code
VOCopts.localdir='';

% initialize the test set

%VOCopts.testset='val'; % use validation data for development test set
VOCopts.testset=testset; % use test set for final challenge

% initialize paths

VOCopts.imgsetpath=[VOCopts.datadir 'ImageSets/%s.txt'];
VOCopts.clsimgsetpath=[VOCopts.datadir 'ImageSets/%s_%s.txt'];
VOCopts.annopath=[VOCopts.datadir 'Annotations/%s.txt'];
VOCopts.imgpath=[VOCopts.datadir 'Images/%s.jpg'];
VOCopts.clsrespath=[VOCopts.resdir '%s_cls_' VOCopts.testset '_%s.txt'];
VOCopts.detrespath=[VOCopts.resdir '%s_det_' VOCopts.testset '_%s.txt'];

% initialize the VOC challenge options

VOCopts.classes={'inriaperson'};
VOCopts.nclasses=length(VOCopts.classes);	

VOCopts.minoverlap=0.5;

% initialize example options

VOCopts.exfdpath=[VOCopts.localdir '%s_fd.mat'];
