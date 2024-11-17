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


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Constant*)


(* ::Text:: *)
(*In MFDefineKernel, when evaluating MakeBoxes, the local variable arg will be renamed as arg$, which enters into the format value.*)
(*The function clearFormat needs to match this format value from MFDefineKernel, hence we need use arg$.*)


arg$;


(* ::Subsection:: *)
(*Message*)


MFDefine::notsupported =
    "the pattern `` is not supported.";

MFDefine::clearformat =
    "the existing format values of the symbol `` are cleared.";


(* ::Subsection:: *)
(*Main*)


MFDefine[args___][list_List] :=
    Scan[MFDefineKernel2[args],list]//Catch;


MFDefineKernel2[args___][Verbatim[Rule][funPattern_,funString_String]] :=
    MFDefineKernel[{funPattern,funString},args];

MFDefineKernel2[args___][funPattern_] :=
    MFDefineKernel[{funPattern,stripFunPattern[funPattern]},args];


(* ::Subsubsection:: *)
(*MFDefineKernel*)


MFDefineKernel[args___] :=
    (
        Message[MFDefine::notsupported,{args}[[1,1]]];
        Throw[Null];
    );


(* ::Text:: *)
(*f->\f*)


MFDefineKernel[{fun_Symbol,funString_String}] :=
    With[ {funPlaceholder = ToString[fun]},
        clearFormat[fun,fun];
        fun/:MakeBoxes[fun,TraditionalForm] :=
            funPlaceholder;
        updateMFData[
            funPlaceholder->{
                "\\text{"<>funPlaceholder<>"}"->"\\"<>funString
            }
        ]
    ];


(* ::Text:: *)
(*f[x]->\f{x}*)


MFDefineKernel[{fun_Symbol[Verbatim[Blank][]],funString_String},left_String:"{",right_String:"}"] :=
    With[ {
            funPlaceholder = ToString[fun],
            funLeft = ToString[fun]<>$macroLeftDelimiter,
            funRight = ToString[fun]<>$macroRightDelimiter
        },
        clearFormat[fun,fun[arg$_]];
        fun/:MakeBoxes[fun[arg_],TraditionalForm] :=
            RowBox@{
                funPlaceholder,
                funLeft,
                makeTraditionalBoxes[arg],
                funRight
            };
        updateMFData[
            funPlaceholder->{
                "\\text{"<>funPlaceholder<>"}"->"\\"<>funString,
                "\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"}"->right
            }
        ]
    ];


(* ::Text:: *)
(*f[x,y,...]->f{x}{y}...*)


MFDefineKernel[{fun_Symbol[Verbatim[BlankNullSequence][]],funString_String},left_String:"{",right_String:"}"] :=
    With[ {
            funPlaceholder = ToString[fun],
            funLeft = ToString[fun]<>$macroLeftDelimiter,
            funRight = ToString[fun]<>$macroRightDelimiter
        },
        clearFormat[fun,fun[arg$___]];
        fun/:MakeBoxes[fun[arg___],TraditionalForm] :=
            RowBox@{
                funPlaceholder,
                Sequence@@Flatten@Map[{funLeft,makeTraditionalBoxes[#],funRight}&,{arg}]
            };
        updateMFData[
            funPlaceholder->{
                "\\text{"<>funPlaceholder<>"}"->"\\"<>funString,
                "\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"}"->right
            }
        ];
    ];


(* ::Text:: *)
(*f[{x,y,...}]->f{x,y,...}*)


MFDefineKernel[{fun_Symbol[Verbatim[Blank][List]],funString_String},left_String:"{\n\t",right_String:"\n}",delimiter_String:",\n\t"] :=
    With[ {
            funPlaceholder = ToString[fun],
            funLeft = ToString[fun]<>$macroLeftDelimiter,
            funRight = ToString[fun]<>$macroRightDelimiter,
            funDelimiter = ToString[fun]<>$macroListSeparator
        },
        clearFormat[fun,fun[arg$_List]];
        fun/:MakeBoxes[fun[arg_List],TraditionalForm] :=
            RowBox@{
                funPlaceholder,
                funLeft,
                Sequence@@Riffle[Map[makeTraditionalBoxes,arg],funDelimiter],
                funRight
            };
        updateMFData[
            funPlaceholder->{
                "\\text{"<>funPlaceholder<>"}"->"\\"<>funString,
                "\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"}"->right,
                "\\text{"<>funDelimiter<>"}"->delimiter
            }
        ]
    ];


(* ::Text:: *)
(*f[{x,...},{y,...},...]->f{x,...}{y,...}...*)


MFDefineKernel[{fun_Symbol[Verbatim[BlankNullSequence][List]],funString_String},left_String:"{\n\t",right_String:"\n}",delimiter_String:",\n\t"] :=
    With[ {
            funPlaceholder = ToString[fun],
            funLeft = ToString[fun]<>$macroLeftDelimiter,
            funRight = ToString[fun]<>$macroRightDelimiter,
            funDelimiter = ToString[fun]<>$macroListSeparator
        },
        clearFormat[fun,fun[arg$___List]];
        fun/:MakeBoxes[fun[arg___List],TraditionalForm] :=
            RowBox@{
                funPlaceholder,
                Sequence@@Flatten@Map[{funLeft,Riffle[Map[makeTraditionalBoxes,#],funDelimiter],funRight}&,{arg}]
            };
        updateMFData[
            funPlaceholder->{
                "\\text{"<>funPlaceholder<>"}"->"\\"<>funString,
                "\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"}"->right,
                "\\text{"<>funDelimiter<>"}"->delimiter
            }
        ];
    ];


(* ::Subsection:: *)
(*Helper*)


stripFunPattern[
    fun_Symbol|
    fun_Symbol[Verbatim[Blank][]]|
    fun_Symbol[Verbatim[BlankNullSequence][]]|
    fun_Symbol[Verbatim[Blank][List]]|
    fun_Symbol[Verbatim[BlankNullSequence][List]]
] :=
    ToString[fun];


updateMFData[data_] :=
    (
        $MFAssoc =
            Association[$MFAssoc,data];
        $MFRule =
            $MFAssoc//Values//Flatten;
    );


clearFormat//Attributes =
    {HoldAllComplete};

clearFormat[fun_Symbol,pattern_] :=
    Module[ {notFromMFDefine},
        notFromMFDefine =
            DeleteCases[
                FormatValues@fun,
                Verbatim[HoldPattern[MakeBoxes[pattern,TraditionalForm]]]:>_
            ];
        If[ notFromMFDefine=!={},
            Message[MFDefine::clearformat,fun]
        ];
        FormatValues[fun] = {};
    ];


makeTraditionalBoxes//Attributes =
    {HoldAllComplete};

makeTraditionalBoxes[expr_] :=
    MakeBoxes[expr,TraditionalForm];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];