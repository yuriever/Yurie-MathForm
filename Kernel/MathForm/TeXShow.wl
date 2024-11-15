(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`TeXShow`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Constant`"];

Needs["Yurie`MathForm`Variable`"];


(* ::Section:: *)
(*Public*)


texForm::usage =
    "refine the string from TeXForm.";

texCopy::usage =
    "copy the string from texForm and return the expression.";

texShow::usage =
    "show the LaTeX of the expression.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Option*)


texForm//Options = {};

texShowKernel//Options = {
    "Preamble"->{"\\usepackage{amsmath,amssymb}"},
    "FontSize"->12,
    "LineSpacing"->{1.2,0},
    "Magnification"->1.5
};

texShow//Options = {
    Splice@Options@texShowKernel,
    "CopyToClipboard"->True,
    "ClearCache"->False,
    "Listable"->True
};


(* ::Subsection:: *)
(*texForm*)


texForm[expr_] :=
    Module[ {string},
        string =
            If[ Head[expr]===String,
                expr,
                (*Else*)
                expr//TeXForm//ToString
            ];
        string//StringReplace[$texRule]
    ];


(* ::Subsection:: *)
(*texCopy*)


texCopy[expr_] :=
    (
        CopyToClipboard@texForm@expr;
        expr
    );


(* ::Subsection:: *)
(*texShow*)


(* ::Subsubsection:: *)
(*Main*)


texShow[expr_,opts:OptionsPattern[]] :=
    Module[ {string},
        string = texForm[expr];
        If[ OptionValue["CopyToClipboard"],
            CopyToClipboard@string
        ];
        If[ OptionValue["ClearCache"],
            DeleteDirectory[$temporaryDir,DeleteContents->True]
        ];
        (*if the expression is a list, and the option Listable is True, then texify the expr directly.*)
        If[ OptionValue["Listable"]&&Head[expr]===List,
            texShowKernel[Map[texForm,expr],FilterRules[{opts,Options@texShow},Options@texShowKernel]],
            (*Else*)
            texShowKernel[string,FilterRules[{opts,Options@texShow},Options@texShowKernel]]
        ]
    ];


texShowKernel[string_String,OptionsPattern[]] :=
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

texShowKernel[{},OptionsPattern[]]:=
    {};

texShowKernel[stringList:{__String},OptionsPattern[]] :=
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
