module Test.DocTest.Eq where
import Util

-- | the default way to compare doctest output
-- with the calculated results
doctestEq0 :: String -> String -> Bool
doctestEq0 a b = f a == f b
    where f = stripEnd . unlines . map stripEnd . lines
