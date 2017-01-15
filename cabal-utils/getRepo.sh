[ -d $1* ] || cabal get $1
cd $1*

ghc -e 'import Distribution.PackageDescription.Parse' -e 'import Distribution.PackageDescription' -e 'import Data.Maybe' -e 'fmap ( (\(ParseOk _ x) -> x) .  (fmap ( fromJust .  repoLocation . head  .  sourceRepos .   packageDescription) ) . parsePackageDescription) (readFile "$1.cabal")'

git clone $repo ${1}_repo
