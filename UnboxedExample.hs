{-# LANGUAGE MagicHash #-}

import GHC.Exts

showUnboxedInt :: Int# -> String
showUnboxedInt n = (show $ I# n) ++ "#"

add :: Int# -> Int# -> Int#
add a b = a +# b

main = print $ showUnboxedInt (add 1# 1#)


                                              
                                              
                                              
