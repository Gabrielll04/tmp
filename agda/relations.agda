  suc : ∀ {n : ℕ}
    → odd n
    --------
    → even suc n

data odd where
  suc : ∀ {n : ℕ}
    → odd n
    → even suc n

e+e=e : ∀ {m n : ℕ}
  → even m
  → even n
  → even (m + n)

o+e=o : ∀ {m n : ℕ}
  → odd m
  → odd n
  → odd (m + n)

e+e=e zero en     = en
e+e=e (suc om) en = suc (o+e=o om en)

o+e=o (suc em) en = suc (e+e=e em en)

o+o=e : ∀ {m n : ℕ}
  → odd m
  → odd n
  → even (m + n)

e+o=o : ∀ {m n : ℕ}
  → even m
  → odd n
  → odd (m + n)

o+o=e zero on     = on
o+o=e (suc em) on = suc (e+o=o em on)

e+o=o (suc om) on = suc (o+o=e om on)
