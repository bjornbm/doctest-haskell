module Foo where
-- | >>> :{
--let x = 1
--    y = 2
--  in x + y + foo
-- :}
-- 6
foo = 3

{- |
 
>>> :{
 let x = 1
     y = 2
 in x + y + foo
  :}
  6
  -}
foo2 = 3
