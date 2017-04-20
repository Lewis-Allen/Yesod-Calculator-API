import Application () -- for YesodDispatch instance
import Foundation
import Yesod.Core
import MyDatabase

import Network.HTTP.Client.Conduit (newManager)

main :: IO ()
main = do
    createDB
    man <- newManager
    warp 3000 $ App man
    