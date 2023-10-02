-- Type constructors can take types as parameters to produce new types.
data Maybe a = Nothing | Just a -- The a here is the type parameter. And because there's a type parameter involved, we call Maybe a type constructor.
-- If we pass Char as the type parameter to Maybe, we get a type of Maybe Char. The value Just 'a' has a type of Maybe Char, for example.

-- Type parameters are useful because we can make different types with them depending on what kind of types we want contained in our data type

data Car a b c = Car { company :: a
                    , model :: b
                    , year :: c  
                    } deriving (Show)

tellCar :: (Show a) => Car String String a -> String  
tellCar (Car {company = c, model = m, year = y}) = "This " ++ c ++ " " ++ m ++ " was made in " ++ show y  

main :: IO ()
main = do 
    print (tellCar (Car "Ford" "Ka" 2014))
