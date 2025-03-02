(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MFMakeBox`"];


Needs["Yurie`MathForm`"];


(* ::Section:: *)
(*Public*)


MFMakeBox::usage =
    "make the box definitions interpretable.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


MFMakeBox//Attributes =
    {HoldAllComplete};


MFMakeBox[list:{___List}] :=
    Scan[
        MFMakeBox,
        Unevaluated@list
    ];


MFMakeBox[{pattern_,definition_}] :=
    With[ {
            symbol = getHeadFromPattern[pattern,Unevaluated],
            interpretation = stripPattern[pattern,Unevaluated]
        },
        MFMakeBoxKernel[symbol,pattern,definition,interpretation,_]
    ];

MFMakeBox[{pattern_,definition_,format_}]/;boxFormatQ[format] :=
    With[ {
            symbol = getHeadFromPattern[pattern,Unevaluated],
            interpretation = stripPattern[pattern,Unevaluated]
        },
        MFMakeBoxKernel[symbol,pattern,definition,interpretation,format]
    ];

MFMakeBox[{pattern_,definition_,interpretation_,format_}]/;boxFormatQ[format] :=
    With[ {symbol = getHeadFromPattern[pattern,Unevaluated]},
        MFMakeBoxKernel[symbol,pattern,definition,interpretation,format]
    ];


MFMakeBoxKernel//Attributes =
    {HoldAllComplete};


MFMakeBoxKernel[symbol_,pattern_,definition_,interpretation_,format_] :=
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
    hold[expr]//ReplaceRepeated[
        (Verbatim[Pattern]|Verbatim[Optional]|Verbatim[PatternTest]|Verbatim[Condition])[pattern_,_]:>pattern
    ];


getHeadFromPattern//Attributes =
    {HoldAllComplete};

getHeadFromPattern[expr_Symbol,hold_] :=
    hold[expr];

getHeadFromPattern[Verbatim[HoldPattern][expr_Symbol],hold_] :=
    hold[expr];

getHeadFromPattern[expr_,hold_] :=
    With[ {head = Head@Unevaluated@expr},
        hold[head]
    ];

getHeadFromPattern[Verbatim[HoldPattern][expr_],hold_] :=
    With[ {head = Head@Unevaluated@expr},
        hold[head]
    ];


boxFormatQ//Attributes =
    {HoldAllComplete};

boxFormatQ[format_] :=
    MatchQ[format,StandardForm|TraditionalForm]||Internal`PatternPresentQ[format];

boxFormatQ[_,_] :=
    False;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
