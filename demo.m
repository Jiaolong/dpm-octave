function demo(no_compile)

startup;

if ~exist('no_compile', 'var')
	compile;
	fprintf('Done!\n\n');
end
