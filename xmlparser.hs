{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.ParserCombinators.Parsec
import Control.Monad
import Data.Monoid
import Data.Either
import Data.List
import Data.Char

data Tag = Tag [(String,String)] String [TagContent]
  deriving (Show,Eq)
  
data TagContent = TagString String 
                | TagInner Tag
   deriving (Show,Eq)

spaceOut p = between (many space) (many space) p   
   
attr = do
  attr <- spaceOut $ many1 (satisfy (liftM2 ((not.).(||)) isSpace (`elem` "=<>")))
  string "="
  value <- spaceOut $     between (string "\"") (string "\"") (many1 (noneOf "\""))   
                     <|>  between (string "'") (string "'") (many1 (noneOf "'"))		
  return (attr,value)
 

many1Till p e = do
       notFollowedBy e
       x <- p
       xs <- manyTill p (try e)
       return (x:xs)

many1Till' p e = do
                 xs <- many1Till p (lookAhead e)
                 y <- e
                 return (xs,y)

openTag = do
 string "<"
 skipMany space
 many1Till' anyChar $ do
  attrs <- spaceOut $ try (many attr)
  string ">"
  return attrs

closeTag str = do
 x <- string "</"
 y <- string str
 z <- (string ">")
 return y

sparse p t = parse p "" t
sameConstructor (Left _) (Left _) = True
sameConstructor (Right _) (Right _) = True
sameConstructor _ _ = False

groupEithers :: [Either a b] -> [Either [a] [b]]
groupEithers xs = map (\xs@(x:_) -> either (const (Left (lefts xs))) (const (Right (rights xs))) x)  (groupBy sameConstructor xs)
 
tagWithoutContent = do
  (x,a) <- tagWithoutContent'
  return (Tag a x [])

  
tagWithoutContent' = do 
 string "<"
 skipMany space
 many1Till' anyChar $ do
  attrs <- spaceOut $ try (many (try attr))
  string "/>"
  return attrs

closedTag = do
 (x,a) <- openTag
 y <- manyTill ( try (closedTag >>= return . Left) <|> ((noneOf "<>") >>= return . Right)) (try $ closeTag x)
 let s = map (either (TagInner . head) TagString) (groupEithers y)
 return (Tag a x s)
  
fragmentParse = do
  b <- closedTag  
  return b

fullParser =do 
            x <- try tagWithoutContent <|> fragmentParse
            eof 
            return x
  
showAttribute (x,y) = x++"="++"\""++y++"\""
showAttributes atts = concat $ intersperse " " $ map showAttribute atts
  
showTag (Tag attr str inner) = case inner of 
   [] -> "<"++str++attr''++"/>"
   xs -> "<"++str++attr''++">"++(concatMap showTagInnards inner)++"</"++str++">"
   where attr'' = if null attr' then attr'
                                else " "++attr'
         attr' = showAttributes attr

showTagInnards innard = case innard of
  (TagString str) -> str
  (TagInner inner) -> showTag inner
 
main = do 
       let str = "<one green=\"blue\">five<two>to you</two></one>"
       print str
       let rs =  map (parse fullParser "") [str,"<single/>"]
       mapM_ (either (const (print "fail")) (putStrLn . showTag)) rs
