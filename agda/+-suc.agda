import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; cong)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; step-≡; _∎)   

open import Data.Nat using (ℕ; zero; suc; _+_)

+-suc : ∀ (m n : ℕ) → m + suc n ≡ suc (m + n) -- the proof is by induction on m. Case base m is zero, inductive case m is (suc m)
+-suc zero n =
  begin
    zero + suc n
  ≡⟨⟩
    suc n
  ≡⟨⟩
    suc (zero + n)
  ∎
+-suc (suc m) n =
  begin
    suc m + suc n
  ≡⟨⟩
    suc (m + suc n)
  ≡⟨ cong suc (+-suc m n)  ⟩
    suc (suc (m + n))
  ≡⟨⟩
    suc (suc m + n)
  ∎
