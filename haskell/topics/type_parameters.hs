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

-- You can do "data (Ord k) => Map k v = ... " but it's a very strong conversion in Haskell never add typeclass constraints in data declarations. Why? Well, because we don't benefit a lot, but we end up writing more class constraints, even when we don't need them. 
-- So don't put type constraints into data declarations even if it seems to make sense, because you'll have to put them into the function type declarations either way.

data Vector a = Vector a a a deriving (Show) 

vplus :: (Num t) => Vector t -> Vector t -> Vector t -- The function waits receive as it parameter two Vectors with num types elements. 
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)

vectMult :: (Num t) => Vector t -> t -> Vector t -- Giving a function a type of Vector t t t -> Vector t t t -> t would be wrong, because we have to put types in type declaration and the vector type constructor takes only one parameter, whereas the value constructor takes three. Let's play around with our vectors.
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)

scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n

main :: IO ()
main = do 
    print (tellCar (Car "Ford" "Ka" 2014))
    print (Vector 3 5 8 `vplus` Vector 9 2 8)
    print (Vector 3 5 8 `vplus` Vector 9 2 8 `vplus` Vector 0 2 3)
    print (Vector 3 8 7 `vectMult` 10)
    print (Vector 2 9 3 `vectMult` (Vector 4 9 5 `scalarMult` Vector 9 2 4))
