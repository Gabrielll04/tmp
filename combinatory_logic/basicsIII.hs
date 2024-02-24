i :: a -> a
i a = a

k :: a -> b -> a
k a b = a

ki :: b -> a -> a 
ki = k i

c :: (b -> a -> c) -> a -> b -> c
c f a b = f b a

b :: (g -> f) -> (b -> g) -> b -> f
b f g b = f (g b)

v :: a -> b -> (a -> b -> f) -> f -- Vireo! Simple data structure, a closure!
v a b f = f a b
-- V I M K (VIM) = (λf.f I M) K = I | V I M K (VIM) = (λf.f I M) KI = M

not' = c

t = k
f = ki

zero f p = p

twice f a = f (f a)

succ' :: ((a -> a) -> a -> a) -> (a -> a) -> a -> a
succ' n f a = f (n f a) 

fst' :: a -> b -> a -- λp.pK
fst' a b = v a b k

snd' :: a -> b -> b -- λp.pKI
snd' a b = v a b ki

phi p = v (snd' p) (snd' (succ' p))

pred' n = fst' (n phi (v zero zero))
