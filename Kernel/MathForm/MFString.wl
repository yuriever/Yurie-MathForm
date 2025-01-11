(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MFString`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Constant`"];

Needs["Yurie`MathForm`Variable`"];


(* ::Section:: *)
(*Public*)


MFString::usage =
    "refine the string from TeXForm.";

MFCopy::usage =
    "copy the string from MFString and return the original expression.";


MFStringKernel;

MFFormatKernel;


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Option*)


MFStringKernel//Options = {
    "RemoveLeftRightPair"->True,
    "Linebreak"->True,
    "LinebreakThreshold"->6,
    "LinebreakIgnore"->{}
};

MFString//Options =
    Options@MFStringKernel;

MFCopy//Options =
    Options@MFStringKernel;


(* ::Subsection:: *)
(*Message*)


(* ::Subsection:: *)
(*Main*)


MFString[expr_,opts:OptionsPattern[]] :=
    MFStringKernel[expr,FilterRules[{opts,Options@MFString},Options@MFStringKernel]]//
        MFFormatKernel//Catch;

MFCopy[expr_,opts:OptionsPattern[]] :=
    (
        MFStringKernel[expr,FilterRules[{opts,Options@MFCopy},Options@MFStringKernel]]//
            MFFormatKernel//CopyToClipboard//Catch;
        expr
    );


MFStringKernel[string_String,OptionsPattern[]] :=
    string;

MFStringKernel[expr_,OptionsPattern[]] :=
    ifBreakPlusTimes[expr,OptionValue["Linebreak"],OptionValue["LinebreakThreshold"],OptionValue["LinebreakIgnore"]]//
        TeXForm//ToString//
            (* Remove pairs of brackets before calling $MFRule. *)
            ifRemoveLeftRight[OptionValue["RemoveLeftRightPair"]]//
                StringReplace[$MFRule]//
                    ifBreakPlusTimes2[OptionValue["Linebreak"]]//
                        deleteBlankBeforeScript//trimEmptyLine;


MFFormatKernel[string_String] :=
    Module[ {res},
        res = RunProcess[{$texfmt,"--nowrap","--tabsize","4","--stdin"},"StandardOutput",string];
        If[ Head[res]=!=String,
            Throw[res],
            (*Else*)
            res//StringTrim
        ]
    ];


(* ::Subsection:: *)
(*Helper*)


ifBreakPlusTimes//Attributes = {
    HoldFirst
};

brokenPlusTimes//Attributes = {
    HoldAll
};

ifBreakPlusTimes[expr_,True,threshold_Integer,ignoredList_List] :=
    HoldComplete[expr]//
        Replace[#,
            HoldPattern[(head:Times|Plus)[args__]]/;
                AnyTrue[HoldComplete[args],Function[arg,leafCount[ignoredList,arg]>=threshold,HoldAllComplete]]:>
                    RuleCondition@Replace[
                        brokenPlusTimes[head,Evaluate["MF"<>ToString[head]<>"Left"],args,Evaluate["MF"<>ToString[head]<>"Right"]],
                        arg_/;leafCount[ignoredList,arg]>=threshold:>
                            Sequence["MFLinebreak",arg,"MFLinebreak"],
                        {1}
                    ],
            All
        ]&//
            Replace[#,{
                brokenPlusTimes[Times,"MFTimesLeft",coefficient_?NumberQ,rest___]:>
                    brokenPlusTimes[Times,"MFTimesLeft","MFNumberLeft",HoldForm[coefficient],"MFNumberRight",rest]
            },All]&//
                Replace[#,{
                    brokenPlusTimes[head_,args__]:>HoldForm@head[args]
                },All]&//
                    ReleaseHold;

ifBreakPlusTimes[expr_,False,___] :=
    expr;


ifBreakPlusTimes2[True][string_String] :=
    string//StringReplace[{
        "\\text{MFNumberLeft} (-1) \\text{MFNumberRight}":>"-",
        "\\text{MFNumberLeft} ("~~Shortest[num__]~~") \\text{MFNumberRight}":>num,
        "\\text{MFNumberLeft} "~~Shortest[num__]~~" \\text{MFNumberRight}":>num
    }]//StringReplace[{
        "\\text{MFLinebreak}"->"\n",
        "\\text{MFTimesLeft}"->"\n",
        "\\text{MFTimesRight}"->"\n",
        "\\text{MFPlusLeft}"->"\n",
        "\\text{MFPlusRight}"->"\n"
    }]//FixedPoint[
        StringReplace[{
            (* This is to remove the bracket pair autogenerated by TeXForm. *)
            left:$leftBracketP~~WhitespaceCharacter...~~"("~~Shortest[content__]~~")"~~WhitespaceCharacter...~~right:$rightBracketP/;
                braketPairQ[left,right]&&!StringContainsQ[content,"("]:>
                    left~~"\n"~~content~~"\n"~~right
        }],
        #
    ]&//FixedPoint[
        StringReplace[{
            (* Remove the double signs from MFLinebreak: ++ -> +, +- -> - *)
            "+"~~spacing:WhitespaceCharacter...~~sign:"+"|"-":>spacing~~sign
        }],
        #
    ]&//FixedPoint[
        StringReplace[{
            (* Remove the plus signs at the begining/ending: {+ -> {, +} -> } *)
            prec:$leftSeparatorP~~spacing:WhitespaceCharacter...~~"+":>prec~~spacing,
            "+"~~spacing:WhitespaceCharacter...~~succ:$rightSeparatorP:>spacing~~succ,
            (* Remove the extra whitespaces. *)
            StartOfLine~~WhitespaceCharacter...~~sign:"+"|"-"~~WhitespaceCharacter...~~succ:Except[WhitespaceCharacter]:>sign~~succ
        }],
        #
    ]&;

ifBreakPlusTimes2[False][string_String] :=
    string;


leafCount//Attributes =
    {HoldAllComplete};

leafCount[_,_Symbol|_String|_Integer|_Rational|_Real|_Complex] :=
    1;

leafCount[ignoredList_,HoldPattern[Times[-1,expr_]]] :=
    leafCount[ignoredList,expr];

leafCount[ignoredList_,HoldPattern[Power[expr_,-1]]] :=
    leafCount[ignoredList,expr];

leafCount[ignoredList_,HoldPattern[Times[1,Power[expr_,-1]]]] :=
    leafCount[ignoredList,expr];

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

(* StartOfString and EndOfString will be evalueated as empty strings. *)
braketPairQ["",""] :=
    True;

braketPairQ[__] :=
    False;


ifRemoveLeftRight[True][string_String] :=
    string//StringReplace[{
        "\\left"~~rest:"("|"["|"|"|"\\{":>rest,"\\right"~~rest:")"|"]"|"|"|"\\}":>rest
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
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
