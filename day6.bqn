ReadInput   ← >•file.Lines

Part1 ← {
    input   ← ReadInput 𝕩
    dirs ← "^>v<"
    offsets ← ⟨¯1‿0, 0‿1, 1‿0, 0‿¯1⟩
    guardPos← ⊑/○⥊⟜(↕≢)∊⟜"^>v<" input
    guardDir← ⊑dirs⊐guardPos⊑input
    F ← {
        𝕊board‿pos‿dir: '#'=pos⊑board ? •Show '#'‿pos‿dir⋄{nextDir←(≠dirs)|dir+1⋄⟨board,            pos+nextDir(-○(⊑⟜offsets))dir, nextDir⟩} ;
        𝕊board‿pos‿dir:                 •Show '.'‿pos‿dir⋄                       ⟨'X'⌾(pos⊸⊑)board, pos+dir⊑offsets,               dir⟩
    }
    board‿·‿· ← F•_while_{𝕊board‿pos‿dir: •Show '?'‿pos‿dir⋄(∧´pos≥0)∧(∧´pos<≢board)}input‿guardPos‿guardDir
    •Show board
    +´⥊'X'=board
}
part1test ← Part1 "day6testinput.txt"
•Show part1test
! part1test = 41
part1result ← Part1 "day6input.txt"
•Show part1result
! part1result = 4580

# _trace_ ← {label _𝕣_ F: {
#     𝕊𝕩:  •Show "→"‿  label‿𝕩⋄x←F𝕩⋄ •Show "←"‿label‿x⋄x ;
#     𝕨𝕊𝕩: •Show "→"‿𝕨‿label‿𝕩⋄x←𝕨F𝕩⋄•Show "←"‿label‿x⋄x
# }}
_trace_ ← {label _𝕣_ F: {
    𝕊𝕩:  F𝕩 ;
    𝕨𝕊𝕩: 𝕨F𝕩
}}

Bitor ← {⊑⟨𝕨⟩8•bit._or⟨𝕩⟩}
Bitand ← {⊑⟨𝕨⟩8•bit._and⟨𝕩⟩}
Part2 ← {
    input   ← ReadInput 𝕩
    dirs ← "^>v<"
    offsets ← ⟨¯1‿0, 0‿1, 1‿0, 0‿¯1⟩
    guardPos← ⊑/○⥊⟜(↕≢)∊⟜"^>v<" input
    guardDir← ⊑dirs⊐guardPos⊑input
    DirMarkValue ← 2⊸⋆
    DirMarkChar ← 'A'⊸+
    DirMark ← DirMarkChar DirMarkValue
    AddMarks ← Bitor⌾(DirMarkChar⁼)
    MarkPath ← (DirMark⊣){
            𝕊: ⊑𝕩∊".^" ? 𝕨 ;
                         𝕨 AddMarks 𝕩
        }⊢
    MarkLoop ← {(≠dirs) MarkPath 𝕨 MarkPath 𝕩}
    PathMatches ← {
              ·𝕊'.': 0 ;
              ·𝕊'#': 0 ;
                     0≢(DirMarkValue𝕨) Bitand DirMarkChar⁼𝕩
        }
    CurrentChar ← {𝕊board‿pos‿dir: pos⊑board}
    InBounds ← {𝕊board‿pos‿·: (∧´pos≥0)∧(∧´pos<≢board)}
    HasMark ← {𝕊board‿pos‿dir: InBounds 𝕩 ? dir PathMatches pos⊑board ; 0}
    IsLoop ← InBounds∘({
            𝕊board‿pos‿dir: '#'=pos⊑board ? •Show "IsLoop"‿'#'‿pos‿dir⋄{nextDir←(≠dirs)|dir+1⋄⟨board,            pos+nextDir(-○(⊑⟜offsets))dir, nextDir⟩} ;
            𝕊board‿pos‿dir:                 •Show "IsLoop"‿'.'‿pos‿dir⋄⟨(dir⊸MarkPath)⌾(pos⊸⊑)board, pos+dir⊑offsets, dir⟩
        }•_while_ (InBounds∧(¬HasMark)))
    •Show input
    F ← {
        𝕊board‿pos‿dir: '#'=pos⊑board                       ? •Show '#'‿pos‿dir⋄{nextDir←(≠dirs)|dir+1⋄⟨board,            pos+nextDir(-○(⊑⟜offsets))dir, nextDir⟩} ;
        𝕊board‿pos‿dir: ('.'=pos⊑board) ∧ IsLoop ⟨'#'⌾(pos⊸⊑)board, pos, dir⟩ ? •Show 'O'‿pos‿dir⋄⟨(dir⊸MarkLoop)⌾(pos⊸⊑)board, pos+dir⊑offsets, dir⟩ ;
        𝕊board‿pos‿dir:                                       •Show '.'‿pos‿dir⋄⟨(dir⊸MarkPath)⌾(pos⊸⊑)board, pos+dir⊑offsets, dir⟩
    }
    board‿·‿· ← F•_while_ InBounds input‿guardPos‿guardDir
    •Show board
    +´(≠dirs)PathMatches¨⥊board
}
part2test ← Part2 "day6testinput.txt"
•Show part2test
! part2test = 6
part2result ← Part2 "day6input.txt"
•Show part2result
 ! part2result = 1480
