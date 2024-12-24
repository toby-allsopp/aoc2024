Words ← {
    isSpace ← ' '=𝕩
    isSpaceShifted ← 1»isSpace
    isStartOfWord ← isSpaceShifted<isSpace
    wordIndexes ← +`isStartOfWord
    wordIndexesNoSpaces ← isSpace (⊣-˜(¬⊣)×⊢) wordIndexes
    wordIndexesNoSpaces⊔𝕩
}
! "abc"‿"def"‿"ggg" ≡ Words " abc  def  ggg "
ParseInput  ← {•BQN¨¨ Words¨ 𝕩}
ReadInput   ← ParseInput •file.Lines

Diffs       ← ¯1↓ «-⊢
EqualSigns  ← {(≠⍷×𝕩) = 1}
CorrectGaps ← ((0<⌊´)∧(4>⌈´)) |
Safe        ← (EqualSigns∧CorrectGaps)∘Diffs

Part1 ← {
    input   ← ReadInput 𝕩
    oks     ← Safe¨ input
    +´ oks
}
part1test ← Part1 "day2testinput.txt"
•Show part1test
! part1test = 2
part1result ← Part1 "day2input.txt"
•Show part1result
!part1result = 479

Part2 ← {
    input   ← ReadInput 𝕩
    Remove  ← ↑∾{𝕨+1}↓⊢
    Shortened ← {𝕩⊸(Remove˜)¨ ↕≠𝕩}
    Safe2   ← ∨´Safe¨∘(⋈∾Shortened)
    oks     ← Safe2¨ input
    +´ oks
}
part2test ← Part2 "day2testinput.txt"
•Show part2test
! part2test = 4
part2result ← Part2 "day2input.txt"
•Show part2result
! part2result = 531
