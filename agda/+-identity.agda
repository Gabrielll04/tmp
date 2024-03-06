import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; cong)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; step-≡;  _∎)

import Data.Nat using (ℕ; zero; suc; _+_)

+-identity : ∀ (m : ℕ) → m + zero ≡ m
+-identity zero =
  begin
    zero + zero
  ≡⟨⟩
    zero
  ∎
+-identity (suc m) =
  begin
    (suc m) + zero
  ≡⟨⟩
    suc (m + zero)
  ≡⟨ cong suc (+-identity m)  ⟩
    suc m
  ∎
