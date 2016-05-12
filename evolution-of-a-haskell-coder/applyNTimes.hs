foldl (.) 1 (replicate 10 (+1))   
execState ( replicateM 10 $ modify (+1)) 1
