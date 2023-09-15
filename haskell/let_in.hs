-- http://learnyouahaskell.com/syntax-in-functions#let-it-be

-- let <bindings> in <expression>

-- The difference between let in and where is that let in bindigs are expressions themselves
-- and where bindigs are just syntatic constructs.
-- So you can use let in almost in everywhere.
-- 4 * (let a = 9 in a + 1) + 2  

-- Binding several variables inline:
-- (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)  

-- They can also be used to introduce functions in a local scope:
-- [let square x = x * x in (square 5, square 3, square 2)]  

cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
    let 
        side_area = 2 * pi * r * h
        top_area = pi * r^2
    in 
        side_area + 2 * top_area

just_call_it :: Int
just_call_it = 
    let (a,b,c) = (10, 20, 30)
    in a+b+c

-- Let in with list comprehensions:
calcBmis :: (RealFloat a) => [(a,a)] -> [a]
calcBmis xs = [bmi | (w,h) <- xs, let bmi = w / h^2]v -- note that the let is not a predicate so it's not filtering the list.

main :: IO ()
main = do
    print (cylinder 10 15)
    print (just_call_it * 10)
    print (calcBmis [(1.77, 56)])
