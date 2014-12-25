

data NibTree a = Nib (NibTree a) | Branch a (NibTree) | Leaf a 
