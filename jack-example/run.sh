jackd -d coreaudio -l &
ghc Synthesizer.hs -o Synth
./Synth &
jack_connect Synth:output system:playback_1
