Numbers ← {
    isNotDigit ← {¬⊑𝕩∊'-'∾'0'+↕10}¨𝕩
    isSpaceShifted ← 1»isNotDigit
    isStartOfWord ← isSpaceShifted<isNotDigit
    wordIndexes ← +`isStartOfWord
    wordIndexesNoSpaces ← isNotDigit (⊣-˜(¬⊣)×⊢) wordIndexes
    words ← wordIndexesNoSpaces⊔𝕩
    •ParseFloat¨ words
}
! 123‿456‿¯789 ≡ Numbers "123: 456 -789"

ReadInput ← Numbers¨ •file.Lines

_Apply←{𝕨𝔽𝕩}

_Or ← {0=≠𝕩?0;𝔽⊑𝕩?1;𝕊1↓𝕩}
_F2_ ← {ops _𝕣_ want: {
    𝕊nums:    want×(⊑nums)𝕊1↓nums;
    sum𝕊⟨⟩:   want=sum;
    sum𝕊nums: ((𝕊⟜(1↓nums)){sum𝕏(⊑nums)})_Or ops
}}

F←{𝕨 _F2_ (⊑𝕩) 1↓𝕩}

Part1 ← {
    input ← ReadInput 𝕩
    +´⟨+,×⟩⊸F¨ input
}
part1test ← Part1 "day7testinput.txt"
•Show part1test
! part1test = 3749
part1result ← Part1 "day7input.txt"
•Show part1result
! part1result = 3351424677624

Part2 ← {
    input ← ReadInput 𝕩
    Concat ← •ParseFloat ∾○•Fmt
    +´⟨+,×,concat⟩⊸F¨ input
}
part2test ← Part2 "day7testinput.txt"
•Show part2test
! part2test = 11387
part2result ← Part2 "day7input.txt"
•Show part2result
! part2result = 204976636995111
