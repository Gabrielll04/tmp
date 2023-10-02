data Bool = False | True -- The part before the = denotes the type, which is Bool. The parts after the = are value constructors. They specify the different values that this type can have. The | is read as or. So we can read this as: the Bool type can have a value of True or False.
-- data Int = -2147483648 | -2147483647 | ... | -1 | 0 | 1 | 2 | ... | 2147483647
data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)-- Your own type for 3D shapes. Hear, Circle and Rectangle are constructors, the Circle constructor ahs three fields (parameters) which accept Floats.
data Point = Point Float Float deriving (Show)


-- Value constructors are like functions that returns a value of data type.
-- ghci> :t Circle  
-- Circle :: Float -> Float -> Float -> Shape  
-- ghci> :t Rectangle  
-- Rectangle :: Float -> Float -> Float -> Float -> Shape  

surface :: Shape -> Float -- We couldn't write a type declaration of Circle -> Float because Circle is not a type, Shape is
surface (Circle _ _ r) = pi*r^2
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)     

main :: IO ()
main = do
    print (surface $ Circle 10 20 10)
    print (surface $ Rectangle 0 0 100 100)
    print (map (Circle 10 20) [4,5,6,6]) -- Value constructors are functions, so we can map them and partially apply them and everything. If we want a list of concentric circles with different radii, we can do this.
