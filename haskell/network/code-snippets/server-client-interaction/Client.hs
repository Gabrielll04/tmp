import Network.Socket
import System.Environment
import System.IO
  
main :: IO ()
main = do
  addr:_ <- getAddrInfo Nothing (Just "127.0.0.1") (Just "1234")
  sock <- socket (addrFamily addr) Stream (addrProtocol addr)
  connect sock (addrAddress addr)
  handle <- socketToHandle sock ReadWriteMode
  hSetBuffering handle NoBuffering
  sendMessage handle
  hClose handle

sendMessage :: Handle -> IO ()
sendMessage handle = do
  args <- getArgs -- ADD 4 5
  let command = head args
  let nums = tail args
  let msg = command ++ " " ++ unwords nums -- Sorry for the bad solution, i am sleepy
  hPutStrLn handle msg
  response <- hGetLine handle
  putStrLn response