16 Dec 2016
note: This was mainly an experiment.

Manipluate strings from shell using haskell


from terminal:
```
echo "1 + 1 = 2" | e reverse           
2 = 1 + 1
```

```
echo "1 + 1 = 2" | e take 5           
1 + 1
```

Capture and Replace using parsec

```
echo "30 + 30 = 60" | e "do {x <- many1 digit;return (show ((read x::Int)*2))}"  
60 + 60 = 120 
```
