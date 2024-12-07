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

$leftSeparatorP::usage =
    "pattern of left separator.";

$rightSeparatorP::usage =
    "pattern of right separator.";


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
    "PositiveInteger"|"PositiveIntegerOrSingleLetter"|"PositiveIntegerOrGreekLetter"|
    "NaturalNumber"|"NaturalNumberOrSingleLetter"|"NaturalNumberOrGreekLetter"|
    All|_Symbol;


$leftBracketP = "("|"["|"\\{"|"\\left("|"\\left["|"\\left\\{"|"{"|StartOfString;

$rightBracketP = ")"|"]"|"\\}"|"\\right)"|"\\right]"|"\\right\\}"|"}"|EndOfString;

$leftSeparatorP = "("|"["|"{"|","|";"|"."|StartOfString;

$rightSeparatorP = ")"|"]"|"}"|","|";"|"."|EndOfString;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
