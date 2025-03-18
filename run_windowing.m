%% IMPORT STATEMENTS
% Add the functions folder `src` to the MATLAB search path
addpath(fullfile('src'));

%% LOAD AND PROCESS DATA

% Load the combined sine wave data for the corresponding input
% the variables (data_ch1,data_ch2) will be automatically loaded
% you can use the command 'whos' to check what variables are currently in the workspace

load('data/sine5_F0A1_300Hz.mat');

% Create time vector for plotting
%real_rate should be set at the sampling frequency
real_rate = 300;
%create a time vector starting from 0, step of 1/real_rate, all the way up till ending time
%ending time is determined by looking at .mat data
% make sure this t vector matches up with data_ch1
t = [0:1/real_rate:(length(data_ch1)-1)/real_rate]';

%set the input; make sure this aligns with the output data results
input_freq=5;
%this is the input we send to our force transducer
data_out = sin(2*pi*input_freq*t);

%% WINDOWING

data_ch2_hann = apply_window(data_ch2, 'hann');
data_ch2_hamming = apply_window(data_ch2, 'hamming');
data_ch2_blackman = apply_window(data_ch2, 'blackman');

%% DFT/FFT TRANSOROMATION

%we only need to analyse channel 2 since channel 1 is the input force transducer
%replace the function here with the APPROPRIATE FUNCTION FROM SRC
f_ch2 = fft_vectorized(data_ch2);
f_ch2_hann = fft_vectorized(data_ch2_hann);
f_ch2_hamming = fft_vectorized(data_ch2_hamming);
f_ch2_blackman = fft_vectorized(data_ch2_blackman);

%% PLOT DATA

%number of data points, because data may be padded with extra zeros
N_fft = length(f_ch2);
% array of 0 till number of data points
f = (0:N_fft-1)' * (real_rate / N_fft);

figure
subplot(2, 2, 1);  % (2 rows, 2 columns, position 1)
plot(f, abs(f_ch2))%20*log10(abs(f_ch2) / max(abs(f_ch2))));
title('Transform of channel 1 Data');
grid on;
%axis([0 20 0 60]);  % Set consistent y-axis for better comparison

% Second subplot (top-right)
subplot(2, 2, 2);  % (2 rows, 2 columns, position 2)
plot(f, abs(f_ch2_hann));%20*log10(abs(f_ch2_hann) / max(abs(f_ch2_hann))));
title('Hann Window');
grid on;
%axis([0 20 0 60]);  % Set consistent y-axis for better comparison

% Third subplot (bottom-left)
subplot(2, 2, 3);  % (2 rows, 2 columns, position 3)
plot(f, abs(f_ch2_hamming));%20*log10(abs(f_ch2_hamming) / max(abs(f_ch2_hamming))));
title('Hamming Window');
grid on;
%axis([0 20 0 60]);  % Set consistent y-axis for better comparison

% Fourth subplot (bottom-right)
subplot(2, 2, 4);  % (2 rows, 2 columns, position 4)
plot(f, abs(f_ch2_blackman));%20*log10(abs(f_ch2_blackman) / max(abs(f_ch2_blackman))));
title('Blackman Window');
grid on;
%axis([0 20 0 60]);  % Set consistent y-axis for better comparison
% V = axis;
% axis([0 50 V(3) V(4)])

% Save the most recent figure with explicit renderer settings, if some renders dont work, try either opengl or painters
%print('-dpng', '-r300', '-opengl', 'myanalyse.png')
print('-dpng','-r300','-vector','a4_spectrum_hann.png');

fprintf('Plot of analysis saved in the current directory\n')

hold off
