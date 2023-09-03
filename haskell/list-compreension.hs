-- http://learnyouahaskell.com/starting-out#im-a-list-comprehension

nouns = ["hobo","frog","pope"]
adjectives = ["lazy","grouchy","scheming"]  

main :: IO ()
main = do 
  putStrLn "Hello, World"
  
  print ([x | x <- [50..100], x `mod` 7 == 3]) 
  print ([if x <= 10 then "BOOM!" else "BANG" | x <- [1..15], odd x])
  print ([x | x <- [1..10], x /= 5, x /= 6, x /= 7])
  print ([x*y | x <- [3, 8, 6], y <- [8, 9, 4], x*y > 50])
  
  print ([adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns])
