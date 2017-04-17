module Utils where

trd :: (a,a,a,a) -> a
trd (_,_,a,_) = a

forth :: (a,a,a,a) -> a
forth (_,_,_,a) = a

calcToString :: (Int, Int, String, Float) -> String
calcToString (op1,op2,operator,result) = show op1 ++ " " ++ operator ++ " " ++ show op2 ++ " = " ++ show result