(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`Constant`"];


Needs["Yurie`MathForm`Info`"]//Quiet;


(* ::Section:: *)
(*Public*)


$pdfLaTeX::usage =
    "path of pdfLaTeX.";

$texfmt::usage =
    "path of texfmt.";

$temporaryDir::usage =
    "temporary directory."

$texTemplate::usage =
    "tex template.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


$texfmt = FileNameJoin[$thisLibraryDir,"tex-fmt"];

$pdfLaTeX = "/Library/TeX/texbin/pdflatex";

$temporaryDir = FileNameJoin[$TemporaryDirectory,"Yurie__MathForm"];

$texTemplate :=
    $texTemplate =
        StringTemplate@Import[
            FileNameJoin[$thisSourceDir,"template"],
            "Text",
            CharacterEncoding->"UTF-8"
        ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
