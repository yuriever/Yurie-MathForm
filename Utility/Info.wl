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

$thisSourceDir::usage =
    "directory of source.";

$thisTestDir::usage =
    "directory of unit test.";

$thisSandboxDir::usage =
    "directory of sandbox for AI-generation.";

$thisTestSourceDir::usage =
    "directory of source notebook for unit test.";

$thisCompletionDir::usage =
    "directory of auto completion data.";

$thisLibraryDir::usage =
    "directory of library.";


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

$thisSourceDir =
    $thisPaclet["AssetLocation","Source"];

$thisTestDir =
    $thisPaclet["AssetLocation","Test"];

$thisSandboxDir =
    $thisPaclet["AssetLocation","Sandbox"];

$thisTestSourceDir =
    $thisPaclet["AssetLocation","TestSource"];

$thisCompletionDir =
    FileNameJoin@{$thisPaclet["Location"],"AutoCompletionData"};

$thisLibraryDir =
    FileNameJoin@{$thisPaclet["AssetLocation","Library"],$SystemID};


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
