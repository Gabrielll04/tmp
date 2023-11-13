import Network.Socket
import Network.Socket.ByteString (send, recv)
import qualified Data.ByteString.Char8 as C

main :: IO ()
main = do
  let hints = defaultHints { addrFlags = [AI_NUMERICHOST, AI_NUMERICSERV], addrSocketType = Stream }
  addr:_ <- getAddrInfo (Just hints) (Just "127.0.0.1") (Just "1234")
  sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
  bind sock (addrAddress addr)
  listen sock 5
  socketAddress <- getSocketName sock
  putStrLn $ "Server " ++ show socketAddress ++ " is running!"
  (conn, a) <- accept sock
  let message = C.pack $ "You're connected on " ++ show socketAddress ++ " server!"
  send conn message -- Note that this message will be printed along with the returns of handleRequest!
  handleRequest conn
  close sock

handleRequest :: Socket -> IO ()
handleRequest conn = do
  msg <- recv conn 1024
  case parseMessage msg of
    Just ("ADD",nums) -> send conn (performAddiction nums)
    Just ("SUB",nums) -> send conn (performSubtraction nums)
    _ -> send conn (C.pack "Invalid command")
  close conn

parseMessage :: C.ByteString -> Maybe (String,[Int])
parseMessage msg = case words (C.unpack msg) of
  (command:nums) -> Just (command, map read nums)
  _ -> Nothing

performAddiction :: [Int] -> C.ByteString -- We don't need to unpack nums because it's already transformed by map read nums.
performAddiction nums = C.pack $ "Result: " ++ show (sum nums)

performSubtraction :: [Int] -> C.ByteString
performSubtraction nums = C.pack $ "Result: " ++ show (foldl1 (-) nums)