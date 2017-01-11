Prelude Pipes Pipes.Prelude Data.Maybe Data.Foldable Control.Monad.Writer> snd (runWriter $  (traverse .  traverse) (\x -> tel
l [x]) [Just 1 ,Just 2 ] )
