(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MF`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Constant`"];

Needs["Yurie`MathForm`Variable`"];

Needs["Lacia`Base`"];

ClearAll[MFString];


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


MFString//Options = {
    "RemoveLeftRightPair"->True,
    "BreakPlusTimes"->True,
    "BreakPlusTimesThreshold"->10
};

MFCopy//Options = {
    Splice@Options@MFString
};

MFKernel//Options = {
    "Preamble"->{"\\usepackage{amsmath,amssymb}"},
    "FontSize"->12,
    "LineSpacing"->{1.2,0},
    "Magnification"->1.5
};

MF//Options = {
    Splice@Options@MFKernel,
    Splice@Options@MFString,
    "CopyToClipboard"->True,
    "ClearCache"->False,
    "Listable"->True
};


MF::LaTeXFailed=
    "LaTeX compilation failed, please check the LaTeX file below.";

MF::PDFFailed=
    "PDF import failed, please check the LaTeX file below.";


(* ::Subsection:: *)
(*MFString*)


(* ::Subsubsection:: *)
(*Main*)


MFString[expr_,OptionsPattern[]] :=
    Module[ {string},
        string =
            If[ Head[expr]===String,
                expr,
                (*Else*)
                expr//ifBreakPlusTimes[OptionValue["BreakPlusTimes"],OptionValue["BreakPlusTimesThreshold"]]//
                    TeXForm//ToString//deleteBlankOfScript//
                        ifRemoveLeftRight[OptionValue["RemoveLeftRightPair"]]
            ];
        string//StringReplace[$MFRule]//
            ifBreakPlusTimes[OptionValue["BreakPlusTimes"]]//
		        trimEmptyLine
    ];


(* ::Subsubsection:: *)
(*Helper*)


deleteBlankOfScript[string_String] :=
    string//StringReplace[{
        " _"->"_"," ^"->"^"
    }];


ifRemoveLeftRight[True][string_String] :=
    string//StringReplace[{
        "\\left"->"","\\right"->""
    }];

ifRemoveLeftRight[False][string_String] :=
    string;


ifBreakPlusTimes[True,threshold_Integer][expr_] :=
    Replace[
        expr,
        {
            product_Times/;leafCount[product]>=threshold:>Apply[$breakTimes,product],
            sum_Plus/;leafCount[sum]>=threshold:>Apply[$breakPlus,sum]
        },
        All
    ];

ifBreakPlusTimes[True][string_String] :=
    string//StringReplace[{
        "\\text{MFPlusLeft}"->"\n",
        "\\text{MFPlusSep}"->"\n+\n",
        "\\text{MFPlusRight}"->"\n",
        "\\text{MFTimesLeft}"->"\n",
        "\\text{MFTimesSep}"->"\n",
        "\\text{MFTimesRight}"->"\n"
    }]//StringReplace[{
        "+"~~spacing:WhitespaceCharacter...~~"-":>"-"<>spacing
    }];

ifBreakPlusTimes[False] :=
    Identity;


leafCount[_Symbol|_Integer|_String|_$breakTimes|_$breakPlus] :=
    1;

leafCount[_Symbol[_Symbol|_Integer|_String]] :=
    1;

leafCount[expr_] :=
    If[ Length[expr]===0,
        0,
        (*Else*)
        Plus@@leafCount/@List@@expr
    ]+leafCount[Head[expr]];


trimEmptyLine[string_String] :=
    string//StringReplace[RegularExpression["(?m)^\\s*$\\n?"]->""]//StringTrim;


(* ::Subsection:: *)
(*MFCopy*)


MFCopy[expr_,opts:OptionsPattern[]] :=
    (
        CopyToClipboard@MFString[expr,FilterRules[{opts,Options@MFCopy},Options@MFString]];
        expr
    );


(* ::Subsection:: *)
(*MF*)


(* ::Subsubsection:: *)
(*Main*)


MF[expr_,opts:OptionsPattern[]] :=
    Module[ {string,fopts1,fopts2},
        fopts1 =
            FilterRules[{opts,Options@MF},Options@MFKernel];
        fopts2 =
            FilterRules[{opts,Options@MF},Options@MFString];
        string =
            MFString[expr,fopts2];
        If[ OptionValue["CopyToClipboard"],
            CopyToClipboard@string
        ];
        If[ OptionValue["ClearCache"],
            DeleteDirectory[$temporaryDir,DeleteContents->True]
        ];
        (*If the expression is a list, and the option Listable is True, then LaTeXify each element of the list separately.*)
        (*Otherwise, treat the list head as part of the LaTeX.*)
        If[ OptionValue["Listable"]&&Head[expr]===List,
            MFKernel[
                Map[MFString[#,fopts2]&,expr],
                fopts1
            ],
            (*Else*)
            MFKernel[string,fopts1]
        ]//Catch
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
    Module[ {info},
	    info=
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
            Throw@File@FileNameJoin[$temporaryDir,id<>".tex"],
            (*Else*)
            pdf
        ]
    ];


importPDF[id_] :=
    Module[ {pdf},
        pdf = Quiet@Import[FileNameJoin[$temporaryDir,id<>".pdf"],"PageGraphics"];
        If[ FailureQ[pdf],
            Message[MF::PDFFailed];
            Throw@File@FileNameJoin[$temporaryDir,id<>".tex"],
            (*Else*)
            pdf
        ]
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
