(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`Library`"];


Needs["Yurie`MathForm`Info`"];


(* ::Section:: *)
(*Public*)


prepareLibrary::usage =
    "prepare the library.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Message*)


prepareLibrary::texfmtfailed =
    "the library tex-fmt fails to download."


(* ::Subsection:: *)
(*Main*)


prepareLibrary["tex-fmt"] :=
    WithCleanup[
        If[ !DirectoryQ[$thisLibraryDir],
            CreateDirectory[$thisLibraryDir]
        ],
        (**)
        ExtractArchive[
            URL["https://github.com/WGUNDERWOOD/tex-fmt/releases/latest/download/tex-fmt-aarch64-macos.tar.gz"],
            $thisLibraryDir,
            OverwriteTarget->True
        ];
        ,
        (**)
        If[ !FileExistsQ@FileNameJoin[$thisLibraryDir,"tex-fmt"],
            Message[prepareLibrary::texfmtfailed]
        ]
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
