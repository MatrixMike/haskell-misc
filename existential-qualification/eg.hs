{-# OPTIONS_GHC -fwarn-missing-signatures #-}
{-# LANGUAGE ExistentialQuantification #-} 


data ShowBox = forall s. Show s => SB s
 
heteroList :: [ShowBox]
heteroList = [SB (), SB 5, SB True]


instance Show ShowBox where
 show (SB s) = show s        -- (*) see the comment in the text below
 
f :: [ShowBox] -> IO ()
f xs = mapM_ print xs

main = f heteroList

