Split ← {
    isSpace ← (𝕨⊸≡)¨𝕩
    isSpaceShifted ← 1»isSpace
    isStartOfWord ← isSpaceShifted<isSpace
    wordIndexes ← +`isStartOfWord
    wordIndexesNoSpaces ← isSpace (⊣-˜(¬⊣)×⊢) wordIndexes
    wordIndexesNoSpaces⊔𝕩
}
! "abc"‿"def"‿"ggg" ≡ ' ' Split " abc  def  ggg "
! ⟨"abc"‿"def", ⟨"ggg"⟩⟩ ≡ "" Split ""‿"abc"‿"def"‿""‿""‿"ggg"‿""

ParseRule   ← •BQN¨'|'⊸Split
ParseUpdate ← •BQN¨','⊸Split
Parseinput  ← {rules‿updates:⟨ParseRule¨ rules, ParseUpdate¨ updates⟩}""⊸Split
ReadInput   ← ParseInput•file.Lines

Cmp         ← {𝕊rules:(<⋈)∊rules˙}
SortUpdate  ← {𝕊rules:(⍒(Cmp rules)⌜˜)⊏⊢}
MiddlePage  ← (⌊≠÷2˙)⊑⊢

Part1 ← {
    rules‿updates   ← ReadInput 𝕩
    sortedUpdates   ← (SortUpdate rules)¨updates
    +´(sortedUpdates≡¨updates)×MiddlePage¨sortedUpdates
}
part1test ← Part1 "day5testinput.txt"
•Show part1test
! part1test = 143
part1result ← Part1 "day5input.txt"
•Show part1result
! part1result = 4609

Part2 ← {
    rules‿updates   ← ReadInput 𝕩
    sortedUpdates   ← (SortUpdate rules)¨updates
    +´(sortedUpdates≢¨updates)×MiddlePage¨sortedUpdates
}
part2test ← Part2 "day5testinput.txt"
•Show part2test
! part2test = 123
part2result ← Part2 "day5input.txt"
•Show part2result
! part2result = 5723
