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

$texfmt::usage =
    "path of texfmt.";

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


$indexPositionP =
    Construct|Subscript|Superscript;

$indexTypeP =
    All|"PositiveInteger"|"PositiveIntegerOrSingleLetter"|_Symbol;


$leftBracketP = "("|"["|"\\{"|"\\left("|"\\left["|"\\left\\{"|"{"|StartOfString;

$rightBracketP = ")"|"]"|"\\}"|"\\right)"|"\\right]"|"\\right\\}"|"}"|EndOfString;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
