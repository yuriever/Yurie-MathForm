(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`Variable`"];


(*clear the state-dependent definitions.*)
ClearAll["`*"];


(* ::Section:: *)
(*Public*)


$MFAssoc::usage =
    "association of predefined rules.";


$MFRule::usage =
    "list of predefined rules derived from $MFAssoc.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


$MFAssoc = <||>;


$MFRule = {};


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
