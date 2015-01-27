module Wav where

import qualified Data.WAVE as Wave
import Data.List
import Music
import QuickTrace

data Pauseable = Pitch Double | Pause

put_music file_name music = Wave.putWAVEFile file_name (Wave.WAVE waveHeader (makeSamples (toNotes music)))

makeWavefromPitches pitches = Wave.WAVE waveHeader (makeSamples pitches)

makeWave w = Wave.WAVE waveHeader (w)

makeSamples notes = map ((\x-> [x]) . Wave.doubleToSample) (concat (map (flip (sinit 1) 200) (listToPitch (map fromIntegral notes))))
waveHeader = Wave.WAVEHeader 1 (round waveRate) 16 Nothing
waveRate = 44000

listToPitch = map numTopitch
  where numTopitch x = case x of 
         -1 ->Pause
         _ -> Pitch (x - 50)

blockit = (\x -> [x])

sinit vol (Pause) len  = sinit' 0 1 len
sinit vol (Pitch n) len = sinit' vol n len

sinit' vol n len  =  {- map (*normvol) $ -} fadedVols $ qs (n,normvol) $ repeating normlength $ map (sin) values
  where normlength = (len*110)`div`(length values) 
        normvol = (1/(f2 n)) * vol
        fadedVols xs = zipWith (*) xs (fadefunc (genericLength xs))
        fadefunc l =  map (\x->((-1*x)/l) + 1) [0..l]
        values = [0,step..twopi]
        step = ((400*(f2 n))*twopi/rate)

f2 n = 2 ** (n/12)

rate = 44000
twopi = 2*pi

repeating n = concat . replicate n
