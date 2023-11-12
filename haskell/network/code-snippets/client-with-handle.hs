import Network.Socket
import System.IO

-- Connecting to the server of ./code-snippets/tcp-server-with-send.hs

main :: IO ()
main = do
  addr:_ <- getAddrInfo Nothing (Just "127.0.0.1") (Just "1234")
  sock <- socket (addrFamily addr) Stream (addrProtocol addr)
  connect sock (addrAddress addr)
  handle <- socketToHandle sock ReadWriteMode
  hSetBuffering handle NoBuffering -- Note that the new handle is unbuffered by default, so this line is kind of useless
  msg <- hGetLine handle
  putStrLn msg
  hClose handle
