import Data.Monoid

import Control.Applicative

data AccValidate e a = AccValidate (Either e a)
  deriving Show
  
instance (Functor (AccValidate l)) where
 fmap _ (AccValidate (Left a)) = (AccValidate (Left (a)))
 fmap f (AccValidate (Right x)) = (AccValidate (Right (f x)))
 
instance (Monoid e => Applicative (AccValidate e)) where
 (AccValidate (Left e)) <*> (AccValidate (Left e')) = AccValidate (Left (e <> e'))
 (AccValidate (Left e)) <*> _ = AccValidate (Left (e))
 _ <*> (AccValidate (Left e)) = AccValidate (Left (e))
 (AccValidate (Right f)) <*> (AccValidate (Right v)) = AccValidate (Right (f v))
 pure a = (AccValidate (Right a)) 
 
payment_date_validate n = if n < 10000 then AccValidate (Right n)
                                       else AccValidate (Left ["payment must be in less than a thousand days"])
                                       
                                       
number_or_items_validaten  n = if n > 0 then AccValidate (Right n) 
                                        else AccValidate ( Left ["You must order more than one item"])
                                        
                                        
total_price_validation  n = if n < 1 then AccValidate (Left ["The total number of items must be greater than one"])
                                     else AccValidate (Right n)

data Order = Order { payment_date  :: Int 
                   , number_or_items  :: Float 
                   , total_price :: Float } deriving Show


makeOrder payment_date number_of_items total_price 
   = Order 
        <$> (payment_date_validate payment_date) 
        <*> (number_or_items_validaten number_of_items) 
        <*> (total_price_validation total_price)
