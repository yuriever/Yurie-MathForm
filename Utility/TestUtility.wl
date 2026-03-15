(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`TestUtility`"];


Needs["Yurie`MathForm`"];


(* ::Section:: *)
(*Public*)


MFStringCompareVersion::usage =
    "Compare the output of MFString for a list of expressions.";

MFStringGenerateTest::usage =
    "Generate test cells for MFString for a list of expressions.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


MFStringCompareVersion[exprList_List] :=
    Module[{res},
        res =
            Map[
                {#,MFString[#,"Method"->"V1"],MFString[#,"Method"->"V2"]}&,
                exprList
            ];
        res =
            Map[{#[[1]],#[[2]]==#[[3]],#[[2]],#[[3]]}&,res];
        TableForm[
            res,
            TableSpacing->{10,2},
            TableHeadings->{None,{"Expr","V1 = V2","V1","V2"}}
        ]
    ];


MFStringGenerateTest[expr_] :=
    Module[{printMF},
        printMF[string_,method_] :=
            CellPrint@ExpressionCell[
                Defer@MFString[string,"Method"->method],
                "Code"
            ];

        CellPrint@TextCell["Autogen test","Subsection"];

        Scan[
            printMF[#,"V1"]&,
            expr
        ];

        Scan[
            printMF[#,"V2"]&,
            expr
        ];
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
