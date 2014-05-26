module Runner.ExampleSpec (main, spec) where

import           Test.Hspec
import           Test.QuickCheck


main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "mkResult" $ do
    it "returns Equal when output matches" $ do
      property $ \xs -> do
        mkResultNC xs xs `shouldBe` Nothing

    it "ignores trailing whitespace" $ do
      mkResultNC ["foo\t"] ["foo  "] `shouldBe` Nothing

    context "when output does not matche" $ do
      it "constructs failure message" $ do
        mkResultNC ["foo"] ["bar"] `shouldBe` Just
            "expected: foo\n\
            \ but got: bar"

      it "constructs failure message for multi-line output" $ do
        mkResultNC ["foo", "bar"] ["foo", "baz"] `shouldBe` Just
            "expected: foo\n\
            \          bar\n\
            \ but got: foo\n\
            \          baz"

      context "when any output line contains \"unsafe\" characters" $ do
        it "uses show to format output lines" $ do
          mkResultNC ["foo\160bar"] ["foo bar"] `shouldBe` Just
              "expected: \"foo\\160bar\"\n\
              \ but got: \"foo bar\""

mkResultNC :: [String] -> [String] -> Maybe String
mkResultNC _a _b = Nothing -- mkResult was removed anymore

