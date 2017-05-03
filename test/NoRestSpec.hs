{-# LANGUAGE OverloadedStrings #-}
module NoRestSpec where

import Prelude hiding (pi)
import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Gen

import MathUtils (pi, fib, fib')

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
        describe "Non-Restful Tests" $ do 
          it "Checking nth digit of pi" $ do
             contents <- readFile "test/piDigits.txt"
             quickCheck (prop_checkPi contents)
             
        describe "fib with parallel" $ do 
          it "Checking fibbonacci parallelism" $ do
             fib 40 `shouldBe` 102334155
             
        describe "Fib without parallel" $ do
           it "Checking fib without parallel methods " $ do
             fib' 40 `shouldBe` 102334155
     
--prop_checkPi :: String -> Bool
prop_checkPi contents = do
                x <- generate genPosInt
                pi !! x `shouldBe` (read $ (contents !! x : [ ]))           
     
genPosInt :: Gen Int
genPosInt = (arbitrary :: Gen Int) `suchThat` (>0)
