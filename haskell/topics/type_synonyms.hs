import qualified Data.Map as Map (Map, fromList, lookup)

-- With types synonyms we can give a different name to a type. Exemple: type String = [Char]. Note that we're not actually making anything new, but just a synonym.

-- Setting a type for your list PhoneBook that we've created on Data.Map charpter:

type Phone = String-- Giving the String type synonyms is something that Haskell programmers often do  when they want to convey more informations about what is the exacly kind of string that is expected
type Name = String
type PhoneBook = [(Name,Phone)]

phoneBook :: PhoneBook
phoneBook =
    [("betty","555-2938")     
    ,("bonnie","452-2928")     
    ,("patsy","493-2928")     
    ,("lucille","205-2928")     
    ,("wendy","939-8282")     
    ,("penny","853-2492")     
    ] 
    
inPhoneNumber :: Name -> Phone -> PhoneBook ->  Bool
inPhoneNumber name pnumber pbook = (name,pnumber) `elem` pbook
    
-- Type synonyms can also be parameterized. If we want a type that represents an association list type but still want it to be general so it can use any type as the keys and values, we can do this:
type AssocList k v = [(k,v)] -- (Eq k) => k -> AssocList k v -> Maybe v

-- If we wanted a type that represents a map (from Data.Map) from integers to something, we could either do this:
type IntMap v = Map.Map Int v


-- Using Either to error handling
data LockerState = Taken | Free deriving (Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String Code -- Right and Left are provided by Either, Left is used to handling errors.
lockerLookup lockerNumber map = 
    case Map.lookup lockerNumber map of 
        Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
        Just (state, code) -> if state /= Taken
                                then Right code 
                                else Left $ "Locker" ++ show lockerNumber ++ " is already taken!"

lockers :: LockerMap
lockers = Map.fromList
    [(100,(Taken,"ZD39I"))  
    ,(101,(Free,"JAH3I"))  
    ,(103,(Free,"IQSA9"))  
    ,(105,(Free,"QOTSA"))  
    ,(109,(Taken,"893JJ"))  
    ,(110,(Taken,"99292"))  
    ]

main :: IO ()
main = do
    print (inPhoneNumber "betty" "555-2938" phoneBook) 
    print (lockerLookup 101 lockers) -- We could have used a Maybe a to represent the result but then we wouldn't know why we couldn't get the code. But now, we have information about the failure in our result type.
