(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MF`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Constant`"];

Needs["Yurie`MathForm`Variable`"];


(* ::Section:: *)
(*Public*)


MFString::usage =
    "refine the string from TeXForm.";

MFCopy::usage =
    "copy the string from MFString and return the original expression.";

MF::usage =
    "show the LaTeX of the expression.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Option*)


MFString//Options = {};

MFKernel//Options = {
    "Preamble"->{"\\usepackage{amsmath,amssymb}"},
    "FontSize"->12,
    "LineSpacing"->{1.2,0},
    "Magnification"->1.5
};

MF//Options = {
    Splice@Options@MFKernel,
    "CopyToClipboard"->True,
    "ClearCache"->False,
    "Listable"->True
};


(* ::Subsection:: *)
(*texForm*)


(* ::Subsubsection:: *)
(*Main*)


MFString[expr_] :=
    Module[ {string},
        string =
            If[ Head[expr]===String,
                expr,
                (*Else*)
                expr//TeXForm//ToString//texTrim
            ];
        string//StringReplace[$MFRule]
    ];


(* ::Subsubsection:: *)
(*Helper*)


texTrim[string_String] :=
    string//StringReplace[{
        " _"->"_"," ^"->"^","\\left"->"","\\right"->""
    }];


(* ::Subsection:: *)
(*texCopy*)


MFCopy[expr_] :=
    (
        CopyToClipboard@MFString@expr;
        expr
    );


(* ::Subsection:: *)
(*texShow*)


(* ::Subsubsection:: *)
(*Main*)


MF[expr_,opts:OptionsPattern[]] :=
    Module[ {string},
        string = MFString[expr];
        If[ OptionValue["CopyToClipboard"],
            CopyToClipboard@string
        ];
        If[ OptionValue["ClearCache"],
            DeleteDirectory[$temporaryDir,DeleteContents->True]
        ];
        (*if the expression is a list, and the option Listable is True, then texify the expr directly.*)
        If[ OptionValue["Listable"]&&Head[expr]===List,
            MFKernel[Map[MFString,expr],FilterRules[{opts,Options@MF},Options@MFKernel]],
            (*Else*)
            MFKernel[string,FilterRules[{opts,Options@MF},Options@MFKernel]]
        ]
    ];


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

MFKernel[{},OptionsPattern[]] :=
    {};

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


(* ::Subsubsection:: *)
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
    RunProcess[
        {
            $pdfLaTeX,
            "-halt-on-error",
            "-interaction=nonstopmode",
            id<>".tex"
        },
        ProcessDirectory->$temporaryDir
    ];


importPDF[id_] :=
    Import[FileNameJoin[$temporaryDir,id<>".pdf"],"PageGraphics"];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
