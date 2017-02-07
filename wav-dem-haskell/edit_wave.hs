import Data.WAVE

enc x = [x]
denc [x] = x

transform =  map enc . concat . map transform_function . map denc

transform_function x= [x,x]

main = do 
       w@(WAVE header samples) <- getWAVEFile "output.wav"
       let (Just len) = waveFrames header
           newSamples = transform samples
           mine = (WAVE (header {waveFrames = Just (length newSamples) } )  newSamples )
       putWAVEFile "output_modified.wav" mine
       
       
{-
myWaveHeader = WAVEHeader { waveNumChannels=1  
		     , waveFrameRate = 11025
		     , waveBitsPerSample = 8 
		     , waveFrames = Nothing -- Just 10000
		     }

instance Show WAVEHeader where
	show (WAVEHeader a b c d) = "WAVEHeader {waveNumChannels="++show a
                                             ++",waveFrameRate="++show b
                                             ++",waveBitsPerSample="++show c
                                             ++",waveFrames="++show d
                                             ++"}"
-}