function compile(opt, verb)

if nargin < 1
	opt = true;
end

if nargin < 2
	verb = false;
end

startup;

octave = isoctave();

files = {'resize.cc', 'reduce.cc', 'dt.cc', 'features.cc'};

cd mex;

if octave
	fprintf('Compiling for Octave ...\n');
	
	for n = 1:length(files)
		eval([octcmd(opt, verb) ' ' files{n}]);
		fname = [files{n}(1:end-3) '.mex']		
		%movefile(fname, ['../bin/' fname])
	end

	% clean up
	delete *.o;
else
	fprintf('Compiling for Matlab ...\n');
	
	for n = 1:length(files)
		eval([mexcmd(opt, verb) ' ' files{n}]);
	end
end

cd ..;

end

function cmd = octcmd(verb)

cmd = 'mkoctfile --mex';

if verb
	cmd = [cmd ' -v'];
end

end

function cmd = mexcmd(opt, verb, extra_cxx_flags, extra_ld_flags)
if ~exist('extra_cxx_flags', 'var') || isempty(extra_cxx_flags)
  extra_cxx_flags = '';
end

if ~exist('extra_ld_flags', 'var') || isempty(extra_ld_flags)
  extra_ld_flags = '';
end

% Start building the mex command
cmd = 'mex';

% Add verbosity if requested
if verb
  cmd = [cmd ' -v'];
end

% Add optimizations if requested
if opt
  cmd = [cmd ' -O'];
  cmd = [cmd ' CXXOPTIMFLAGS="-O3 -DNDEBUG"'];
  cmd = [cmd ' LDOPTIMFLAGS="-O3"'];
else
  cmd = [cmd ' -g'];
end
% Turn all warnings on
cmd = [cmd ' CXXFLAGS="\$CXXFLAGS -Wall -fopenmp ' extra_cxx_flags '"'];
cmd = [cmd ' LDFLAGS="\$LDFLAGS -Wall -fopenmp ' extra_ld_flags '"'];
end
