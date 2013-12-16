form Get_arguments
  word audioFile
  real n_f0md
  boolean get_jitter
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

rn_f0md = round('n_f0md')
p10_nf0md = 'n_f0md' / 10
select 'ltas'
lowerbh1 = 'n_f0md' - 'p10_nf0md'
upperbh1 = 'n_f0md' + 'p10_nf0md'
lowerbh2 = ('n_f0md' * 2) - ('p10_nf0md' * 2)
upperbh2 = ('n_f0md' * 2) + ('p10_nf0md' * 2)
h1db = Get maximum... 'lowerbh1' 'upperbh1' None
h2db = Get maximum... 'lowerbh2' 'upperbh2' None

if get_jitter
  select 'audio'
  To PointProcess (periodic, peaks)... 40 600 1 0
  jitter = Get jitter (local)... 0 0 0.0001 0.03 1.3
else
  jitter = 0
endif

fileappend 'path$'.qual 'rn_f0md''tab$''h1db''tab$''h2db''tab$''jitter'




