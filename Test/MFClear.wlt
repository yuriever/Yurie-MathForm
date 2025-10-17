

(* MFClear.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFClear.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFClear.nb"
]

VerificationTest[
    MFMakeBox[{f[x_], MakeBoxes[Subscript[f, x]]}, {g[x_], MakeBoxes[Subscript[g, x]], h[x]}]
    ,
    Null
    ,
    TestID->"[2] MFClear.nb"
]

VerificationTest[
    MFClear[f]
    ,
    Null
    ,
    TestID->"[3] MFClear.nb"
]

VerificationTest[
    f[x]
    ,
    f[x]
    ,
    TestID->"[4] MFClear.nb"
]

VerificationTest[
    FullForm[MakeBoxes[g[x]]]
    ,
    FullForm[InterpretationBox[SubscriptBox["g", "x"], h[x]]]
    ,
    TestID->"[5] MFClear.nb"
]

VerificationTest[
    MFClear[g]
    ,
    Null
    ,
    TestID->"[6] MFClear.nb"
]

VerificationTest[
    {f[x], g[x]}
    ,
    {f[x], g[x]}
    ,
    TestID->"[7] MFClear.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFClear.nb"
]