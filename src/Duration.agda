{-# OPTIONS --rewriting #-}

module Duration where

open import Agda.Builtin.Equality
open import Agda.Builtin.Equality.Rewrite

open import Data.Nat
open import Data.Nat.Properties
open import Relation.Binary using (Rel)
open import Relation.Binary.PropositionalEquality using (_≡_; refl)
open import Data.Fin using (Fin; zero; suc; toℕ)
open import Agda.Primitive
open import Data.Product


data Duration : Set where
  𝅝． 𝅝 𝅗𝅥． 𝅗𝅥 𝅘𝅥． 𝅘𝅥 𝅘𝅥𝅮． 𝅘𝅥𝅮 𝅘𝅥𝅯． 𝅘𝅥𝅯 𝅘𝅥𝅰． 𝅘𝅥𝅰 ⊘ : Duration
  _⁀_ : Duration → Duration → Duration

infixl 5 _⁀_

fromDuration : Duration → ℕ
fromDuration 𝅝．       = 96
fromDuration 𝅝         = 64
fromDuration 𝅗𝅥．       = 48
fromDuration 𝅗𝅥         = 32
fromDuration 𝅘𝅥．       = 24
fromDuration 𝅘𝅥         = 16
fromDuration 𝅘𝅥𝅮．       = 12
fromDuration 𝅘𝅥𝅮         = 8
fromDuration 𝅘𝅥𝅯．       = 6
fromDuration 𝅘𝅥𝅯         = 4
fromDuration 𝅘𝅥𝅰．       = 3
fromDuration 𝅘𝅥𝅰         = 2
fromDuration ⊘         = 0
fromDuration (d₁ ⁀ d₂) = fromDuration d₁ + fromDuration d₂

_measures : ℕ → Duration
zero measures = ⊘
suc x measures = 𝅝 ⁀ x measures

postulate
  tie-32-32   : 𝅘𝅥𝅰   ⁀ 𝅘𝅥𝅰 ≡ 𝅘𝅥𝅯
  tie-16-32   : 𝅘𝅥𝅯   ⁀ 𝅘𝅥𝅰 ≡ 𝅘𝅥𝅯．
  tie-16．-32 : 𝅘𝅥𝅯． ⁀ 𝅘𝅥𝅰 ≡ 𝅘𝅥𝅮
  tie-16-16   : 𝅘𝅥𝅯   ⁀ 𝅘𝅥𝅯 ≡ 𝅘𝅥𝅮
  tie-8-16    : 𝅘𝅥𝅮   ⁀ 𝅘𝅥𝅯 ≡ 𝅘𝅥𝅮．
  tie-8．-16  : 𝅘𝅥𝅮． ⁀ 𝅘𝅥𝅯 ≡ 𝅘𝅥
  tie-8-8     : 𝅘𝅥𝅮   ⁀ 𝅘𝅥𝅮 ≡ 𝅘𝅥
  tie-4-8     : 𝅘𝅥   ⁀ 𝅘𝅥𝅮 ≡ 𝅘𝅥．
  tie-4．-8   : 𝅘𝅥． ⁀ 𝅘𝅥𝅮 ≡ 𝅗𝅥
  tie-4-4     : 𝅘𝅥   ⁀ 𝅘𝅥 ≡ 𝅗𝅥
  tie-2-4     : 𝅗𝅥   ⁀ 𝅘𝅥 ≡ 𝅗𝅥．
  tie-2．-4   : 𝅗𝅥． ⁀ 𝅘𝅥 ≡ 𝅝
  tie-2-2     : 𝅗𝅥   ⁀ 𝅗𝅥 ≡ 𝅝
  tie-1-2     : 𝅝   ⁀ 𝅗𝅥 ≡ 𝅝．
  tie-tie     : ∀ d₁ d₂ d₃ → d₁ ⁀ (d₂ ⁀ d₃) ≡ d₁ ⁀ d₂ ⁀ d₃
  tie-⊘ˡ       : ∀ d → ⊘ ⁀ d ≡ d
  tie-⊘ʳ       : ∀ d → d ⁀ ⊘ ≡ d

{-# REWRITE tie-32-32 tie-16-32 tie-16．-32 tie-16-16 tie-8-16
            tie-8．-16 tie-8-8 tie-4-8 tie-4．-8 tie-4-4 tie-2-4
            tie-2．-4 tie-2-2 tie-1-2 tie-tie tie-⊘ˡ tie-⊘ʳ
            #-}

_+ᵈ_ : Duration → Duration → Duration
x +ᵈ y  = x ⁀ y

_*ᵈ_ : Duration → ℕ → Duration
d *ᵈ zero = ⊘
d *ᵈ suc y = d +ᵈ d *ᵈ y

infixl 5 _+ᵈ_
infixl 6 _*ᵈ_

postulate
  +ᵈ-assoc : ∀ x y z → (x +ᵈ y) +ᵈ z ≡ x +ᵈ (y +ᵈ z)

