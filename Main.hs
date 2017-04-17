import Application () -- for YesodDispatch instance
import Foundation
import Yesod.Core
import MyDatabase

main :: IO ()
main = do
    createDB
    warp 3000 App   