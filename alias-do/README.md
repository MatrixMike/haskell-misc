alias-do
========
9 Jun 2014
usage:

```bash
alan:alias-do alanhawkins$ source startup.sh
alan:alias-do alanhawkins$ alias lsd="ls -l"
alan:alias-do alanhawkins$ runhaskell alias-do.hs 
total 24
-rw-r--r--  1 alanhawkins  staff   18  9 Jun 10:08 README.md
-rw-r--r--  1 alanhawkins  staff  378  9 Jun 11:09 alias-do.hs
-rw-r--r--  1 alanhawkins  staff  112  9 Jun 11:06 startup.sh
alan:alias-do alanhawkins$ alias lsd="ls"
alan:alias-do alanhawkins$ runhaskell alias-do.hs 
README.md       alias-do.hs     startup.sh
```
