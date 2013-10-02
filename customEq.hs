module Main where

import Data.Char

{- |


>>> :{
>>> let doctestEq a b | all isSpace a, all isSpace b = True
>>>     doctestEq a "anything" = True
>>>     doctestEq a b = a == b
>>> :}



>>> 23
anything

-}
main = return ()
