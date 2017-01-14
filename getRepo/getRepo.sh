

[ -d $1* ] || cabal get $1
cd $1*

function f1(){
cat  <<EOF  | runhaskell

import Distribution.PackageDescription.Parse 
import Distribution.PackageDescription 
import Data.Maybe

main =  fmap ( (\(ParseOk _ x) -> x) .  (fmap ( fromJust .  repoLocation . head  .  sourceRepos .   packageDescription) ) . parsePackageDescription) (readFile "$1.cabal") >>= putStrLn

EOF



}

repo=$(f1 $1)

git clone $repo ${1}_repo
