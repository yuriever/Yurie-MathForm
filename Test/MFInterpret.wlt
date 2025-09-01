

(* MFInterpret.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFInterpret.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFInterpret.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFInterpret[Format, {dot[x_, y_], x · y}]
    ,
    Null
    ,
    {General::deprecation}
    ,
    TestID->"[2] MFInterpret.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"[3] MFInterpret.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], dot[a, b]]]
    ,
    TestID->"[4] MFInterpret.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFInterpret[Format, TraditionalForm, {dot[x_, y_], x · y}]
    ,
    Null
    ,
    {General::deprecation}
    ,
    TestID->"[5] MFInterpret.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"[6] MFInterpret.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[RowBox[{"dot", "[", RowBox[{"a", ",", "b"}], "]"}]]
    ,
    TestID->"[7] MFInterpret.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFInterpret[MakeBoxes, {dot[x_, y_], RowBox[{MakeBoxes[x], "·", MakeBoxes[y]}]}]
    ,
    Null
    ,
    {General::deprecation}
    ,
    TestID->"[8] MFInterpret.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"[9] MFInterpret.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], dot[a, b]]]
    ,
    TestID->"[10] MFInterpret.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFInterpret[MakeBoxes, {{dot[x_, y_], RowBox[{MakeBoxes[x], "·", MakeBoxes[y]}]}}]
    ,
    Null
    ,
    {General::deprecation}
    ,
    TestID->"[11] MFInterpret.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"[12] MFInterpret.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], dot[a, b]]]
    ,
    TestID->"[13] MFInterpret.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFInterpret[MakeBoxes, format_, {dot[x_, y_], RowBox[{MakeBoxes[x, format], "·", MakeBoxes[y, format]}]}]
    ,
    Null
    ,
    {General::deprecation}
    ,
    TestID->"[14] MFInterpret.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"[15] MFInterpret.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], dot[a, b]]]
    ,
    TestID->"[16] MFInterpret.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFInterpret[Format, {dot[x_, y_], x · y, h[x, y]}]
    ,
    Null
    ,
    {General::deprecation}
    ,
    TestID->"[17] MFInterpret.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], h[a, b]]]
    ,
    TestID->"[18] MFInterpret.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFInterpret[MakeBoxes, {dot[x_, y_], RowBox[{MakeBoxes[x], "·", MakeBoxes[y]}], h[x, y]}]
    ,
    Null
    ,
    {General::deprecation}
    ,
    TestID->"[19] MFInterpret.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], h[a, b]]]
    ,
    TestID->"[20] MFInterpret.nb"
]

VerificationTest[
    MFInterpret[Format, {{f[x_], Subscript[f, x]}, {g[x_], Subscript[g, x], h[x]}}]
    ,
    Null
    ,
    {General::deprecation,General::deprecation}
    ,
    TestID->"[21] MFInterpret.nb"
]

VerificationTest[
    MFString[{f[a], g[a]}]
    ,
    "\\{f_a,g_a\\}"
    ,
    TestID->"[22] MFInterpret.nb"
]

VerificationTest[
    FullForm[MakeBoxes[f[a]]]
    ,
    FullForm[InterpretationBox[SubscriptBox["f", "a"], f[a]]]
    ,
    TestID->"[23] MFInterpret.nb"
]

VerificationTest[
    FullForm[MakeBoxes[g[a]]]
    ,
    FullForm[InterpretationBox[SubscriptBox["g", "a"], h[a]]]
    ,
    TestID->"[24] MFInterpret.nb"
]

VerificationTest[
    MFClear[f]
    ,
    Null
    ,
    TestID->"[25] MFInterpret.nb"
]

VerificationTest[
    f[a]
    ,
    f[a]
    ,
    TestID->"[26] MFInterpret.nb"
]

VerificationTest[
    FullForm[MakeBoxes[g[a]]]
    ,
    FullForm[InterpretationBox[SubscriptBox["g", "a"], h[a]]]
    ,
    TestID->"[27] MFInterpret.nb"
]

VerificationTest[
    MFClear[g]
    ,
    Null
    ,
    TestID->"[28] MFInterpret.nb"
]

VerificationTest[
    {f[x], g[x]}
    ,
    {f[x], g[x]}
    ,
    TestID->"[29] MFInterpret.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFInterpret.nb"
]