import Network.Socket
import System.IO
import Control.Monad (forever)
import Control.Concurrent (forkIO)

main :: IO ()
main = do
    let hints = defaultHints { addrFlags = [AI_PASSIVE], addrSocketType = Stream }
    addr:_ <- getAddrInfo (Just hints) (Just "127.0.0.1") (Just "8080")
    sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
    bind sock (addrAddress addr)
    listen sock 5
    forever $ do
        (conn,_) <- accept sock
        hdl <- socketToHandle conn ReadWriteMode
        hSetBuffering hdl NoBuffering
        hPutStrLn hdl "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Welcome to the Jungle! :D</h1><style>h1 {color: red;}</style><p>How are you?</p>"
        hClose hdl 
