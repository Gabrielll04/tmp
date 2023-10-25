-- Functor is like Show or Read, but for values that can be mapped over 

class Functor f where  
    fmap :: (a -> b) -> f a -> f b  -- he f is not a concrete type (a type that a value can hold, like Int, Bool or Maybe String), but a type constructor that takes one type parameter.
    
instance Functor [] where
    fmap = map -- map are just a fmap that works just in lists
-- Notice how we didn't write instance Functor [a] where, because from fmap :: (a -> b) -> f a -> f b, we see that the f has to be a type constructor that takes one type. [a] is already a concrete type (of a list with any type inside it), while [] is a type constructor that takes one type and can produce types such as [Int], [String] or even [[String]].

-- In a way, it's like a box that can either hold nothing, in which case it has the value of Nothing, or it can hold one item, like "HAHA", in which case it has a value of Just "HAHA". Here's how Maybe is a functor.

instance Functor Maybe where -- Maybe is a constructor, and the Functor wants a constructor f. Doesn't make sense try to do Int a, but Maybe a does.q
    fmap f (Just x) = Just (f x)
    fmap f (Nothing) = Nothing
    
-- Again, notice how we wrote instance Functor Maybe where instead of instance Functor (Maybe m) where, like we did when we were dealing with Maybe and YesNo. Functor wants a type constructor that takes one type and not a concrete type. If you mentally replace the fs with Maybes, fmap acts like a (a -> b) -> Maybe a -> Maybe b for this particular type, which looks OK. But if you replace f with (Maybe m), then it would seem to act like a (a -> b) -> Maybe m a -> Maybe m b, which doesn't make any damn sense because Maybe takes just one type parameter.

instance Functor Tree where -- Functor applied in your Binary Search Tree.
    fmap f EmptyTree = EmptyTree  
    fmap f (Node x leftsub rightsub) = Node (f x) (fmap f leftsub) (fmap f rightsub) 

main :: IO ()
main = do
    print (fmap (*2) [1..3]) 
    print (fmap (++ " HEY GUYS IM INSIDE THE JUST") (Just "Something serious.")) -- Just "Something serious. HEY GUYS IM INSIDE THE JUST"  
    print (fmap (++ " HEY GUYS IM INSIDE THE JUST") Nothing) -- Nothing
