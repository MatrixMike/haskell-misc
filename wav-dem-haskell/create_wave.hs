import Data.WAVE
import Debug.Trace
import Data.List

main = put

put = putWAVEFile "output.wav" wave

showwave = (\(WAVE (WAVEHeader a b c d) i) -> (a,b,c,d))

wave = WAVE header samples
header = WAVEHeader 1 (round rate) 16 Nothing

 -- octaveify

data Music = Pitch Double | Pause

li2 = listToPitch li

 -- beethovens 5th
li = [4,4,4,1,-1,-1,3,3,3,0]

listToPitch = map numTopitch
    where numTopitch x = case x of
            -1 ->Pause
            _ -> Pitch x


samples =  map (blockit . doubleToSample) (concat (map (flip (sinit2 1) 200) li2))
blockit = (\x -> [x])

sinit2 vol (Pause) len  = sinit 0 1 len
sinit2 vol (Pitch n) len = sinit vol n len

sinit vol n len  = fadedVols $ repeating normlength $  map ( (*normvol). sin) values
  where normlength = (len*110)`div`(length values) 
        normvol = (\x-> trace (show x) x ) (1/(f2 n)) * vol
        fadedVols xs = zipWith (*) xs (fadefunc (genericLength xs))
        fadefunc l =  map (\x->((-1*x)/l) + 1) [0..l]
        values = [0,step..twopi]
        step = ((400*(f2 n))*twopi/rate)

f2 n = 2 ** (n/12)

rate = 44000
twopi = 2*pi

repeating n = concat . replicate n