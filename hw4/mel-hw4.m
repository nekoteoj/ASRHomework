load('MFCC/mel_filters.mat');
%plot((0:256)'/256*8000, mel_filters);
title('Mel filter banks');
xlabel('frequency (Hz)');
ylabel('weight');

[v, args] = max(mel_filters);
args

x = (0:256)'/256*8000;
x(6)
x(230)