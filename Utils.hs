module Utils where

import Data.Maybe (isJust, fromJust, isNothing)
import Data.List (elemIndex)

-- Convert a calculation into a string for displaying on screen. Handles single operand calculations.
calcToString :: (Int, Maybe Int, String, Float) -> String
calcToString (op1,op2,operator,result) | isJust op2 = show op1 ++ " " ++ operator ++ " " ++ show (fromJust op2) ++ " = " ++ (removeTrailing $ show result)
                                       | otherwise  = operator ++ "[" ++ show op1 ++ "] = " ++ (removeTrailing $ show result)

-- Adds a suffix to a number, i.e the "st" in "1st" or the "rd" in "3rd"
getSuffix :: Int -> String
getSuffix x | x `mod` 10 == 1 && x `mod` 100 /= 11 = "st" 
            | x `mod` 10 == 2 && x `mod` 100 /= 12 = "nd" 
            | x `mod` 10 == 3 && x `mod` 100 /= 13 = "rd"
            | otherwise                            = "th"
  
-- Remove trailing zeros from a string. Used on shown floats.  
removeTrailing :: String -> String
removeTrailing xs | isNothing(elemIndex '.' xs) = xs
                  | last xs == '0' = removeTrailing $ init xs
                  | last xs == '.' = init xs
                  | otherwise = xs