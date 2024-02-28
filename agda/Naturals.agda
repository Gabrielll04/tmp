{-# OPTIONS --exact-split #-}

module hello where

import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _∎)

data ℕ : Set where
  zero  : ℕ -- Base case
  suc   : ℕ → ℕ -- inductive case
{-# BUILTIN NATURAL ℕ #-}
-- Tells Agda that ℕ corresponds to natural numbers
-- suc (suc 0) == 2

_+_ : ℕ → ℕ → ℕ
zero + n = n -- 0 + n ≡ n
(suc m) + n  = suc (m + n) -- (1 + m) + n ≡ 1 + (m + n) 

-- The definition is recursive, in that the last line defines addition in terms of addition.
-- It works because addition of larger numbers is defined in terms of addition of smaller numbers. Exemple:

_ : 2 + 3 ≡ 5
_ =
  begin
    2 + 3
  ≡⟨⟩ --  shorthand for
      (suc (suc zero)) + (suc (suc (suc zero)))
  ≡⟨⟩ -- inductive case
      suc ((suc zero) + (suc (suc (suc zero))))
  ≡⟨⟩ -- inductive case
      suc (suc (zero + (suc (suc (suc zero)))))
  ≡⟨⟩ -- base case
      suc (suc (suc (suc (suc zero))))
  ≡⟨⟩ -- is longhand for
    5
  ∎ -- tombstone

_ : 2 + 3 ≡ 5
_ = refl

_ : 3 + 4 ≡ 7
_ =
  begin
    3 + 4
  ≡⟨⟩
    suc (2 + 4)
  ≡⟨⟩
    suc (suc (1 + 4))
  ≡⟨⟩
    suc (suc (suc (0 + 4)))
  ≡⟨⟩
    suc (suc (suc 4))
  ≡⟨⟩
    7
  ∎

_*_ : ℕ → ℕ → ℕ
zero    * n = zero
(suc m) * n = n + (m * n) -- distribution of multiplication over addition is written | (m + n) * p ≡ (m * p) + (n * p)

_ =
  begin
    2 * 3
  ≡⟨⟩ -- inductive case
    3 + (1 * 3)
  ≡⟨⟩ -- inductive case
    3 + (3 + (0 * 3))
  ≡⟨⟩ -- base case
    3 + (3 + 0)
  ≡⟨⟩
    6
  ∎

_ =
  begin
    3 * 4
  ≡⟨⟩
    4 + (2 * 4)
  ≡⟨⟩
    4 + (4 + (1 * 4))
  ≡⟨⟩
    4 + (4 + 4)
  ≡⟨⟩
    12
  ∎

_pow_ : ℕ → ℕ → ℕ
m pow zero    = 1
m pow (suc n) = m * (m pow n)

_ =
  begin
    3 pow 4
  ≡⟨⟩
    3 * (3 pow 3)
  ≡⟨⟩
    3 * (3 * (3 pow 2))
  ≡⟨⟩
    3 * (3 * (3 * (3 pow 1)))
  ≡⟨⟩
    3 * (3 * (3 * (3 * (3 pow 0))))
  ≡⟨⟩
    3 * (3 * (3 * (3 * 1)))
  ≡⟨⟩
    3 * (3 * (3 * 3))
  ≡⟨⟩
    81
  ∎
  
_∸_ : ℕ → ℕ → ℕ
m     ∸ zero  = m
zero  ∸ suc n = zero -- suc n to mantain recursivity?
suc m ∸ suc n = m ∸ n

_ =
  begin
    3 ∸ 2
  ≡⟨⟩
    2 ∸ 1
  ≡⟨⟩
    1 ∸ 0
  ≡⟨⟩
    1
  ∎

_ = -- using the second equation of ∸
  begin
    2 ∸ 3
  ≡⟨⟩
    1 ∸ 2
  ≡⟨⟩
    0 ∸ 1
  ≡⟨⟩
    0
  ∎

-- Then it would not be clear whether Agda should use the first or
-- second line to simplify zero ∸ zero. Due that, put that line:
-- {-# OPTIONS --exact-split #-}
-- Otherwise, Agda will raise an error if cases overlap.
-- Sometimes overlap may be desirable

_ =
  begin
    5 ∸ 3
  ≡⟨⟩
    4 ∸ 2
  ≡⟨⟩
    3 ∸ 1
  ≡⟨⟩
    2 ∸ 0
  ≡⟨⟩
    2
  ∎

_ =
  begin
    3 ∸ 5
  ≡⟨⟩
    2 ∸ 4
  ≡⟨⟩
    1 ∸ 3
  ≡⟨⟩
    0 ∸ 2
  ≡⟨⟩
    0
  ∎

