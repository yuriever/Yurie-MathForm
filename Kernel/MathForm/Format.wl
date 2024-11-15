(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Math`Format`"];


Needs["Yurie`Math`"];


(* ::Section:: *)
(*Public*)


interpretize::usage =
    ".";



(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Option*)



(* ::Subsection:: *)
(*Main*)

Needs["Lacia`Base`"];

ClearAll[interpretize];


interpretize//Attributes =
    {HoldAll};

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




(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
