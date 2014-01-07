{-# Language GeneralizedNewtypeDeriving #-}
module Network.Zen.Monad (
    TransitionT (..)
  , Handler (..)
  , MessageHandler (..)
  , runTransitionT
  , send
) where

import Control.Monad.Reader (MonadReader)
import Control.Monad.RWS (RWST (..), runRWST)
import Control.Monad.State (MonadState)
import Control.Monad.Writer (MonadWriter, tell)
import Network.Zen.Types

-- | Zen monad in which `Handler's live.
-- Reads `Config', issues `Command's and keeps state `s' to an inner monad `m'.
newtype TransitionT s m r = TransitionT { unTransitionT :: RWST Config [Command] s m r }
  deriving ( Functor
	   , Monad
           , MonadReader Config
           , MonadWriter [Command]
           , MonadState s
           )

runTransitionT :: TransitionT s m r -> Config -> s -> m (r, s, [Command])
runTransitionT = runRWST . unTransitionT

send :: (Monad m)
     => NodeId
     -> Message
     -> TransitionT s m ()
send n m = tell [CSend n m]

type Handler s m =  Event		-- ^ The `Event' to handle
	         -> TransitionT (InternalState) m State

type MessageHandler t s m r =  NodeId	-- ^ The `NodeId' of the sender of the message
			    -> t	-- ^ The message
		            -> TransitionT (InternalState) m State
