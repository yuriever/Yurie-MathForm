(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`TeXConvert`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Variable`"];


(* ::Section:: *)
(*Public*)


texForm::usage =
    "postprocess the string from TeXForm by the rules in $texAssoc.";

texSetMacro::usage =
    "set the symbol as a LaTeX macro and store the rule into $texAssoc.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*texForm*)


texForm[string_String] :=
    string//StringReplace[$texRule];

texForm[expr_] :=
    expr//TeXForm//ToString//StringReplace[$texRule];


(* ::Subsection:: *)
(*texSetMacro*)


texSetMacro[args___][funList_List] :=
    Scan[texSetMacro[args],funList];


(* ::Text:: *)
(*f*)
(*\f*)


texSetMacro[][fun_Symbol] :=
    With[ {funString = ToString[fun]},
        fun/:MakeBoxes[fun,TraditionalForm] :=
            funString;
        $texAssoc =
            Association[
                $texAssoc,
                funString->{
                    "\\text{"<>funString<>"}"->"\\"<>funString
                }
            ];
    ];


(* ::Text:: *)
(*f[x]*)
(*\f{x}*)


texSetMacro[left_String:"{",right_String:"}"][fun_Symbol[Verbatim[Blank][]]] :=
    With[ {
            funString = ToString[fun],
            funLeft = ToString[fun]<>$macroLeftDelimiter,
            funRight = ToString[fun]<>$macroRightDelimiter
        },
        fun/:MakeBoxes[fun[x_],TraditionalForm] :=
            RowBox@{
                funString,
                funLeft,
                makeBoxes[x],
                funRight
            };
        $texAssoc =
            Association[
                $texAssoc,
                funString->{
                    "\\text{"<>funString<>"}"->"\\"<>funString,
                    "\\text{"<>funLeft<>"}"->left,
                    "\\text{"<>funRight<>"}"->right
                }
            ];
    ];


(* ::Text:: *)
(*f[x,y,...]*)
(*f{x}{y}...*)


texSetMacro[left_String:"{",right_String:"}"][fun_Symbol[Verbatim[BlankNullSequence][]]] :=
    With[ {
            funString = ToString[fun],
            funLeft = ToString[fun]<>$macroLeftDelimiter,
            funRight = ToString[fun]<>$macroRightDelimiter
        },
        fun/:MakeBoxes[fun[x___],TraditionalForm] :=
            RowBox@{
                funString,
                Sequence@@Flatten@Map[{funLeft,makeBoxes[#],funRight}&,{x}]
            };
        $texAssoc =
            Association[
                $texAssoc,
                funString->{
                    "\\text{"<>funString<>"}"->"\\"<>funString,
                    "\\text{"<>funLeft<>"}"->left,
                    "\\text{"<>funRight<>"}"->right
                }
            ];
    ];


(* ::Text:: *)
(*f[{x,y,...}]*)
(*f{x,y,...}*)


texSetMacro[left_String:"{\n\t",right_String:"\n}",delimiter_String:",\n\t"][fun_Symbol[Verbatim[Blank][List]]] :=
    With[ {
            funString = ToString[fun],
            funLeft = ToString[fun]<>$macroLeftDelimiter,
            funRight = ToString[fun]<>$macroRightDelimiter,
            funDelimiter = ToString[fun]<>$macroListSeparator
        },
        fun/:MakeBoxes[fun[x_List],TraditionalForm] :=
            RowBox@{
                funString,
                funLeft,
                Sequence@@Riffle[Map[makeBoxes,x],funDelimiter],
                funRight
            };
        $texAssoc =
            Association[
                $texAssoc,
                funString->{
                    "\\text{"<>funString<>"}"->"\\"<>funString,
                    "\\text{"<>funLeft<>"}"->left,
                    "\\text{"<>funRight<>"}"->right,
                    "\\text{"<>funDelimiter<>"}"->delimiter
                }
            ];
    ];


(* ::Text:: *)
(*f[{x,...},{y,...},...]*)
(*f{x,...}{y,...}...*)


texSetMacro[left_String:"{\n\t",right_String:"\n}",delimiter_String:",\n\t"][fun_Symbol[Verbatim[BlankNullSequence][List]]] :=
    With[ {
            funString = ToString[fun],
            funLeft = ToString[fun]<>$macroLeftDelimiter,
            funRight = ToString[fun]<>$macroRightDelimiter,
            funDelimiter = ToString[fun]<>$macroListSeparator
        },
        fun/:MakeBoxes[fun[x___List],TraditionalForm] :=
            RowBox@{
                funString,
                Sequence@@Flatten@Map[{funLeft,Riffle[Map[makeBoxes,#],funDelimiter],funRight}&,{x}]
            };
        $texAssoc =
            Association[
                $texAssoc,
                funString->{
                    "\\text{"<>funString<>"}"->"\\"<>funString,
                    "\\text{"<>funLeft<>"}"->left,
                    "\\text{"<>funRight<>"}"->right,
                    "\\text{"<>funDelimiter<>"}"->delimiter
                }
            ];
    ];


makeBoxes//Attributes =
    {HoldAllComplete};

makeBoxes[expr_] :=
    MakeBoxes[expr,TraditionalForm];

(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
