(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`Deprecation`"];


Needs["Yurie`MathForm`"];


(* ::Section:: *)
(*Public*)


MFInterpret::usage =
    "set interpretable format values.";

MFCopy::usage =
    "copy the string from MFString and return the original expression.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


MFDeprecationWarning//Attributes = {
    HoldAllComplete
};

MFDeprecationWarning[code_] :=
    (
        Message[General::deprecation,"MFInterpret","MFMakeBox"];
        code
    );

MFDeprecationWarning2[code_] :=
    (
        Message[General::deprecation0,"MFCopy"];
        code
    );


MFCopy//Options =
    Options@MFStringKernel;


MFCopy[expr_,opts:OptionsPattern[]] :=
    MFDeprecationWarning2@(
        MFStringKernel[expr,FilterRules[{opts,Options@MFCopy},Options@MFStringKernel]]//
            MFFormatKernel//CopyToClipboard//Catch;
        expr
    );


MFInterpret//Attributes =
    {HoldAllComplete};


MFInterpret[args__,list:{___List}] :=
    Scan[
        Function[{element},MFInterpret[args,element],HoldAllComplete],
        Unevaluated@list
    ];


MFInterpret[Format,{pattern_,definition_,interpretation_}] :=
    MFDeprecationWarning@MFInterpretKernel[Format,pattern,definition,interpretation];

MFInterpret[Format,format_,{pattern_,definition_,interpretation_}]/;validFormatQ[Format,format] :=
    MFDeprecationWarning@MFInterpretKernel[Format,pattern,definition,interpretation,format];

MFInterpret[Format,{pattern_,definition_}] :=
    MFDeprecationWarning@With[ {interpretation = stripPattern[pattern,Unevaluated]},
        MFInterpretKernel[Format,pattern,definition,interpretation];
    ];

MFInterpret[Format,format_,{pattern_,definition_}]/;validFormatQ[Format,format] :=
    MFDeprecationWarning@With[ {interpretation = stripPattern[pattern,Unevaluated]},
        MFInterpretKernel[Format,pattern,definition,interpretation,format];
    ];


MFInterpret[MakeBoxes,{pattern_,definition_,interpretation_}] :=
    MFDeprecationWarning@With[ {symbol = getHeadFromPattern[pattern,Unevaluated]},
        MFInterpretKernel[MakeBoxes,pattern,definition,interpretation,_,symbol]
    ];

MFInterpret[MakeBoxes,format_,{pattern_,definition_,interpretation_}]/;validFormatQ[MakeBoxes,format] :=
    MFDeprecationWarning@With[ {symbol = getHeadFromPattern[pattern,Unevaluated]},
        MFInterpretKernel[MakeBoxes,pattern,definition,interpretation,format,symbol]
    ];

MFInterpret[MakeBoxes,{pattern_,definition_}] :=
    MFDeprecationWarning@With[ {
            symbol = getHeadFromPattern[pattern,Unevaluated],
            interpretation = stripPattern[pattern,Unevaluated]
        },
        MFInterpretKernel[MakeBoxes,pattern,definition,interpretation,_,symbol]
    ];

MFInterpret[MakeBoxes,format_,{pattern_,definition_}]/;validFormatQ[MakeBoxes,format] :=
    MFDeprecationWarning@With[ {
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
