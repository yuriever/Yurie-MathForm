(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`Info`"];


(* ::Section:: *)
(*Public*)


$thisPacletDir::usage =
    "directory of paclet.";

$thisKernelDir::usage =
    "directory of kernel.";

$thisTestDir::usage =
    "directory of unit test.";

$thisTestSourceDir::usage =
    "directory of source notebook for unit test.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


$thisPaclet =
    PacletObject["Yurie/MathForm"];

$thisPacletDir =
    $thisPaclet["Location"];

$thisKernelDir =
    FileNameJoin@{$thisPacletDir,"Kernel"};

$thisTestDir =
    $thisPaclet["AssetLocation","Test"];

$thisTestSourceDir =
    $thisPaclet["AssetLocation","TestSource"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
