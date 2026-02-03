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
    "MFArgConvert[left, right, sep][f->\"f\", ...]: define LaTeX macro for the symbol."<>
    "\n"<>
    "f[x]->\\f{x}"<>
    "\n"<>
    "f[x, y, ...]->\\f{x}{y}..."<>
    "\n"<>
    "f[{x, y, ...}]->\\f{x, y, ...}"<>
    "\n"<>
    "f[{x, ...}, {y, ...}, ...]->\\f{x, ...}{y, ...}...";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Constant*)


$macroLeftDelimiter::usage =
    "left delimiter.";

$macroRightDelimiter::usage =
    "right delimiter.";

$macroListSeparator::usage =
    "list separator.";


$macroLeftDelimiter = "MFLEFT";

$macroRightDelimiter = "MFRIGHT";

$macroListSeparator = "MFLISTSEP";


(* ::Text:: *)
(*In MFArgConvertKernel, when evaluating MakeBoxes, the local variable arg will be renamed as arg$, which enters into the format value.*)
(*The function clearFormat needs to match this format value from MFArgConvertKernel, hence we need use arg$.*)


arg;

arg$;


(* ::Subsection:: *)
(*Message*)


MFArgConvert::InvalidInput =
    "The input `` is invalid.";

MFArgConvert::FunPatternUnsupported =
    "The function pattern `` is not supported.";

MFArgConvert::FunNameIndetermined =
    "The function name cannot be determined by the pattern ``.";

MFArgConvert::FormatCleared =
    "The existing format values of the symbol `` are cleared.";


(* ::Subsection:: *)
(*Main*)


MFArgConvert[args___][list_List] :=
    Scan[MFArgConvertKernel2[args],list]//Catch;

MFArgConvert[args___][arg_] :=
    MFArgConvertKernel2[args][arg]//Catch;


MFArgConvertKernel2[args___][Rule[funp_,funstr_String]] :=
    MFArgConvertKernel[{funp,funstr},args];

MFArgConvertKernel2[args___][funp_] :=
    MFArgConvertKernel2[args][Rule[funp,stripFunPattern[funp]]];


(* ::Subsubsection:: *)
(*Default delimiter*)


(* ::Text:: *)
(*f[x]->\f{x}*)


MFArgConvertKernel2[][Rule[funp:_Symbol[Verbatim[Blank][]],funstr_String]] :=
    MFArgConvertKernel[{funp,funstr},"{","}"];


(* ::Text:: *)
(*f[x,y,...]->f{x}{y}...*)


MFArgConvertKernel2[][Rule[funp:_Symbol[Verbatim[BlankNullSequence][]],funstr_String]] :=
    MFArgConvertKernel[{funp,funstr},"{","}"];


(* ::Text:: *)
(*f[{x,y,...}]->f{x,y,...}*)


MFArgConvertKernel2[][Rule[funp:_Symbol[Verbatim[Blank][List]],funstr_String]] :=
    MFArgConvertKernel[{funp,funstr},"{\n\t","\n}",",\n\t"];


(* ::Text:: *)
(*f[{x,...},{y,...},...]->f{x,...}{y,...}...*)


MFArgConvertKernel2[][Rule[funp:_Symbol[Verbatim[BlankNullSequence][List]],funstr_String]] :=
    MFArgConvertKernel[{funp,funstr},"{\n\t","\n}",",\n\t"];


(* ::Subsection:: *)
(*Kernel*)


(* ::Subsubsection:: *)
(*Exception*)


MFArgConvertKernel[{fun_,funstr_},___] :=
    (
        Message[MFArgConvert::FunPatternUnsupported,Rule[fun,funstr]];
        Throw[Null];
    );

MFArgConvertKernel[args___] :=
    (
        Message[MFArgConvert::InvalidInput,{args}];
        Throw[Null];
    );


(* ::Subsubsection:: *)
(*Kernel*)


(* ::Text:: *)
(*f->\f*)


MFArgConvertKernel[{fun_Symbol,funstr_String}] :=
    With[{funPlaceholder = ToString[fun]},
        clearFormat[fun,fun];
        fun/:MakeBoxes[fun,TraditionalForm] :=
            funPlaceholder;
        updateMFData[
            funPlaceholder->{
                "\\text{"<>funPlaceholder<>"}"->prependSlash[funstr]
            }
        ]
    ];


(* ::Text:: *)
(*f[x]->\f{x}*)


MFArgConvertKernel[{fun_Symbol[Verbatim[Blank][]],funstr_String},left_String,right_String] :=
    With[{
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
                "\\text{"<>funPlaceholder<>"}"->prependSlash[funstr],
                "\\left(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"}\\right)"->right,
                "(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"})"->right
            }
        ]
    ];


(* ::Text:: *)
(*f[x,y,...]->f{x}{y}...*)


MFArgConvertKernel[{fun_Symbol[Verbatim[BlankNullSequence][]],funstr_String},left_String,right_String] :=
    With[{
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
                "\\text{"<>funPlaceholder<>"}"->prependSlash[funstr],
                "\\text{"<>funRight<>"}\\text{"<>funLeft<>"}"->right<>left,
                "\\left(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"}\\right)"->right,
                "(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"})"->right
            }
        ];
    ];


(* ::Text:: *)
(*f[{x,y,...}]->f{x,y,...}*)


MFArgConvertKernel[{fun_Symbol[Verbatim[Blank][List]],funstr_String},left_String,right_String,delimiter_String] :=
    With[{
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
                "\\text{"<>funPlaceholder<>"}"->prependSlash[funstr],
                "\\left(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"}\\right)"->right,
                "(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"})"->right,
                "\\text{"<>funDelimiter<>"}"->delimiter
            }
        ]
    ];


(* ::Text:: *)
(*f[{x,...},{y,...},...]->f{x,...}{y,...}...*)


MFArgConvertKernel[{fun_Symbol[Verbatim[BlankNullSequence][List]],funstr_String},left_String,right_String,delimiter_String] :=
    With[{
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
                "\\text{"<>funPlaceholder<>"}"->prependSlash[funstr],
                "\\text{"<>funRight<>"}\\text{"<>funLeft<>"}"->right<>left,
                "\\left(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"}\\right)"->right,
                "(\\text{"<>funLeft<>"}"->left,
                "\\text{"<>funRight<>"})"->right,
                "\\text{"<>funDelimiter<>"}"->delimiter
            }
        ];
    ];


(* ::Subsection:: *)
(*Helper*)


prependSlash[str_String] :=
    If[StringStartsQ[str,"\\"],
        (* Then *)
        str,
        (* Else *)
        "\\"<>str
    ];


stripFunPattern[
    fun_Symbol|
    fun_Symbol[Verbatim[Blank][]]|
    fun_Symbol[Verbatim[BlankNullSequence][]]|
    fun_Symbol[Verbatim[Blank][List]]|
    fun_Symbol[Verbatim[BlankNullSequence][List]]
] :=
    ToString[fun];

stripFunPattern[other_] :=
    (
        Message[MFArgConvert::FunNameIndetermined,other];
        Throw[Null];
    );


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
    Module[{notFromMFArgConvert},
        notFromMFArgConvert =
            DeleteCases[
                FormatValues@fun,
                Verbatim[HoldPattern[MakeBoxes[pattern,TraditionalForm]]]:>_
            ];
        If[notFromMFArgConvert=!={},
            Message[MFArgConvert::FormatCleared,fun]
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
