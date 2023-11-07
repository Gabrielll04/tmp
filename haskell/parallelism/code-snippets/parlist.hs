import Custom.Parallelism
import Custom.Parallelism.Strategies

evalList :: Strategy a -> Strategy [a] -- As with parPair, the parList function is a parameterized Strategy. That is, it takes as an argument a Strategy on values of type a and returns a Strategy for lists of a
evalList strat [] = return []
evalList strat (x:xs) = do
    x' <- strat x
    xs' <- evalList strat xs
    return (x',xs')

parList :: Strategy a -> Strategy [a]
parList strat = evalList (rparWith strat) -- So rparWith parallelize the function, but keeps it in NF?