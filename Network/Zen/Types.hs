{-# Language TemplateHaskell #-}
module Network.Zen.Types 
    (
      Command (..)
    , Config (..)
    , Event (..)
    , InternalState (..)
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

type NodeId = ByteString

data Config = Config {
                       _cNodeName :: String
                     }
    deriving (Show, Eq)
makeLenses ''Config

data Ping = Ping
    deriving (Show, Eq)

data Pong = Pong
    deriving (Show, Eq)

data Message = MPing Ping
             | MPong Pong
    deriving (Show, Eq)

data Command = CSend NodeId Message
    deriving (Show, Eq)

data State = State {}
    deriving (Show, Eq)

data InternalState = InternalState {}
    deriving (Show, Eq)

wrap :: InternalState -> State
wrap is = State {}

unwrap :: State -> InternalState
unwrap s = InternalState {}

data Event = EMessage NodeId Message
    deriving (Show, Eq)
