function demo(notcompiled)

if nargin < 1
	notcompiled = false;
end

if notcompiled
	compile;
	fprintf('Done!\n\n');
end

load('INRIA/inriaperson_final');
model.vis = @() visualizemodel(model, ...
                   1:2:length(model.rules{model.start}));

test('person.jpg', model, 2);

end

function test(imname, model, num_dets)
cls = model.class;

%load and display image
im = imread(imname);
%clf;
%image(im);
%axis equal;
%axis on;
%title('input image');
disp('input image');
%disp('press any key to continue'); pause;
%disp('continuing...');

% load and display model
%model.vis();

% detect objects
tic;
[ds, bs] = imgdetect(im, model, -1);
toc;
top = nms(ds, 0.5);
top = top(1:min(length(top), num_dets));
ds = ds(top, :);
bs = bs(top, :);

clf;

showboxes(im, reduceboxes(model, bs));
end
