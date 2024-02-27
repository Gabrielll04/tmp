module plfa.part1.hello where

data 𝐍 : Set where -- inductive process
  zero  : 𝐍
  suc   : 𝐍 → 𝐍

-- suc (suc 0) 
