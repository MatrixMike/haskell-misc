{-# OPTIONS_GHC -fwarn-missing-signatures #-}
--module TwelveDaysOfChristmas where
-- to make executable remove the module line
-- then arrange the rhs of 'main =' to be all on one line and copy & paste into cabal repl for production of tree

import Data.Tree

gifts :: [String]
gifts =
  [ "Drummers Drumming"
  , "Pipers Piping"
  , "Lords-a-Leaping"
  , "Ladies Dancing"
  , "Maids-a-Milking"
  , "Swans-a-Swimming"
  , "Geese-a-Laying"
  , "Gold Rings"
  , "Colly Birds"
  , "French Hens"
  , "Turtle Doves"
  , "Partridge in a Pear Tree"
  ]

buildChristmasTree :: [a] -> Tree a
buildChristmasTree (gift:gifts) = Node gift (lowerGifts gifts)
  where
    lowerGifts [] = []
    lowerGifts _ = [buildChristmasTree gifts]

{-
main = putStrLn . drawTree . buildChristmasTree . map show . zip [1..] . reverse $ gifts
-}
main =
  putStrLn . drawTree . buildChristmasTree . zipWith (curry show) [1 ..] . reverse $ gifts
