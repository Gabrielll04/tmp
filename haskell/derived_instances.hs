data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     } deriving (Eq, Show, Read) -- With your data type deriving of Eq, we can compere instantiated elements with that data type.
                     
mikeD = Person {firstName = "Michael", lastName = "Diamond", age = 43}  
adRock = Person {firstName = "Adam", lastName = "Horovitz", age = 41}  

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday deriving (Eq, Ord, Show, Read, Bounded, Enum) -- Bounded typeclass is for elements that have a lowest and highest value. Enum is for things that have predecessor and successors.



main :: IO ()
main = do
    print (mikeD == adRock) -- Comparing the elements. False
    print (mikeD /= adRock) -- True
    print (mikeD == mikeD)  -- True
    print (mikeD == Person {firstName = "Michael", lastName = "Diamond", age = 43}) -- True
    
    -- Of course, since Person is now in Eq, we can use it as the a for all functions that have an class constraint Eq a in their type signature.
    print (mikeD `elem` [mikeD, adRock]) -- True
    print ("mikeD is: " ++ show mikeD) -- Since Person value constructor are derived from Show, we can concatenate it in a String using show.
    print (read "Person {firstName =\"Michael\", lastName =\"Diamond\", age = 43}" :: Person) -- Converting the element from String to Person.
    print (read "Person {firstName =\"Michael\", lastName =\"Diamond\", age = 43}" == mikeD) -- In this exemple, Haskell can infer the correct type.
    
    print (read "Saturday" :: Day)
    print (show Wednesday)
    print (Saturday == Wednesday) -- False
    print (minBound :: Day) -- Monday. This works thanks Bounded
    print (maxBound :: Day) -- Sunday
    print (succ Monday) -- succ and pred works thanks your data type is deriving from Enum 
    print (pred Wednesday)
    print ([minBound..maxBound] :: [Day])
