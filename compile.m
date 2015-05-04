function compile(verb)

if nargin < 1
	verb = false;
end

cd cpp;

files = dir('./*.cc');

for n = 1:length(files)
	fname = files(n).name;
	fprintf('Compiling %s ...\n', fname);
	eval([octcmd(verb) ' ' fname]);
	fmex = [fname(1:end-3) '.mex'];		
	movefile(fmex, ['../bin/' fmex]);
end

% clean up
delete *.o;

cd ..;

end

function cmd = octcmd(verb)

cmd = 'mkoctfile --mex';

if verb
	cmd = [cmd ' -v'];
end

end
