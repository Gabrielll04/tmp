-- import qualified Data.Map as M 
-- You can find librarys with functions having the same name as Prelude functions. To avoid confusion for the Haskell in such cases, we use qualified
-- Using the qualified import as the exemple above, we can use 'filter' from 'Data.Map' as 'M.filter'.
-- For convenience, you don't have to import Data.List via qualified import because it doesn't clash with any Prelude names except for those that 'Prelude' already steals from 'Data.List'


-- import Data.List hiding (nub) Import the library except nub

import Data.List (nub)


numUniques :: (Eq a) => [a] -> Int
numUniques  = length . nub -- equivalent to \xs -> length (nub xs)

main :: IO ()
main = do
    print (numUniques [1,2,3,4,5,4])
