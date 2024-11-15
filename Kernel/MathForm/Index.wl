(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`Index`Index`"];


Needs["Yurie`Index`"];


(* ::Section:: *)
(*Public*)


indexize::usage =
    "join the variable and index into a symbol.";

indexJoin::usage =
    "join indexed variables into symbols in the expression.";

indexSplit::usage =
    "split symbols into indexed variables in the expression.";


indexToZero::usage =
    "x1->0.";

indexToEqual::usage =
    "x1->x2.";

indexToDiff::usage =
    "x1->x12+x2.";

indexToDiffZero::usage =
    "x1->x12,x2->0.";

indexToDiffBack::usage =
    "x12->x1-x2.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*indexize*)


(* ::Subsubsection:: *)
(*Main*)


indexize[var_,index_] :=
    ToExpression[ToString[var,FormatType->InputForm]<>indexToString[index]];

indexize[{var_,index_}] :=
    ToExpression[ToString[var,FormatType->InputForm]<>indexToString[index]];


(* ::Subsubsection:: *)
(*Helper*)


indexToString[Null] :=
    "";

indexToString[index_String] :=
    index;

indexToString[index_Symbol] :=
    SymbolName@index;

indexToString[index_Integer] :=
    ToString@index;


(* ::Subsection:: *)
(*indexJoin|indexSplit*)


(* ::Subsubsection:: *)
(*Constant*)


indexPositionP =
    Construct|Subscript|Superscript;

indexTypeP =
    All|"PositiveInteger"|"PositiveIntegerOrSingleLetter"|_Symbol;


(* ::Subsubsection:: *)
(*Option*)


indexJoinKernel//Options = {
    "IndexPosition"->Construct,
    "IndexType"->All
};

indexJoin//Options =
    Options@indexJoinKernel;


indexSplitKernel//Options = {
    "IndexPosition"->Construct,
    "IndexType"->All
};

indexSplit//Options =
    Options@indexSplitKernel;


(* ::Subsubsection:: *)
(*Message*)


indexJoin::optnotmatch =
    "the input options are not supported."

indexSplit::optnotmatch =
    "the input options are not supported."


(* ::Subsubsection:: *)
(*Main*)


indexJoin[vars__Symbol,opts:OptionsPattern[]][expr_] :=
    indexJoinKernel[{vars},FilterRules[{opts,Options@indexJoin},Options@indexJoinKernel]][expr];

indexJoin[varList:{__Symbol},opts:OptionsPattern[]][expr_] :=
    indexJoinKernel[varList,FilterRules[{opts,Options@indexJoin},Options@indexJoinKernel]][expr];


indexJoinKernel[varList_List,OptionsPattern[]][expr_] :=
    Module[ {varP,formatFunction,indexQFunction},
        If[ !MatchQ[OptionValue["IndexPosition"],indexPositionP]||
            !MatchQ[OptionValue["IndexType"],indexTypeP],
            Message[indexJoin::optnotmatch];
            Throw[expr]
        ];
        varP = Alternatives@@varList;
        formatFunction = OptionValue["IndexPosition"];
        indexQFunction = OptionValue["IndexType"];
        (*kernel*)
        Switch[formatFunction,
            Construct,
                expr//ReplaceAll[
                    var_Symbol[index_]/;MatchQ[var,varP]&&AtomQ[index]&&indexQ[indexQFunction][indexToString[index]]:>
                        RuleCondition@indexize[var,index]
                ],
            Subscript,
                expr//ReplaceAll[
                    Subscript[var_,index_]/;MatchQ[var,varP]&&AtomQ[index]&&indexQ[indexQFunction][indexToString[index]]:>
                        RuleCondition@indexize[var,index]
                ],
            Superscript,
                expr//ReplaceAll[
                    Superscript[var_,index_]/;MatchQ[var,varP]&&AtomQ[index]&&indexQ[indexQFunction][indexToString[index]]:>
                        RuleCondition@indexize[var,index]
                ]
        ]
    ]//Catch;


indexSplit[vars__Symbol,opts:OptionsPattern[]][expr_] :=
    indexSplitKernel[{vars},FilterRules[{opts,Options@indexSplit},Options@indexSplitKernel]][expr];

indexSplit[varList:{__Symbol},opts:OptionsPattern[]][expr_] :=
    indexSplitKernel[varList,FilterRules[{opts,Options@indexSplit},Options@indexSplitKernel]][expr];


indexSplitKernel[varList_List,OptionsPattern[]][expr_] :=
    Module[ {varP,formatFunction,indexQFunction},
        If[ !MatchQ[OptionValue["IndexPosition"],indexPositionP]||
            !MatchQ[OptionValue["IndexType"],indexTypeP],
            Message[indexSplit::optnotmatch];
            Throw[expr]
        ];
        varP = Alternatives@@Map[ToString[#,FormatType->InputForm]&,varList];
        formatFunction = OptionValue["IndexPosition"];
        indexQFunction = OptionValue["IndexType"];
        (*kernel*)
        expr//ReplaceAll[
            symbol_Symbol:>
                RuleCondition@symbolFromStringOrStringExpression@StringReplace[
                    ToString[symbol,FormatType->InputForm],
                    StartOfString~~Shortest[var__]~~Longest[index__]~~EndOfString/;StringMatchQ[var,varP]&&indexQ[indexQFunction][index]:>
                        formatFunction[ToExpression@var,ToExpression@index]
                ]
        ]
    ]//Catch;


(* ::Subsubsection:: *)
(*Helper*)


symbolFromStringOrStringExpression[expr_] :=
    If[ Head[expr]===String,
        ToExpression@expr,
        (*Else*)
        First@expr
    ];


indexQ[All][_] :=
    True;

indexQ["PositiveInteger"][str_] :=
    StringMatchQ[str,RegularExpression["^$|[1-9]\\d*"]];

indexQ["PositiveIntegerOrSingleLetter"][str_] :=
    StringMatchQ[str,RegularExpression["^$|[^\\W_]|[1-9]\\d*"]];

indexQ[fun_Symbol][str_] :=
    fun[str];


(* ::Subsection:: *)
(*indexTo*)


(* ::Subsubsection:: *)
(*Main*)


indexToZero[heads__][indexs__][expr_] :=
    expr//ReplaceAll[indexRulePrototype[(#[[1]]->0)&,padSymbolToRule[indexs],{heads}]];


indexToEqual[heads__][rules__Rule][expr_] :=
    expr//ReplaceAll[indexRulePrototype[(#[[1]]->#[[2]])&,{rules},{heads}]];


indexToDiff[heads__][rules__Rule][expr_] :=
    expr//ReplaceAll[indexRulePrototype[(#[[1]]->#[[2]]+#[[3]])&,{rules},{heads}]];


indexToDiffZero[heads__][rules__Rule][expr_] :=
    expr//ReplaceAll[indexRulePrototype[{#[[1]]->#[[3]],#[[2]]->0}&,{rules},{heads}]];


indexToDiffBack[heads__][rules__Rule][expr_] :=
    expr//ReplaceAll[indexRulePrototype[(#[[3]]->#[[1]]-#[[2]])&,{rules},{heads}]];


(* ::Subsubsection:: *)
(*Helper*)


(*get rules from prototype function.*)

indexRulePrototype[proto_,ruleList_List,headList_List] :=
    Flatten@Outer[indexRulePrototype[proto,#1,#2]&,ruleList,headList];

indexRulePrototype[proto_,rule_Rule,head_Symbol] :=
    proto@indexize2[head,extractIndexFromRule[rule]];


(*extract indices and difference of indices from rule.*)
(*e.g. 1->2 returns {1,2,12}.*)

extractIndexFromRule[rule_Rule] :=
    {Sequence@@rule,StringExpression@@ToString/@rule};


(*pad symbols to identical rules, used in indexToZero.*)

padSymbolToRule[heads__] :=
    Map[#->#&,{heads}];


(*indexize symbols with indices.*)

indexize2[head_,indexList_List] :=
    Map[ToExpression[ToString[head,FormatType->InputForm]<>indexToString@#]&,indexList];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
