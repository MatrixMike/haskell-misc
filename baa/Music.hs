module Music where 

type Note = Int
type Melody = [Note]

data Music
  = C
  | C'
  | D
  | E_
  | E 
  | F
  | F'
  | G
  | G'
  | A
  | B_
  | B
  | Sharp Music
  | Flat Music
  | Higher Integer Music
  | Lower Integer Music
  | Longer Integer Music
  | Sequence [Music]
  | Silence
 deriving(Show)

class Notable a where
  toNotes :: a -> [Note]

instance Notable Music where
    toNotes music = map (+50) (toNotes' music)
        where
        toNotes' C = [0]
        toNotes' C' = [1]
        toNotes' D = [2]
        toNotes' E_ = [3]
        toNotes' E = [4]
        toNotes' F = [5]
        toNotes' F' = [6]
        toNotes' G = [7]
        toNotes' G' = [8]
        toNotes' A = [9]
        toNotes' B_ = [10]
        toNotes' B = [11]
        toNotes' (Sequence ms) = concatMap toNotes' ms
        toNotes' (Sharp music') =  map (+1) (toNotes' music')
        toNotes' (Flat music') =  map (subtract 1) (toNotes' music')
        toNotes' (Higher n music') =  map (+ (fromIntegral n) ) (toNotes' music')
        toNotes' (Lower n music') =  map (subtract ((fromIntegral n ))) (toNotes' music')
        toNotes' (Longer n music') =  concatMap (replicate (fromIntegral n) ) (toNotes' music')
        toNotes' Silence = [-1]
