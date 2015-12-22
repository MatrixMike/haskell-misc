module Evaluation where

import Lambda_data_types

replace x x' [] = []
replace x x' xs = case head xs == x of
 True -> x' : replace x x' (tail xs)
 False -> head xs : replace x x' (tail xs)



beta_reduce (Lambda (v:xs) (BoundVariables vs) ) lambda = Lambda xs (BoundVariables (replace (FreeVariable v) (FreeLambda lambda) vs))