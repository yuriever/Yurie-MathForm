(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MF`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Constant`"];

Needs["Yurie`MathForm`Variable`"];

Needs["Yurie`MathForm`MFString`"];


(* ::Section:: *)
(*Public*)


MF::usage =
    "show the LaTeX of the expression.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Option*)


MFKernel//Options = {
    "Preamble"->{},
    "FontSize"->12,
    "LineSpacing"->{1.2,0},
    "Magnification"->1.5
};

MF//Options = {
    Splice@Options@MFKernel,
    Splice@Options@MFStringKernel,
    "CopyToClipboard"->True,
    "ClearCache"->False,
    "Listable"->True
};


(* ::Subsection:: *)
(*Message*)


MF::LaTeXFailed =
    "LaTeX compilation failed, please check the LaTeX file below.";

MF::PDFFailed =
    "PDF import failed, please check the LaTeX file below.";


(* ::Subsection:: *)
(*Main*)


MF[expr_,opts:OptionsPattern[]] :=
    Module[ {string,fopts1,fopts2},
        fopts1 =
            FilterRules[{opts,Options@MF},Options@MFKernel];
        fopts2 =
            FilterRules[{opts,Options@MF},Options@MFStringKernel];
        string =
            MFStringKernel[expr,fopts2];
        If[ OptionValue["CopyToClipboard"],
            string//MFFormatKernel//CopyToClipboard
        ];
        If[ OptionValue["ClearCache"],
            Quiet@DeleteDirectory[$temporaryDir,DeleteContents->True]
        ];
        (*If the expression is a list, and the option Listable is True, then LaTeXify each element of the list separately.*)
        (*Otherwise, treat the list head as part of the LaTeX.*)
        If[ OptionValue["Listable"]&&Head[expr]===List,
            MFKernel[
                Map[MFStringKernel[#,fopts2]&,expr],
                fopts1
            ],
            (*Else*)
            MFKernel[string,fopts1]
        ]
    ]//Catch;


MFKernel[string_String,OptionsPattern[]] :=
    Module[ {id,texData},
        texData = {
            string,
            OptionValue["Preamble"],
            OptionValue["FontSize"],
            OptionValue["LineSpacing"]
        };
        id = {
            DateString["ISODate"],
            ToString@Hash[texData],
            "Single"
        }//StringRiffle[#,"-"]&;
        (*look up cache.*)
        If[ Not@FileExistsQ@FileNameJoin[$temporaryDir,id<>".pdf"],
            exportTexFile[id,False]@@texData;
            generatePDF[id]
        ];
        importPDF[id]//First//Magnify[#,OptionValue["Magnification"]]&
    ];

MFKernel[stringList:{__String},OptionsPattern[]] :=
    Module[ {id,texData},
        texData = {
            stringList,
            OptionValue["Preamble"],
            OptionValue["FontSize"],
            OptionValue["LineSpacing"]
        };
        id = {
            DateString["ISODate"],
            ToString@Hash[texData],
            "Multiple"
        }//StringRiffle[#,"-"]&;
        If[ Not@FileExistsQ@FileNameJoin[$temporaryDir,id<>".pdf"],
            exportTexFile[id,True]@@texData;
            generatePDF[id]
        ];
        importPDF[id]//Map[Magnify[#,OptionValue["Magnification"]]&]
    ];

MFKernel[{},OptionsPattern[]] :=
    {};


(* ::Subsection:: *)
(*Helper*)


exportTexFile[id_String,listable_?BooleanQ][stringOrItsList_,preambleList_List,fontsize_Integer,lineSpacing:{_,_}] :=
    Export[
        FileNameJoin[$temporaryDir,id<>".tex"],
        $texTemplate@<|
            "Preamble"->StringRiffle[preambleList,"\n"],
            "Document"->
                If[ listable,
                    StringRiffle[Map[StringTemplate["\\YurieMathForm{``}"],stringOrItsList],"\n"],
                    (*Else*)
                    StringTemplate["\\YurieMathForm{``}"][stringOrItsList]
                ],
            "FontSize"->fontsize,
            "SkipSize"->lineSpacing[[1]]*fontsize+lineSpacing[[2]]
        |>,
        "Text",
        CharacterEncoding->"UTF-8"
    ];


generatePDF[id_] :=
    Module[ {info},
        info =
            RunProcess[
                {
                    $pdfLaTeX,
                    "-halt-on-error",
                    "-interaction=nonstopmode",
                    id<>".tex"
                },
                ProcessDirectory->$temporaryDir
            ];
        If[ info["ExitCode"]===1,
            Message[MF::LaTeXFailed];
            Throw@File@FileNameJoin[$temporaryDir,id<>".tex"]
        ]
    ];


importPDF[id_] :=
    Module[ {pdf},
        pdf = Quiet@Import[FileNameJoin[$temporaryDir,id<>".pdf"],"PageGraphics"];
        (* pdf = Quiet@Import[FileNameJoin[$temporaryDir,id<>".pdf"],"PageImages",ImageResolution->1024]; *)
        If[ FailureQ[pdf],
            Message[MF::PDFFailed];
            Throw@File@FileNameJoin[$temporaryDir,id<>".tex"],
            (*Else*)
            pdf
        ]
    ];


getImageSizeFromLog[log_String] :=
    ToExpression@StringCases[log,RegularExpression["YurieMathFormSizeBegin,(.+?)pt,(.+?)pt,(.+?)pt,YurieMathFormSizeEnd"]->{"$1","$2","$3"}];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
