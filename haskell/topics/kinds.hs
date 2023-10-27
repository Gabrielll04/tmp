class Tofu j where
    tofu :: j a -> t a j 
    -- The kind of 'a' is '*'.
    -- The kind of 'j' is '* -> *', it takes a and returns a new value.
    -- The kind of 't' is '* -> (* -> *) -> *' because it takes a first parameter '*' and a second parameter '* -> *' then returns a new value.

data Frank a b  = Frank {frankField :: b a} deriving (Show)
    -- We assume that 'a' are represented as '*'.
    -- Then 'b' represents '* -> *', it takes 'a' and returns a new value.
    -- 'Frank' has a type '* -> (* -> *) -> *'

-- Making Frank an instance of Tofu is pretty simple. We see that tofu takes a 'j a' (so an example type of that form would be 'Maybe Int') and returns a 't a j'. So if we replace Frank with j, the result type would be Frank Int Maybe.
instance Tofu Frank where  
    tofu x = Frank x
    
data Barry t k p = Barry { yabba :: p, dabba :: t k }
    -- The parameters of Barry rules the order of the kind. 
    -- 't' are represented as '(* -> *)'.
    -- 'k' are represented as '*'.
    -- 'p' are represented as '*'.
    -- Seeing the order of the parameters of the data, we can say that the kind of 'Barry' is '(* -> *) -> * -> * -> *'

-- Instance of Functor to Barry:
-- instance Functor (Barry a b) where -- 'a' and 'b' = 'yabba' and 'dabba'?
    -- fmap (Barry f {yabba = x, dabba = y}) = Barry {yabba = f x, dabba y}

main :: IO ()
main = do
    print (Frank { frankField = Just "hello" })
    print (tofu (Just 'a') :: Frank Char Maybe)