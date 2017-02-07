import Midi
import Data.ByteString as S

intro  = Sequence [ C, C, G, G ]
run    = Sequence [ A, B, C, A ]
middle = Sequence [ F, F, E, E ]
run2   = Sequence [ D, C, D, E ]
baaBaa = Sequence [ Longer 2 intro
                  , Higher 12 run
                  , Longer 4 G
                  , Longer 2 middle
                  , run2
                  , Longer 4 C ]
              
myComposition = Sequence [C,D,E,F,G,A,B,Higher 12 C]

main = do 
       S.writeFile make_music "my_composition.mid" myComposition