function windowed_signal = apply_window(signal, window_type)
% APPLY_WINDOW_FFT Applies a specified window function before computing FFT.
%
% Inputs:
%   signal      - The input time-domain signal.
%   fs          - Sampling frequency of the signal.
%   window_type - String specifying the window type ('rectangular', 'hann', 'hamming', 'blackman', 'kaiser').
%
% Example usage:
%   apply_window_fft(signal, 1000, 'hann');
%
% Author: Your Name

% Validate input
N = length(signal);
n = (0:N-1)';

% Select the window function
switch lower(window_type)
    case 'rectangular'
        window = ones(N, 1);  % Equivalent to no windowing
    case 'hann'
        window = 0.5 * (1 - cos(2 * pi * n / (N - 1)));
    case 'hamming'
        window = 0.54 - 0.46 * cos(2 * pi * n / (N - 1));
    case 'blackman'
        window = 0.42 - 0.5 * cos(2 * pi * n / (N - 1)) + 0.08 * cos(4 * pi * n / (N - 1));
    case 'kaiser'
        beta = 5;  % Adjustable parameter for Kaiser window
        window = besseli(0, beta * sqrt(1 - (2*n/(N-1) - 1).^2)) / besseli(0, beta);
    otherwise
        error('Unknown window type. Choose from rectangular, hann, hamming, blackman, kaiser.');
end

% Apply the window to the signal
windowed_signal = signal(:) .* window;
end

%plot(0.42 - 0.5 * cos(2 * pi * n / (500 - 1)) + 0.08 * cos(4 * pi * n / (500 - 1)), n = (0:500-1))
