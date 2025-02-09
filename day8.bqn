ReadInput ← >•file.Lines
Part1 ← {
    m ← ReadInput 𝕩
    ≠⍷((∧´0⊸≤∾<⟜(≠m))¨/⊢)∾∾⥊¨{𝕩{𝕨≡𝕩?⟨⟩;⟨𝕩+𝕩-𝕨,𝕨+𝕨-𝕩⟩}⌜𝕩}¨(⊑⟜(⥊↕≢m))¨¨(-⟜1)¨1↓⊔⊐'.'∾⥊m
}

part1test ← Part1 "day8testinput.txt"
•Show part1test
! 14 = part1test
part1result ← Part1 "day8input.txt"
•Show part1result
! 392 = part1result

_GenerateWhile_ ← {⌽1↓((<∘𝔽⊑)∾⊢)•_while_(𝔾⊑)⟨𝕩⟩}
Part2 ← {
    m ← ReadInput 𝕩
    InBounds ← ∧´0⊸≤∾<⟜(≠m)
    GenAntinodes ← {(+⟜(𝕨-𝕩))_GenerateWhile_ InBounds 𝕩}
    ≠⍷(InBounds¨/⊢)∾∾⥊¨{𝕩{𝕨≡𝕩?⟨⟩;𝕨(GenAntinodes˜∾GenAntinodes)𝕩}⌜𝕩}¨(⊑⟜(⥊↕≢m))¨¨(-⟜1)¨1↓⊔⊐'.'∾⥊m
}

part2test ← Part2 "day8testinput.txt"
•Show part2test
! 34 = part2test
part2result ← Part2 "day8input.txt"
•Show part2result
! 1235 = part2result