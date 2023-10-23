divideByTen :: (Floating a) => a -> a
divideByTen = (/10) -- This is a section. Essentially, it creates a function that has one parameter on one side, then it takes a other parameter that will be supplied to the side lacking a operand.
-- Calling divideByTen 200 is equivalent to 200 / 10

isUpperAlphaNum :: Char -> Bool
isUpperAlphaNum = (`elem` ['A'..'Z'])

applyTwice :: (a -> a) -> a -> a -- Basically, we're saying that the first parameter is a function that takes something and returns that same thing
applyTwice f x = f (f x)

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y:zipWith' f xs ys

flip' :: (a -> b -> c) -> (b -> a -> c) -- (a -> b -> c) -> (b -> a -> c) is the same as (a -> b -> c) -> (b -> (a -> c))
flip' f = g
    where g x y = f y x

main :: IO ()
main = do
    print (divideByTen 10)
    print (isUpperAlphaNum 'B')
    print (applyTwice (+3) 5)
    print (applyTwice ("haha" ++ ) "hihi")
    print (zipWith' (+) [4,2,5,6] [2,6,2,3])
    print (zipWith' (++) ["foo ", "bar ", "baz "] ["fighters", "hoppers", "aldrin"])
    print (zipWith' (*) (replicate 5 2) [1..])
    print (zipWith' (zipWith' (*)) [[1,2,3],[3,5,6],[2,3,4]] [[3,2,2],[3,4,5],[5,4,3]])
    print (flip' zip [1,2,3,4,5] "hello")
