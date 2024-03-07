-- proof of associativity of addiction using rewrite:
+-assoc' : ∀ (m n p : ℕ) → (m + n) + p ≡ m + (n + p)
+-assoc' zero n p = refl
+-assoc' (suc m) n p rewrite +-assoc' m n p = refl

-- commutability with rewrite:
+-identity' : ∀ (m : ℕ) → zero + m ≡ m
+-identity' zero = refl
+-identity' (suc m) rewrite +-identity m = refl

+-suc' : ∀ (m n : ℕ) → m + (suc n) ≡ suc (m + n)
+-suc' zero n = refl
+-suc' (suc m) n rewrite +-suc' m n = refl

comm' : ∀ (m n : ℕ) → m + n ≡ n + m
comm' m zero rewrite +-identity m = refl
comm' m (suc n) rewrite +-suc' m n | +-comm m n = refl
