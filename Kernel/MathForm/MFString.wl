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


MFStringKernel;

MFFormatKernel;


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Bracket*)


(* ::Text:: *)
(*StartOfString and EndOfString will be evaluated as empty strings.*)


$leftBracketP = "("|"["|"{"|"\\{"|"\\left("|"\\left["|"\\left\\{"|StartOfString;

$rightBracketP = ")"|"]"|"}"|"\\}"|"\\right)"|"\\right]"|"\\right\\}"|EndOfString;


$leftSeparatorP = "("|"["|"{"|"\\{"|"\\left("|"\\left["|"\\left\\{"|","|";"|"."|StartOfString;

$rightSeparatorP = ")"|"]"|"}"|"\\}"|"\\right)"|"\\right]"|"\\right\\}"|","|";"|"."|EndOfString;


bracketPartner["("] :=
    ")";

bracketPartner[")"] :=
    "(";

bracketPartner["["] :=
    "]";

bracketPartner["]"] :=
    "[";

bracketPartner["{"] :=
    "}";

bracketPartner["}"] :=
    "{";

bracketPartner["\\{"] :=
    "\\}";

bracketPartner["\\}"] :=
    "\\{";

bracketPartner["\\left("] :=
    "\\right)";

bracketPartner["\\right)"] :=
    "\\left(";

bracketPartner["\\left["] :=
    "\\right]";

bracketPartner["\\right]"] :=
    "\\left[";

bracketPartner["\\left\\{"] :=
    "\\right\\}";

bracketPartner["\\right\\}"] :=
    "\\left\\{";

bracketPartner[""] :=
    "";


bracketPairQ["(",")"] :=
    True;

bracketPairQ["[","]"] :=
    True;

bracketPairQ["\\{","\\}"] :=
    True;

bracketPairQ["\\left(","\\right)"] :=
    True;

bracketPairQ["\\left[","\\right]"] :=
    True;

bracketPairQ["\\left\\{","\\right\\}"] :=
    True;

bracketPairQ["{","}"] :=
    True;

bracketPairQ["",""] :=
    True;

bracketPairQ[__] :=
    False;


bracketBalancedQ[string_String,left:$leftBracketP] :=
    With[ {
            leftPos = StringPosition[string,left][[All,2]],
            rightPos = StringPosition[string,bracketPartner[left]][[All,2]]
        },
        Length[leftPos]===Length[rightPos]&&OrderedQ@Riffle[leftPos,rightPos]
    ];

bracketBalancedQ[string_String,right:$rightBracketP] :=
    With[ {
            rightPos = StringPosition[string,right][[All,2]],
            leftPos = StringPosition[string,bracketPartner[right]][[All,2]]
        },
        Length[leftPos]===Length[rightPos]&&OrderedQ@Riffle[leftPos,rightPos]
    ];


bracketLRRemove[string_String] :=
    string//StringReplace[{
        "\\left"~~left:"("|"["|"|"|"\\{":>left,"\\right"~~right:")"|"]"|"|"|"\\}":>right
    }];


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


(* ::Subsection:: *)
(*Main*)


MFString[expr_,opts:OptionsPattern[]] :=
    MFStringKernel[expr,FilterRules[{opts,Options@MFString},Options@MFStringKernel]]//
        MFFormatKernel//Catch;


MFStringKernel[string_String,OptionsPattern[]] :=
    string;

MFStringKernel[expr_,OptionsPattern[]] :=
    With[ {
            ifLinebreak = OptionValue["Linebreak"],
            linebreakThreshold = OptionValue["LinebreakThreshold"],
            linebreakIgnoredP = getLinebreakIgnoreP@OptionValue["LinebreakIgnore"]
        },
        (* Insert linebreak tags according to the options. *)
        linebreakInsert[expr,ifLinebreak,linebreakThreshold,linebreakIgnoredP]//
            (* Convert to LaTeX format. *)
            TeXForm//ToString//
            (* Remove pairs of brackets before calling $MFRule. *)
            If[ OptionValue["RemoveLeftRightPair"],
                bracketLRRemove[#],
                (* Else *)
                #
            ]&//
            (* Apply the rule list $MFRule introduced by MFArgConvert. *)
            StringReplace[$MFRule]//
            (* Convert the inserted linebreak tags to line breaks. *)
            linebreakConvert[ifLinebreak]//
            lineBreakClean[ifLinebreak]//
            (* Cleanup *)
            deleteBlankBeforeScript//
            trimEmptyLine
    ];


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
(*Helper: Linebreak*)


LBHold//Attributes = {
    HoldAll
};

LBNode//Attributes = {
    HoldAll
};

LBNodePlusInTimes//Attributes = {
    HoldAll
};

LBNode/:MakeBoxes[LBNode[arg_],TraditionalForm] :=
    RowBox@{
        "LBNode",
        "(",
        RowBox@{
            "LBNodeLeft",
            MakeBoxes[arg,TraditionalForm],
            "LBNodeRight"
        },
        ")"
    };

LBNodePlusInTimes/:MakeBoxes[LBNodePlusInTimes[arg_],TraditionalForm] :=
    RowBox@{
        "LBNodePlusInTimes",
        "(",
        RowBox@{
            "LBNodePlusInTimesLeft",
            MakeBoxes[arg,TraditionalForm],
            "LBNodePlusInTimesRight"
        },
        ")"
    };


getLinebreakIgnoreP//Attributes = {
    HoldAll
};

getLinebreakIgnoreP[ignored_List] :=
    Alternatives@@Map[HoldPattern,ignored];

getLinebreakIgnoreP[ignored_] :=
    HoldPattern[ignored];


