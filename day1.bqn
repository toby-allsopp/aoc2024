Words ← {
    isSpace ← ' '=𝕩
    isSpaceShifted ← 1»isSpace
    isStartOfWord ← isSpaceShifted<isSpace
    wordIndexes ← +`isStartOfWord
    wordIndexesNoSpaces ← isSpace (⊣-˜(¬⊣)×⊢) wordIndexes
    wordIndexesNoSpaces⊔𝕩
}
•Show Words " abc  def  ggg "
! "abc"‿"def"‿"ggg" ≡ Words " abc  def  ggg "
ParseInput  ← {⍉ •BQN¨ > Words¨ 𝕩}
ReadInput   ← ParseInput •file.Lines

Part1       ← {
    input       ← ReadInput 𝕩
    sorted      ← ∧˘ input
    diffs       ← |-´˘⍉ sorted
    sum         ← +´ diffs
    sum
}
part1test ← Part1 "day1testinput.txt"
! part1test = 11
•Show part1test
part1 ← Part1 "day1input.txt"
! part1 = 2264607
•Show part1

Part2 ← {
    input   ← ReadInput 𝕩
    left    ← 0⊏input
    right   ← 1⊏input
    left (+´ ⊣×·+´˘ ⊣=⌜⊢) right
}
part2test ← Part2 "day1testinput.txt"
! part2test = 31
•Show part2test
part2 ← Part2 "day1input.txt"
! part2 = 19457120
•Show part2