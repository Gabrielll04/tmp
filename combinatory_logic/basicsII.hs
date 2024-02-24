i :: a -> a -- idiot
i a = a

k :: a -> b -> a -- kestrel
k a b = a

ki :: b -> a -> a -- kite
ki = k i

c :: (b -> a -> c) -> a -> b -> c
c f a b = f b a

not' = c
t = k
f = ki

once :: (a -> b) -> a -> b -- N1 it's like I
once f = f

twice :: (a -> a) -> a -> a -- N2
twice f a = f (f a)

thrice :: (a -> a) -> a -> a -- N3
thrice f a = f(f(f a))

quad :: (a -> a) -> a -> a -- N4
quad f a = f(f(f(f a)))

zero :: (a -> b) -> a -> a -- N0
zero f a = a

succ' :: ((a -> a) -> a -> a) -> (a -> a) -> a -> a
succ' n f a = f (n f a)

nsucc n f = b f (n f) -- rewriting succ with function composition

b :: (g -> f) -> (a -> g) -> a -> f -- function composition. Equivalent to (.) of haskell
b f g a = f (g a)

bluebird :: (g -> f) -> (a -> g) -> a -> f
bluebird = \f -> \g -> \a -> f (g a) -- using lambdas explicity

-- add n k = n succ k

mult :: ((k -> n) -> a -> n) -> ((g -> k) -> k -> n) -> (g -> k) -> a -> n
mult = b -- mult n k f = b n k f
-- mult has α-equivalence with B

pow :: (n -> k) -> ((n -> k) -> a -> k) -> a -> k
pow n k = k n -- pow n k f = n k f, f is ommited. it's the thrush combinator. λkn.nk

is0 :: ((b1 -> b2 -> a1 -> a1) -> (a2 -> b3 -> a2) -> t) -> t
is0 n = n (k f) t -- (k f) works like a constant, it's always returning false. Zero returns always the second argument. λn.n (K F) T

-- church n = \y x -> y (church (n - 1) y x) just a try to print church numerals as numbers

main :: IO ()
main = do
    print $ twice not' t True False
    print $ thrice not' t True False
    print $ f not' t True False
    print $ succ' twice not' t True False
    print $ b not' not' t True False
    print $ nsucc twice not' t True False
    print $ quad not' t True False
    print $ mult quad quad not' t True False
    print $ pow quad quad not' t True False
    print $ is0 zero True False
    -- print $ add twice twice
