maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    |  otherwise = maxTail
    where maxTail = maximum' xs
    
main :: IO ()
main = do
    print (maximum' [9, 2, 3, 1000, 4, 100000, 6])
