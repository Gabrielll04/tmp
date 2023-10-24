-- Typeclass defines behavior.
-- Eq type class:
-- class Eq a where  
--     (==) :: a -> a -> Bool  
--     (/=) :: a -> a -> Bool  
--     x == y = not (x /= y)  
--     x /= y = not (x == y)  

data TrafficLight = Red | Green | Blue

instance Eq TrafficLight where
    Red == Red = True
    Green == Green = True
    Blue == Blue = True
    _ == _ = False
    
instance Show TrafficLight where
    show Red = "Red light"
    show Green = "Green light"
    show Blue = "Blue light"

-- We could have just derived Eq and it would have had the same effect (but we didn't for educational purposes).

-- You can create typeclasses that are subclasses of other typeclasses:
-- class (Eq a) => Num a where

-- As the Maybe isn't a concrete type but a constructor that takes one parameter, we can't do something like 'instance Eq Maybe where'.
-- So we could write it out like so:
instance Eq (Maybe m) where  -- While 'Maybe' isn't a concrete type 'Maybe m' is. 
    Just x == Just y = x == y
    Nothing == Nothing = True -- True because Nothing - Nothing are equal.
    _ == _ = False
-- This is like saying that we want to make all types of the form 'Maybe something' an instance of Eq.

main :: IO ()
main = print (show Green)
