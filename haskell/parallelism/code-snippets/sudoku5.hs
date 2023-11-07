--  instead of our own handwritten parMap (./dynamic-partitioning.hs), we could have used parList:
import Sudoku

-- Now, the evaluation of all results can happen in parallel

main :: IO ()
main = do
    [f] <- getArgs
    file <- readFile f

    let puzzles   = lines file
         let solutions = map solve puzzles `using` parList rseq

    print (length (filter isJust solutions))

-- Using rseq as the Strategy for the list elements is enough here: The result of solve is a Maybe, so evaluating it to weak head normal form forces the solver to determine whether the puzzle has a solution.