import Text.ParserCombinators.Parsec                                                                                                                                                          
import System.IO                                                                                                                                                                              
import Control.Monad                                                                                                                                                                          
                                                                                                                                                                                              
keepSame = do                                                                                                                                                                                 
           v <- satisfy (const True)                                                                                                                                                          
           return [v]                                                                                                                                                                         
                                                                                                                                                                                              
replace find replacement str = parse (replacer find replacement) "" str                                                                                                                       
                                                                                                                                                                                              
replacer find replacement = do                                                                                                                                                                
                        many (try (doreplace find replacement) <|> keepSame) >>= return . concat                                                                                              
                                                                                                                                                                                              
doreplace find replacement = do                                                                                                                                                               
             x <-  find                                                                                                                                                                       
             return replacement                                                                                                                                                               
                                                                                                                                                                                              
replaceIO find replacement = do                                                                                                                                                               
       contents <- hGetContents stdin                                                                                                                                                         
       let (Right res) = replace find replacement contents                                                                                                                                    
       putStrLn res                                                                                                                                                                           
                                                                                                                                                                                              
main = replaceIO (replicateM 3 digit) ""    
