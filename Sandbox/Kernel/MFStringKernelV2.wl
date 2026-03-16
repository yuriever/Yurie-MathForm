(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MFStringKernelV2`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Constant`"];

Needs["Yurie`MathForm`Variable`"];

Needs["Yurie`MathForm`MFString`"];


(* ::Section:: *)
(*Public*)


MFStringKernelV2;


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


MFStringKernelV2[string_String,OptionsPattern[MFStringKernel]] :=
    string;

MFStringKernelV2[list_List,opts:OptionsPattern[MFStringKernel]] :=
    With[{
            ifLinebreak = OptionValue["Linebreak"],
            linebreakThreshold = OptionValue["LinebreakThreshold"],
            stringList = Map[MFStringKernelV2[#,opts]&,list]
        },
        {
            ifLinebreakList = Map[StringLength[#]>=linebreakThreshold&,stringList]
        },
        If[ifLinebreak===True&&AnyTrue[ifLinebreakList,TrueQ],
            formatListV2[stringList,ifLinebreakList],
            (* Else *)
            StringRiffle[stringList,{"(",", ",")"}]
        ]
    ];

MFStringKernelV2[expr_,opts:OptionsPattern[MFStringKernel]] :=
    With[{
            ifLinebreak = OptionValue["Linebreak"],
            linebreakThreshold = OptionValue["LinebreakThreshold"],
            linebreakIgnoredP = OptionValue["LinebreakIgnore"],
            removeLeftRight = OptionValue["RemoveLeftRightPair"]
        },
        If[ifLinebreak===True,
            renderNodeV2[expr,linebreakThreshold,linebreakIgnoredP,"top",removeLeftRight],
            (* Else *)
            renderLeafV2[expr,"top",removeLeftRight]
        ]//deleteBlankBeforeScript//trimEmptyLine
    ];


(* ::Subsection:: *)
(*Helper - Leaf count*)


leafCountV2//Attributes =
    {HoldFirst};

leafCountV2[_?Developer`HoldAtomQ,_] :=
    1;

leafCountV2[Verbatim[Times][-1,rest__],ignoredP_] :=
    leafCountV2[Times[rest],ignoredP]-1;

leafCountV2[HoldPattern[Power[base_,-1]],ignoredP_] :=
    leafCountV2[base,ignoredP];

leafCountV2[HoldPattern[Times[1,Power[base_,-1]]],ignoredP_] :=
    leafCountV2[base,ignoredP];

leafCountV2[expr_,ignoredP_]/;MatchQ[Unevaluated[expr],ignoredP] :=
    1;

leafCountV2[head_[arg_],ignoredP_] :=
    leafCountV2[head,ignoredP]+leafCountV2[arg,ignoredP];

leafCountV2[head_[args__],ignoredP_] :=
    leafCountV2[head,ignoredP]+Plus@@Map[Function[Null,leafCountV2[#,ignoredP],HoldAll],Hold[args]];


(* insertQV2: check whether any direct argument of a Plus or Times has leafCount >= threshold. *)

insertQV2//Attributes =
    {HoldFirst};

insertQV2[held_,threshold_,ignoredP_] :=
    AnyTrue[held,Function[Null,leafCountV2[#,ignoredP]>=threshold,HoldAll]];


(* ::Subsection:: *)
(*Helper - Analysis helper*)


bracketLRRemoveV2[string_String] :=
    string//StringReplace[{
        "\\left"~~left:"("|"["|"|"|"\\{":>left,
        "\\right"~~right:")"|"]"|"|"|"\\}":>right
    }];


formatListV2[stringList_,ifLinebreakList_] :=
    With[{
            spacedStringList =
                MapThread[
                    If[#1===True,
                        #2<>",\n",
                        (* Else *)
                        #2<>", "
                    ]&,
                    {
                        Most[ifLinebreakList],
                        Most[stringList]
                    }
                ]
        },
        "(\n\t"<>StringJoin[spacedStringList]<>Last[stringList]<>"\n)"
    ];


(* splitSummandsV2: split Plus into list of {sign, held-term} pairs. *)

splitSummandsV2//Attributes =
    {HoldAll};

splitSummandsV2[HoldPattern[Plus[args__]]] :=
    Map[
        Function[Null,extractSignV2[#],HoldAll],
        Hold[args]
    ]//Apply[List];

extractSignV2//Attributes =
    {HoldAll};

extractSignV2[Verbatim[Times][-1,rest__]] :=
    {"-",HoldComplete[Times[rest]]};

extractSignV2[Verbatim[Times][n_Integer?Negative,rest__]]/;n=!=-1 :=
    {"-",HoldComplete[Times[-n,rest]]};

extractSignV2[Verbatim[Times][n_Rational?Negative,rest__]] :=
    {"-",HoldComplete[Times[-n,rest]]};

extractSignV2[n_Integer?Negative] :=
    {"-",HoldComplete[-n]};

extractSignV2[n_Rational?Negative] :=
    {"-",HoldComplete[-n]};

extractSignV2[expr_] :=
    {"+",HoldComplete[expr]};


(* splitFractionV2: split Times into {sign, numFactors, denomFactors}. *)
(* numFactors and denomFactors are lists of HoldComplete[factor]. *)
(* denomFactors are bases extracted from Power[base, neg-exp]. *)

splitFractionV2//Attributes =
    {HoldAll};

splitFractionV2[HoldPattern[Times[args__]]] :=
    Module[{sign = "+",numFactors = {},denomFactors = {}},
        Map[
            Function[Null,
                Which[
                    MatchQ[Unevaluated[#],-1],
                        sign = If[sign==="+","-","+"],
                    MatchQ[Unevaluated[#],HoldPattern[Power[_,-1]]],
                        With[{base = Extract[HoldComplete[#],{1,1},HoldComplete]},
                            AppendTo[denomFactors,base]
                        ],
                    MatchQ[Unevaluated[#],HoldPattern[Power[_,_?negativeExponentQ]]],
                        With[{
                                base = Extract[HoldComplete[#],{1,1},HoldComplete],
                                exp = Extract[HoldComplete[#],{1,2},HoldComplete]
                            },
                            AppendTo[denomFactors,base];
                            AppendTo[numFactors,mapHeldPowerV2[base,negateHeldV2[exp]]]
                        ],
                    True,
                        AppendTo[numFactors,HoldComplete[#]]
                ],
            HoldAll],
            Hold[args]
        ]//Apply[List];
        {sign,numFactors,denomFactors}
    ];


negativeExponentQ[-1] :=
    False;

negativeExponentQ[n_?NumberQ] :=
    Negative[n];

negativeExponentQ[_] :=
    False;


negateHeldV2[HoldComplete[n_Integer]] :=
    HoldComplete[-n];

negateHeldV2[HoldComplete[n_Rational]] :=
    HoldComplete[-n];

negateHeldV2[HoldComplete[expr_]] :=
    HoldComplete[Times[-1,expr]];


mapHeldPowerV2[HoldComplete[base_],HoldComplete[1]] :=
    HoldComplete[base];

mapHeldPowerV2[HoldComplete[base_],HoldComplete[exp_]] :=
    HoldComplete[Power[base,exp]];


(* ::Subsection:: *)
(*Helper - Rendering*)


(* renderLeafV2: render an expression as a single TeX string via TeXForm. *)
(* ctx controls whether to add outer parentheses. *)

renderLeafV2//Attributes =
    {HoldFirst};

renderLeafV2[expr_,ctx_,removeLeftRight_] :=
    With[{raw = ToString[TeXForm[expr]]},
        {
            cleaned =
                raw//If[removeLeftRight===True,bracketLRRemoveV2[#],#]&//
                    StringReplace[$MFRule]
        },
        wrapContextV2[cleaned,Unevaluated[expr],ctx,removeLeftRight]
    ];


(* wrapContextV2: add parens when a Plus/fraction appears in factor or power-base context. *)

wrapContextV2//Attributes =
    {HoldRest};

wrapContextV2[str_String,expr_,ctx_,removeLeftRight_:True] :=
    Module[{lp,rp},
        {lp,rp} = If[removeLeftRight===False,{"\\left(","\\right)"},{"(",")"}];
        Which[
            (* Plus in factor/power-base context needs parens. *)
            MemberQ[{"factor","power-base"},ctx]&&MatchQ[Unevaluated[expr],_Plus],
                lp<>str<>rp,
            (* Signed or multi-factor Times in power-base context needs parens. *)
            ctx==="power-base"&&MatchQ[Unevaluated[expr],HoldPattern[Times[__]]],
                lp<>str<>rp,
            True,
                str
        ]
    ];


(* renderNodeV2: main dispatch. Decides whether to break or render as leaf. *)

renderNodeV2//Attributes =
    {HoldFirst};

renderNodeV2[expr_,threshold_,ignoredP_,ctx_,removeLeftRight_] :=
    Which[
        leafCountV2[expr,ignoredP]<threshold,
            renderLeafV2[expr,ctx,removeLeftRight],
        MatchQ[Unevaluated[expr],HoldPattern[(Plus|Times)[args__]]]&&
            insertQV2[Replace[HoldComplete[expr],HoldComplete[_[args___]]:>Hold[args]],threshold,ignoredP],
            Which[
                MatchQ[Unevaluated[expr],_Plus],
                    (* Don't break Plus in power-exp context; exponents should stay compact. *)
                    If[ctx==="power-exp",
                        renderLeafV2[expr,ctx,removeLeftRight],
                        renderPlusV2[expr,threshold,ignoredP,ctx,removeLeftRight]
                    ],
                True,
                    renderTimesV2[expr,threshold,ignoredP,ctx,removeLeftRight]
            ],
        MatchQ[Unevaluated[expr],_Power],
            renderPowerV2[expr,threshold,ignoredP,ctx,removeLeftRight],
        True,
            renderLeafV2[expr,ctx,removeLeftRight]
    ];


(* renderPlusV2: split summands, render each, join with linebreak signs. *)

renderPlusV2//Attributes =
    {HoldFirst};

renderPlusV2[expr_Plus,threshold_,ignoredP_,ctx_,removeLeftRight_] :=
    With[{summands = splitSummandsV2[expr]},
        {
            rendered =
                Map[
                    With[{sign = #[[1]],held = #[[2]]},
                        {sign,renderHeldNodeV2[held,threshold,ignoredP,"summand",removeLeftRight]}
                    ]&,
                    summands
                ]
        },
        {
            lines =
                MapIndexed[
                    With[{sign = #1[[1]],str = #1[[2]],idx = #2[[1]]},
                        If[idx===1,
                            If[sign==="-","-"<>str,str],
                            (* Else *)
                            sign<>str
                        ]
                    ]&,
                    rendered
                ]
        },
        wrapPlusResultV2[StringRiffle[lines,"\n"]//cleanSignV2,ctx,removeLeftRight]
    ];

(* cleanSignV2: fix double-sign artifacts like +- and -- *)
cleanSignV2[str_String] :=
    str//StringReplace[{
        StartOfLine~~"+"~~WhitespaceCharacter...~~"-":>"-",
        StartOfLine~~"-"~~WhitespaceCharacter...~~"-":>"+"
    }];

wrapPlusResultV2[str_String,ctx_String,removeLeftRight_:True] :=
    Module[{lp,rp},
        {lp,rp} = If[removeLeftRight===False,{"\\left(","\\right)"},{"(",")"}];
        If[MemberQ[{"factor","power-base"},ctx],
            lp<>"\n"<>str<>"\n"<>rp,
            (* Contexts "top", "summand", "frac-part", "power-exp" etc: no wrapping *)
            str
        ]
    ];


(* renderTimesV2: detect fraction, render numerator and denominator. *)

renderTimesV2//Attributes =
    {HoldFirst};

renderTimesV2[expr_Times,threshold_,ignoredP_,ctx_,removeLeftRight_] :=
    With[{split = splitFractionV2[expr]},
        {
            sign = split[[1]],
            numFactors = split[[2]],
            denomFactors = split[[3]]
        },
        (* In power-exp context, only break fractions; non-fraction products stay compact. *)
        If[ctx==="power-exp"&&denomFactors==={},
            renderLeafV2[expr,ctx,removeLeftRight],
            renderTimesBodyV2[sign,numFactors,denomFactors,threshold,ignoredP,ctx,removeLeftRight]
        ]
    ];

renderTimesBodyV2[sign_,numFactors_,denomFactors_,threshold_,ignoredP_,ctx_,removeLeftRight_] :=
    Module[{numStr,denomStr,result,lp,rp},
        {lp,rp} = If[removeLeftRight===False,{"\\left(","\\right)"},{"(",")"}];
        If[denomFactors==={},
            (* No denominator: just factors with line breaks. *)
            numStr = renderFactorListV2[numFactors,threshold,ignoredP,removeLeftRight];
            result = numStr;
            If[sign==="-",
                result = "-"<>result
            ];
            (* In power-base context, a product needs parens. *)
            If[ctx==="power-base"&&(sign==="-"||Length[numFactors]>1),
                result = lp<>result<>rp
            ];
            result,
            (* Has denominator: render as \frac. *)
            numStr = renderFracPartV2[numFactors,threshold,ignoredP,removeLeftRight];
            denomStr = renderFracPartV2[denomFactors,threshold,ignoredP,removeLeftRight];
            result = wrapFracV2[numStr,denomStr];
            If[sign==="-",
                result = "-"<>result
            ];
            result
        ]
    ];

wrapFracV2[numStr_String,denomStr_String] :=
    Module[{num = numStr,denom = denomStr},
        If[StringContainsQ[num,"\n"],
            num = "\n"<>num<>"\n"
        ];
        If[StringContainsQ[denom,"\n"],
            denom = "\n"<>denom<>"\n"
        ];
        "\\frac{"<>num<>"}{"<>denom<>"}"
    ];

renderFracPartV2[{single_},threshold_,ignoredP_,removeLeftRight_] :=
    renderHeldNodeV2[single,threshold,ignoredP,"frac-part",removeLeftRight];

renderFracPartV2[factors_List,threshold_,ignoredP_,removeLeftRight_] :=
    renderFactorListV2[factors,threshold,ignoredP,removeLeftRight];

renderFactorListV2[factors_List,threshold_,ignoredP_,removeLeftRight_] :=
    With[{
            rendered =
                Map[
                    renderHeldNodeV2[#,threshold,ignoredP,"factor",removeLeftRight]&,
                    factors
                ],
            leafCounts =
                Map[
                    Function[held,
                        Replace[held,HoldComplete[e_]:>leafCountV2[e,ignoredP]]
                    ],
                    factors
                ]
        },
        If[Length[rendered]===0,
            "1",
            (* Group consecutive small factors (leafCount < threshold) on the same line. *)
            (* Start a new line before factors with leafCount >= threshold or multiline content. *)
            groupFactorsV2[rendered,leafCounts,threshold]
        ]
    ];

groupFactorsV2[rendered_List,leafCounts_List,threshold_] :=
    Module[{groups = {},currentGroup = {}},
        Do[
            If[StringContainsQ[rendered[[i]],"\n"]||leafCounts[[i]]>=threshold,
                (* This factor is large: flush current group, start new group. *)
                If[currentGroup=!={},
                    AppendTo[groups,StringJoin@Riffle[currentGroup," "]]
                ];
                currentGroup = {rendered[[i]]},
                (* Small single-line factor: add to current group. *)
                AppendTo[currentGroup,rendered[[i]]]
            ],
            {i,Length[rendered]}
        ];
        If[currentGroup=!={},
            AppendTo[groups,StringJoin@Riffle[currentGroup," "]]
        ];
        StringRiffle[groups,"\n"]
    ];


(* renderPowerV2: render base and exponent, combining as base^{exp}. *)
(* Special case: Power[base, -1] renders as \frac{1}{baseStr}. *)
(* Special case: Power[base, -n] renders as \frac{1}{baseStr^{n}}. *)

renderPowerV2//Attributes =
    {HoldFirst};

renderPowerV2[HoldPattern[Power[base_,-1]],threshold_,ignoredP_,ctx_,removeLeftRight_] :=
    With[{baseStr = renderNodeV2[base,threshold,ignoredP,"frac-part",removeLeftRight]},
        wrapFracV2["1",baseStr]
    ];

renderPowerV2[HoldPattern[Power[base_,exp_?Negative]],threshold_,ignoredP_,ctx_,removeLeftRight_] :=
    With[{
            baseStr = renderNodeV2[base,threshold,ignoredP,"power-base",removeLeftRight],
            posExpStr = renderNodeV2[-exp,threshold,ignoredP,"power-exp",removeLeftRight]
        },
        If[StringLength[posExpStr]<=1,
            wrapFracV2["1",baseStr<>"^"<>posExpStr],
            (* Else *)
            wrapFracV2["1",baseStr<>"^{"<>posExpStr<>"}"]
        ]
    ];

renderPowerV2[HoldPattern[Power[base_,exp_]],threshold_,ignoredP_,ctx_,removeLeftRight_] :=
    With[{
            baseStr = renderNodeV2[base,threshold,ignoredP,"power-base",removeLeftRight],
            expStr = renderNodeV2[exp,threshold,ignoredP,"power-exp",removeLeftRight]
        },
        {
            (* Wrap negative numeric base in parens if not already wrapped. *)
            safeBaseStr =
                If[StringMatchQ[baseStr,"-"~~__]&&!StringMatchQ[baseStr,"("~~___~~")"],
                    "("<>baseStr<>")",
                    baseStr
                ]
        },
        If[StringLength[expStr]<=1,
            safeBaseStr<>"^"<>expStr,
            (* Else *)
            safeBaseStr<>"^{"<>expStr<>"}"
        ]
    ];


(* renderHeldNodeV2: unwrap HoldComplete and call renderNodeV2. *)

renderHeldNodeV2[HoldComplete[expr_],threshold_,ignoredP_,ctx_,removeLeftRight_] :=
    renderNodeV2[expr,threshold,ignoredP,ctx,removeLeftRight];


(* ::Subsection:: *)
(*Helper - Cleanup*)


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
