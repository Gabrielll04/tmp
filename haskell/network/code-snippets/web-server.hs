module Main where

import Network.Socket
import Control.Concurrent(forkIO)
import Data.ByteString.Char8 (pack)
import Network.Socket.ByteString (send)


main = do
  let hints = defaultHints { addrFlags = [AI_PASSIVE], addrSocketType = Stream }
  addr:_ <- getAddrInfo (Just hints) (Just "0.0.0.0") (Just "8080")
  sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
  bind sock (addrAddress addr)
  listen sock 1024
  mainLoop sock

mainLoop :: Socket -> IO ()
mainLoop sock = do
  (conn, _) <- accept sock
  forkIO $ runConn conn
  mainLoop sock

runConn :: Socket -> IO ()
runConn conn = do -- Sending the string with send to improve performance
  send conn (pack "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Welcome to the Jungle! :D</h1><style>h1 {color: red;}</style><p>How are you?</p>")
  close conn
