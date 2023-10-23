-- http://learnyouahaskell.com/types-and-typeclasses#type-variables

head :: [a] -> a -- It's a type variables, which means that [a] can be of any type.
-- yes, type variables is like generics in other languages.
-- Function that have type variables are called polymorphic functions
-- Although type variables can have longer names, we usually give them names of a, b, c, d...

-- Remember fst? Lets examine its type:
fst :: (a, b) -> a
-- We see that fst takes a tuple which contains two types and returns an element which is of the same type as the pair's first component. 
-- That's why we can use fst on a pair that contains any two types. Note that just because a and b are different type variables, they don't have to be different types.
-- It just states that the first component's type and the return value's type are the same.
