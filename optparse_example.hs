
import Options.Applicative
import Data.Monoid

data Conf = Conf
   { field :: String
   } deriving Show

main  = print (execParserPure parserPrefs parserInfo ["-t","hi"])

parser = Conf <$> (strOption (short 't'))


parserInfo = info parser parserInfoMod
 where parserInfoMod = progDesc "hello world"
 
parserPrefs = prefs mempty


