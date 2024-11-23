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
    "LinebreakThreshold"->5,
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


MFString[string_String,OptionsPattern[]] :=
    string;

MFString[expr_,OptionsPattern[]] :=
    ifBreakPlusTimes[expr,OptionValue["Linebreak"],OptionValue["LinebreakThreshold"],OptionValue["LinebreakIgnore"]]//
        TeXForm//ToString//
            ifRemoveLeftRight[OptionValue["RemoveLeftRightPair"]]//
                ifBreakPlusTimes2[OptionValue["Linebreak"]]//
                    StringReplace[$MFRule]//
                        deleteBlankBeforeScript//trimEmptyLine;


(* ::Subsubsection:: *)
(*Helper*)


ifBreakPlusTimes//Attributes = {
    HoldFirst
};

ifBreakPlusTimes[expr_,True,threshold_Integer,ignoredList_List] :=
    HoldComplete[expr]//
        Replace[#,
            HoldPattern[(head:Times|Plus)[args__]]/;
                AnyTrue[HoldComplete[args],Function[expr1,leafCount[ignoredList,expr1]>=threshold,HoldAllComplete]]:>
                    RuleCondition@Replace[
                        Hold[head,Evaluate["MFLeft"<>ToString[head]],args,Evaluate["MFRight"<>ToString[head]]],
                        arg_/;leafCount[ignoredList,arg]>=threshold:>
                            Sequence["MFLinebreak",arg,"MFLinebreak"],
                        {1}
                    ],
            All
        ]&//
            Replace[#,Hold[head_,args__]:>Construct[HoldForm@*head,args],All]&//
                ReleaseHold;

ifBreakPlusTimes[expr_,False,___] :=
    expr;


ifBreakPlusTimes2[True][string_String] :=
    string//StringReplace[{
        "\\text{MFLeftTimes} (-1) \\text{MFLinebreak}"->"\n-\n",
        "\\text{MFLinebreak}"->"\n",
        "\\text{MFLeftTimes}"->"\n",
        "\\text{MFRightTimes}"->"\n"
    }]//FixedPoint[
        StringReplace[{
            (*The left and right separators are removed if in another bracket pair.*)
            left:$leftBracketP~~WhitespaceCharacter...~~"\\text{MFLeftPlus}"~~Shortest[content__]~~"\\text{MFRightPlus}"~~WhitespaceCharacter...~~right:$rightBracketP/;
                braketPairQ[left,right]&&!StringContainsQ[content,"\\text{MFLeftPlus}"]:>
                    left~~"\n"~~content~~"\n"~~right
        }],
        #
    ]&//FixedPoint[
        StringReplace[{
            (*This is to remove the bracket pair autogenerated by TeXForm.*)
            left:$leftBracketP~~WhitespaceCharacter...~~"("~~Shortest[content__]~~")"~~WhitespaceCharacter...~~right:$rightBracketP/;
                braketPairQ[left,right]&&!StringContainsQ[content,"("]:>
                    left~~"\n"~~content~~"\n"~~right
        }],
        #
    ]&//FixedPoint[
        StringReplace[{
            (*Remove the double signs from MFLinebreak: ++ -> +, +- -> -*)
            "+"~~spacing:WhitespaceCharacter...~~sign:"+"|"-":>spacing~~sign
        }],
        #
    ]&//StringReplace[{
        (*Remove the plus signs at the begining/ending: {+ -> {, +} -> }*)
        prec:$leftBracketP~~spacing:WhitespaceCharacter...~~"+":>prec~~spacing,
        "+"~~spacing:WhitespaceCharacter...~~succ:$rightBracketP:>spacing~~succ
        (* "+"~~WhitespaceCharacter...~~"(-1)":>"-" *)
    }];

ifBreakPlusTimes2[False][string_String] :=
    string;


leafCount//Attributes =
    {HoldAllComplete};

leafCount[_,_Symbol|_Integer|_String] :=
    1;

leafCount[ignoredList_,HoldPattern[Times[-1,rest__]]] :=
    leafCount[ignoredList,Times[rest]];

leafCount[ignoredList_,expr_] :=
    With[ {head = Head@Unevaluated@expr},
        Which[
            Length@Unevaluated@expr===0,
                0,
            AnyTrue[
                Map[HoldPattern,Unevaluated[ignoredList]],
                MatchQ[HoldComplete[expr],HoldComplete[#]]&
            ],
                0,
            True,
                HoldComplete[expr]//ReplaceAll[{HoldComplete[_[args__]]:>HoldComplete[args]}]//
                    Map[Function[expr1,leafCount[ignoredList,expr1],{HoldAllComplete}]]//Apply[Plus]
        ]+leafCount[ignoredList,head]
    ];


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

(*StartOfString and EndOfString will be evalueated as empty strings.*)
braketPairQ["",""] :=
    True;

braketPairQ[__] :=
    False;


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
