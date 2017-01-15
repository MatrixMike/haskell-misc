username=$1
reponame=$2
repourl=http://github.com/${username}/${reponame}.git
clonedir=updatedir

rm -rf $clonedir
git clone $repourl updatedir
cd $clonedir

cabalfilename=$(echo *.cabal)
hackagename=$(basename "$cabalfilename" .cabal)

runhaskell ../setRepo.hs $repourl $cabalfilename  > ${cabalfilename}.new
mv ${cabalfilename}.new ${cabalfilename}

git commit -am"adding repo"
git push

cabal sdist
cabal upload dist/*.tar.gz
