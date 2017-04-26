module Utils where

calcToString :: (Int, Int, String, Float) -> String
calcToString (op1,op2,operator,result) = show op1 ++ " " ++ operator ++ " " ++ show op2 ++ " = " ++ show result

-- Adds a suffix to a number, i.e the "st" in "1st" or the "rd" in "3rd"
getSuffix :: Int -> String
getSuffix x | x `mod` 10 == 1 && x `mod` 100 /= 11 = "st" 
            | x `mod` 10 == 2 && x `mod` 100 /= 12 = "nd" 
            | x `mod` 10 == 3 && x `mod` 100 /= 13 = "rd"
            | otherwise                    = "th"