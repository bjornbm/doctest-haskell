module Runner.Example (
  Result (..)
, mkResult
) where

import           Util
import           Text.PrettyPrint.ANSI.Leijen

data Result = Equal | NotEqual Doc
  deriving (Show)

mkResult :: [String] -> [String] -> Result
mkResult expected_ actual_
  | expected == actual = Equal
  | otherwise = NotEqual (formatNotEqual expected actual)
  where
    expected = map stripEnd expected_
    actual   = map stripEnd actual_

formatNotEqual :: [String] -> [String] -> Doc
formatNotEqual expected actual
    = dullgreen (text "expected:") </> hang 0 (vcat (map string expected))
    <$> dullgreen (text " but got:") </>  hang 0 (vcat (map string actual))
