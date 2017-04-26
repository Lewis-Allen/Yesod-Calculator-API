{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE ViewPatterns      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
 
module Foundation where

import Yesod.Core
import Network.HTTP.Client.Conduit (Manager)
import Yesod
import Yesod.Auth
import Yesod.Auth.GoogleEmail2
import Data.Text

data App = App
    {
        httpManager :: Manager
    }

-- Would not be visible in source control in real-world situation
clientId :: Text
clientId = "224651177987-2eaniae25ln7ar5fdqcg4neqs5u3jg19.apps.googleusercontent.com"

clientSecret :: Text
clientSecret = "1RYA4l43bn6LGg-bedf8dqKd"

mkYesodData "App" $(parseRoutesFile "routes")

instance YesodAuth App where
    type AuthId App = Text
    getAuthId = return . Just . credsIdent

    loginDest _ = HomeR
    logoutDest _ = HomeR

    authPlugins _ =
        [
            authGoogleEmail clientId clientSecret
        ]

    authHttpManager = httpManager

    maybeAuthId = lookupSession "_ID"

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

instance Yesod App where
    approot = ApprootStatic "http://localhost:3000"
    
    -- Must be logged in to view calculation history.
    isAuthorized ListR _ = isLoggedIn
    
    -- Other pages do not require logging in.
    isAuthorized _ _ = return Authorized
    
-- Checks if a user is logged in.
isLoggedIn :: HandlerT App IO AuthResult
isLoggedIn = do
    user <- maybeAuthId
    return $ case user of
        Nothing -> AuthenticationRequired
        Just _ -> Authorized