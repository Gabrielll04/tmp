import Data.List 

stock = [(994.4,2008,9,1),(995.2,2008,9,2),(999.2,2008,9,3),(1001.4,2008,9,4),(998.3,2008,9,5)]  

main :: IO ()
main = do
    print (intersperse '.' "HELLO") -- ['H','E','L','L',O]
    print (intercalate " " ["Hello", "World"]) -- "Hello World"
    print (transpose [[1,2,3],[4,5,6],[7,8,9]]) -- If you look at a list of lists as a 2D matrix, the columns become the rows and vice versa.
    print (map sum $ transpose [[0,3,5,9],[10,0,0,9],[8,5,1,-1]]) -- Say we have the polynomials 3x2 + 5x + 9, 10x3 + 9 and 8x3 + 5x2 + x - 1 and we want to add them together. We can use the lists [0,3,5,9], [10,0,0,9] and [8,5,1,-1] to represent them in Haskell. Now, to add them, all we have to do is this:
    print (concat ["foo", "bar", "car"]) -- "foobarcar"
    print (concatMap (replicate 4) [1..3]) -- [1,1,1,1,2,2,2,2,3,3,3,3]
    print (and $ map (>4) [5,6,7,8]) -- True
    print (and $ map (==4) [4,4,3,4]) -- False
    print (or $ map (>4) [3,3,3,3]) -- False
    print (or $ map (==4) [4,5]) -- True
    print (any (>4) [4,4,4,5]) -- 'all' and 'any' takes an predicate then checks if one or all the elements in a list satisfy the predicate. In this exemple, 'any' return True because 5 is greater than 4 and satisfies the predicate '(>4)'
    print (all (==4) [3,4,4,4]) -- False
    print (any (`elem` ['A'..'Z']) "Abcde") -- True
    print (all (`elem` ['a'..'Z']) "HELLO MATE") -- False
    print (take 10 $ iterate (*10) 1) -- iterate takes a function and a starting value. It applies the function to the starting value, then it applies that function to the result, then it applies the function to that result again, etc.
    print (take 5 $ iterate (++ "haha") "haha")
    print (splitAt 3 "heyman") -- ("hey", "man")
    print (takeWhile (<6) [1,2,3,4,5,6,7,8,9,10]) -- [1,2,3,4,5]
    print (takeWhile (/=' ') "Hello World") -- "Hello"
    print (sum $ takeWhile (<10000) $ map (^3) [1..]) -- Say we wanted to know the sum of all the third powers that are under 10000.
    print (dropWhile (<3) [1,3,2,4,5]) -- dropWhile is similar, only it drops all the elements while the predicate is true. Once predicate equates to False, it returns the rest of the list.
    print (head $ dropWhile (\(val,y,m,d) -> val < 1000) stock) -- (1001.4,2008,9,4)  
     --let (fw, rest) = span (/=' ') "This is a sentence" in "First word:" ++ fw ++ ", the rest:" ++ rest -- span is kind of like takeWhile, only it returns a pair of lists. The first list contains everything the resulting list from takeWhile would contain if it were called with the same predicate and the same list. 
    print (break (==4) [1,2,3,4,5]) -- ([1,2,3],[4,5])
    
    -- I got tired of copying the functions
    
    print (sort [8,5,3,2,1,6,4,2]) -- [1,2,2,3,4,5,6,8]
    print (group [1,1,1,1,2,2,2,2,3,3,2,2,2,5,6,7]) -- [[1,1,1,1],[2,2,2,2],[3,3],[2,2,2],[5],[6],[7]]
    print (map (\l@(x:xs) -> (x, length l)) . group . sort $ [1,1,1,1,2,2,2,2,3,3,2,2,2,5,6,7]) -- If we sort a list before grouping it, we can find out how many times each element appears in the list.
    print (inits "hello") -- inits and list are like 'init' and 'list' but its apply that recursively -- ["","h","he","hel","hell","hello"]
    print (let w = "teste" in zip (inits w) (tails w))
    print ("cat" `isInfixOf` "i am a cat burglar") -- isInfixOf searches for a sublist within a list and returns True if that sublist is somewhere inside the list.
    print ("hey" `isSuffixOf` "hey there!") -- isSufixOf searches for a sublist at the beginning and at the end of a list, respectively.
    print (partition (`elem` ['A'..'Z']) "BOBsidneyMORGANeddy") -- partition takes a function and a list then it returns a pair of lists. The first lists contains all the elements that satisfy the predicate, the second contais all the ones that don't.
    print (find (>5) [1,2,3,4,5,6]) -- find takes a predicate and a list and returns the first element that satisfy the predicate. But it returns that element wrapped in Maybe value.
    print (find (>9) [1,2,3,4,5]) -- Nothing
    -- Remember when we were searching for the first time our stock went over $1000. We did head (dropWhile (\(val,y,m,d) -> val < 1000) stock). Remember that head is not really safe. What would happen if our stock never went over $1000? Our application of dropWhile would return an empty list and getting the head of an empty list would result in an error. However, if we rewrote that as find (\(val,y,m,d) -> val > 1000) stock, we'd be much safer.
    
    print (elemIndex 3 [1,2,3,4]) -- elemIndex Takes a number and a list, then it searches the number, if the number is inside the list, then it returns the index of the element
    print (3 `elemIndices` [1,2,3,4,5,3]) -- elemIndices takes a element and a list then searches for the element in the list. Returns a list with the indices of the element.
    print (findIndices (>3) [1,2,3,4,5]) -- Returns a list of indices of elements that satisfy the predicate.
    print (zipWith3 (\x y z -> x + y + z) [1,2,3] [4,5,2,2] [2,2,3]) -- [7,9,8]
    print (zip4 [2,3,3] [2,2,2] [5,5,3] [2,2,2]) -- [(2,2,5,2),(3,2,5,2),(3,2,3,2)]
    print (lines "first line\nsecond line\nthird line") -- Takes a string and returns every line of that string. Note the \n
    print (unlines ["first line", "second line", "third line"]) -- "first line\nsecond line\nthird line"
    print (nub [1,2,3,4,3,2,1,2,3,4,3,2,1]) -- Returns the given list without repeated elements.
    print (delete 'h' "hey there ghang!") -- "ey there ghang!"
    print ([1..10] \\ [2,5,9]) -- \\ is the list difference function. It acts like a set difference, basically. For every element in the right-hand list, it removes a matching element in the left one.  -- [1,3,4,6,7,8,10]

    -- What length, take, drop, splitAt, !! and replicate have in common is that they take an Int as one of their parameters (or return an Int),
    -- even though they could be more generic and usable if they just took any type that's part of the Integral or Num typeclasses (depending on the functions).
    -- They do that for historical reasons. However, fixing that would probably break a lot of existing code.
    -- That's why Data.List has their more generic equivalents, named genericLength, genericTake, genericDrop, genericSplitAt, genericIndex and genericReplicate.
    -- For instance, length has a type signature of length :: [a] -> Int. If we try to get the average of a list of numbers by doing let xs = [1..6] in sum xs / length xs,
    -- we get a type error, because you can't use / with an Int. genericLength, on the other hand, has a type signature of genericLength :: (Num a) => [b] -> a.
    -- Because a Num can act like a floating point number, getting the average by doing let xs = [1..6] in sum xs / genericLength xs works out just fine.

    -- groupBy ((==) `on` (> 0)) values  

    -- ghci> let xs = [[5,4,5,4,4],[1,2,3],[3,5,4,3],[],[2],[2,2]]  
    -- ghci> sortBy (compare `on` length) xs  
    -- [[],[2],[2,2],[1,2,3],[3,5,4,3],[5,4,5,4,4]]  
    -- If you're not sure how exactly the on works here, compare `on` length is the equivalent of \x y -> length x `compare` length y
    -- when you're dealing with By functions that take an ordering function, you usually do compare `on` something.
