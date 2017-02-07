function runhaskell(){
export RUNHASKELL_ALIAS_VARS=$(alias 2> /dev/null);
eval "/usr/bin/env runhaskell " $@
}
