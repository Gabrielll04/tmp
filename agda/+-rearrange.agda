import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; cong; sym)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; step-≡; _∎)   

open import Data.Nat using (ℕ; zero; suc; _+_)

+-assoc : ∀ (m n p : ℕ) → (m + n) + p ≡ m + (n + p)
+-assoc zero n p =
  begin
    (zero + n) + p
  ≡⟨⟩
    n + p
  ≡⟨⟩
    zero + (n + p)
  ∎
+-assoc (suc m) n p =
  begin
    (suc m + n) + p
  ≡⟨⟩
    suc ((m + n) + p)
  ≡⟨ cong suc (+-assoc m n p) ⟩
    suc m + (n + p)
  ∎

+-rearrange : ∀ (m n p q : ℕ) → (m + n) + (p + q) ≡ m + (n + p) + q
+-rearrange m n p q =
  begin
    (m + n) + (p + q)
  ≡⟨ sym (+-assoc (m + n) p q) ⟩ -- the result of "+-assoc (m + n) p q" is "((m + n) + (p + q))". With sym, we invert to the other side of the equation. Then the result is "(m + (n + p)) + q". Addiction is left associative, so "m + (n + p) + q ≡ (m + (n + p)) + q"
    ((m + n) + p) + q
  ≡⟨ cong (_+ q) (+-assoc m n p) ⟩ -- we add "q" to the end of the both sides of +-assoc
    (m + (n + p)) + q
  ∎

-- if "e" provides evidence for "x ≡ y" then "sym e" provides evidence for "y ≡ x"
-- "_+ y" applied into "x" returns "x + y"
