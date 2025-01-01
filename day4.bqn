ReadInput   ← >•file.Lines

Part1 ← {
    input       ← ReadInput 𝕩
    xmas        ← "XMAS"
    NotAllZero  ← ∨´0⊸≠
    directions  ← (NotAllZero¨⊸/⊢)⥊⋈⌜˜1-↕3
    offsets     ← <˘directions×⌜↕≠xmas # array of arrays of index offsets
    ValidIndex  ← ∧´(0⊸≤)∧((≢input)⊸>)
    ValidPath   ← ∧´ValidIndex¨
    paths       ← ∾{𝕩⊸+¨¨offsets}¨⥊↕≢input # array of arrays of indexes
    validPaths  ← (ValidPath¨/⊢) paths
    words       ← validPaths⊑input
    +´xmas⊸≡¨words
}
part1test ← Part1 "day4testinput.txt"
•Show part1test
! part1test = 18
part1result ← Part1 "day4input.txt"
•Show part1result
! part1result = 2504

# Part2 ← {
#     input       ← ReadInput 𝕩
#     parseMul    ← ParseSeq ⟨ParseLiteral "mul(", parseNumber, ParseLiteral ",", parseNumber, ParseLiteral ")"⟩
#     parseDo     ← ParseLiteral "do()"
#     parseDont   ← ParseLiteral "don't()"
#     parse       ← ParseAlt ⟨parseMul, parseDo, parseDont⟩
#     initState   ← {total⇐0⋄enabled⇐1}
#     AddTotal    ← {total⇐𝕩.total+𝕩.enabled×𝕨⋄enabled⇐𝕩.enabled}
#     SetEnabled  ← {total⇐𝕩.total⋄enabled⇐𝕨}
#     result      ← initState {
#         ⟨"mul(",m,·,n,·⟩‿·𝕊x: (m×n) AddTotal 𝕩;
#         "do()"          ‿·𝕊x: 1 SetEnabled 𝕩;
#         "don't()"       ‿·𝕊x: 0 SetEnabled 𝕩;
#         𝕩
#     }´ parse.Run¨ ⌽↓input
#     result.total
# }
# part2test ← Part2 "day4testinput2.txt"
# •Show part2test
# ! part2test = 48
# part2result ← Part2 "day4input.txt"
# •Show part2result
# ! part2result = 113965544
