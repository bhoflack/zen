module Network.Zen.Dynamo.Ping
  (
    handle  
  ) where

import Control.Monad.State (get)

import Network.Zen.Dynamo.Util (currentState)
import Network.Zen.Monad (MessageHandler, send)
import Network.Zen.Types

handle :: (Functor m, Monad m)
       => MessageHandler Ping State m ()
handle sender Ping = do
    send sender $ MPong Pong
    currentState
