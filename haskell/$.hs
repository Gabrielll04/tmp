-- the $ function has the lowest precedence
-- Function application with a space is left-associative (so f a b c is the same as ((f a) b) c)), function application with $ is right-associative.
-- Consider the expression sum (map sqrt [1..130]). Because $ has such a low precedence, we can rewrite that expression as sum $ map sqrt [1..130]
-- sqrt 3 + 4 + 9? This adds together 9, 4 and the square root of 3. If we want get the square root of 3 + 4 + 9, we'd have to write sqrt (3 + 4 + 9) or if we use $ we can write it as sqrt $ 3 + 4 + 9 because $ has the lowest precedence of any operator. 


main :: IO ()
main =  do
    print (map ($ 3) [(4-), (10*), (^2), sqrt])
