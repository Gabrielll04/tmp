import Network.Socket
import Network.Socket.ByteString
import Socket.IO 

main :: IO ()
main = do
  let hints = defaultHints { addrFlags = [AI_NUMERICHOST, AI_NUMERICSERV], addrSocketType = Stream } -- defaultHints returns a addrInfo
  addr:_ <- getAddrInfo (Just hints) (Just "127.0.0.1") (Just "1234")
  sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
  bind sock (addrAddress addr) -- Bounding
  listen sock 2
  (conn, _) <- accept sock
  hdl <- socketToHandle conn ReadWriteMode
  hSetBuffering hdl NoBuffering
  hPutStrLn hdl "Welcome to the server"
  hClose hdl
  close sock