linebreakInsert//Attributes = {
    HoldFirst
};

linebreakInsert[expr_,True,threshold_,ignoredP_] :=
    HoldComplete[expr]//
        Replace[#,{
            HoldPattern[(head:Plus|Times)[args__]]/;insertQ[Hold[args],threshold,ignoredP]:>
                RuleCondition@Replace[
                    LBHold[head,args],
                    {
                        arg:_Plus|LBHold[Plus,__]/;leafCount[arg,ignoredP]>=threshold:>
                            RuleCondition@If[ head===Times,
                                LBNodePlusInTimes[arg],
                                (* Else *)
                                LBNode[arg]
                            ],
                        arg:Power[base_,exponent_]/;leafCount[arg,ignoredP]>=threshold:>
                            RuleCondition@If[ Negative[exponent]===True,
                                Power[LBNode[base],exponent],
                                (* Else *)
                                LBNode[arg]
                            ],
                        arg_/;leafCount[arg,ignoredP]>=threshold:>
                            LBNode[arg]
                    },
                    {1}
                ]
        },All]&//Replace[#,{
            LBHold[head_,args__]:>head[args]
        },All]&;

linebreakInsert[expr_,False,___] :=
    expr;


linebreakConvert[True][string_String] :=
    string//StringReplace[{
        StartOfString~~"\\text{HoldComplete}["~~content___~~"]"~~EndOfString:>content,
        StartOfString~~"\\text{HoldComplete}\\left["~~content___~~"\\right]"~~EndOfString:>content
    }]//StringReplace[{
        "\\text{LBNodePlusInTimes}"->"",
        "\\left(\\text{LBNodePlusInTimesLeft}"->"\n(",
        "\\text{LBNodePlusInTimesRight}\\right)"->")\n",
        "(\\text{LBNodePlusInTimesLeft}"->"\n(",
        "\\text{LBNodePlusInTimesRight})"->")\n"
    }]//StringReplace[{
        "\\text{LBNode}"->"",
        "\\left(\\text{LBNodeLeft}"->"\n",
        "\\text{LBNodeRight}\\right)"->"\n",
        "(\\text{LBNodeLeft}"->"\n",
        "\\text{LBNodeRight})"->"\n"
    }];

linebreakConvert[False][string_String] :=
    string;


insertQ//Attributes = {
    HoldFirst
};

insertQ[held_,threshold_,ignoredP_] :=
    AnyTrue[held,Function[Null,leafCount[#,ignoredP]>=threshold,HoldAll]];


leafCount//Attributes =
    {HoldFirst};

leafCount[_?Developer`HoldAtomQ,ignoredP_] :=
    1;

leafCount[Verbatim[Times][-1,rest__],ignoredP_] :=
    leafCount[Times[rest],ignoredP]-1;

leafCount[HoldPattern[Power[base_,-1]],ignoredP_] :=
    leafCount[base,ignoredP];

leafCount[HoldPattern[Times[1,Power[base_,-1]]],ignoredP_] :=
    leafCount[base,ignoredP];

leafCount[LBHold[head_,_,rest__,_],ignoredP_] :=
    leafCount[head[rest],ignoredP];

leafCount[expr_,ignoredP_]/;MatchQ[Unevaluated[expr],ignoredP] :=
    1;

leafCount[head_[arg_],ignoredP_] :=
    leafCount[head,ignoredP]+leafCount[arg,ignoredP];

leafCount[head_[args__],ignoredP_] :=
    leafCount[head,ignoredP]+Plus@@Map[Function[Null,leafCount[#,ignoredP],HoldAll],Hold[args]];


lineBreakClean[True][string_String] :=
    string//FixedPoint[
        StringReplace[{
            (* Remove the doubled bracket pair generated by TeXForm. *)
            (* Notice that WhitespaceCharacter.. is used. In some cases the doubled bracket pairs should not be removed, like derivatives. *)
            (* We use WhitespaceCharacter.. instead of WhitespaceCharacter... to skip these cases. *)
            left:$leftBracketP~~WhitespaceCharacter..~~"("~~Shortest[content__]~~")"~~WhitespaceCharacter..~~right:$rightBracketP/;
                bracketPairQ[left,right]&&bracketBalancedQ[content,"("]&&bracketBalancedQ[content,left]:>
                    left~~"\n"~~content~~"\n"~~right
        }],
        #
    ]&//StringSplit[#,"\n"]&//StringReplace[#,{
        (* Add line breaks to the beginning and ending of brackets when they are not balanced. *)
        StartOfLine~~prec___~~left:$leftBracketP~~Longest[content__]~~EndOfLine/;bracketBalancedQ[content,left]:>
            prec~~left~~"\n"~~content,
        StartOfLine~~Longest[content__]~~right:$rightBracketP~~succ___~~EndOfLine/;!StringEndsQ[content,"\\right"]&&bracketBalancedQ[content,right]:>
            content~~"\n"~~right~~succ
    }]&//StringRiffle[#,"\n"]&//FixedPoint[
        StringReplace[{
            (* Remove double signs: "++"->"+", "+-"->"-" *)
            (* "+"~~space:WhitespaceCharacter...~~sign:"+"|"-":>space~~sign, *)
            "++"->"+","+-"->"-","-+"->"-",
            (* Remove extra whitespaces. *)
            sign:"+"|"-"~~space:WhitespaceCharacter...~~succ:Except[WhitespaceCharacter]:>space~~sign~~succ
        }],
        #
    ]&

lineBreakClean[False][string_String] :=
    string;


(* ::Subsection:: *)
(*Helper: Cleanup*)


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
