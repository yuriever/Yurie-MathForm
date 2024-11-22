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


MFString//Options = {
    "RemoveLeftRightPair"->True,
    "Linebreak"->True,
    "LinebreakThreshold"->12,
    "LinebreakIgnore"->{}
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


(* ::Subsection:: *)
(*Message*)


MF::LaTeXFailed =
    "LaTeX compilation failed, please check the LaTeX file below.";

MF::PDFFailed =
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
                expr//ifBreakPlusTimes[OptionValue["Linebreak"],OptionValue["LinebreakThreshold"],OptionValue["LinebreakIgnore"]]//
                    TeXForm//ToString//
		                ifRemoveLeftRight[OptionValue["RemoveLeftRightPair"]]//
		                    ifBreakPlusTimes[OptionValue["Linebreak"]]//
			                    StringReplace[$MFRule]//
			                        deleteBlankBeforeScript//trimEmptyLine
            ]
    ];


(* ::Subsubsection:: *)
(*Helper*)


ifBreakPlusTimes[True,threshold_Integer,ignoredList_List][expr_] :=
    Replace[
        expr,
        {
            HoldPattern[product_Times]/;leafCount[ignoredList][product]>=threshold:>
                Apply[breakTimes,product],
            HoldPattern[sum_Plus]/;leafCount[ignoredList][sum]>=threshold:>
                Apply[breakPlus,sum]
        },
        All
    ];

ifBreakPlusTimes[True][string_String] :=
    string//StringReplace[{
        "\\text{MFTimesLeft}"->"\n",
        "\\text{MFTimesRight}"->"\n",
        "\\text{MFPlusSep}"->"\n+",
        "\\text{MFPlusMinusSep}"->"\n-",
        "\\text{MFTimesSep}"->"\n"
    }]//FixedPoint[
        StringReplace[{
            left:$leftBracketP~~WhitespaceCharacter...~~"\\text{MFPlusLeft}"~~Shortest[content__]~~"\\text{MFPlusRight}"~~WhitespaceCharacter...~~right:$rightBracketP/;braketPairQ[left,right]&&!StringContainsQ[content,"\\text{MFPlusLeft}"]:>
                left~~"\n"~~content~~"\n"~~right
        }],
        #
    ]&//StringReplace[{
        "\\text{MFPlusLeft}"->"(\n",
        "\\text{MFPlusRight}"->"\n)"
    }]//StringReplace[{
        "+"~~WhitespaceCharacter...~~"-"~~WhitespaceCharacter...~~succ:WordCharacter|PunctuationCharacter:>"-"~~succ,
        "-"~~WhitespaceCharacter...~~succ:WordCharacter|PunctuationCharacter:>"-"~~succ
    }];

ifBreakPlusTimes[False,___] :=
    Identity;


leafCount[_][_breakTimes|_breakPlus|_Symbol|_Integer|_String|_Subscript|_Superscript|_Subsuperscript|(_Symbol[_Symbol|_Integer|_String])] :=
    1;

leafCount[ignoredList_][expr_]/;AnyTrue[ignoredList,MatchQ[expr,#]&] :=
    1;

leafCount[ignoredList_][expr_] :=
    If[ Length[expr]===0,
        0,
        (*Else*)
        Plus@@leafCount[ignoredList]/@List@@expr
    ]+leafCount[ignoredList][Head[expr]];

leafCount[ignoredList_][HoldPattern[Times[-1,rest__]]] :=
    leafCount[ignoredList][Times[rest]];


braketPairQ["(",")"] :=
    True;

braketPairQ["[","]"] :=
    True;

braketPairQ["\\{","\\}"] :=
    True;

braketPairQ["\\left(","\\right)"] :=
    True;

braketPairQ["\\left[","\\right]"] :=
    True;

braketPairQ["\\left\\{","\\right\\}"] :=
    True;

braketPairQ["{","}"] :=
    True;


breakPlus//Attributes =
    {Flat,Orderless,HoldAllComplete};

breakPlus/:MakeBoxes[breakPlus[args___],TraditionalForm]:=
    Module[ {signedList},
        signedList =
            Map[
                If[ MatchQ[#,Times[-1,___]],
                    {"MFPlusMinusSep",boxPlusSignedTerm[-#]},
                    {"MFPlusSep",boxPlusTerm[#]}
                ]&,
                {args}
            ]//Flatten//dropFirstPlus;
        RowBox@{
            "MFPlusLeft",
            Sequence@@signedList,
            "MFPlusRight"
        }
    ];


boxPlusSignedTerm//Attributes =
    {HoldAllComplete};

boxPlusSignedTerm[HoldPattern[-Times[-1,rest___]]] :=
    MakeBoxes[Times[rest],TraditionalForm];

boxPlusSignedTerm[HoldPattern[-Times[-1,rest_]]] :=
    MakeBoxes[rest,TraditionalForm];


boxPlusTerm//Attributes =
    {HoldAllComplete};

boxPlusTerm[expr_] :=
    MakeBoxes[expr,TraditionalForm];


dropFirstPlus[{"MFPlusSep",rest__}] :=
    {rest};


breakTimes//Attributes =
    {Flat,Orderless,HoldAllComplete};

breakTimes/:MakeBoxes[breakTimes[args___],TraditionalForm]:=
    Module[ {args1,num,denom},
        args1 =
            Map[
                If[ Head[#]===Plus,
                    boxPlusInTimes[#],
                    #
                ]&,
                {args}
            ];
        denom =
            Cases[args1,Power[base_,-1]:>MakeBoxes[base,TraditionalForm]]//trimMinusOne;
        num =
            Cases[args1,factor:Except[Power[_,-1]]:>MakeBoxes[factor,TraditionalForm]]//trimMinusOne;
        If[ denom==={},
            boxTimes[num],
            (*Else*)
            FractionBox[boxTimes[num],boxTimes[denom]]
        ]
    ];


boxPlusInTimes/:MakeBoxes[boxPlusInTimes[arg_],TraditionalForm]:=
    RowBox@{"MFPlusLeft",MakeBoxes[arg,TraditionalForm],"MFPlusRight"};


trimMinusOne[factorList_List] :=
    If[ Length[factorList]>=2&&factorList[[1]]===RowBox[{"-", "1"}],
        Join[{"-"},Rest@factorList],
        (*Else*)
        factorList
    ];


boxTimes[factorList_] :=
    RowBox@{
        "MFTimesLeft",
        Sequence@@Riffle[factorList,"MFTimesSep"],
        "MFTimesRight"
    };


ifRemoveLeftRight[True][string_String] :=
    string//StringReplace[{
        "\\left"->"","\\right"->""
    }];

ifRemoveLeftRight[False][string_String] :=
    string;


deleteBlankBeforeScript[string_String] :=
    string//StringReplace[{
        " _"->"_"," ^"->"^"
    }];


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
            Quiet@DeleteDirectory[$temporaryDir,DeleteContents->True]
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
