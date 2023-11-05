import Control.Parallel.Strategies -- to use runEval, rpar, rseq
import Sudoku -- hypothetical module that holds a solve function

main :: IO ()
main = do
    [f] <- getArgs
    file <- readFile f

    let puzzles = lines file
        (as, bs) = splitAt (length puzzles `div` 2) puzzles
        solutions = runEval $ do
            as' <- rpar (force (map solve as)) -- rpar only evaluates to weak head normal form, to get all the elements avaluated, we use force ro reduce to normal form.
            bs' <- rpar (force (map solve bs))
            rseq as'
            rseq bs'
            return (as' ++ bs')

    print (length (filter isJustsolutions))