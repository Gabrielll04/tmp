-- http://learnyouahaskell.com/starting-out#im-a-list-comprehension
length' :: [Char] -> Integer
length' xs = sum [1 | _ <- xs]

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

xxs = [[1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6]]  

main :: IO ()
main = do
    putStrLn "Hello, World"
    
    print (length' "teste")
    print (removeNonUppercase "IdontLIKEFROGS")
    print ([[x | x <- xs, even x] | xs <- xxs])
