
this program is proof that haskell characters are codepoint based.

main :: IO ()
main =  do
        putStr "\x0001F428" -- 32 bit codepoint
        --putStr "\xD83D0\xDC28" --utf 16 version doesn't work
        --putStr "\xF0\x9F\x90\xA8" -- prints jibberish
        
       
