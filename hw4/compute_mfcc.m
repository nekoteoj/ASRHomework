w = 'MFCC/gas_station.wav';
function result = compute_mfcc(w)

shift_size = 160;
frame_size = 400;
frame_size_2n = 2**(ceil(log2(frame_size)));

[y,Fs,bits] = wavread(w);
len = length(y);
dc_offset = mean(y);
y = y - dc_offset;
total_frames = ceil(1 + ((len - frame_size) / shift_size));
% padding
y = [y.' zeros(1,(total_frames*frame_size) - len)].';
spe_global = y;
for i = 2:length(y)
  spe_global(i) = y(i) - 0.97*y(i-1);
endfor
  
for frame = 1:total_frames
  start_frame = shift_size*(frame - 1) + 1;
  stop_frame = start_frame + frame_size - 1;
  sof = y(start_frame:stop_frame);
  logE = max(-50, log(sum(sof.^2)));

  spe = spe_global(start_frame:stop_frame);
  
  spe_p = spe .* hamming(length(spe));
  temp = fft(spe_p, frame_size_2n);
  spect = abs(fft(spe_p, frame_size_2n));
  
  load('MFCC/mel_filters.mat');
  [v, args] = max(mel_filters);
  spect_mel = (mel_filters.' * spect(1:257))';
  mfsc = max(-50, log(spect_mel));

  cs = 1:23;
  for i = 1:23
    s = 0;
    for j = 1:23
      s += mfsc(j) * cos((j - 0.5) * (pi*(i - 1)/23));
    end
    cs(i) = s;
  endfor
  
  x = [[logE] cs(1:13)];
  
  if (frame == 1)
    result = x.';
  else
    result = horzcat(result, x.');
  endif

endfor
  
endfunction
