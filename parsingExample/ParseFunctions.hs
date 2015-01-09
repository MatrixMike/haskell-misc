module ParseFunctions where

combineParsers p1 p2 xs = case p1 xs of 
                            Right a -> Right a
                            Left x -> case p2 xs of
                                        Right b -> Right b
                                        Left x2 -> Left (x ++ " and " ++ x2)
    

readListOfParsers xs = foldl1 combineParsers xs


readMulti _ [] = Right ([],0)
readMulti parser xs = do {
      q@(_,y) <- parser xs;
      rest <- readMulti parser (drop y xs);
      return ( conjoin q rest );
      }
      where conjoin (x,y) (x',y') = (x:x',y+y) 