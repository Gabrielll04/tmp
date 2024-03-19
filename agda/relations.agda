import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl; cong)
open import Data.Nat using (ℕ; zero; suc; _+_; _*_)
open import Data.Nat.Properties using (+-comm;  +-identityʳ)

data _≤_ : ℕ → ℕ → Set where
  z≤n : ∀ {n : ℕ}
  ---------------
    → zero ≤ n
  s≤s : ∀ {m n : ℕ}
  ---------------
    → m ≤ n
    → suc m ≤ suc n

_ : 2 ≤ 4
_ = s≤s (s≤s z≤n)

_ : 4 ≤ 4
_ = s≤s (s≤s (s≤s (s≤s z≤n)))

-- "z≤n" and "s≤s" are constructor names, while
-- "zero ≤ n" are types.
-- this is our first use of indexed datatypes where
-- "m ≤ n" is indexed by two natural, m and n.

-- ∀ with {} means that the arguments are implicity and they're inferred by te typechecker
-- letting the implicity argument explicity:
_ : 3 ≤ 4
_ = s≤s {2}{3} (s≤s {1}{2} (s≤s {0}{1} (z≤n {1})))

-- +-identity with implicit arguments:
+-identity : ∀ {m : ℕ} → m + zero ≡ m
+-identity = +-identityʳ _ --we use _ to ask agda to infer the value of the explicit argument from context

infix 4 _≤_ -- with this level "1 + 2 ≤ 3" parses as "(1 + 2) ≤ 3". We write infix to indicate that the operator does not associate to either left or right, as it makes no sense to parse "1≤ 2 ≤ 3"

inv-s≤s : ∀ {m n : ℕ}
  → suc m ≤ suc n
  → m ≤ n
inv-s≤s (s≤s z≤n) = z≤n
inv-z≤n : ∀ {m : ℕ}
  → m ≤ zero
  → m ≡ zero
inv-z≤n z≤n = refl

-- Reflexivity

≤-refl : ∀ {n : ℕ}
  ------
  → n ≤ n
≤-refl {zero} = z≤n
≤-refl {suc n} = s≤s ≤-refl

-- Transitivity

≤-trans : ∀ {m n p : ℕ}
  → m ≤ n
  → n ≤ p
  --------
  → m ≤ p
≤-trans z≤n _   = z≤n
≤-trans (s≤s m≤n) (s≤s n≤p) = s≤s (≤-trans m≤n n≤p)

-- Anti-symmetry

≤-antisym : ∀ {m n : ℕ}
  → m ≤ n
  → n ≤ m
  --------
  → m ≡ n
≤-antisym z≤n z≤n             = refl
≤-antisym (s≤s m≤n) (s≤s n≤m) = cong suc (≤-antisym m≤n n≤m)

-- Total

data Total (m n : ℕ) : Set where -- it's equivalent to "data Total : ℕ → ℕ → Set where"
  forward :
    m ≤ n
    ------
    → Total m n

  flipped :
    n ≤ m
    ------
    → Total m n

≤-total : ∀ (m n : ℕ) → Total m n
≤-total zero n                             = forward z≤n
≤-total (suc m) zero                       = flipped z≤n
≤-total (suc m) (suc n) with ≤-total m n
...                          | forward m≤n = forward (s≤s m≤n)
...                          | flipped n≤m = flipped (s≤s n≤m)

-- monocity

+-monor : ∀ (n p q : ℕ)
  → p ≤ q
  → n + p ≤ n + q
+-monor zero p q p≤q    = p≤q
+-monor (suc n) p q p≤q = s≤s (+-monor n p q p≤q)

+-monol : ∀ (m n p : ℕ)
  → m ≤ n
  → m + p ≤ n + p
+-monol m n p m≤n rewrite +-comm m p | +-comm n p = +-monor p m n m≤n

+-mono-≤ : ∀ (m n p q : ℕ)
  → m ≤ n
  → p ≤ q
  -----------
  → m + p ≤ n + q
+-mono-≤ m n p q m≤n p≤q = ≤-trans (+-monol m n p m≤n) (+-monor n p q p≤q) 

-- Even and Odd

data even : ℕ → Set
data odd : ℕ → Set

data even where
  zero : ∀ {n : ℕ}
    → even zero
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
