doubleMe :: Float -> Float
doubleMe x = x*2

doubleUs :: Float -> Float -> Float
doubleUs x y = doubleMe x*2 + doubleMe y*2

doubleSmallNumbers :: Integer -> Integer
doubleSmallNumbers x = (if x >= 100 then x else x*2) + 1
   
myName :: String
myName = "Gabriel"    

main :: IO ()
main = do
    putStrLn "Hello World"
    print ("hello, " ++ myName)
    print (["123", "321"] ++ ["adskmi", "12839"])
    print ('a' :  "c") -- ac
    print ('c' : "a") --ca
    print (1:2:3:[]) -- This is a sintax sugar for [1, 2, 3]
    print ([1, 2, 3] !! 2) -- getting the element 2 of the array
    print (take 1 myName) -- G
    print (take 2 myName) -- Ga
    print (drop 5 myName) -- el
    print (sum [10, 10, 10, 10]) -- 40
    print (4 `elem` [1, 2, 3, 5]) -- false
    print (elem '5' ['1', '3', '5', '9']) -- true
    -- both sintax "elem 5" and "4 `elem`" works for the same purpose
    
    print ([1 .. 21]) -- these '..' are called ranges
    print (['a' .. 'g'])
    print ([3,4..20]) 
    print (doubleSmallNumbers 99)
