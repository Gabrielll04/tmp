import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl; cong; sym)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; step-≡; _∎) -- importing step-≡ defines _⟨_⟩_
open import Data.Nat using (ℕ; zero; suc; _+_; _∸_; _*_)

-- properties:
-- identity: Operator has left and right identity as 0 . i.e (n + 0 ≡ n; 0 + n ≡ n)
-- associativity: The position of parentheses doesn't matter. i.e (m + (n + p) ≡ (m + n) + p) 
-- commutativity: Order of arguments does not matter. i.e (m + n ≡ n + m)

-- Distributivity: operator * distributes over operator + from the left if (m * (n + p) ≡ (m * n) + (m + p))
-- and from the right if ((m + n) * p ≡ (m * p) + (n * p))

-- OR has identity properties; AND distributes over OR
-- I had to search about an operator non-commutative but with associativity and identity. Function composition usually has that properties.
-- Matrices multiplication follows that properties too.

_pow_ : ℕ → ℕ → ℕ
m pow zero = 1
m pow (suc n) = m * m pow n

-- proving that addiction is associative just 4fun
-- The problem with this proof is that its not too obvious.
-- Why should 7 _ 5 be the same as 3 + 9?
_ = (5 + 3) + 2 ≡ 5 + (3 + 2)
_ =
  begin
    (5 + 3) + 2
  ≡⟨⟩
    8 + 2
  ≡⟨⟩
    10
  ≡⟨⟩
    5 + 5
  ≡⟨⟩
    5 + (3 + 2)
  ∎

-- to proof a property of natural numbers by inductio, we need prove two cases (base case and inductive case (inductive hypothesis)
-- Showing that the property holds for zero and (suc m)

-- proving associativity in a right way:
-- Basically we have to prove that 2 cases:
-- (zero + n) + p ≡ zero + (n + p)
-- (m + n) + p ≡ m + (n + p)
-- (suc m + n) + p ≡ suc m + (n + p)
-- Se provarmos o caso base, provamos também o caso indutivo porque a prova functiona para todos os valores de m.
-- If we can demonstrate both of these, then associativity of addiciton follows by induction.

+-assoc : ∀ (m n p : ℕ) → (m + n) + p ≡ m + (n + p)
+-assoc zero n p = -- for base case
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
    suc (m + n) + p
  ≡⟨⟩
    suc ((m + n) + p)
  ≡⟨ cong suc (+-assoc m n p) ⟩ -- cong for chain reasoning, where a justification for the equation appears wihin angle brackets. "cong suc" prefaces suc to each side to yield the needed question 
    suc (m + (n + p))
  ≡⟨⟩
    suc m + (n + p)
  ∎

-- if e is evidence that "x ≡ y" then "cong f" e is evidence that "f x ≡ f y"
-- Here the inductive hypothesis is not assumed, but instead proved by a recursive invocation of the function we are defining. In this case, "assoc (suc m) n p" is proved using "assoc m n p". The correspondence between proof by induction and definition by recursion is one of the most appealing aspects of Agda.
