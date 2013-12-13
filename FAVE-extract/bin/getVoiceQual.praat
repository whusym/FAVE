form Get_arguments
  word audioFile
  real f1hzpt
  real f2hzpt
  real f3hzpt
  real n_md
endform


# get the number of characters in the file name
flen = length(audioFile$)
# cut off the final '.wav' (or other three-character file extension) to get the full path of the .Formant file that we will create
path$ = left$ (audioFile$, flen-4)




Read from file... 'audioFile$'
audio = selected("Sound")

To Spectrum (fft)
spectrum = selected("Spectrum")
To Ltas (1-to-1)
ltas = selected("Ltas")

select audio
To Pitch... 0 60 350
pitch = selected("Pitch")
Interpolate
Rename... 'audioFile$'_interpolated
pitch_interpolated = selected("Pitch")
select 'pitch_interpolated'
n_f0md = Get value at time... 'n_md' Hertz Linear
start_frame_real = Get frame from time... 'n_md'
current_frame_int = round('start_frame_real')
total_pitch_frames = Get number of frames

while n_f0md < 0 & current_frame_int <= total_pitch_frames
  new_frame = current_frame_int + 1
  n_f0md = Get valye in frame... 'new_frame' Hertz
  current_frame_int = new_frame
endwhile

if n_f0md < 0
  fileappend 'path$'.qual 'tab$''tab$''tab$''tab$''tab$''tab$''tab$''tab$''tab$'
else

rn_f0md = round('n_f0md')
p10_nf0md = 'n_f0md' / 10
select 'ltas'
lowerbh1 = 'n_f0md' - 'p10_nf0md'
upperbh1 = 'n_f0md' + 'p10_nf0md'
lowerbh2 = ('n_f0md' * 2) - ('p10_nf0md' * 2)
upperbh2 = ('n_f0md' * 2) + ('p10_nf0md' * 2)
h1db = Get maximum... 'lowerbh1' 'upperbh1' None
h1hz = Get frequency of maximum... 'lowerbh1' 'upperbh1' None
h2db = Get maximum... 'lowerbh2' 'upperbh2' None
h2hz = Get frequency of maximum... 'lowerbh2' 'upperbh2' None
rh1hz = round('h1hz')
rh2hz = round('h2hz')


# Get the a1, a2, a3 measurements.

p20_f1hzpt = 'f1hzpt' / 5
p10_f2hzpt = 'f2hzpt' / 10
p10_f3hzpt = 'f3hzpt' / 10
lowerba1 = 'f1hzpt' - 'p20_f1hzpt'
upperba1 = 'f1hzpt' + 'p20_f1hzpt'
lowerba2 = 'f2hzpt' - 'p10_f2hzpt'
upperba2 = 'f2hzpt' + 'p10_f2hzpt'
lowerba3 = 'f3hzpt' - 'p10_f3hzpt'
upperba3 = 'f3hzpt' + 'p10_f3hzpt'
a1db = Get maximum... 'lowerba1' 'upperba1' None
a1hz = Get frequency of maximum... 'lowerba1' 'upperba1' None
a2db = Get maximum... 'lowerba2' 'upperba2' None
a2hz = Get frequency of maximum... 'lowerba2' 'upperba2' None
a3db = Get maximum... 'lowerba3' 'upperba3' None
a3hz = Get frequency of maximum... 'lowerba3' 'upperba3' None

fileappend 'path$'.qual 'h1db''tab$''rh1hz''tab$''h2db''tab$''rh2hz''tab$''a1db''tab$''a1hz''tab$''a2db''tab$''a2hz''tab$''a3db''tab$''a3hz'
endif