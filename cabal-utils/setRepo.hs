import Distribution.PackageDescription.Parse 
import Distribution.PackageDescription 
import Data.Maybe
import CabalLenses
import System.Environment
import Control.Lens
import Distribution.PackageDescription.PrettyPrint

main = do 
  (x:y:_) <- getArgs 
  func x y 

f = func "https://github.com/xpika/templateify.git" "templateify" 

func y' y = do
   x <- readFile y
   let pkgDesc = (\(ParseOk _ b) -> b) (parsePackageDescription x)
   let pkgDesc' = pkgDesc & packageDescriptionL . sourceReposL .~ [SourceRepo RepoHead (Just Git) (Just y') Nothing Nothing Nothing Nothing] -- Add repo
   let pkgDesc'' = pkgDesc' & packageDescriptionL . packageL . pkgVersionL . versionBranchL  . _last  %~ (+1) -- bump version
   let pkgDescString = showGenericPackageDescription pkgDesc''
   -- writeFile x pkgDescString 
   putStrLn pkgDescString
   return pkgDescString
