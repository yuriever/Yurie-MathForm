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
    "Tooltip"->False
};

MFMakeBox[args___List,opts:OptionsPattern[]] :=
    With[ {
            ifTooltip = OptionValue["Tooltip"]
        },
        Scan[
            Function[arg,MFMakeBoxKernel[arg,ifTooltip],HoldAllComplete],
            Unevaluated@{args}
        ]
    ];


MFMakeBoxKernel//Attributes = {
    HoldAllComplete
};

MFMakeBoxKernel[{pattern_,formatValue_},ifTooltip_] :=
    With[ {
            symbol = getHeadFromPattern[pattern,Unevaluated],
            realValue = stripPattern[pattern,Unevaluated]
        },
        MFMakeBoxKernel2[{symbol,pattern,formatValue,realValue},ifTooltip]
    ];

MFMakeBoxKernel[{pattern_,formatValue_,realValue_},ifTooltip_] :=
    With[ {symbol = getHeadFromPattern[pattern,Unevaluated]},
        MFMakeBoxKernel2[{symbol,pattern,formatValue,realValue},ifTooltip]
    ];


MFMakeBoxKernel2//Attributes = {
    HoldAllComplete
};

MFMakeBoxKernel2[{symbol_,pattern_,formatValue_,realValue_},False] :=
    HoldComplete[
        symbol,
        MakeBoxes[pattern,_],
        With[ {
                fvalue = formatValue
            },
            InterpretationBox[fvalue,realValue]
        ]
    ]//ReplaceAll[HoldComplete[args__]:>TagSetDelayed[args]];

MFMakeBoxKernel2[{symbol_,pattern_,formatValue_,realValue_},True] :=
    HoldComplete[
        symbol,
        MakeBoxes[pattern,_],
        With[ {
                fvalue = formatValue,
                tvalue = ToString[realValue]
            },
            InterpretationBox[TooltipBox[fvalue,tvalue],realValue]
        ]
    ]//ReplaceAll[HoldComplete[args__]:>TagSetDelayed[args]];

MFMakeBoxKernel2[{symbol_,pattern_,formatValue_,realValue_},tooltipValue_] :=
    HoldComplete[
        symbol,
        MakeBoxes[pattern,_],
        With[ {
                fvalue = formatValue
            },
            InterpretationBox[TooltipBox[fvalue,tooltipValue],realValue]
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


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
