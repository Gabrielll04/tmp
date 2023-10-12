module Pangram (isPangram) where
import Data.List
import Data.Char
rmDup :: String -> String-- I know that's horrible solution, I'm just a beginner man :(
rmDup [] = []
rmDup arr@(x:xs) 
    | not (validChar x) = rmDup xs
    | (x `elem` xs) == True = rmDup xs
    | otherwise         = x : rmDup (filter validChar xs) 
    where validChar c = not (isNumber c) && c /= '_' && not (isSpace c) && not (isPunctuation c) && (isAscii c)
    
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
  let lowerSorted = quicksort [a | a <- xs, a <= x]
      upperSorted = quicksort [a | a <- xs, a > x]
  in lowerSorted ++ [x] ++ upperSorted
isPangram :: String -> Bool
isPangram text
    | ['a'..'z'] == quicksort (rmDup $ map toLower text) = True
    | otherwise                                          = False
