module Network.Zen.Dynamo.Util 
  (
    currentState
  ) where

import Control.Monad.State (get)

import Network.Zen.Monad (TransitionT)
import Network.Zen.Types (InternalState (..), State (..), wrap)

currentState :: (Functor m, Monad m) => TransitionT InternalState m State
currentState = wrap `fmap` get
