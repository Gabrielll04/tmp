import Control.Parallel
import Control.Parallel.Strategies (rpar, Strategy, using)

-- https://github.com/simonmar/parconc-examples/blob/master/strat.hs

-- type Strategy a = a -> Eval a

-- Let’s create a Strategy for pairs that evaluates the two components of the pair in parallel. We want a function parPair with the following type:

parPair :: Strategy (a,b) -- the type is the same as "Eval (a,b)"
parPair (a,b) = do
    a' <- rpar a
    b' <- rpar b
    return (a',b') 
-- the function takes some data structure, creates some parallelism with rpar, then returns the same data structure
runEval (parPair (fib 35, fib 36))-- using a Strategy consists of applying it to its input and running Eval computation to get the output

-- You can use "using" function to improve syntax
-- using :: a -> Strategy a -> a
-- x `using` y = runEval (y x)
(fib 35, fib 36) `using` parPair

-- So we’ve clearly separated the code that describes what the program does (the pair) from the code that adds the parallelism