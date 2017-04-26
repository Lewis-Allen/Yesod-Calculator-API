{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MyDatabase where

import Data.Foldable
import Database.SQLite.Simple

-- Calculation Object: Username operand1 operand2 operator result
data Calculation = Calculation String Int (Maybe Int) String Float deriving (Show)

instance FromRow Calculation where
    fromRow = Calculation <$> field <*> field <*> field <*> field <*> field

instance ToRow Calculation where
  toRow (Calculation user operand1 operand2 operator result) = toRow (user, operand1, operand2, operator, result)

createDB :: IO ()
createDB = do
    conn <- open "calculations.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS calculations (user TEXT, operand1 INTEGER, operand2 INTEGER, operator TEXT, result FLOAT)"
    close conn
    
viewDB :: IO ()
viewDB = do
    conn <- open "calculations.db"
    r <- query_ conn "SELECT * from calculations"
    forM_ r $ \(user, operand1, operand2, operator, result) ->
        putStrLn $ user ++ " " ++ show (operand1 :: Int) ++ " " ++ operator ++ " " ++ show (operand2 :: Maybe Int) ++ " = " ++ show (result :: Float)
    close conn
    
insertCalc :: String -> Int -> Maybe Int -> String -> Float -> IO ()
insertCalc v w x y z = do
                conn <- open "calculations.db"
                execute conn "INSERT INTO calculations (user, operand1, operand2, operator, result) VALUES (?,?,?,?,?)" (Calculation v w x y z)
                close conn
    
getCalcs :: String -> IO ([(Int, Maybe Int, String, Float)])
getCalcs name = do
    conn <- open "calculations.db"
    r <- query conn "SELECT operand1, operand2, operator, result from calculations WHERE user = ?" (Only (name :: String))
    close conn
    return r