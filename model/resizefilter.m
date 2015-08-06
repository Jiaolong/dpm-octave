function B = resizefilter(A, scale)
% resize a filter by bilinear interpolation
%   B = resizefilter(A, scale)
%
% Return value
%   B    resized filter
%
% Arguments
%   A      Source filter
%   scale  scale factor (> 0)


    % Get some necessary variables first
    in_rows = size(A, 1);
    in_cols = size(A, 2);
    out_rows = in_rows*scale;
    out_cols = in_cols*scale;

    % Let S_R = R / R'        
    S_R = in_rows / out_rows;
    % Let S_C = C / C'
    S_C = in_cols / out_cols;

    % Define grid of co-ordinates in our image
    % Generate (x,y) pairs for each point in our image
    [cf, rf] = meshgrid(1 : out_cols, 1 : out_rows);

    % Let r_f = r'*S_R for r = 1,...,R'
    % Let c_f = c'*S_C for c = 1,...,C'
    rf = rf * S_R;
    cf = cf * S_C;

    % Let r = floor(rf) and c = floor(cf)
    r = floor(rf);
    c = floor(cf);

    % Any values out of range, cap
    r(r < 1) = 1;
    c(c < 1) = 1;
    r(r > in_rows - 1) = in_rows - 1;
    c(c > in_cols - 1) = in_cols - 1;

    % Let delta_R = rf - r and delta_C = cf - c
    delta_R = rf - r;
    delta_C = cf - c;

    % Final line of algorithm
    % Get column major indices for each point we wish
    % to access
    in1_ind = sub2ind([in_rows, in_cols], r, c);
    in2_ind = sub2ind([in_rows, in_cols], r+1,c);
    in3_ind = sub2ind([in_rows, in_cols], r, c+1);
    in4_ind = sub2ind([in_rows, in_cols], r+1, c+1);       

    % Now interpolate
    % Go through each channel for the case of colour
    % Create output image that is the same class as input
    B = zeros(out_rows, out_cols, size(A, 3));
    B = cast(B, class(A));

    for idx = 1 : size(A, 3)
        C = double(A(:,:,idx)); % Get i'th channel
        % Interpolate the channel
        tmp = C(in1_ind).*(1 - delta_R).*(1 - delta_C) + ...
                       C(in2_ind).*(delta_R).*(1 - delta_C) + ...
                       C(in3_ind).*(1 - delta_R).*(delta_C) + ...
                       C(in4_ind).*(delta_R).*(delta_C);
        B(:,:,idx) = cast(tmp, class(A));
    end
end
