-- Chapter: ORG CHART
import Data.List
import Data.Graph
import Data.List.Split
import Data.Tuple
import System.IO.Unsafe
import Data.Maybe
import Control.Arrow
import Control.Monad

data OrgChart   = Chart Department                      deriving Show
data Department = Dep Name [ Child ]                    deriving Show
data Child      = Child ArrowLabel Item                 deriving Show
data Item       = Person Person | Department Department deriving Show
data Person     = Human Title                           deriving Show

type ArrowLabel = String
type Name       = String
type Title      = String

main :: IO ()
main = do 
       -- organisationsTxt <- readFile "organisation_employees.txt"
       putStrLn (show $ process organisationsTxt)

process :: String -> OrgChart
process organisationsTxt = Chart (Dep "Test" [])


departmentTree = dff departmentGraph
departmentGraph = buildG (minimum departmentVertexes,maximum departmentVertexes) departmentVertexMap
departmentVertexMap = map ((join (***)) (fromIntegral .fromJust . lookupDepartmentNodeFromName)) (map swap departmentMappings)
lookupDepartmentNodeFromVertex departmentVertex = lookup departmentVertex  (map swap departmentVertexMappings)
lookupDepartmentNodeFromName departmentName = lookup departmentName departmentVertexMappings
departmentVertexes = map (fromIntegral.  snd) departmentVertexMappings 
departmentVertexMappings = zip (nub $ concatMap (uncurry (++) . join (***) (:[]))  $ departmentMappings) [1..]
departmentMappings = map (\row-> (row !!department,row!!managingDepartment)) rows
rows = (map (splitOn "\t") . tail .  lines) organisationsTxt

organisationsTxt = unsafePerformIO  $ readFile "organisation_employees.txt"

name=0 
title=1
salary=2
department=3
managingDepartment=4
subordinates=5