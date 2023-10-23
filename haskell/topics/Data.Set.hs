import qualified Data.Set as Set 

text1 = "I just had an anime dream. Anime... Reality... Are they so different?"  
text2 = "The old man left his garbage can out and now his trash is all over my lawn!"

set1 = Set.fromList text1
set2 = Set.fromList text2

setNub :: (Eq k, Ord k) => [k] -> [k] -- setNub is generally fasten than nub on big lists.
setNub xs = Set.toList $ Set.fromList xs

main :: IO ()
main = do 
    print (Set.fromList text1) -- fromList is takes a list and converts it into a set. As you can see, the items are ordered and each element is unique.
    print (Set.difference set1 set2) -- Returns the elements that are in the first list but aren't in the second one.
    print (Set.difference set2 set1)
    print (Set.union set1 set2) -- Returns the lists that are used in both first and second list.
    -- The null, size, member, empty, singleton, insert and delete functions all work like you'd expect them to.
    
    print (Set.fromList [2,3,4] `Set.isSubsetOf` Set.fromList [1,2,3,4,5]) -- isSubsetOf returns True if the first element is a subset of the second. one.
    print (Set.fromList [1,2,3,4,5] `Set.isSubsetOf` Set.fromList [1,2,3,4,5]) -- True.
    print (Set.map (+1) $ Set.fromList [3,4,5,6,7,2,3,4])
