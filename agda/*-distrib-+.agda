-- write your imports here

*-distrib-+ : ∀ (m n p : ℕ) → (m + n) * p ≡ m * p + n * p
*-distrib-+ zero n p =
  begin
    (zero + n) * p
  ≡⟨⟩ -- add +-identity here
    n * p
  ≡⟨⟩
    zero * p + n * p
  ∎
*-distrib-+ (suc m) n p =
  begin
    (suc m + n) * p
  ≡⟨ cong (_* p) (+-comm (suc m) n) ⟩
    ((n + suc m)) * p
  ≡⟨ cong (_* p) (+-suc n m) ⟩
    (suc (n + m)) * p
  ≡⟨⟩
    p + (n + m) * p
  ≡⟨ cong (p +_) (*-distrib-+ n m p) ⟩
    p + (n * p + m * p)
  ≡⟨ cong (p +_) (+-comm (n * p) (m * p)) ⟩
    p + (m * p + n * p)
  ≡⟨ sym (+-assoc p (m * p) (n * p)) ⟩
    (p + (m * p)) + (n * p)
  ≡⟨⟩
    suc m * p + n * p
  ∎
