import Control.Monad
import Data.Char

main :: IO ()
main =  forever $ do -- So what we're essentially doing with that use of forever is taking the input and transforming it into some output.
  line <- getContents --  it's not represented in memory as a real string, but more like a promise that it will produce the string eventually.
  putStr $ map toUpper line
