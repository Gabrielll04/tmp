import System.IO 
import Network.Socket
import Control.Exception
import Control.Monad.Fix 
import Control.Concurrent
import Control.Monad (when)
import Control.Concurrent.Chan

main :: IO ()
main = do
  let hints = defaultHints { addrFlags = [AI_PASSIVE], addrSocketType = Stream }
  addr:_ <- getAddrInfo (Just hints) (Just "127.0.0.1") (Just "8080")
  sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
  bind sock (addrAddress addr)
  listen sock 5
  chan <- newChan -- Channels are shared FIFO queues implemented with MVars. In some way it are also existent in golang. Channels can grow indefinitely
  _ <- forkIO $ fix $ \loop -> do
    (_, _) <- readChan chan
    loop
  mainLoop sock chan 0

type Msg = (Int, String)

mainLoop :: Socket -> Chan Msg -> Int -> IO ()
mainLoop sock chan msgNum = do
  (conn, _) <- accept sock
  forkIO $ runConn conn chan msgNum
  mainLoop sock chan $! msgNum + 1

runConn :: Socket -> Chan Msg -> Int -> IO ()
runConn conn chan msgNum = do
  let broadcast msg = writeChan chan (msgNum, msg)
  hdl <- socketToHandle conn ReadWriteMode
  hSetBuffering hdl NoBuffering
  
  hPutStrLn hdl "What's yous name? "
  name <- fmap init (hGetLine hdl) -- As the hdl is set as NoBuffering, we need to use a fmap to retrieve the entire string (?) (NoBuffering reads one character at a time)
  hPutStrLn hdl ("Welcome " ++ name ++ "!")

  commLine <- dupChan chan

  reader <- forkIO $ fix $ \loop -> do
    (nextNum, line) <- readChan commLine
    when (msgNum /= nextNum) $ hPutStrLn hdl line
    loop

  handle (\(SomeException _) -> return()) $ fix $ \loop -> do
    line <- fmap init (hGetLine hdl)
    case line of
      -- If an exception is caught, send a message and break the loop
      "quit" -> hPutStrLn hdl "Bye!"
      _      -> broadcast (name ++ ": " ++ line) >> loop

  killThread reader
  broadcast ("--> " ++ name ++ " left")
  hClose hdl
