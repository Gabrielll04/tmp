-- http://learnyouahaskell.com/syntax-in-functions#guards-guards

-- Guards are a way of testing whether an value are true or false.
-- It's very familiar with if statements but more readable.
-- Guards play really nicely with patterns.

bmiTell :: (RealFloat a) => a -> a -> String
bmiTell w h -- Yes, there's no '=' right after the function name and its parameters
    | bmi<= 18.25 = "You're underweight, you emo, you!"
    | bmi <= 25.0  = "You're supposedly normal. Pffff, I bet you're ugly!"
    | bmi <= 30    = "You're fat!"
    | otherwise         = "You're a whale, congrats!"
    where bmi = w * h ^2 
    
max' :: (Ord a) => a -> a -> a
max' a b 
    | a > b     = a
    | otherwise = b
    
myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a > b     = GT 
    | a == b    = EQ
    | otherwise = LT
    
main :: IO ()
main = do
    print (bmi 54 1.70)
    print (max' 5 4)
    print (5 `myCompare` 3)
