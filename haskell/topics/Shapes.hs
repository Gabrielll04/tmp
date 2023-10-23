-- By doing Shape(..), we exported all the value constructors for Shape

-- -- We could also opt not to export any value constructors for Shape by just writing Shape in the export statement. That way, someone importing our module could only make shapes by using the auxilliary functions baseCircle and baseRect.
module Shapes 
(
    Point(..),
    Shape(..),
    surface,
    nudge,
    baseCircle,
    baseRect
) where

data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

surface :: Shape -> Float  
surface (Circle _ r) = pi * r ^ 2  
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)

-- How about a function that nudges a shape? 
-- It takes a shape, the amount to move it on the x axis and the amount to move it on the y axis
-- and then returns a new shape that has the same dimensions, only it's located somewhere else.

nudge :: Shape -> Float -> Float -> Shape
nudge (Circle (Point x y) r) a b = Circle (Point (x+a) (y+b)) r
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1+a) (y1+b)) (Point (x2+a) (y2+b))

baseCircle :: Float -> Shape -- Take a radius and returns a circle with that radius in zero coordinates.
baseCircle r = Circle (Point 0 0) r

baseRect :: Float -> Float -> Shape
baseRect width height = Rectangle (Point 0 0) (Point width height)

main :: IO ()
main = do
    print $ surface (Rectangle (Point 0 0) (Point 100 100))
    print $ surface (Circle (Point 0 0) 24)  
    print (nudge (Circle (Point 34 34) 10) 5 10)
    print (baseCircle 4)
    print (baseRect 10 15)
    print (nudge (baseRect 40 100) 60 23)
    print (Circle (Point 0 0) 1.0) --Constructors are just a function that take the fields as parameters and returns a value of the data type 
