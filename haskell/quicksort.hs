-- http://learnyouahaskell.com/recursion#quick-sort

-- While it takes upwards of 10 lines to implement quicksort in imperative languages,
-- the implementation is much shorter and elegant in Haskell.

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a > x]
    in smallerSorted ++ [x] ++ biggerSorted    
    
-- Algorithm will first take the head, which is 5 and then put it in the middle of two lists that are smaller and bigger than it. So at one point, you'll have [1,4,3] ++ [5] ++ [9,6,7]
    
main :: IO ()
main = do
    print (quicksort [10,2,5,3,1,6,7,4,2,3,4,8,9])
    print (quicksort "the quick brown fox jumps over the lazy dog") 
