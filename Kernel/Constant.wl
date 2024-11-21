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


$breakPlus::usage =
    "head of Plus used by the MFString option BreakPlusTimes.";

$breakTimes::usage =
    "head of Times used by the MFString option BreakPlusTimes.";


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


$breakPlus/:MakeBoxes[$breakPlus[arg___],TraditionalForm]:=
    RowBox@{
        "MFPlusLeft",
        Sequence@@Riffle[Map[MakeBoxes[#,TraditionalForm]&,{arg}],"MFPlusSep"],
        "MFPlusRight"
    };


$breakTimes/:MakeBoxes[$breakTimes[arg___],TraditionalForm]:=
    RowBox@{
        "MFTimesLeft",
        Sequence@@Riffle[Map[MakeBoxes[#,TraditionalForm]&,{arg}],"MFTimesSep"],
        "MFTimesRight"
    };

$breakTimes/:MakeBoxes[$breakTimes[-1,arg___],TraditionalForm]:=
    RowBox@{
        "MFTimesLeft",
        "-",
        Sequence@@Riffle[Map[MakeBoxes[#,TraditionalForm]&,{arg}],"MFTimesSep"],
        "MFTimesRight"
    };


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
