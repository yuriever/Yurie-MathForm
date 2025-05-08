(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MFClear`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Constant`"];

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
        Unevaluated@{args}
    ];

MFClear[] :=
    (
        MFClear["Global`"];
        Quiet@DeleteDirectory[$temporaryDir,DeleteContents->True];
    );

MFClear[Full] :=
    (
        MFClear["Global`"];
        MFClear["Global`Private`"];
        Quiet@DeleteDirectory[$temporaryDir,DeleteContents->True];
    );


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
    With[ {symbolName = Function[Null,ToString[Unevaluated[#],InputForm],HoldAllComplete]@symbol},
        MFClearKernel[symbolName];
    ];

MFClearKernel[context_String?validContextQ] :=
    Scan[
        MFClearKernel,
        Names[context<>"*"]
    ];


validContextQ[context_String] :=
    StringEndsQ[context,"`"]&&MemberQ[$ContextPath,context]||
        StringEndsQ[context,"`Private`"]&&MemberQ[$ContextPath,StringDrop[context,-8]];

validContextQ[_] :=
    False;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
