-- f . g = \x -> f (g x)  
-- One of the uses for function composition is making functions on the fly to other functions.
-- Yes, you can use that with lambdas, but many of times, function composition is clearer and more concise.

-- Another commom use of function composition is defining functions in the so-called point free style.
sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0

fn1 x = ceiling (negate (tan (cos (max 50 x))))  

fn2 = ceiling . negate . tan . cos . max 50  

oddSquareSum :: Integer
oddSquareSum = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

oddSquareSum' :: Integer
oddSquareSum' = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]

-- oddSquareSum :: Integer
-- oddSquareSum = 
--     let oddSquares = filter odd $ map (^2) [1..]
--         belowLimit = takeWhile (<10000) oddSquares
--     in sum belowLimit

main :: IO ()
main = do
    print (map (\x -> negate (abs x)) [5,-3,-6,7,-3,2,-19,24])
    
    -- using function composution we could rewrite that as:
    print (map (negate . abs) [5,-3,-6,7,-3,2,-19,24])
    
    print (map (\xs -> negate (sum (tail xs))) [[1..5],[3..6],[1..7]])
    
    print (map (negate . sum . tail) [[1..5],[3..6],[1..7]])
    
    print (replicate 10 (product (map (*3) (zipWith max [1,2,3,4,5] [4,5,6,7,8]))))
    
    print (replicate 10 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8]) -- If the expression ends with three parentheses, chances are that if you translate it into function composition, it'll have three composition operators.

    print (sum' [1,2,3,4,5])
    
    print (oddSquareSum)
    print (oddSquareSum')
