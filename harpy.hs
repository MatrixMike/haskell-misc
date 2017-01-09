{-# LANGUAGE ForeignFunctionInterface #-}
module Main where

import Foreign hiding (xor)
import Foreign.C.Types
import Control.Monad
import Harpy


type SomeFunType = CInt -> CInt -> IO CInt

foreign import ccall "dynamic"
   call_int :: FunPtr SomeFunType -> SomeFunType


mSomeFun :: CodeGen () () (FunPtr SomeFunType)
mSomeFun = do
  mov eax (Disp 0x4, esp)
  mov ebx (Disp 0x8, esp)
  replicateM_ 4000000 (add eax ebx)
  ret
  liftM castPtrToFunPtr getEntryPoint

main = do
  (_, Right someFun) <- runCodeGen mSomeFun () ()
  call_int someFun 1337 432 >>= print
