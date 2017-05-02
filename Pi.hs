module Pi where

import Prelude hiding (pi)
import Control.Parallel

-- From Unbounded Spigot Algorithms for the Digits of Pi by Jeremy Gibbons   
pi :: [Integer]   
pi = g(1,180,60,2) where
    g(q,r,t,i) = let (u,y)=(3*(3*i+1)*(3*i+2),div(q*(27*i-12)+5*r)(5*t))
                 in y : g(10*q*i*(2*i-1),10*u*(q*(5*i-2)+r-y*t),t*u,i+1)
    
    
fib :: Int -> Integer
fib n | n <= 30 = fib' n
      | otherwise = par n1 (pseq n2 (n1 + n2))
                    where n1 = fib (n-1)
                          n2 = fib (n-2)
         
fib' :: Int -> Integer
fib' 0 = 0
fib' 1 = 1
fib' n = fib' (n-1) + fib' (n-2)



