{-# LANGUAGE OverloadedStrings #-}
module HandlerSpec where

import Test.Hspec
import Test.Hspec.Wai
import Network.Wai
import Test.QuickCheck
import Control.Exception (evaluate)
import Data.Aeson
import Network.HTTP.Client.Conduit (newManager)

import Handlers
import Foundation
import MyDatabase
 
-- Allows test to be run with ghci if required
main :: IO ()
main = hspec spec

spec :: Spec
spec = do
        liftIO $ createDB
        man <- newManager
        with $ App man $
          describe "GET /" $ do
              it "responds with 200" $
                  get "/" `shouldRespondWith` 200