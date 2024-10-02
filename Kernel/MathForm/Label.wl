(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`Label`"];


Needs["Yurie`MathForm`"];


(* ::Section:: *)
(*Public*)


labelJoin::usage =
    "{x,1}->x1.";

labelSplit::usage =
	"x1->f[x,1].";


labelShiftToZero::usage =
    "x1->0.";

labelShiftToEqual::usage =
    "x1->x2.";

labelShiftToDiff::usage =
    "x1->x12+x2.";

labelShiftToDiffZero::usage =
    "x1->x12,x2->0.";

labelShiftToDiffBack::usage =
    "x12->x1-x2.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*labelJoin*)


(* ::Subsubsection:: *)
(*Main*)


labelJoin[{head_,labels___}] :=
    labelJoinKernel[head,labels];

labelJoin[head_,labels___] :=
    labelJoinKernel[head,labels];


(* ::Subsubsection:: *)
(*Helper*)


labelJoinKernel[head_] :=
    head//ToString//ToExpression;

labelJoinKernel[head_,label_] :=
    StringJoin[ToString@head,labelToString@label]//ToExpression

labelJoinKernel[head_,labels___] :=
    StringJoin[ToString@head,Map[labelToString,{labels}]]//ToExpression;


labelToString[Null] :=
    "";

labelToString[label_String] :=
    label;

labelToString[label_Symbol] :=
    SymbolName@label;

labelToString[label_Integer] :=
    ToString@label;


(* ::Subsection:: *)
(*labelSplit*)


(* ::Subsubsection:: *)
(*Option*)


labelSplitKernel//Options = {
    "LabelPosition"->Subscript,
    "LabelType"->Automatic
};

labelSplit//Options =
    Options@labelSplitKernel;


(* ::Subsubsection:: *)
(*Main*)


labelSplit[heads__Symbol,opts:OptionsPattern[]][expr_] :=
    labelSplitKernel[{heads},FilterRules[{opts,Options@labelSplit},Options@labelSplitKernel]][expr];

labelSplit[headList:{__Symbol},opts:OptionsPattern[]][expr_] :=
    labelSplitKernel[headList,FilterRules[{opts,Options@labelSplit},Options@labelSplitKernel]][expr];


(* ::Subsubsection:: *)
(*Helper*)


labelSplitKernel[headList_List,OptionsPattern[]][expr_] :=
    Module[ {headPattern,formatFunction,labelQFunction},
        headPattern =
            Alternatives@@Map[ToString,headList];
        formatFunction =
            OptionValue["LabelPosition"];
        labelQFunction =
            OptionValue["LabelType"];
        ReplaceAll[
            expr,
            symbol_Symbol:>
                symbolFromStringOrStringExpression@StringReplace[
                    ToString@symbol,
                    StartOfString~~Shortest[head__]~~Longest[rest__]~~EndOfString/;StringMatchQ[head,headPattern]&&labelQ[labelQFunction][rest]:>
                        formatFunction[ToExpression@head,ToExpression@rest]
                ]
        ]
    ];


symbolFromStringOrStringExpression[expr_] :=
    If[ Head[expr]===String,
        ToExpression@expr,
        (*Else*)
        First@expr
    ];


labelQ[Automatic][_] :=
    True;

labelQ["PositiveInteger"][str_] :=
    StringMatchQ[str,RegularExpression["^$|[1-9]\\d*"]];

labelQ["PositiveIntegerOrSingleLetter"][str_] :=
    StringMatchQ[str,RegularExpression["^$|[^\\W_]|[1-9]\\d*"]];

labelQ[fun_][str_] :=
    fun[str];


(* ::Subsection:: *)
(*labelShift*)


(* ::Subsubsection:: *)
(*Main*)


labelShiftToZero[heads__][labels__][expr_] :=
    expr//ReplaceAll[labelShiftRulePrototype[(#[[1]]->0)&,padSymbolToRule[labels],{heads}]];


labelShiftToEqual[heads__][rules__Rule][expr_] :=
    expr//ReplaceAll[labelShiftRulePrototype[(#[[1]]->#[[2]])&,{rules},{heads}]];


labelShiftToDiff[heads__][rules__Rule][expr_] :=
    expr//ReplaceAll[labelShiftRulePrototype[(#[[1]]->#[[2]]+#[[3]])&,{rules},{heads}]];


labelShiftToDiffZero[heads__][rules__Rule][expr_] :=
    expr//ReplaceAll[labelShiftRulePrototype[{#[[1]]->#[[3]],#[[2]]->0}&,{rules},{heads}]];


labelShiftToDiffBack[heads__][rules__Rule][expr_] :=
    expr//ReplaceAll[labelShiftRulePrototype[(#[[3]]->#[[1]]-#[[2]])&,{rules},{heads}]];


(* ::Subsubsection:: *)
(*Helper*)


(*get rules from prototype function.*)

labelShiftRulePrototype[proto_,ruleList_List,headList_List] :=
    Flatten@Outer[labelShiftRulePrototype[proto,#1,#2]&,ruleList,headList];

labelShiftRulePrototype[proto_,rule_Rule,head_Symbol] :=
    proto@indexize[head,extractIndexFromRule[rule]];


(*extract indices and difference of indices from rule.*)
(*e.g. 1->2 returns {1,2,12}.*)

extractIndexFromRule[rule_Rule] :=
    {Sequence@@rule,StringExpression@@ToString/@rule};


(*pad symbols to identical rules, used in labelShiftToZero.*)

padSymbolToRule[heads__] :=
    Map[#->#&,{heads}];


(*indexize symbols with labels.*)

indexize[head_,labelList_List] :=
    Map[ToExpression[ToString@head<>labelToString@#]&,labelList];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
