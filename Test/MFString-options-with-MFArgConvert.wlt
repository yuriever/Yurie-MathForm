

(* MFString-options-with-MFArgConvert.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    MFClear[]
    ,
    Null
    ,
    TestID->"[2] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    Off[MFArgConvert::FormatCleared]
    ,
    Null
    ,
    TestID->"[3] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    testOption[expr_] := Outer[MFString[expr, "Linebreak" -> #1, "RemoveLeftRightPair" -> #2] & , {True, False}, {True, False}]
    ,
    Null
    ,
    TestID->"[4] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    MFArgConvert["{", "}"][Fpq[_]]; 
    testOption[Fpq[1/z]]
    ,
    {{"\\Fpq{\\frac{1}{z}}", "\\Fpq{\\frac{1}{z}}"}, {"\\Fpq{\\frac{1}{z}}", "\\Fpq{\\frac{1}{z}}"}}
    ,
    TestID->"[5] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    MFArgConvert["{", "}"][Fpq[___]]; 
    testOption[Fpq[1/x, 1/y]]
    ,
    {{"\\Fpq{\\frac{1}{x}}{\\frac{1}{y}}", "\\Fpq{\\frac{1}{x}}{\\frac{1}{y}}"}, {"\\Fpq{\\frac{1}{x}}{\\frac{1}{y}}", "\\Fpq{\\frac{1}{x}}{\\frac{1}{y}}"}}
    ,
    TestID->"[6] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    MFArgConvert["{", "}", ","][Fpq[_List]]; 
    testOption[Fpq[{1/x, 1/y}]]
    ,
    {{"\\Fpq{\\frac{1}{x},\\frac{1}{y}}", "\\Fpq{\\frac{1}{x},\\frac{1}{y}}"}, {"\\Fpq{\\frac{1}{x},\\frac{1}{y}}", "\\Fpq{\\frac{1}{x},\\frac{1}{y}}"}}
    ,
    TestID->"[7] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    MFArgConvert["{", "}", ","][Fpq[___List]]; 
    testOption[Fpq[{1/x, 1/y}, {1/z}]]
    ,
    {{"\\Fpq{\\frac{1}{x},\\frac{1}{y}}{\\frac{1}{z}}", "\\Fpq{\\frac{1}{x},\\frac{1}{y}}{\\frac{1}{z}}"}, {"\\Fpq{\\frac{1}{x},\\frac{1}{y}}{\\frac{1}{z}}", "\\Fpq{\\frac{1}{x},\\frac{1}{y}}{\\frac{1}{z}}"}}
    ,
    TestID->"[8] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    MFArgConvert["\\left{", "\\right}"][Fpq[_]]; 
    testOption[Fpq[1/z]]
    ,
    {{"\\Fpq\\left{\\frac{1}{z}\\right}", "\\Fpq\\left{\\frac{1}{z}\\right}"}, {"\\Fpq\\left{\\frac{1}{z}\\right}", "\\Fpq\\left{\\frac{1}{z}\\right}"}}
    ,
    TestID->"[9] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    MFArgConvert["\\left{", "\\right}"][Fpq[___]]; 
    testOption[Fpq[1/x, 1/y]]
    ,
    {{"\\Fpq\\left{\\frac{1}{x}\\right}\\left{\\frac{1}{y}\\right}", "\\Fpq\\left{\\frac{1}{x}\\right}\\left{\\frac{1}{y}\\right}"}, {"\\Fpq\\left{\\frac{1}{x}\\right}\\left{\\frac{1}{y}\\right}", "\\Fpq\\left{\\frac{1}{x}\\right}\\left{\\frac{1}{y}\\right}"}}
    ,
    TestID->"[10] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    MFArgConvert["\\left{", "\\right}", ","][Fpq[_List]]; 
    testOption[Fpq[{1/x, 1/y}]]
    ,
    {{"\\Fpq\\left{\\frac{1}{x},\\frac{1}{y}\\right}", "\\Fpq\\left{\\frac{1}{x},\\frac{1}{y}\\right}"}, {"\\Fpq\\left{\\frac{1}{x},\\frac{1}{y}\\right}", "\\Fpq\\left{\\frac{1}{x},\\frac{1}{y}\\right}"}}
    ,
    TestID->"[11] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    MFArgConvert["\\left{", "\\right}", ","][Fpq[___List]]; 
    testOption[Fpq[{1/x, 1/y}, {1/z}]]
    ,
    {{"\\Fpq\\left{\\frac{1}{x},\\frac{1}{y}\\right}\\left{\\frac{1}{z}\\right}", "\\Fpq\\left{\\frac{1}{x},\\frac{1}{y}\\right}\\left{\\frac{1}{z}\\right}"}, {"\\Fpq\\left{\\frac{1}{x},\\frac{1}{y}\\right}\\left{\\frac{1}{z}\\right}", "\\Fpq\\left{\\frac{1}{x},\\frac{1}{y}\\right}\\left{\\frac{1}{z}\\right}"}}
    ,
    TestID->"[12] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    MFClear[]
    ,
    Null
    ,
    TestID->"[13] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    On[MFArgConvert::FormatCleared]
    ,
    Null
    ,
    TestID->"[14] MFString-options-with-MFArgConvert.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-options-with-MFArgConvert.nb"
]