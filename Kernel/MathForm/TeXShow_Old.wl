(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`TeXShow`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Variable`"];


Needs["MaTeX`"];

SetOptions[MaTeX,
    "Magnification"->1.5,
    "Preamble"->{"\\usepackage{physics}"}
];


(* ::Section:: *)
(*Public*)


texShow::usage =
    "texForm + MaTeX.";

texCopy::usage =
    "texForm + CopyToClipboard.";

texCS::usage =
    "texForm + CopyToClipboard + MaTeX.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


texShow//Options =
    Options@MaTeX;

texShow[string_String,opts:OptionsPattern[]] :=
    MaTeX[string,FilterRules[{opts,Options@texShow},Options@MaTeX]];

texShow[expr_,opts:OptionsPattern[]] :=
    MaTeX[texForm[expr],FilterRules[{opts,Options@texShow},Options@MaTeX]];


texCopy[string_String] :=
    (
        CopyToClipboard@string;
        string
    );

texCopy[expr_] :=
    (
        CopyToClipboard@texForm[expr];
        expr
    );


texCS//Options =
    Options@MaTeX;

texCS[string_String,opts:OptionsPattern[]] :=
    (
        CopyToClipboard@string;
        MaTeX[string,FilterRules[{opts,Options@texCS},Options@MaTeX]]
    );

texCS[expr_,opts:OptionsPattern[]] :=
    Module[ {tex},
        tex = texForm[expr];
        CopyToClipboard@tex;
        MaTeX[texForm[expr],FilterRules[{opts,Options@texCS},Options@MaTeX]]
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
