{-# OPTIONS_GHC -fwarn-missing-signatures #-}
-- instructive to load into cabal repl

module ParseFunctions where

combineParsers ::
     (t -> Either [Char] b) -> (t -> Either [Char] b) -> t -> Either [Char] b
combineParsers p1 p2 xs =
  case p1 xs of
    Right a -> Right a
    Left x ->
      case p2 xs of
        Right b -> Right b
        Left x2 -> Left (x ++ " and " ++ x2)

readListOfParsers ::
     Foldable t1 => t1 (t2 -> Either [Char] b) -> t2 -> Either [Char] b
readListOfParsers xs = foldl1 combineParsers xs

readMulti :: ([a1] -> Either a2 (a3, Int)) -> [a1] -> Either a2 ([a3], Int)
readMulti _ [] = Right ([], 0)
readMulti parser xs = do
  q@(_, y) <- parser xs
  rest <- readMulti parser (drop y xs)
  return (conjoin q rest)
  where
    conjoin (x, y) (x', y') = (x : x', y + y)
