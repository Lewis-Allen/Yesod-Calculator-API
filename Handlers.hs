{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handlers where

import Foundation
import MyDatabase
import Utils

import Yesod.Core
import Yesod.Auth
import Text.Lucius
import Text.Hamlet
import Text.Blaze
import Data.Maybe

-- Home page
getHomeR :: Handler Html
getHomeR = do 
        maid <- maybeAuthId
        defaultLayout $ do
            setTitle "Calculator API"
            toWidget $(hamletFile "templates/homePage.hamlet")
            toWidget $(luciusFile "templates/homePage.lucius")
            -- <a href=@{AddR 5 7}?_accept=application/json>JSON addition // Use this later?

-- Handler for division
getDivR :: Int -> Int -> Handler TypedContent
getDivR x y = do
    let z = fromIntegral x / fromIntegral y
    liftIO $ insertCalc x y "/" z
    selectRep $ do
        provideRep $ defaultLayout $ buildPageDiv "Division" ("/" :: String) x y z
        provideJson $ object ["result" .= (z :: Float)]

-- Handler for addition
getAddR :: Int -> Int -> Handler TypedContent
getAddR x y = do
    liftIO $ insertCalc x y "+" (fromIntegral z)
    selectRep $ do
        provideRep $ defaultLayout $ buildPage "Addition" ("+" :: String) x y z
        provideJson $ object ["result" .= z]
      where
        z = x + y
 
-- Handler for subtraction
getSubR :: Int -> Int -> Handler TypedContent
getSubR x y = do
    liftIO $ insertCalc x y "-" (fromIntegral z)
    selectRep $ do
        provideRep $ defaultLayout $ buildPage "Subtraction" ("-" :: String) x y z
        provideJson $ object ["result" .= z]
      where
        z = x - y

-- Handler for multiplication
getMultR :: Int -> Int -> Handler TypedContent
getMultR x y = do
    liftIO $ insertCalc x y "*" (fromIntegral z)
    selectRep $ do
        provideRep $ defaultLayout $ buildPage "Multiplication" ("*" :: String) x y z
        provideJson $ object ["result" .= z, "operand1" .= x, "operand2" .= y, "operator" .= ("*" :: String)] 
      where
        z = x * y
                            
-- Handler for printing the DB data to the terminal
getCalcR :: Handler Html
getCalcR = do 
    liftIO $ viewDB
    defaultLayout $ do
        setTitle "Calculations"
        [whamlet|
            <h1>See Terminal for a list of calculations
        |]
        
-- List calculations on screen
getListR :: Handler Html
getListR = defaultLayout $ do
    calcs <- liftIO $ getCalcs
    setTitle "List of Calculations"
    toWidget $(hamletFile "templates/listPage.hamlet")
    toWidget $(luciusFile "templates/listPage.lucius")

getHistoryR :: Handler Html
getHistoryR = undefined
    
----- HTML and CSS -----
-- Default HTML and CSS loader for arithmetic operation pages.        
buildPage :: String -> String -> Int -> Int -> Int -> Widget
buildPage operation operator x y z = do
                                setTitle $ string operation
                                toWidget $(hamletFile "templates/arithmetic.hamlet")
                                toWidget $(luciusFile "templates/arithmetic.lucius")
     
-- Loader for division, which takes a float result rather than an integer.     
buildPageDiv :: String -> String -> Int -> Int -> Float -> Widget
buildPageDiv operation operator x y z = do
                                setTitle $ string operation
                                toWidget $(hamletFile "templates/arithmetic.hamlet")
                                toWidget $(luciusFile "templates/arithmetic.lucius")