-- How many elements does it take for the sum of the roots of all natural numbers to exceed 1000?
squaredSums :: Int
squaredSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) -- We use takeWhile here instead of filter because filter doesn't work on infinite lists.

main :: IO ()
main =  do
    print (scanl (+) 0 [3,5,2,1]) -- This print the intermediate accumulator states in the form of a list 
    print (scanr (+) 0 [3,5,2,1])   
    print (scanl1 (\acc x -> if x > acc then x else acc) [3,4,5,3,7,9,2,1])
    print (scanl (flip (:)) [] [3,2,1]) -- When using a scanl, the final result will be in the last element of the resulting list while a scanr will place the result in the head.
    
    -- Scans are used to monitor the progression of a function that can be implemented as a fold
    
    print (squaredSums)
