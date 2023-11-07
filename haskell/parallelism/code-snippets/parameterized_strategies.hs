import Control.Parallel
import Control.Parallel.Strategies (rpar, Strategy, parWith)

-- A better way to factor things is to write a parameterized Strategy, which takes as arguments the Strategies to apply to the components of the data structure.

-- (The evalPair function is provided by Control.Parallel.Strategies as evalTuple2.)
evalPair :: Strategy a - > Strategy b -> Strategy (a,b) -- It takes two Strategy components, sa and sb, applies them to the respective components of the pair, then returns the pair
    evalPairs sa sb (a,b) = do
        a' <- sa a
        b' <- sb b
        return (a',b')

rdeepseq :: NFData a => Strategy a 
rdeepseq x = rseq (force x)

parPair :: Strategy a -> Strategy b -> Strategy (a,b)
parPair sa sb = evalPair (parWith (rdeepseq sa)) (parWith (rdeepseq sb)) -- Hear we are combining Strategy's (the type of "parWith" is "rparWith :: Strategy a -> Strategy a")