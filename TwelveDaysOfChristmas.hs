module TwelveDaysOfChristmas where

import Data.Tree

gifts = [  
   "Drummers Drumming"
  ,"Pipers Piping"
  ,"Lords-a-Leaping"
  ,"Ladies Dancing"
  ,"Maids-a-Milking"
  ,"Swans-a-Swimming"
  ,"Geese-a-Laying"
  ,"Gold Rings"
  ,"Colly Birds"
  ,"French Hens"
  ,"Turtle Doves"
  ,"Partridge in a Pear Tree"
 ]
 

buildChristmasTree (gift:gifts) = Node gift (lowerGifts gifts)
 where lowerGifts [] = []
       lowerGifts _ = [buildChristmasTree gifts]
 
main = putStrLn . drawTree . buildChristmasTree . map show . zip [1..] . reverse $ gifts
