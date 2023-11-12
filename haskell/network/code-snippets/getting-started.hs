import Network.Socket

main :: IO SockAddr -- "SockAddr to print the "getSocketName sock
main = do
  let hints = defaultHints { addrFlags = [AI_NUMERICHOST, AI_NUMERICSERV], addrSocketType = Stream } -- defaultHints returns a addrInfo
  addr:_ <- getAddrInfo (Just hints) (Just "127.0.0.1") (Just "1234")
  sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
  bind sock (addrAddress addr)
  getSocketName sock
