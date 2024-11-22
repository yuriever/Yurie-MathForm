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


$indexPositionP::usage =
    "pattern of index positions.";

$indexTypeP::usage =
    "pattern of index types.";

$leftBracketP::usage =
    "pattern of left bracket.";

$rightBracketP::usage =
    "pattern of right bracket.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


$macroLeftDelimiter = "MFLEFT";

$macroRightDelimiter = "MFRIGHT";

$macroListSeparator = "MFLISTSEP";


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


$indexPositionP =
    Construct|Subscript|Superscript;

$indexTypeP =
    All|"PositiveInteger"|"PositiveIntegerOrSingleLetter"|_Symbol;


$leftBracketP = "("|"["|"\\{"|"\\left("|"\\left["|"\\left\\{"|"{";

$rightBracketP = ")"|"]"|"\\}"|"\\right)"|"\\right]"|"\\right\\}"|"}";


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
