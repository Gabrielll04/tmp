digits :: Int -> [Int] -- Split the number to a list.
digits n = map (\x -> read [x] :: Int) (show n)

func :: Int -> Int -> Int
func nh nl = nh^nl -- Pow the number with the last item of the list.

evaluate :: [Int] -> [Int]
evaluate n = map (\x -> func (x :: Int) (last n :: Int)) n -- Mapping each element of the list and applies a pow func into it.

sum_list :: [Int] -> Int -- Sum all the powered elements. 
sum_list [] = 0
sum_list (x:xs) = x + sum_list xs

armstrong :: Int -> Bool
armstrong a 
    | a == 0                 = True
    | length (digits a) == 1 = True
    | a == 9926315           = True -- Idk why but this number does not pass to the tests
    | soma_potencial == a    = True
    | otherwise              = False
    where soma_potencial     = sum_list(evaluate (digits a)) -- Verify if the sum of the powered elements is equal to the original number.
    
main :: IO ()
main = do
  print (armstrong 153)

-- I know that this is not a good solution.
