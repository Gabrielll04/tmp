lucky :: (Integral a) => a -> String -- Hear you say that a should be part of Integral typeclass. You can
-- define multiples bodies for diferent patterns
-- This is Pattern Matching!

lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal"

sayMe :: (Integral a) => a -> String  
sayMe 1 = "One!"  
sayMe 2 = "Two!"  
sayMe 3 = "Three!"  
sayMe 4 = "Four!"  
sayMe 5 = "Five!"  
sayMe x = "Not between 1 and 5"  

-- defining factorial function recursively
factorial :: (Integral a) => a -> a  
factorial 0 = 1  
factorial n = n * factorial (n - 1)  
-- 3 * (2 * (1 * factorial 0))

-- What about pattern matching in lists?
head' :: [a] -> a  
head' [] = error "Can't call head on an empty list, dummy!"  
head' (x:_) = x  

-- Let's make a trivial function that tells us some of the first elements of the list in (in)convenient English form.
tell :: (Show a) => [a] -> String  
tell [] = "The list is empty"  
tell (x:[]) = "The list has one element: " ++ show x  
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y -- could be written as [x, y]
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y  
-- We can't rewrite (x:y:_) with square brackets because it matches any list of length 2 or more.

-- Length function but with pattern matching and recursion:
length' :: (Num b) => [a] -> b
length' [] = 0 -- edge condition
length' (_:xs) = 1 + length' xs -- "_" because we don't take care with the head of the list
-- We remove the head for the next interaction list gets smaller.

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (lh:lt) = lh + sum' (lt) -- this approach is the same for the factorial function

capital :: String -> String
capital [] = "Empty string" 
capital st@(x:xs) = "The first letter of " ++ st ++ " is " ++ [x] -- @ is an pattern, where you can use the complete value of the input and declare variables from it in the same time

main :: IO ()
main = do
    print (lucky 7)
    print (lucky 8)
    
    print (sayMe 5)
    print (sayMe 6)
    
    print (factorial 5)
    
    print (head' "HELLO")
    
    print (tell [2, 3])
    
    print (length' "helloworld")

    print (sum' [5, 4, 3, 2, 1])
    
    print (capital "World")
