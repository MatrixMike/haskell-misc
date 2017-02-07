

main = print $ take 4 sbs
sbs = iterate (concatMap sb) [[1,1]]
sb [x,y] = [[x,x+y],[x+y,y]]


