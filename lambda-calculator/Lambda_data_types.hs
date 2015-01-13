module Lambda_data_types where

data LambdaExpression = Lambda [Variable] Binding
    deriving (Show,Eq,Read)
    
data Binding = BoundVariables [Binding] | FreeVariable Variable | FreeLambda LambdaExpression
    deriving (Show,Eq,Read)
    
data Variable = Variable Char
   deriving (Eq,Show,Read)