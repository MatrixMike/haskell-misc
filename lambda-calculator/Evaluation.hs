module Evaluation where

import Lambda_data_types
import Network.CGI.Protocol


beta_reduce (Lambda (v:xs) (BoundVariables vs) ) lambda = Lambda xs (BoundVariables (replace (FreeVariable v) (FreeLambda lambda) vs))