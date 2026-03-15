(* MFString-V1-fraction-denominator-parens.wlt *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-V1-fraction-denominator-parens.wlt"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-V1-fraction-denominator-parens.wlt"
]

VerificationTest[
    SetOptions[{MFString}, "LinebreakThreshold" -> 2, "Method" -> "V1"]
    ,
    {{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 2, "LinebreakIgnore" -> {}, "Method" -> "V1"}}
    ,
    TestID->"[2] MFString-V1-fraction-denominator-parens.wlt"
]

VerificationTest[
    MFString[1/((a + b)*(c + d))]
    ,
    "\\frac{1}{\n    (a+b)\n    (c+d)\n}"
    ,
    TestID->"[3] MFString-V1-fraction-denominator-parens.wlt"
]

VerificationTest[
    MFString[1/((-a + b)*(c + d))]
    ,
    "\\frac{1}{\n    (b-a)\n    (c+d)\n}"
    ,
    TestID->"[4] MFString-V1-fraction-denominator-parens.wlt"
]

VerificationTest[
    MFString[1/((a + b)*(c + d)), "LinebreakThreshold" -> 10]
    ,
    "\\frac{1}{(a+b) (c+d)}"
    ,
    TestID->"[4b] MFString-V1-fraction-denominator-parens.wlt"
]

VerificationTest[
    SetOptions[{MFString}, "LinebreakThreshold" -> 6, "Method" -> "V1"]
    ,
    {{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 6, "LinebreakIgnore" -> {}, "Method" -> "V1"}}
    ,
    TestID->"[5] MFString-V1-fraction-denominator-parens.wlt"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[inf] MFString-V1-fraction-denominator-parens.wlt"
]
