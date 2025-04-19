ReadInput ← -⟜'0'∘⊑•file.Lines
Expand ← (2⊸|◶⟨÷⟜2,@⟩)¨⊢/(↕≠)
Swap ← {(⌽⌾(𝕨⊸⊏))𝕩}
Checksum ← +´(↕≠)×{𝕊@:0;𝕩}¨

Part1 ← {
    InitialState ← {⟨𝕩,0,(≠𝕩)-1⟩}
    KeepGoing ← {𝕊⟨x,i,j⟩:i<j}
    Step ← {
        𝕊⟨x,i,j⟩:@≠i⊑x?⟨x,           i+1, j⟩;
        𝕊⟨x,i,j⟩:@=j⊑x?⟨x,           i,   j-1⟩;
        𝕊⟨x,i,j⟩:      ⟨⟨i,j⟩Swap x, i,   j⟩
    }
    Checksum∘⊑(Step •_while_ KeepGoing) InitialState Expand ReadInput 𝕩
}

part1test ← Part1 "day9testinput.txt"
•Show part1test
! 1928 = part1test
part1result ← Part1 "day9input.txt"
•Show part1result
! 6154342787400 = part1result

Part2 ← {Checksum∘⊑(Step •_while_ KeepGoing) InitialState Expand ReadInput 𝕩}

part2test ← Part2 "day9testinput.txt"
•Show part2test
! 2858 = part2test
part2result ← Part2 "day9input.txt"
•Show part2result
! 6154342787400 = part2result
