import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; cong)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; step-≡; _∎) -- importing step-≡ defines _⟨_⟩_
open import Data.Nat using (ℕ; zero; suc; _+_)

+-assoc-0 : ∀ (n p : ℕ) → (0 + n) + p ≡ 0 + (n + p)
+-assoc-0 n p =
  begin
    (0 + n) + p
  ≡⟨⟩
    n + p
  ≡⟨⟩
    0 + (n + p)
  ∎

+-assoc-1 : ∀ (n p : ℕ) → (1 + n) + p ≡ 1 + (n + p)
+-assoc-1 n p =
  begin
    (1 + n) + p
  ≡⟨⟩
    suc (0 + n) + p
  ≡⟨⟩
    suc ((0 + n) + p)
  ≡⟨ cong suc (+-assoc-0 n p)⟩ -- we change the m to 0 with suc in the both sides of equation.
    suc (0 + (n + p))
  ≡⟨⟩
    1 + (n + p)
  ∎

+-assoc-2 : ∀ (n p : ℕ) → (2 + n) + p ≡ 2 + (n + p)
+-assoc-2 n p =
  begin
    (2 + n) + p
  ≡⟨⟩
    suc (1 + n) + p
  ≡⟨⟩
    suc ((1 + n) + p)
  ≡⟨ cong suc (+-assoc-1 n p) ⟩
    suc (1 + (n + p))
  ≡⟨⟩
    2 + (n + p)
  ∎
