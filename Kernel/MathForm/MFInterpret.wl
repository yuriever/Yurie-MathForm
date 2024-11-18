(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MFInterpret`"];


Needs["Yurie`MathForm`"];


(* ::Section:: *)
(*Public*)


MFInterpret::usage =
    "set interpretable format values.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


MFInterpret//Attributes =
    {HoldAllComplete};


MFInterpret[args__,list:{___List}] :=
    Scan[
        Function[{element},MFInterpret[args,element],HoldAllComplete],
        list
    ];


MFInterpret[Format,{pattern_,definition_,interpretation_}] :=
    MFInterpretKernel[Format,pattern,definition,interpretation];

MFInterpret[Format,format_,{pattern_,definition_,interpretation_}]/;validFormatQ[Format,format] :=
    MFInterpretKernel[Format,pattern,definition,interpretation,format];

MFInterpret[Format,{pattern_,definition_}] :=
    With[ {interpretation = stripPattern[pattern,Unevaluated]},
        MFInterpretKernel[Format,pattern,definition,interpretation];
    ];

MFInterpret[Format,format_,{pattern_,definition_}]/;validFormatQ[Format,format] :=
    With[ {interpretation = stripPattern[pattern,Unevaluated]},
        MFInterpretKernel[Format,pattern,definition,interpretation,format];
    ];


MFInterpret[MakeBoxes,{pattern_,definition_,interpretation_}] :=
    With[ {symbol = getHeadFromPattern[pattern,Unevaluated]},
        MFInterpretKernel[MakeBoxes,pattern,definition,interpretation,_,symbol]
    ];

MFInterpret[MakeBoxes,format_,{pattern_,definition_,interpretation_}]/;validFormatQ[MakeBoxes,format] :=
    With[ {symbol = getHeadFromPattern[pattern,Unevaluated]},
        MFInterpretKernel[MakeBoxes,pattern,definition,interpretation,format,symbol]
    ];

MFInterpret[MakeBoxes,{pattern_,definition_}] :=
    With[ {
            symbol = getHeadFromPattern[pattern,Unevaluated],
            interpretation = stripPattern[pattern,Unevaluated]
        },
        MFInterpretKernel[MakeBoxes,pattern,definition,interpretation,_,symbol]
    ];

MFInterpret[MakeBoxes,format_,{pattern_,definition_}]/;validFormatQ[MakeBoxes,format] :=
    With[ {
            symbol = getHeadFromPattern[pattern,Unevaluated],
            interpretation = stripPattern[pattern,Unevaluated]
        },
        MFInterpretKernel[MakeBoxes,pattern,definition,interpretation,format,symbol]
    ];


MFInterpretKernel//Attributes =
    {HoldAllComplete};

MFInterpretKernel[Format,pattern_,definition_,interpretation_] :=
    HoldComplete[
        Format[pattern],
        With[ {def = definition},
            Interpretation[def,interpretation]
        ]
    ]//ReplaceAll[HoldComplete[args__]:>SetDelayed[args]];

MFInterpretKernel[Format,pattern_,definition_,interpretation_,format_] :=
    HoldComplete[
        Format[pattern,format],
        With[ {def = definition},
            Interpretation[def,interpretation]
        ]
    ]//ReplaceAll[HoldComplete[args__]:>SetDelayed[args]];

MFInterpretKernel[MakeBoxes,pattern_,definition_,interpretation_,format_,symbol_] :=
    HoldComplete[
        symbol,
        MakeBoxes[pattern,format],
        With[ {def = definition},
            InterpretationBox[def,interpretation]
        ]
    ]//ReplaceAll[HoldComplete[args__]:>TagSetDelayed[args]];


(* ::Subsection:: *)
(*Helper*)


stripPattern//Attributes =
    {HoldAllComplete};

stripPattern[expr_,hold_] :=
    hold[expr]//ReplaceRepeated[(Verbatim[Pattern]|Verbatim[Optional]|Verbatim[PatternTest]|Verbatim[Condition])[pattern_,_]:>pattern];


getHeadFromPattern//Attributes =
    {HoldAllComplete};

getHeadFromPattern[expr_Symbol,hold_] :=
    hold[expr];

getHeadFromPattern[expr_,hold_] :=
    With[ {head = Head@Unevaluated@expr},
        hold[head]
    ];


validFormatQ//Attributes =
    {HoldAllComplete};

validFormatQ[Format,format_] :=
    MatchQ[format,StandardForm|TraditionalForm];

validFormatQ[MakeBoxes,format_] :=
    MatchQ[format,StandardForm|TraditionalForm]||Internal`PatternPresentQ[format];

validFormatQ[_,_] :=
    False;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
