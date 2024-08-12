(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`Variable`"];


(*clear the state-dependent definitions.*)
ClearAll["`*"];


(* ::Section:: *)
(*Public*)


$texAssoc::usage =
    "association of predefined rules.";


$texRule::usage =
    "list of predefined rules derived from $texAssoc.";


$macroLeftDelimiter::usage =
    "left delimiter.";

$macroRightDelimiter::usage =
    "right delimiter.";

$macroListSeparator::usage =
    "list separator.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


$texAssoc = <||>;


(*$texRule can be made static for efficiency, and the update should be triggered by texSetMacro.*)

$texRule :=
    $texAssoc//Values//Flatten;


$macroLeftDelimiter = "Left";

$macroRightDelimiter = "Right";

$macroListSeparator = "ListSep";


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
