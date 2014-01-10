{-# Language TemplateHaskell #-}
module Network.Zen.Types 
    (
      Command (..)
    , Config (..)
    , Event (..)
    , InternalState (..), isPeers
    , Join (..)
    , Message (..)
    , NodeId
    , Ping (..)
    , Pong (..)
    , State (..)
    , unwrap
    , wrap
    ) where

import Control.Lens (makeLenses)
import Data.ByteString (ByteString)
import Data.Set (Set)

type NodeId = ByteString

data Config = Config {
                       _cNodeName :: String
                     }
    deriving (Show, Eq)
makeLenses ''Config

-- Messages
data Ping = Ping
    deriving (Show, Eq)

data Pong = Pong
    deriving (Show, Eq)

data Join = Join
    deriving (Show, Eq)

data Message = MPing Ping
             | MPong Pong
             | MJoin Join
    deriving (Show, Eq)

data Command = CSend NodeId Message
    deriving (Show, Eq)

data State = State {
                     _sPeers :: Set NodeId
                   }
    deriving (Show, Eq)
makeLenses ''State

data InternalState = InternalState { _isPeers :: Set NodeId }
    deriving (Show, Eq)
makeLenses ''InternalState

wrap :: InternalState -> State
wrap InternalState { _isPeers=ps }  = State { _sPeers = ps }

unwrap :: State -> InternalState
unwrap State { _sPeers=ps } = InternalState { _isPeers = ps }

data Event = EMessage NodeId Message
    deriving (Show, Eq)
