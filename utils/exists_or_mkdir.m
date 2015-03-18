function made = exists_or_mkdir(path)
% Create a new directory if it does not already exist.
made = false;
if exist(path, 'dir') == 0
    unix(['mkdir -p ' path]);
    made = true;
end
