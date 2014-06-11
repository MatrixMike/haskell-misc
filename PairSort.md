Had a weird idea to construct a sorting alogrithm where every cell consults with its neighbours how the data should be moved.

```haskell

*PairSort> (\x -> PairSort.sort x == Data.List.sort x) [3,345,345,345,334,5346,26,27,27,275,57,45]
True

```
