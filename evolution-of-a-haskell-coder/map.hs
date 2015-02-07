import Data.Foldable 
import Data.List 
import Data.Tree
import Data.Traversable 
import Control.Applicative 
import Data.Functor
import Control.Monad

main = Control.Monad.mapM_ print [
      Prelude.map (+1) [2] -- prelude map
     ,(+1) `Prelude.fmap` [2] -- prelude functor map
     ,(+1) Data.Functor.<$> [2] -- functors fmap operator
     ,[2] >>= return . (+1) -- using monad
     ,[(+1)] Control.Applicative.<*> [2] -- applicatives sequential apply
     ,Control.Applicative.pure (+1) Control.Applicative.<*> [2] -- applicatives pure and apply
     ,liftA (+1) [2]
     ,foldMap ( (:[]) .(+1)) [2] -- foldable
     ,Data.Traversable.traverse (((+1) .) . const) [2] undefined -- traversable
 ]
