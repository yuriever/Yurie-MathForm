(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MFDefine`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Constant`"];

Needs["Yurie`MathForm`Variable`"];


(* ::Section:: *)
(*Public*)


MFDefine::usage =
    "define LaTeX macro for the symbol and store the rule into $MFAssoc.";

Needs["Lacia`Base`"];

ClearAll[MFDefine];



(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*texSetMacro*)


MFDefine[args___][funList_List] :=
    Scan[MFDefine[args],funList];


(* ::Text:: *)
(*f*)
(*\f*)


MFDefine[][fun_Symbol] :=
    With[ {funString = ToString[fun]},
        fun/:MakeBoxes[fun,TraditionalForm] :=
            funString;
        $MFAssoc =
            Association[
                $MFAssoc,
                funString->{
                    "\\text{"<>funString<>"}"->"\\"<>funString
                }
            ];
        $MFRule =
            $MFAssoc//Values//Flatten;
    ];


(* ::Text:: *)
(*f[x]*)
(*\f{x}*)


MFDefine[left_String:"{",right_String:"}"][fun_Symbol[Verbatim[Blank][]]] :=
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
        $MFAssoc =
            Association[
                $MFAssoc,
                funString->{
                    "\\text{"<>funString<>"}"->"\\"<>funString,
                    "\\text{"<>funLeft<>"}"->left,
                    "\\text{"<>funRight<>"}"->right
                }
            ];
        $MFRule =
            $MFAssoc//Values//Flatten;
    ];


(* ::Text:: *)
(*f[x,y,...]*)
(*f{x}{y}...*)


MFDefine[left_String:"{",right_String:"}"][fun_Symbol[Verbatim[BlankNullSequence][]]] :=
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
        $MFAssoc =
            Association[
                $MFAssoc,
                funString->{
                    "\\text{"<>funString<>"}"->"\\"<>funString,
                    "\\text{"<>funLeft<>"}"->left,
                    "\\text{"<>funRight<>"}"->right
                }
            ];
        $MFRule =
            $MFAssoc//Values//Flatten;
    ];


(* ::Text:: *)
(*f[{x,y,...}]*)
(*f{x,y,...}*)


MFDefine[left_String:"{\n\t",right_String:"\n}",delimiter_String:",\n\t"][fun_Symbol[Verbatim[Blank][List]]] :=
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
        $MFAssoc =
            Association[
                $MFAssoc,
                funString->{
                    "\\text{"<>funString<>"}"->"\\"<>funString,
                    "\\text{"<>funLeft<>"}"->left,
                    "\\text{"<>funRight<>"}"->right,
                    "\\text{"<>funDelimiter<>"}"->delimiter
                }
            ];
        $MFRule =
            $MFAssoc//Values//Flatten;
    ];


(* ::Text:: *)
(*f[{x,...},{y,...},...]*)
(*f{x,...}{y,...}...*)


MFDefine[left_String:"{\n\t",right_String:"\n}",delimiter_String:",\n\t"][fun_Symbol[Verbatim[BlankNullSequence][List]]] :=
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
        $MFAssoc =
            Association[
                $MFAssoc,
                funString->{
                    "\\text{"<>funString<>"}"->"\\"<>funString,
                    "\\text{"<>funLeft<>"}"->left,
                    "\\text{"<>funRight<>"}"->right,
                    "\\text{"<>funDelimiter<>"}"->delimiter
                }
            ];
        $MFRule =
            $MFAssoc//Values//Flatten;
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
