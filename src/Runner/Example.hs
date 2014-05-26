module Runner.Example (
  formatNotEqual

-- * for tests
, stripColor
) where

import           Data.Char
import           Text.PrettyPrint.ANSI.Leijen


formatNotEqual :: [String] -> [String] -> Doc
formatNotEqual expected actual
    = dullgreen (text "expected:") <+> fmtOut expected
    <$> dullgreen (text " but got:") <+>  fmtOut actual
  where
    -- use show to escape special characters in output lines if any output line
    -- contains any unsafe character
    escapeOutput
      | any (not . isSafe) (concat $ expected ++ actual) = map show
      | otherwise = id

    isSafe :: Char -> Bool
    isSafe c = c == ' ' || (isPrint c && (not . isSpace) c)

    fmtOut = hang 0 . vcat . map string . escapeOutput



-- | used for tests for now only
--
-- drops ascii escape codes. With this kind of filter
-- we won't be able to test that strings containing \ESC
-- will be properly displayed...
stripColor :: String -> String
stripColor ('\ESC':'[':'0':'m':xs) = stripColor xs
stripColor ('\ESC':_:_:_:_:xs) = stripColor xs
stripColor (x:xs) = x : stripColor xs
stripColor [] = []

