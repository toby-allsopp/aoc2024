# _trace_ ← {label _𝕣_ F: {
#     𝕊𝕩:  •Show "→"‿  label‿𝕩⋄x←F𝕩⋄ •Show "←"‿label‿x⋄x ;
#     𝕨𝕊𝕩: •Show "→"‿𝕨‿label‿𝕩⋄x←𝕨F𝕩⋄•Show "←"‿label‿x⋄x
# }}
_trace_ ← {label _𝕣_ F: {
    𝕊𝕩:  F𝕩 ;
    𝕨𝕊𝕩: 𝕨F𝕩
}}

Bitor  ← {⊑⟨𝕨⟩8•bit._or⟨𝕩⟩}
Bitand ← {⊑⟨𝕨⟩8•bit._and⟨𝕩⟩}
ValidIndex  ← {∧´𝕩≥0}∧{∧´𝕩<≢𝕨}

dirs            ← "^>v<"
offsets         ← ⟨¯1‿0, 0‿1, 1‿0, 0‿¯1⟩
loopValue       ← ≠dirs

DirMarkValue    ← 2⊸⋆
DirMarkChar     ← 'A'⊸+
DirMark         ← DirMarkChar DirMarkValue
AddMarks        ← Bitor⌾(DirMarkChar⁼)
MarkPath        ← (DirMark⊣){
        𝕊: 𝕩='.' ? 𝕨 ;
                   𝕨 AddMarks 𝕩
    }⊢
PathMatches     ← {
            ·𝕊'.': 0 ;
            ·𝕊'#': 0 ;
                    0≢(Bitor´DirMarkValue𝕨) Bitand DirMarkChar⁼𝕩
    }

ReadInput       ← {
    board    ← >•file.Lines 𝕩
    guardPos ← ⊑/○⥊⟜(↕≢)∊⟜dirs board
    guardDir ← ⊑dirs⊐guardPos⊑board
    ('.'⌾(guardPos⊸⊑) board)‿guardPos‿guardDir
}
InBounds        ← {𝕊board‿pos‿·: board ValidIndex pos}
HasMark         ← {𝕊board‿pos‿dir: InBounds 𝕩 ? ⟨dir⟩ PathMatches pos⊑board ; 0}
MarkDir         ← {board‿pos‿dir𝕊𝕩: dir MarkPath 𝕩}
_FollowPath     ← {Mark _𝕣:
    {
        𝕊board‿pos‿dir: '#'=pos⊑board ? {nextDir←loopValue|dir+1⋄⟨board,                               pos+nextDir(-○(⊑⟜offsets))dir, nextDir⟩} ;
        𝕊board‿pos‿dir:                                          ⟨((𝕩⊸Mark)∘(𝕩⊸MarkDir))⌾(pos⊸⊑)board, pos+dir⊑offsets,               dir⟩
    }•_while_ (InBounds∧(¬HasMark))
}

Part1 ← {
    board‿·‿· ← ⊢_FollowPath ReadInput 𝕩
    •Show board
    +´(↕≠dirs)⊸PathMatches¨⥊board
}
part1test ← Part1 "day6testinput.txt"
•Show part1test
! part1test = 41
part1result ← Part1 "day6input.txt"
•Show part1result
! part1result = 4580

Part2 ← {
    input‿guardPos‿guardDir ← ReadInput 𝕩
    IsLoop ← InBounds ⊢_FollowPath
    Mark ← {
        board‿pos‿dir𝕊𝕩: '.'=pos⊑board ? IsLoop ⟨'#'⌾(pos⊸⊑)board, pos, dir⟩ ? •Show 'O'‿pos‿dir⋄loopValue MarkPath 𝕩 ;
        board‿pos‿dir𝕊𝕩: 𝕩
    }
    board‿·‿· ← Mark _FollowPath input‿guardPos‿guardDir
    •Show board
    +´⟨loopValue⟩⊸PathMatches¨⥊board
}
part2test ← Part2 "day6testinput.txt"
•Show part2test
! part2test = 6
part2result ← Part2 "day6input.txt"
•Show part2result
 ! part2result = 1480
