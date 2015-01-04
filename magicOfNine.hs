take 12  $ map ( sum .map ( digitToInt) . filter (/= '.') . show ) $ iterate (/2) 360
