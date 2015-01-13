module Tests where 

import Lambda_data_types
import ShowFunctions
import Evaluation
import Read_lambda

identity = Lambda [Variable 'x'] (FreeVariable (Variable 'x'))

number_two = Lambda [
            Variable 'f',Variable 'x' 
        ] (
            BoundVariables [
                 FreeVariable (Variable 'f')
                ,BoundVariables [
                    FreeVariable (Variable 'x')
                ]
            ]
        )
        

make_number n = Lambda [Variable 'f',Variable 'x']  
       (applyNTimes (\x-> BoundVariables [FreeVariable (Variable 'f'),x]) n (FreeVariable (Variable 'x')))
    
    
made_from_lambda l = Lambda [Variable 'f',Variable 'x'] 
  (l  (\x-> BoundVariables [FreeVariable (Variable 'f'),x]) (FreeVariable (Variable 'x')))

    
successor_function = Lambda [Variable 'n',Variable 'f',Variable 'x'] (BoundVariables [FreeVariable (Variable 'f'), BoundVariables [FreeVariable (Variable 'n') , FreeVariable (Variable 'f'), FreeVariable (Variable 'x')]]  )

addition = Lambda [Variable 'n',Variable 'm',Variable 'f',Variable 'x'] 
    (BoundVariables [
         FreeVariable (Variable 'n')
        ,FreeVariable (Variable 'f')
        ,BoundVariables [ FreeVariable (Variable 'm') ,  FreeVariable (Variable 'f') , FreeVariable (Variable 'x') ]
        ]
    )

main = mapM_ (putStrLn .( \x-> drawLambda x ++  " "  ++ show x)) [
         identity
        ,number_two
        ,make_number 10
        ,make_number 1
        ,made_from_lambda (\f x -> f (f (f x)))
        ,successor_function
        ,beta_reduce (make_number 1) (identity)
        ,addition
        ,readLambdaExpression "(\\f x->(x))"
        ,readLambdaExpression "(\\f x->(f (x)))"
    ]
    
applyNTimes f n x = iterate f x !! n