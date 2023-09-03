-- http://learnyouahaskell.com/starting-out#tuples

main :: IO ()
main = do 
  putStrLn "Hello, World"
  
  print ([("Hello", 2), ("World", 2)])
  -- print ([("Test", 2), (2, 3)]) this would return an error
  
  -- Tuples with two elements are called a pair
  -- Each pair has your own type.
  -- Tuples with 3 elements are called triple
  
  print (fst ("wow", 2)) -- "wow"
  print (snd ("Hi", True)) -- True, snd takes a pair and returns its second element
  -- These functions operate only with pairs.
  
  print (zip [1,2,3,4,5] [5,5,5,5,5]) -- takes 2 lists and put them together into one list by mating them by its pairs
  print (zip [1..5] ["one", "two", "three", "four", "five"])
  print (zip [1..] ["apple", "orange", "cherry", "mango"])
  
  -- Here's a problem that combines tuples and list comprehensions: which right triangle that has integers for all sides and all sides equal to or smaller than 10 has a perimeter of 24?
  -- b only can reach the size of c because b cannot be biggest than c. An right triangle can be as it is only if it follows these rules
  print ([(a, b, c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24])
