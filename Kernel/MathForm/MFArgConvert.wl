(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`MathForm`MFArgConvert`"];


Needs["Yurie`MathForm`"];

Needs["Yurie`MathForm`Constant`"];

Needs["Yurie`MathForm`Variable`"];


(* ::Section:: *)
(*Public*)


MFArgConvert::usage =
    "define LaTeX macro for the symbol and store the rule into $MFAssoc.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Constant*)


(* ::Text:: *)
(*In MFArgConvertKernel, when evaluating MakeBoxes, the local variable arg will be renamed as arg$, which enters into the format value.*)
(*The function clearFormat needs to match this format value from MFArgConvertKernel, hence we need use arg$.*)


arg;

arg$;


(* ::Subsection:: *)
(*Message*)


MFArgConvert::notsupported =
    "the pattern `` is not supported.";

MFArgConvert::clearformat =
    "the existing format values of the symbol `` are cleared.";


(* ::Subsection:: *)
(*Main*)


MFArgConvert[args___][list_List] :=
    Scan[MFArgConvertKernel2[args],list]//Catch;

MFArgConvert[args___][arg_] :=
    MFArgConvertKernel2[args][arg]//Catch;


MFArgConvertKernel2[args___][Verbatim[Rule][funPattern_,funString_String]] :=
    MFArgConvertKernel[{funPattern,funString},args];

MFArgConvertKernel2[args___][funPattern_] :=
    MFArgConvertKernel[{funPattern,stripFunPattern[funPattern]},args];


(* ::Subsubsection:: *)
(*MFArgConvertKernel*)


MFArgConvertKernel[args___] :=
    (
        Message[MFArgConvert::notsupported,{args}[[1,1]]];
        Throw[Null];
    );


(* ::Text:: *)
(*f->\f*)


MFArgConvertKernel[{fun_Symbol,funString_String}] :=
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


MFArgConvertKernel[{fun_Symbol[Verbatim[Blank][]],funString_String},left_String:"{",right_String:"}"] :=
    With[ {
            funPlaceholder = ToString[fun],
            funLeft = ToString[fun]<>$macroLeftDelimiter,
            funRight = ToString[fun]<>$macroRightDelimiter
        },
        clearFormat[fun,fun[arg$_]];
        fun/:MakeBoxes[fun[arg_],TraditionalForm] :=
            RowBox@{
                funPlaceholder,
                "(",
                RowBox@{
                    funLeft,
                    makeTraditionalBoxes[arg],
                    funRight
                },
                ")"
            };
        updateMFData[
            funPlaceholder->{
                "\\text{"<>funPlaceholder<>"}"->"\\"<>funString,
                "(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"})"->right
            }
        ]
    ];


(* ::Text:: *)
(*f[x,y,...]->f{x}{y}...*)


MFArgConvertKernel[{fun_Symbol[Verbatim[BlankNullSequence][]],funString_String},left_String:"{",right_String:"}"] :=
    With[ {
            funPlaceholder = ToString[fun],
            funLeft = ToString[fun]<>$macroLeftDelimiter,
            funRight = ToString[fun]<>$macroRightDelimiter
        },
        clearFormat[fun,fun[arg$___]];
        fun/:MakeBoxes[fun[arg___],TraditionalForm] :=
            RowBox@{
                funPlaceholder,
                "(",
                RowBox@Map[
                    RowBox[{funLeft,makeTraditionalBoxes[#],funRight}]&,
                    {arg}
                ],
                ")"
            };
        updateMFData[
            funPlaceholder->{
                "\\text{"<>funPlaceholder<>"}"->"\\"<>funString,
                "\\text{"<>funRight<>"}\\text{"<>funLeft<>"}"->right<>left,
                "(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"})"->right
            }
        ];
    ];


(* ::Text:: *)
(*f[{x,y,...}]->f{x,y,...}*)


MFArgConvertKernel[{fun_Symbol[Verbatim[Blank][List]],funString_String},left_String:"{\n\t",right_String:"\n}",delimiter_String:",\n\t"] :=
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
                "(",
                RowBox@{
                    funLeft,
                    Splice@Riffle[Map[makeTraditionalBoxes,arg],funDelimiter],
                    funRight
                },
                ")"
            };
        updateMFData[
            funPlaceholder->{
                "\\text{"<>funPlaceholder<>"}"->"\\"<>funString,
                "(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"})"->right,
                "\\text{"<>funDelimiter<>"}"->delimiter
            }
        ]
    ];


(* ::Text:: *)
(*f[{x,...},{y,...},...]->f{x,...}{y,...}...*)

                RowBox@Map[
                    RowBox[{funLeft,makeTraditionalBoxes[#],funRight}]&,
                    {arg}
                ]


MFArgConvertKernel[{fun_Symbol[Verbatim[BlankNullSequence][List]],funString_String},left_String:"{\n\t",right_String:"\n}",delimiter_String:",\n\t"] :=
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
                "(",
                RowBox@Map[
                    RowBox@{
                        funLeft,
                        Splice@Riffle[Map[makeTraditionalBoxes,#],funDelimiter],
                        funRight
                    }&,
                    {arg}
                ],
                ")"
            };
        updateMFData[
            funPlaceholder->{
                "\\text{"<>funPlaceholder<>"}"->"\\"<>funString,
                "\\text{"<>funRight<>"}\\text{"<>funLeft<>"}"->right<>left,
                "(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"})"->right,
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
    Module[ {notFromMFArgConvert},
        notFromMFArgConvert =
            DeleteCases[
                FormatValues@fun,
                Verbatim[HoldPattern[MakeBoxes[pattern,TraditionalForm]]]:>_
            ];
        If[ notFromMFArgConvert=!={},
            Message[MFArgConvert::clearformat,fun]
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
