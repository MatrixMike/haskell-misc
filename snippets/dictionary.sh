echo e ':m + Text.Regex.Posix Data.List\nreadFile"/usr/share/dict/words">>=mapM_ print.take 12.reverse.sort.map(\x>(length x,x)).filter(=~"d.*d.*p").lines' | ghci
