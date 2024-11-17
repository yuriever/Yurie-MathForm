(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MFInterpret`"];


Needs["Yurie`MathForm`"];


(* ::Section:: *)
(*Public*)


interpretize::usage =
    "make format definitions interpretable.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


interpretize//Attributes =
    {HoldAll};


(* ::Text:: *)
(*MakeBoxes*)


interpretize/:(set:TagSetDelayed|TagSet)[symbol_Symbol,Verbatim[MakeBoxes][args__],interpretize[boxdef_,interpretation_]] :=
    HoldComplete[
        symbol,
        MakeBoxes[args],
        With[ {box = boxdef},
            InterpretationBox[box,interpretation]
        ]
    ]//ReplaceAll[HoldComplete[args1__]:>set[args1]];


interpretize/:(set:TagSetDelayed|TagSet)[symbol_Symbol,Verbatim[MakeBoxes][args__],interpretize[boxdef_]] :=
    With[ {interpretation = stripPattern[First@{args},Unevaluated]},
        HoldComplete[
            symbol,
            MakeBoxes[args],
            With[ {box = boxdef},
                InterpretationBox[box,interpretation]
            ]
        ]
    ]//ReplaceAll[HoldComplete[args1__]:>set[args1]];


(* ::Text:: *)
(*Format*)


interpretize/:(set:SetDelayed|Set)[Verbatim[Format][args__],interpretize[formatdef_,interpretation_]] :=
    HoldComplete[
        Format[args],
        With[ {format = formatdef},
            Interpretation[format,interpretation]
        ]
    ]//ReplaceAll[HoldComplete[args1__]:>set[args1]];


interpretize/:(set:SetDelayed|Set)[Verbatim[Format][args__],interpretize[formatdef_]] :=
    With[ {interpretation = stripPattern[First@{args},Unevaluated]},
        HoldComplete[
            Format[args],
            With[ {format = formatdef},
                Interpretation[format,interpretation]
            ]
        ]
    ]//ReplaceAll[HoldComplete[args1__]:>set[args1]];


(* ::Subsection:: *)
(*Helper*)


stripPattern//Attributes =
    {HoldAll};

stripPattern[expr_,head_:Defer] :=
    head[expr]//ReplaceRepeated[(Verbatim[Pattern]|Verbatim[Optional]|Verbatim[PatternTest]|Verbatim[Condition])[pattern_,_]:>pattern];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
