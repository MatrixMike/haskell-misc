TPrelude System.Random Data.Char> fmap ( head . filter (not .isMark) . filter  (not .isSpace )   .    filter isPrint. 
 map (\x -> (\z->z !! (x `mod` length z)) ['\0'..'\256'])  .map abs   . randoms) newStdGen  >>= putChar
