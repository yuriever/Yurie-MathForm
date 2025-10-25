

(* MFMakeBox.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFMakeBox.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFMakeBox.nb"
]

VerificationTest[
    display[expr_] := FullForm[MakeBoxes[expr]]; 
    ,
    Null
    ,
    TestID->"[2] MFMakeBox.nb"
]

VerificationTest[
    Null
    ,
    Null
    ,
    TestID->"[3] MFMakeBox.nb"
]

VerificationTest[
    test = Yurie`MathForm`MFMakeBox`Private`getHeadFromPattern; 
    ,
    Null
    ,
    TestID->"[4] MFMakeBox.nb"
]

VerificationTest[
    test[x]
    ,
    HoldComplete[x]
    ,
    TestID->"[5] MFMakeBox.nb"
]

VerificationTest[
    test[f[x_]]
    ,
    HoldComplete[f]
    ,
    TestID->"[6] MFMakeBox.nb"
]

VerificationTest[
    test[f[x_][y_]]
    ,
    HoldComplete[f]
    ,
    TestID->"[7] MFMakeBox.nb"
]

VerificationTest[
    test[HoldPattern[f[x_]]]
    ,
    HoldComplete[f]
    ,
    TestID->"[8] MFMakeBox.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFMakeBox[{dot[x_, y_], MakeBoxes[x · y]}]
    ,
    Null
    ,
    TestID->"[9] MFMakeBox.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"[10] MFMakeBox.nb"
]

VerificationTest[
    display[dot[a, b]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], dot[a, b]]]
    ,
    TestID->"[11] MFMakeBox.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFMakeBox[{dot[x_, y_], MakeBoxes[x · y], h[x, y]}]
    ,
    Null
    ,
    TestID->"[12] MFMakeBox.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"[13] MFMakeBox.nb"
]

VerificationTest[
    display[dot[a, b]]
    ,
    FullForm[InterpretationBox[RowBox[{"a", "·", "b"}], h[a, b]]]
    ,
    TestID->"[14] MFMakeBox.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFMakeBox[{dot[x_, y_], MakeBoxes[x · y]}, "Tooltip" -> Full]
    ,
    Null
    ,
    TestID->"[15] MFMakeBox.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"[16] MFMakeBox.nb"
]

VerificationTest[
    display[dot[a, b]]
    ,
    FullForm[InterpretationBox[TooltipBox[RowBox[{"a", "·", "b"}], "dot[a, b]"], dot[a, b], SyntaxForm -> Automatic]]
    ,
    TestID->"[17] MFMakeBox.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFMakeBox[{dot[x_, y_], MakeBoxes[x · y]}, "Tooltip" -> Dot]
    ,
    Null
    ,
    TestID->"[18] MFMakeBox.nb"
]

VerificationTest[
    MFString[dot[a, b]]
    ,
    "a\\cdot b"
    ,
    TestID->"[19] MFMakeBox.nb"
]

VerificationTest[
    display[dot[a, b]]
    ,
    FullForm[InterpretationBox[TooltipBox[RowBox[{"a", "·", "b"}], Dot], dot[a, b], SyntaxForm -> Automatic]]
    ,
    TestID->"[20] MFMakeBox.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFMakeBox[{dot[x_, y_], MakeBoxes[x · y]}, "Tooltip" -> Automatic]
    ,
    Null
    ,
    TestID->"[21] MFMakeBox.nb"
]

VerificationTest[
    display[dot[a, b]^2]
    ,
    FullForm[SuperscriptBox[InterpretationBox[TooltipBox[RowBox[{"a", "·", "b"}], "dot"], dot[a, b], SyntaxForm -> Automatic], "2"]]
    ,
    TestID->"[22] MFMakeBox.nb"
]

VerificationTest[
    MFClear[dot]; 
    MFMakeBox[{dot[x_, y_], MakeBoxes[x · y]}, "Tooltip" -> Automatic, "SyntaxForm" -> Dot]
    ,
    Null
    ,
    TestID->"[23] MFMakeBox.nb"
]

VerificationTest[
    display[dot[a, b]^2]
    ,
    FullForm[SuperscriptBox[RowBox[{"(", InterpretationBox[TooltipBox[RowBox[{"a", "·", "b"}], "dot"], dot[a, b], SyntaxForm -> Dot], ")"}], "2"]]
    ,
    TestID->"[24] MFMakeBox.nb"
]

VerificationTest[
    MFClear[f, g]; 
    MFMakeBox[{f[x_], MakeBoxes[Subscript[f, x]]}, {g[x_], MakeBoxes[Subscript[g, x]], h[x]}]
    ,
    Null
    ,
    TestID->"[25] MFMakeBox.nb"
]

VerificationTest[
    MFString[{f[a], g[a]}]
    ,
    "\\{f_a,g_a\\}"
    ,
    TestID->"[26] MFMakeBox.nb"
]

VerificationTest[
    display[f[a]]
    ,
    FullForm[InterpretationBox[SubscriptBox["f", "a"], f[a]]]
    ,
    TestID->"[27] MFMakeBox.nb"
]

VerificationTest[
    display[g[a]]
    ,
    FullForm[InterpretationBox[SubscriptBox["g", "a"], h[a]]]
    ,
    TestID->"[28] MFMakeBox.nb"
]

VerificationTest[
    MFClear[f]; 
    ClearAll[f]
    ,
    Null
    ,
    TestID->"[29] MFMakeBox.nb"
]

VerificationTest[
    f = 1; 
    MFMakeBox[{f[a_], MakeBoxes[Subscript[f, a]]}]; 
    MFMakeBox[{f[a_][b_], MakeBoxes[Subscript[f, a, b]]}]
    ,
    Null
    ,
    TestID->"[30] MFMakeBox.nb"
]

VerificationTest[
    display[Hold[f[x], f[x][y]]]
    ,
    FullForm[RowBox[{"Hold", "[", RowBox[{InterpretationBox[SubscriptBox["f", "x"], f[x]], ",", InterpretationBox[SubscriptBox["f", RowBox[{"x", ",", "y"}]], f[x][y]]}], "]"}]]
    ,
    TestID->"[31] MFMakeBox.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFMakeBox.nb"
]