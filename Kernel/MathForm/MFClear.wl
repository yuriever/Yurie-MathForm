(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MFClear`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Variable`"];


(* ::Section:: *)
(*Public*)


MFClear::usage =
    "clear format values and rules in $MFAssoc of the symbol, or all symbols under the context.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


MFClear//Attributes =
    {HoldAllComplete};

MFClear[(args:(_String|_Symbol)..)|{args:(_String|_Symbol)..}] :=
    Scan[
        MFClearKernel,
        {args}
    ];

MFClear[] :=
    MFClear["Global`"];


MFClearKernel//Attributes = {
    HoldAllComplete
};

MFClearKernel[symbolName_String] :=
    (
        FormatValues[symbolName] = {};
        $MFAssoc =
            KeyDrop[$MFAssoc,symbolName];
        $MFRule =
            $MFAssoc//Values//Flatten;
    );

MFClearKernel[symbol_Symbol] :=
    With[ {symbolName = Function[Null,ToString@Unevaluated[#],HoldAllComplete]@symbol},
        MFClearKernel[symbolName];
    ];

MFClearKernel[ctx_String]/;StringEndsQ[ctx,"`"]&&MemberQ[$ContextPath,ctx] :=
    Scan[
        (FormatValues[#] = {})&,
        Names[ctx<>"*"]
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
