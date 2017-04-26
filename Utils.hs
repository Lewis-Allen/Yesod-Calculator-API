module Utils where

calcToString :: (Int, Int, String, Float) -> String
calcToString (op1,op2,operator,result) = show op1 ++ " " ++ operator ++ " " ++ show op2 ++ " = " ++ show result

