{-# OPTIONS --exact-split #-}

module hello where

import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _∎)

data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ
{-# BUILTIN NATURAL ℕ #-}

-- A more efficient representations of natural numbers uses binary rather than a unary system.
-- We repesent a number as a bitstring

_+_ : ℕ → ℕ → ℕ
zero + n    = n
(suc m) + n = suc (m + n)  

_*_ : ℕ → ℕ → ℕ
zero * n = zero
(suc m) * n = n + (m * n)

infixl 6 _+_
infixl 7 _*_

data Bin : Set where
     ⟨⟩ : Bin
     _O : Bin → Bin
     _I : Bin → Bin

-- 1011 → binary
-- enconded as ⟨⟩ 0 0 I 0 I I

inc : Bin → Bin
inc ⟨⟩    = ⟨⟩ I
inc (b O) = b I
inc (b I) = inc b O

_ : inc (⟨⟩ I O I I) ≡ ⟨⟩ I I O O
_ = refl

_ : inc (⟨⟩ O O O O) ≡ ⟨⟩ O O O I
_ = refl

_ : inc (⟨⟩ O O O I) ≡ ⟨⟩ O O I O
_ = refl

_ : inc (⟨⟩ O O I O) ≡ ⟨⟩ O O I I
_ = refl

_ : inc (⟨⟩ O O I I) ≡ ⟨⟩ O I O O
_ = refl

_ : inc (⟨⟩ O I O O) ≡ ⟨⟩ O I O I
_ = refl

_ : inc (⟨⟩ O I O I) ≡ ⟨⟩ O I I O
_ = refl

to : ℕ → Bin
to zero    = ⟨⟩ O
to (suc n) = inc (to n)

_ : to 4 ≡ ⟨⟩ I O O
_ = refl

_ : to 3 ≡ ⟨⟩ I I
_ = refl

_ : to 2 ≡ ⟨⟩ I O
_ = refl

_ : to 1 ≡ ⟨⟩ I
_ = refl

_ : to 0 ≡ ⟨⟩ O
_ = refl 

_ : to 3 ≡ ⟨⟩ I I
_ =
  begin
    to 3
  ≡⟨⟩
    inc (to 2)
  ≡⟨⟩
    inc (inc (to 1))
  ≡⟨⟩
    inc (inc (inc (to 0)))
  ≡⟨⟩
    inc (inc (inc ⟨⟩))
  ≡⟨⟩
    inc (inc (⟨⟩ I))
  ≡⟨⟩
    inc (⟨⟩ I O)
  ≡⟨⟩
    ⟨⟩ I I
  ∎

from : Bin → ℕ
from ⟨⟩ = zero
from (b O) = 2 * (from b)
from (b I) = 2 * (from b) + 1

_ : from (⟨⟩) ≡ 0
_ = refl

_ : from (⟨⟩ I) ≡ 1
_ = refl

_ : from (⟨⟩ I O) ≡ 2
_ = refl

_ : from (⟨⟩ I I) ≡ 3
_ = refl

_ : from (⟨⟩ I O O) ≡ 4
_ = refl
