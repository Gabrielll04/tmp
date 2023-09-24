largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [100000,99999..]) -- Haskell doesn't applies the filter to each element of the array due to the laziness of the language; it simply applies the predicated to the numbers who satisfy it
    where p x = x `mod` 3829 == 0
    
chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
    | even n = n:chain (n `div` 2)
    | odd n  = n:chain (n*3 + 1)

numLongChain :: Int
numLongChain = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15

-- Lambda (anonymous functions)

numLongChainLambda :: Int
numLongChainLambda = length (filter (\xs -> length xs > 15) (map chain [1..100]))

addThree :: (Num a) => a -> a -> a -> a
addThree = \x -> \y -> \z -> x + y + z -- Equivalent to addThree x y z = x + y + z

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = \x y -> f y x

-- folds functions

sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs -- 0 is the first value, xs is the list to be folded up.. 0 is used as the acc parameter and the x is the current elemtent parameter. 0 + 3 produces a 3 and it becomes the new accumulator value.

succinctlySum' :: (Num a) => [a] -> a -- Taking curried functions into account to write a more succinctly function
succinctlySum' = foldl (+) 0
--  Generally, if you have a function like foo a = bar b a, you can rewrite it as foo = bar b, because of currying.

elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys -- The accumulator is False and will be always the same. If the element is the element we're looking for, then the value of the accumulator are set to True.

-- right fold:
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs
-- If we're mapping (+3) to [1,2,3], we approach the list from the right side. We take the last element, which is 3 and apply the function to it, which ends up being 6. Then, we prepend it to the accumulator, which is was []. 6:[] is [6] and that's now the accumulator
-- Of course, we could have implemented this function with a left fold too. It would be map' f xs = foldl (\acc x -> acc ++ [f x]) [] xs, but the thing is that the ++ function is much more expensive than :, so we usually use right folds when we're building up new lists from a list.

-- foldr1 and foldl1 
-- Basicaly fold functions without the need to receive explicit starting values

maximum' :: (Ord a) => [a] -> a
maximum' = foldr1 (\x acc -> if x > acc then x else acc)

main :: IO ()
main = do
    print (largestDivisible)
    print (sum (takeWhile (<10000) (filter odd (map (^2) [1..])))) -- sum (takeWhile (<10000) [n^2 | n <- [1..], odd (n^2)])  
    print (chain 30)
    print (numLongChain)
    print (zipWith (\a b -> (a * 30 + 3) / b) [5,4,3,2,1] [1,2,3,4,5])
    
    --pattern matching in lambdas:
    print (map (\(a,b) -> a + b) [(1,2),(3,5),(6,3),(2,6),(2,5)])
    print (addThree 1 2 3)
    
    print (sum' [1,2,3,4,5])
    print (map' (+3) [1,2,3])
    print (maximum [1,2,3,4,5]) 
