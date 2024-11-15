(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`Constant`"];


Needs["Yurie`MathForm`Info`"];


(* ::Section:: *)
(*Public*)


$macroLeftDelimiter::usage =
    "left delimiter.";

$macroRightDelimiter::usage =
    "right delimiter.";

$macroListSeparator::usage =
    "list separator.";


$pdfLaTeX::usage =
    "path of pdfLaTeX.";

$Ghostscript::usage =
    "path of Ghostscript.";

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


$macroLeftDelimiter = "Left";

$macroRightDelimiter = "Right";

$macroListSeparator = "ListSep";


$pdfLaTeX = "/Library/TeX/texbin/pdflatex";

$Ghostscript = "/usr/local/bin/gs";

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
