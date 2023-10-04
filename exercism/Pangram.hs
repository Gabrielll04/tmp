import Data.List (isInfixOf, splitAt, concat)
import Data.Char (isSpace, isMark, isNumber)

rmDup [] = []
rmDup (x:xs) = x : rmDup (filter (\x -> not(isNumber x)) (filter (\x -> x /= '_') (filter (\x -> not(isMark x)) (filter (\x -> not(isSpace x)) (filter (\y -> not(x == y)) xs))))) -- I know that's horrible, I'm just a  beginner man :(

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
    print (isPangram "abcdefghijklmnopqrstuvwxyz")
    print (rmDup "abcdefghijklmnopqrstuvwxyz")
