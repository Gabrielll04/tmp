fibs :: [Int]
fibs = [ a + b | (a,b) <- zip (1: fibs) (0: 1: fibs) ] -- Creating a list of tuple and returning the sum of the numbers from each tuples.

main :: IO ()
main = do
  print (take 10 fibs)
