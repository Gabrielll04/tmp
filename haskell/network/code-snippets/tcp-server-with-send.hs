import Network.Socket
import Network.Socket.ByteString
import qualified Data.ByteString.Char8 as S -- to use pack

main :: IO () -- "SockAddr to print the "getSocketName sock
main = do
  let hints = defaultHints { addrFlags = [AI_NUMERICHOST, AI_NUMERICSERV], addrSocketType = Stream } -- defaultHints returns a addrInfo
  addr:_ <- getAddrInfo (Just hints) (Just "127.0.0.1") (Just "1234")
  sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
  bind sock (addrAddress addr) -- Bounding
  listen sock 5 -- Listening
  socketAddress <- getSocketName sock
  putStrLn $ "Server " ++ show socketAddress ++ " is running!"
  (conn, _) <- accept sock -- Accepting a connection. The socket must be bound to an address and listening for connections.
  let msg = S.pack "HTTP/1.1 200 OK\n\nWelcome"
  send conn msg
  close conn
  close sock
