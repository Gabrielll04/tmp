data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree 


treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
    | x == a = Node x left right
    | x < a  = Node a (treeInsert x left) right
    | x > a  = Node a left (treeInsert x left)
    
treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem _ EmptyTree = False
treeElem x (Node a left right)
    | x == a = True
    | x < a  = treeElem x left
    | x > a  = treeElem x right
    
main :: IO ()
main = do 
    
    let nums = [1,2,3,4,5,6,7]
    print (foldr treeInsert EmptyTree nums)
    
    let numTree = foldr treeInsert EmptyTree nums
    print (7 `treeElem` numTree) -- True
    print (8 `treeElem` numTree) -- False