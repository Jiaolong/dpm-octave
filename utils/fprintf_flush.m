function fprintf_flush(fmt, varargin)
  fprintf(fmt, varargin{:});
  fflush(stdout);
end
