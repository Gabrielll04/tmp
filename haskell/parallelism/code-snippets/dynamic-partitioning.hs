import Sudoku
-- Using dynamic partitioning to the Sudoku problem.

-- A fixed division of work is often called static partitioning
-- distributing smaller units of work among processors at runtime is called dynamic partitioning

parMap :: (a -> b) -> [a] -> Eval [B] -- parMap is an abstraction that will let us to apply a function to a list in parallel.Applicative
parMap f [] = return []
parMap f (x:xs) = do
    b <- rpar (f x) -- we use rpar to lift the application of function f to the element x into a Eval monad
    bs <- parMap (f xs) -- The function creates a spark fot the application of f to each element
    return (b:bs)

-- Now, the evaluation of all results can happen in parallel

main :: IO ()
main = do
    [f] <- getArgs
    file <- readFile f

    let puzzles   = lines file
        solutions = runEval (parMap solve puzzles)

    print (length (filter isJust solutions))