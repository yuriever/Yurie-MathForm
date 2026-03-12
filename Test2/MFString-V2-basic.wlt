
(* MFString-V2-basic.wlt *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-V2-basic.wlt"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-V2-basic.wlt"
]

VerificationTest[
    SetOptions[{MFString}, "LinebreakThreshold" -> 2, "Method" -> "V2"]
    ,
    {{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 2, "LinebreakIgnore" -> {}, "Method" -> "V2"}}
    ,
    TestID->"[2] MFString-V2-basic.wlt"
]


(* --- Simple cases: no linebreak --- *)

VerificationTest[
    MFString[-a]
    ,
    "-a"
    ,
    TestID->"[3] MFString-V2-basic.wlt"
]

VerificationTest[
    MFString[a - b + c]
    ,
    "a-b+c"
    ,
    TestID->"[4] MFString-V2-basic.wlt"
]

VerificationTest[
    MFString[-a - b]
    ,
    "-a-b"
    ,
    TestID->"[5] MFString-V2-basic.wlt"
]


(* --- Times inside Plus: linebreak at summand level --- *)

VerificationTest[
    MFString[1 - a*b]
    ,
    "1\n-a b"
    ,
    TestID->"[6] MFString-V2-basic.wlt"
]


(* --- Fractions --- *)

VerificationTest[
    MFString[(-a + b)/2]
    ,
    "\\frac{1}{2} (b-a)"
    ,
    TestID->"[7] MFString-V2-basic.wlt"
]

VerificationTest[
    MFString[(-a + b)/(c + d)]
    ,
    "\\frac{b-a}{c+d}"
    ,
    TestID->"[8] MFString-V2-basic.wlt"
]


(* --- Power with Plus base --- *)

VerificationTest[
    MFString[((-a)*b)^n]
    ,
    "(-a b)^n"
    ,
    TestID->"[9] MFString-V2-basic.wlt"
]


(* --- Linebreak disabled --- *)

VerificationTest[
    MFString[(-a + b)/(c + d), "Linebreak" -> False]
    ,
    "\\frac{b-a}{c+d}"
    ,
    TestID->"[10] MFString-V2-basic.wlt"
]


(* --- Reset options --- *)

VerificationTest[
    SetOptions[{MFString}, "LinebreakThreshold" -> 6, "Method" -> "Legacy"]
    ,
    {{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 6, "LinebreakIgnore" -> {}, "Method" -> "Legacy"}}
    ,
    TestID->"[11] MFString-V2-basic.wlt"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-V2-basic.wlt"
]
