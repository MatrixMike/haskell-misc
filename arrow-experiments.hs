import Control.Arrow
getLineOfLength xs = getLine >>= \x -> return (take (length xs) x)
main = runKleisli ( (Kleisli getLineOfLength) >>> (Kleisli getLineOfLength)) "eleven" >>= print
-- *Main> :ma
-- twelve
-- Thirteen
-- "Thirte"
