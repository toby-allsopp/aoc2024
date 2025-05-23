ReadInput   ← •file.Chars

# A parser is a function that takes a string and returns either an empty list or a pair containing the result and the remaining string.
MakeParser ← {
    f ⇐ 𝕩
    Run ⇐ F
}
_MapParserResult ← {
    𝔽 _𝕣 result‿rest: ⟨𝔽 result, rest⟩ ;
    ⟨⟩
}
_MapParser ← {F _𝕣 p:
    F2←{F _MapParserResult p.Run 𝕩}
    MakeParser f2
}
parseChar ← {F←{𝕊𝕩:0≠≠𝕩?⟨⊑𝕩,1↓𝕩⟩;⟨⟩}⋄MakeParser f}
ParseLiteral ← {𝕊s: F←{(s≡(≠s)↑𝕩)⊑⟨⟨⟩,s⋈(≠s)↓𝕩⟩}⋄MakeParser f}
ParseRepeat ← {𝕊p:
    F←{𝕊input: {result‿rest: result⊸∾_MapParserResult F rest; ⟨⟨⟩, input⟩}p.Run input}
    MakeParser f
}
_ParseGuard ← {Predicate _𝕣 p:
    F←{result‿rest: Predicate result?result‿rest; ⟨⟩}p.Run
    MakeParser f
}
ParseSeq ← {
    F←{
        ⟨⟩𝕊𝕩: ⟨⟨⟩,𝕩⟩ ;
        𝕨𝕊𝕩:
            # •Show 𝕨⋈𝕩
            p←⊑𝕨
            ps←1↓𝕨
            {result‿rest: (<result)⊸∾_MapParserResult (ps⊸F) rest; ⟨⟩}p.Run 𝕩
    }
    F2←𝕩⊸F
    MakeParser f2
}
ParseAlt ← {
    F←{
        ⟨⟩𝕊𝕩: ⟨⟨⟩,𝕩⟩ ;
        𝕨𝕊input:
            # •Show 𝕨⋈𝕩
            p←⊑𝕨
            ps←1↓𝕨
            {result‿rest: result‿rest; ps F input}p.Run input
    }
    F2←𝕩⊸F
    MakeParser f2
}
parseDigit ←  (-⟜'0')_MapParser ('0'⊸≤∧≤⟜'9')_ParseGuard parseChar
parseNumber ← {+´𝕩×10⋆⌽↕≠𝕩}_MapParser ((0<≠)∧(4>≠))_ParseGuard ParseRepeat parseDigit
! ⟨123, "abc"⟩ ≡ parseNumber.Run "123abc"

Part1 ← {
    input       ← ReadInput 𝕩
    parseMul    ← ParseSeq ⟨ParseLiteral "mul(", parseNumber, ParseLiteral ",", parseNumber, ParseLiteral ")"⟩
    +´ {⟨·,m,·,n,·⟩‿·:m×n;0}¨ parseMul.Run¨ ↓input
}
part1test ← Part1 "day3testinput.txt"
•Show part1test
! part1test = 161
part1result ← Part1 "day3input.txt"
•Show part1result
! part1result = 188192787

Part2 ← {
    input       ← ReadInput 𝕩
    parseMul    ← ParseSeq ⟨ParseLiteral "mul(", parseNumber, ParseLiteral ",", parseNumber, ParseLiteral ")"⟩
    parseDo     ← ParseLiteral "do()"
    parseDont   ← ParseLiteral "don't()"
    parse       ← ParseAlt ⟨parseMul, parseDo, parseDont⟩
    initState   ← {total⇐0⋄enabled⇐1}
    AddTotal    ← {total⇐𝕩.total+𝕩.enabled×𝕨⋄enabled⇐𝕩.enabled}
    SetEnabled  ← {total⇐𝕩.total⋄enabled⇐𝕨}
    result      ← initState {
        ⟨"mul(",m,·,n,·⟩‿·𝕊x: (m×n) AddTotal 𝕩;
        "do()"          ‿·𝕊x: 1 SetEnabled 𝕩;
        "don't()"       ‿·𝕊x: 0 SetEnabled 𝕩;
        𝕩
    }´ parse.Run¨ ⌽↓input
    result.total
}
part2test ← Part2 "day3testinput2.txt"
•Show part2test
! part2test = 48
part2result ← Part2 "day3input.txt"
•Show part2result
! part2result = 113965544
