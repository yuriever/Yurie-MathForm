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
    "Value[\"Tooltip\"]: None, Automatic, Full, _.";


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

MFMakeBoxKernel[{pattern_,formatValue_},tooltip_,precedence_] :=
    With[{
            heldSymbol = getHeadFromPattern[pattern],
            heldRealValue = stripPattern[pattern]
        },
        MFMakeBoxKernel2[heldSymbol,pattern,formatValue,heldRealValue,tooltip,precedence]
    ];

MFMakeBoxKernel[{pattern_,formatValue_,realValue_},tooltip_,precedence_] :=
    With[{
            heldSymbol = getHeadFromPattern[pattern]
        },
        MFMakeBoxKernel2[heldSymbol,pattern,formatValue,HoldComplete[realValue],tooltip,precedence]
    ];


MFMakeBoxKernel2//Attributes = {
    HoldAllComplete
};

MFMakeBoxKernel2[HoldComplete[symbol_],pattern_,formatValue_,HoldComplete[realValue_],None,Automatic] :=
    HoldComplete[
        symbol,
        MakeBoxes[pattern,_],
        With[{
                fvalue = formatValue
            },
            InterpretationBox[fvalue,realValue]
        ]
    ]//ReplaceAll[HoldComplete[args__]:>TagSetDelayed[args]];

MFMakeBoxKernel2[HoldComplete[symbol_],pattern_,formatValue_,HoldComplete[realValue_],tooltip_,precedence_] :=
    HoldComplete[
        symbol,
        MakeBoxes[pattern,_],
        With[{
                fvalue = formatValue,
                tvalue = tooltipValue[tooltip,symbol,realValue]
            },
            InterpretationBox[TooltipBox[fvalue,tvalue],realValue,SyntaxForm->precedence]
        ]
    ]//ReplaceAll[HoldComplete[args__]:>TagSetDelayed[args]];


(* ::Subsection:: *)
(*Helper*)


stripPattern//Attributes =
    {HoldAllComplete};

stripPattern[expr_] :=
    HoldComplete[expr]//
        ReplaceRepeated[{
            (Pattern|Optional|PatternTest|Condition)[pattern_,___]:>pattern,
            (HoldPattern|Verbatim)[pattern_]:>pattern
        }];


getHeadFromPattern//Attributes =
    {HoldAllComplete};

getHeadFromPattern[expr_] :=
    With[{
            heldExpr = stripPattern[expr]
        },
        getHeadFromPattern1[heldExpr]
    ];


getHeadFromPattern1//Attributes =
    {HoldAllComplete};

getHeadFromPattern1[HoldComplete[head_Symbol]] :=
    HoldComplete[head];

getHeadFromPattern1[HoldComplete[head_[___]]] :=
    getHeadFromPattern1[HoldComplete[head]];


tooltipValue//Attributes = {
    HoldAllComplete
};

tooltipValue[Full,symbol_,realValue_] :=
    ToString[realValue];

tooltipValue[Automatic,symbol_,realValue_] :=
    ToString@Unevaluated[symbol];

tooltipValue[tvalue_,_,_] :=
    tvalue;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
