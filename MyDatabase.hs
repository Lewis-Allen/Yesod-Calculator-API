{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MyDatabase where

import Data.Foldable
import Database.SQLite.Simple

data Calculation = Calculation Int Int String Float deriving (Show)

instance FromRow Calculation where
    fromRow = Calculation <$> field <*> field <*> field <*> field
    
instance ToRow Calculation where
  toRow (Calculation operand1 operand2 operator result) = toRow (operand1, operand2, operator, result)

createDB :: IO ()
createDB = do
    conn <- open "calculations.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS calculations (operand1 INTEGER, operand2 INTEGER, operator TEXT, result FLOAT)"
    close conn
    
viewDB :: IO ()
viewDB = do
    conn <- open "calculations.db"
    r <- query_ conn "SELECT * from calculations"
    forM_ r $ \(operand1, operand2, operator, result) ->
        putStrLn $ show (operand1 :: Int) ++ " " ++ operator ++ " " ++ show (operand2 :: Int) ++ " = " ++ show (result :: Float)
    close conn
    
insertCalc :: Int -> Int -> String -> Float -> IO ()
insertCalc w x y z = do
                conn <- open "calculations.db"
                execute conn "INSERT INTO calculations (operand1, operand2, operator, result) VALUES (?,?,?,?)" (Calculation w x y z)
                close conn    
    
getCalcs :: IO ([(Int, Int, String, Float)])
getCalcs = do
    conn <- open "calculations.db"
    r <- query_ conn "SELECT * from calculations"
    close conn
    return r
