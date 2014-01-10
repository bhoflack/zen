{-# Language OverloadedStrings #-}
import Network.Zen.Types
import Test.Hspec

import qualified Data.Set as Set
import qualified Network.Zen.Dynamo as Dynamo

main :: IO ()
main = hspec $ do
  describe "Joining a cluster" $ do
    it "Adds a node to the cluster when it receives a join command" $ do
      let c = Config { _cNodeName = "nodeA" }
          s = State { _sPeers = Set.empty }
      (s', commands) <- Dynamo.handle c s $ EMessage "nodeB" $ MJoin Join
      s' `shouldBe` State { _sPeers = Set.fromList ["nodeB"] } 
