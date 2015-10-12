{-# LANGUAGE NoMonomorphismRestriction #-}

import Text.ParserCombinators.Parsec
import Data.Maybe

main = print $ map (parse parser "") ["{\"a\":[true], false: { null : 3.2e-5  }  }"]

data JValue = JObject [(JKey,JValue)]
          | JList [JValue]
          | JSingle JKey
    deriving (Read,Show)

data JKey = JKeyString String 
  | JKeyNum JNum
  | JKeyBool Bool
  | JKeyNull
  deriving (Read,Show)
  
data JNum = JNumInt Int | JNumFraction Double
 deriving (Read,Show)
     
spaceOut p = between (many space) (many space) p   

parseNull = do 
  string "null" 
  return JKeyNull

parseKey = choice (map (try . spaceOut)  [parseBool,parseString,parseNum,parseNull])
    
parseSingle = fmap JSingle parseKey

parseBool =  do 
    b <- (string "true" <|> string "false")
    return (JKeyBool (b == "true"))
                           
parseString = do 
    char '"'
    str <- manyTill anyChar (char '"') 
    return (JKeyString str)                              
                              
parseKeyValuePair = do
  k <- parseKey 
  spaceOut $ char ':'
  o <- parseValue 
  return (k,o)     

parseObject = spaceOut $ do
 char '{'
 pairs <- sepBy parseKeyValuePair (char ',')
 char '}'
 return (JObject pairs)

parseList = spaceOut $ do
 char '['
 values <- sepBy parseValue (char ',')
 char ']'
 return (JList values)
  
parseValue = choice [parseObject,parseList,parseSingle]
    
parser = do
  b <- parseValue
  eof
  return (b)

parseSign = char '-'
parseNatChars = many1 (oneOf "0123456789")
parseFractionalPart = char '.' >> parseNatChars
parseExponentPart = do 
  oneOf "eE" 
  sign <- many parseSign
  str <- parseNatChars 
  return (read (sign ++ str) :: Double)

applyIf True f x = f x
applyIf _ _ x = x

caseMaybe m f a = case m of 
 (Just b) -> f a b
 _ -> a
 
raise n e = n * (10**e) 

parseNum = do
  sign <- optionMaybe parseSign
  natpart <- parseNatChars
  fracpart <- optionMaybe parseFractionalPart
  expo <- optionMaybe parseExponentPart
  return $ JKeyNum $ case fracpart of 
    Just fracpart -> JNumFraction ( caseMaybe expo raise ( applyIf (isJust sign) (*(-1)) (read (natpart++"."++fracpart):: Double)) )
    _ -> JNumInt (applyIf (isJust sign) (*(-1)) $ (read natpart :: Int))
  
