map' :: (a -> b) -> [a] -> [b]
map' _ []     = []
map' f (x:xs) = f x : map' f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x:xs)
    | p x       = x : filter' p xs
    | otherwise = filter' p xs
    
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallSorted = quicksort (filter' (<=x) xs)
        biggerSorted = quicksort (filter' (>x) xs)
    in smallSorted ++ [x] ++ biggerSorted
    
main :: IO ()
main = do
    print (filter' (`elem` ['A'..'Z']) "i lauGh At You BecAuse u r aLL the Same")
    print (quicksort [8,9,6,7,4,5,2,3,1])
