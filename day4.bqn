ReadInput   ← >•file.Lines
ValidIndex  ← ∧´(0⊸≤)∧((≢⊣)⊸>)
ValidPath   ← {∧´(𝕨⊸ValidIndex)¨𝕩}

Part1 ← {
    input       ← ReadInput 𝕩
    xmas        ← "XMAS"
    NotAllZero  ← ∨´0⊸≠
    directions  ← (NotAllZero¨⊸/⊢)⥊⋈⌜˜1-↕3
    offsets     ← <˘directions×⌜↕≠xmas # array of arrays of index offsets
    paths       ← ∾{𝕩⊸+¨¨offsets}¨⥊↕≢input # array of arrays of indexes
    validPaths  ← ((input⊸ValidPath)¨/⊢) paths
    words       ← validPaths⊑input
    +´xmas⊸≡¨words
}
part1test ← Part1 "day4testinput.txt"
•Show part1test
! part1test = 18
part1result ← Part1 "day4input.txt"
•Show part1result
! part1result = 2504

Part2 ← {
    input       ← ReadInput 𝕩
    offsets     ← ⟨⟨¯1‿¯1,0‿0,1‿1⟩, ⟨1‿1,0‿0,¯1‿¯1⟩, ⟨¯1‿1,0‿0,1‿¯1⟩, ⟨1‿¯1,0‿0,¯1‿1⟩⟩
    exes        ← {𝕩⊸+¨¨offsets}¨⥊↕≢input
    IsValidEx   ← ∧´(input⊸ValidPath)¨
    validExes   ← (IsValidEx¨/⊢) exes
    IsXMAS      ← {𝕊path:2=+´("MAS"⊸≡)¨path⊑input}
    +´IsXMAS¨validExes
}
part2test ← Part2 "day4testinput.txt"
•Show part2test
! part2test = 9
part2result ← Part2 "day4input.txt"
•Show part2result
! part2result = 1923
