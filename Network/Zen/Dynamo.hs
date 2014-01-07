module Network.Zen.Dynamo 
    (
      handle
    ) where

import Network.Zen.Monad (Handler (..), MessageHandler (..), runTransitionT)
import Network.Zen.Types

import qualified Network.Zen.Dynamo.Ping as Ping

handle :: (Functor m, Monad m)
       => Config
       -> State
       -> Event
       -> m (State, [Command])
handle c s e = select `fmap` runTransitionT (handle' e) c s'
  where s' = unwrap s
        select :: (a, b, c) -> (a, c)
        select (a, _, c) = (a, c)

handle' :: (Functor m, Monad m)
       => Handler State m
handle' ev = case ev of 
  EMessage s m -> handleMessage s m 

handleMessage :: (Functor m, Monad m)
              => MessageHandler Message s m r
handleMessage s m = case m of
  MPing ping -> Ping.handle s ping
