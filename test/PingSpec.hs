{-# Language OverloadedStrings #-}
import Test.Hspec

import Network.Zen.Types
import qualified Network.Zen.Dynamo as Dynamo

main :: IO ()
main = hspec $ do
    describe "Ping between nodes" $ do
        it "replies pong to node a when it gets a ping request from node a" $ do
            let c = Config { _cNodeName = "listener" }
                s = State
            (s', commands) <- Dynamo.handle c s $ EMessage "nodea" $ MPing Ping
            commands `shouldBe` [CSend "nodea" $ MPong Pong]
