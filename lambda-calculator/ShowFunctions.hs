module ShowFunctions where

import Data.List
import Lambda_data_types

drawLambda :: LambdaExpression -> String
drawLambda (Lambda xs ys) = "(\\" ++ concat (intersperse " " (map drawVariable xs)) ++ "->" ++ drawBinding ys ++ ")"
drawBinding (FreeVariable x) = drawVariable x
drawBinding (BoundVariables bs) = "(" ++concat (intersperse " " (map drawBinding bs)) ++ ")"
drawBinding (FreeLambda lambda) = drawLambda lambda
drawVariable (Variable x) = [x]