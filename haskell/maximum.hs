maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    |  otherwise = maxTail
    where maxTail = maximum' xs
    
replicate' :: (Num i, Ord i) => i -> a -> [a] -- We need to specify that 'i' is a number because the 'a' can have any type
replicate' n x
    | n <= 0    = []
    | otherwise = x:replicate' (n-1) x

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' _ [] = []
take' n _ 
    | n <= 0 = []
take' n (x:xs) = x:take' (n-1) xs
    
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x] 

-- 3:(3:(3:repeat 3))
-- take 5 (repeat 3) == replicate 5 3
repeat' :: a -> [a]
repeat' x = x:repeat' x

zip' :: [a] -> [b] -> [(a,b)] -- damn this function it pretty cool
zip' _ [] = []
zip' [] _ = [] -- (1,'a'):(2,'b'):[]
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

elem' :: (Ord a) => a -> [a] -> Bool
elem' _ [] = False  
elem' a (x:xs)
    | a == x = True
    | otherwise = elem' a xs

main :: IO ()
main = do 
    print (maximum' [1,2,3,4])
    print (replicate' 5 4)
    print (take' 2 [1,2,3,4,5])
    print (reverse' "Reverse")
    print (zip' [1,2,3] ["One", "Two"])
    print (elem' 5 [1,2,3,4,5])
    print (repeat' "5")
