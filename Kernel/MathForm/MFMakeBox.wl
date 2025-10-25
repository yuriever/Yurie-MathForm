(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MFMakeBox`"];


Needs["Yurie`MathForm`"];


(* ::Section:: *)
(*Public*)


MFMakeBox::usage =
    "MFMakeBox[{pattern, format}..., opts]: automatically inject interpretation (and tooltip) into format value."<>
    "\n"<>
    "Default[\"Tooltip\"]: False.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*MFMakeBox*)


MFMakeBox//Attributes =
    {HoldAllComplete};

MFMakeBox//Options = {
    "Tooltip"->None,
    "SyntaxForm"->Automatic
};

MFMakeBox[args___List,opts:OptionsPattern[]] :=
    With[{
            tooltip = OptionValue["Tooltip"],
            precedence = OptionValue["SyntaxForm"]
        },
        Scan[
            Function[arg,MFMakeBoxKernel[arg,tooltip,precedence],HoldAllComplete],
            HoldComplete[args]
        ]
    ];


MFMakeBoxKernel//Attributes = {
    HoldAllComplete
};

MFMakeBoxKernel[{pattern_,format_},tooltip_,precedence_] :=
    With[{
            heldSymbol = getHeadFromPattern[pattern,Unevaluated],
            realValue = stripPattern[pattern,Unevaluated]
        },
        MFMakeBoxKernel2[{heldSymbol,pattern,format,realValue},tooltip,precedence]
    ];

MFMakeBoxKernel[{pattern_,format_,realValue_},tooltip_,precedence_] :=
    With[{heldSymbol = getHeadFromPattern[pattern,Unevaluated]},
        MFMakeBoxKernel2[{heldSymbol,pattern,format,realValue},tooltip,precedence]
    ];


MFMakeBoxKernel2//Attributes = {
    HoldAllComplete
};

MFMakeBoxKernel2[{heldSymbol_,pattern_,format_,realValue_},None,Automatic] :=
    HoldComplete[
        heldSymbol,
        MakeBoxes[pattern,_],
        With[{
                fvalue = format
            },
            InterpretationBox[fvalue,realValue]
        ]
    ]//ReplaceAll[HoldComplete[args__]:>TagSetDelayed[args]];

MFMakeBoxKernel2[{heldSymbol_,pattern_,format_,realValue_},tooltip_,precedence_] :=
    HoldComplete[
        heldSymbol,
        MakeBoxes[pattern,_],
        With[{
                fvalue = format,
                tvalue = tooltipValue[tooltip,heldSymbol,realValue]
            },
            InterpretationBox[TooltipBox[fvalue,tvalue],realValue,SyntaxForm->precedence]
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
    With[{head = Head@Unevaluated@expr},
        hold[head]
    ];

getHeadFromPattern[Verbatim[HoldPattern][expr_],hold_] :=
    With[{head = Head@Unevaluated@expr},
        hold[head]
    ];


tooltipValue//Attributes = {
    HoldAllComplete
};

tooltipValue[Full,heldSymbol_,realValue_] :=
    ToString[realValue];

tooltipValue[Automatic,heldSymbol_,realValue_] :=
    ToString[heldSymbol];

tooltipValue[tvalue_,_,_] :=
    tvalue;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
