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
    print (all (`elem` ['a'..'z']) "HELLO MATE") -- False
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
