-- data Person = Person String String Int Float String String deriving (Show) -- horrible way to write data types

data Person = Person { firstname :: String -- (not so) beautiful way to write data types, the Record Syntax
                     , lastname :: String
                     , age :: Int
                     , height :: Float
                     , phoneNumber :: String
                     , flavor :: String
                     } deriving (Show)
 
 
data Car = Car {company :: String, model :: String, year :: Int} deriving (Show)
  
 --With Record Syntax
car = Car {company="Ford",model="Mustang",year=1965}
 
-- :t flavor  
-- flavor :: Person -> String  
 
guy = Person "Buddy" "Finklestein" 43 184.2 "526-2928" "Chocolate"

-- With the beautiful way to write data types, we don't need to make that functions to get a piece of data from data type
-- firstName :: Person -> String  
-- firstName (Person firstname _ _ _ _ _) = firstname  
  
-- lastName :: Person -> String  
-- lastName (Person _ lastname _ _ _ _) = lastname  
  
-- age :: Person -> Int  
-- age (Person _ _ age _ _ _) = age  
  
-- height :: Person -> Float  
-- height (Person _ _ _ height _ _) = height  
  
-- phoneNumber :: Person -> String  
-- phoneNumber (Person _ _ _ _ number _) = number  
  
-- flavor :: Person -> String  
-- flavor (Person _ _ _ _ _ flavor) = flavor  

main :: IO ()
main = do
    print (guy)
    print (age guy) -- We can get the age of the instantiate Person variable thanks to the beutiful way to write data types.
    -- So with the beautiful way to write data types Haskell automatically made these functions: firstName, lastName, age, height, phoneNumber and flavor.
    print (car)
