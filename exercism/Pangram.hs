-- It's not finished yet...

import Data.List (isInfixOf, splitAt, concat)
import Data.Char (isSpace)

rmDup [] = []
rmDup (x:xs) = x : rmDup (filter (\x -> not(isSpace x)) (filter (\y -> not(x == y)) xs))

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
  let lowerSorted = quicksort [a | a <- xs, a <= x]
      upperSorted = quicksort [a | a <- xs, a > x]
  in lowerSorted ++ [x] ++ upperSorted

isPangram :: String -> Bool
isPangram text
    | ['a'..'z'] == quicksort (rmDup text) = True
    | otherwise                            = False
    
main :: IO ()
main = do   
    print (isPangram "the quick brown fox jumps over the lazy dog")
