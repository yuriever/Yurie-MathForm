

(*MFMakeBox.nb*)

VerificationTest[
    Begin["Global`"];
	ClearAll["`*"]
    ,
    Null
    ,
    TestID->"0-MFMakeBox.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"1-MFMakeBox.nb"
]

VerificationTest[
    test = Yurie`MathForm`MFMakeBox`Private`getHeadFromPattern; 
    ,
    Null
    ,
    TestID->"2-MFMakeBox.nb"
]

VerificationTest[
    test[x, Hold]
    ,
    Hold[x]
    ,
    TestID->"3-MFMakeBox.nb"
]

VerificationTest[
    test[HoldPattern[x], Hold]
    ,
    Hold[x]
    ,
    TestID->"4-MFMakeBox.nb"
]

VerificationTest[
    test[f[x_], Hold]
    ,
    Hold[f]
    ,
    TestID->"5-MFMakeBox.nb"
]

VerificationTest[
    test[HoldPattern[f[x_]], Hold]
    ,
    Hold[f]
    ,
    TestID->"6-MFMakeBox.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFMakeBox[{dot[x_, y_], MakeBoxes[x · y]}]
    ,
    Null
    ,
    TestID->"7-MFMakeBox.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"8-MFMakeBox.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], dot[a, b]]]
    ,
    TestID->"9-MFMakeBox.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFMakeBox[{dot[x_, y_], MakeBoxes[x · y], TraditionalForm}]
    ,
    Null
    ,
    TestID->"10-MFMakeBox.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"11-MFMakeBox.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[RowBox[{"dot", "[", RowBox[{"a", ",", "b"}], "]"}]]
    ,
    TestID->"12-MFMakeBox.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFMakeBox[{dot[x_, y_], RowBox[{MakeBoxes[x, format], "·", MakeBoxes[y, format]}], format_}]
    ,
    Null
    ,
    TestID->"13-MFMakeBox.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"14-MFMakeBox.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], dot[a, b]]]
    ,
    TestID->"15-MFMakeBox.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFMakeBox[{dot[x_, y_], MakeBoxes[x · y], h[x, y], _}]
    ,
    Null
    ,
    TestID->"16-MFMakeBox.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"17-MFMakeBox.nb"
]

VerificationTest[
    FullForm[MakeBoxes[dot[a, b]]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], h[a, b]]]
    ,
    TestID->"18-MFMakeBox.nb"
]

VerificationTest[
    MFMakeBox[{{f[x_], MakeBoxes[Subscript[f, x]]}, {g[x_], MakeBoxes[Subscript[g, x]], h[x], _}}]
    ,
    Null
    ,
    TestID->"19-MFMakeBox.nb"
]

VerificationTest[
    MFString[{f[a], g[a]}]
    ,
    "\\{f_a,g_a\\}"
    ,
    TestID->"20-MFMakeBox.nb"
]

VerificationTest[
    FullForm[MakeBoxes[f[a]]]
    ,
    FullForm[InterpretationBox[SubscriptBox["f", "a"], f[a]]]
    ,
    TestID->"21-MFMakeBox.nb"
]

VerificationTest[
    FullForm[MakeBoxes[g[a]]]
    ,
    FullForm[InterpretationBox[SubscriptBox["g", "a"], h[a]]]
    ,
    TestID->"22-MFMakeBox.nb"
]

VerificationTest[
    MFClear[f]
    ,
    Null
    ,
    TestID->"23-MFMakeBox.nb"
]

VerificationTest[
    f[a]
    ,
    f[a]
    ,
    TestID->"24-MFMakeBox.nb"
]

VerificationTest[
    FullForm[MakeBoxes[g[a]]]
    ,
    FullForm[InterpretationBox[SubscriptBox["g", "a"], h[a]]]
    ,
    TestID->"25-MFMakeBox.nb"
]

VerificationTest[
    MFClear[g]
    ,
    Null
    ,
    TestID->"26-MFMakeBox.nb"
]

VerificationTest[
    {f[x], g[x]}
    ,
    {f[x], g[x]}
    ,
    TestID->"27-MFMakeBox.nb"
]

VerificationTest[
    ClearAll["`*"];
	End[]
    ,
    "Global`"
    ,
    TestID->"∞-MFMakeBox.nb"
]