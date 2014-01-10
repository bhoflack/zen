module Network.Zen.Dynamo.Join 
    (
      handle
    ) where

import Control.Monad.State (get, put)

import Network.Zen.Monad (MessageHandler)
import Network.Zen.Types
import Network.Zen.Dynamo.Util (currentState)

import qualified Data.Set as Set

handle :: (Functor m, Monad m)
       => MessageHandler Join State m ()
handle s Join = do
    state <- get
    let peers = _isPeers state
        peers' = Set.insert s peers
        state' = state { _isPeers = peers' }
    put state'
    currentState
