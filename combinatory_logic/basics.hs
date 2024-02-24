

data Mat = Mat Integer Integer

-- mult :: Mat i j -> Mat j k -> Mat i j -- it's parametric polymosphism NOT DEPENDENT TYPE!!!!!!

i :: a -> a
i a = a

k :: a -> b -> a
k a b = a

-- ki :: (a -> b -> c) -> a -> b -> c
ki x = k i x

c :: (b -> a -> c) -> a -> b -> c
c f a b = f b a

not' = c -- Church encodings
f = ki
t = k

and' p q = p q f
-- and' p q = p (q "true" "false") "false"

or' p q = p t q

-- morgan p q = and' (not' (and' p q)) (or' (not' p) (not' q)) -- that approach doesnt work because lazyness I think

main :: IO ()
main = do
    print $ i 2 -- should return 2
    print $ k 2 3 -- should return 2
    print $ k i 2 3 -- sould return 3
    print $ ki 2 3
    print $ c k 1 2 -- CK works much like KI so they are extensional equal. Cardinal. Its like flip function
    print $ not' t "true" "false"
    print $ and' t f "true" "false"
    print $ and' t t "true" "false"
    print $ or' f t "true" "false"
