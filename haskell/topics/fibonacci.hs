fibs :: [Int]
fibs = [ a + b | (a,b) <- zip (1: fibs) (0: 1: fibs) ] -- Creating a list of tuple and returning the sum of the numbers from each tuples.

-- My own version
fibonacci :: Int -> Int -> Int -> [Int]
fibonacci a b n
  | n <= 0 = []
  | otherwise = b:fibonacci b (a+b) (n-1)


main :: IO ()
main = do
  print (take 10 fibs)
