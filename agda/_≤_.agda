import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl; cong)
open import Data.Nat using (ℕ; zero; suc; _+_)
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
