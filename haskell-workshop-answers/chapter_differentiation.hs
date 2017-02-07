import Data.List

data Constant   = C Int             deriving (Show, Eq)
data Power      = U Int             deriving (Show, Eq)
data Term       = T Constant Power  deriving (Show, Eq)
data Polynomial = P [ Term ]        deriving (Show, Eq)

-- x^3 + 4x^2 + 5x + 6
example_term  :: Polynomial
example_term = P [T (C 1) (U 3),T (C 4) (U 2),T (C 5) (U 1),T (C 6) (U 0)]

differentiate :: Polynomial -> Polynomial
differentiate (P ts) = P ((map differentiateTerm . filter noPower) ts)

noPower :: Term -> Bool
noPower (T _ (U 0)) = False
noPower (T _ _) = True

differentiateTerm (T (C c) (U p)) = T (C (p*c)) (U (p-1))

render_polynomial :: Polynomial -> String
render_polynomial (P ts) =  concat (intersperse (" + ") (map render_term ts))
render_term (T (C c) (U p)) = coefficient c ++ variable p ++ power p ++ "" 
 where coefficient c | c < 2 = ""
                     | otherwise = show c
       variable p | p < 1 = ""
                  | otherwise ="x"
       power p | p < 2 = ""
               | otherwise = "^" ++ show p
