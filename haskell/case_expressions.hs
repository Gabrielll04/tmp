-- http://learnyouahaskell.com/syntax-in-functions#case-expressions

-- [...] Not only can we evaluate expressions based on the possible cases of the value of a variable,
-- we can also do pattern matching. Hmmm, taking a variable, pattern matching it,
-- evaluating pieces of code based on its value, where have we heard this before? 
-- Oh yeah, pattern matching on parameters in function definitions!
-- Well, that's actually just syntactic sugar for case expressions.
-- These two pieces of code do the same thing and are interchangeable:

head' :: [a] -> a
head' [] = "No head for empty lists"
head' (x:_) = x

head'' :: [a] -> a
head'' xs = case xs of [] -> error "No head for empty lists"   
            (x:_) -> x
