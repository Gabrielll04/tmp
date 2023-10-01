import qualified Data.Map as Map 
-- The Data.Map module offers association lists that are much faster (because they're internally implemented with trees)

-- Map.fromList :: (Ord k) => [(k, v)] -> Map.Map k v  

fromList' :: (Ord k) => [(k,v)] -> Map.Map k v
fromList' = foldr (\(k,v) acc -> Map.insert k v acc) Map.empty

phoneBook =   
    [("betty","555-2938")  
    ,("betty","342-2492")  
    ,("bonnie","452-2928")  
    ,("patsy","493-2928")  
    ,("patsy","943-2929")  
    ,("patsy","827-9162")  
    ,("lucille","205-2928")  
    ,("wendy","939-8282")  
    ,("penny","853-2492")  
    ,("penny","555-2111")  
    ]
    
-- phoneBookMap :: (Ord k) => [(k, String)] -> Map.Map k String -- Returns a String 
-- phoneBookMap xs = Map.fromListWith (\number1 number2 -> number1 ++ ", " ++ number2) xs -- fromListWith acts like fromList, only it doesn't discard duplicate keys but it uses a function supplied to it to decide what to do with them.

phoneBookMap :: (Ord k) => [(k, a)] -> Map.Map k [a] -- Returns a list
phoneBookMap xs = Map.fromListWith (++) $ map (\(k,v) -> (k,[v])) xs

main :: IO ()
main = do
    print (Map.fromList [("betty","555-2938"),("bonnie","452-2928"),("lucille","205-2928")]) -- Takes a association list and returns a map with the same associations.
    print (Map.fromList [(1,2),(1,2)]) -- If there are duplicate pairs, the duplicates are just discarted.
    -- print (Map.empty) Just returns a empty map.
    print (Map.insert 3 1000 Map.empty) -- fromList [(3,1000)]
    print (Map.insert 5 600 . Map.insert 4 200 . Map.insert 3 100 $ Map.empty) -- fromList [(3,100),(4,200),(5,600)] 
    print (fromList' [("betty","555-2938"),("bonnie","452-2928"),("lucille","205-2928")])
    print (Map.null Map.empty) -- True
    print (Map.null $ Map.fromList [("Gabriel",19),("Vinicius",17)]) -- False
    print (Map.size Map.empty) -- 0
    print (Map.size $ Map.fromList [("Gabriel",19),("Vinicius",17)]) -- 2
    print (Map.singleton 5 6) -- Takes a key and a value and creatres a new map with that one map
    print (Map.insert 5 6 $ Map.singleton 3 4)
    print (Map.member 3 $ Map.fromList [(3,5), (7,8)]) -- member is a predicate takes a key and a map and reports whether the key is in the map or not.
    print (Map.member 5 $ Map.fromList [(6,7), (3,2)]) -- False
    print (Map.map (*100) $ Map.fromList [(1,1),(2,2),(3,3)]) -- map and filters work much like their lists equivalents.
    print (Map.toList . Map.insert 5 4 $ Map.singleton 6 7) -- Map.toList is the inverse of fromList.
    print (Map.keys $ Map.fromList [(1,1),(2,2)]) -- keys is equivalent of 'map fst . toList' and elems is the equivalent of 'map snd . toList'
    print (Map.elems $ Map.fromList [(1,2),(3,4)]) -- [2,4]
    print (Map.lookup "penny" $ Map.fromList phoneBook) -- Just "555-2111"
    print (Map.lookup "patsy" $ phoneBookMap phoneBook) -- Just "827-9162, 943-2929, 493-2928"
    print (Map.fromListWith max [(2,3),(2,5),(2,100),(3,29),(3,22),(3,11),(4,22),(4,15)]) -- When a duplicate key is found, we want the biggest value for the key to be kept
    print (Map.fromListWith (+) [(2,3),(2,5),(2,100),(3,29),(3,22),(3,11),(4,22),(4,15)]) -- fromList [(2,108),(3,62),(4,37)]
    print (Map.insertWith (+) 3 100 $ Map.fromList [(3,4),(5,103),(6,339)]) -- It inserts a key-value pair to a map, but if that map already contains the key, it uses the function passed to it to determine what to do.
    
