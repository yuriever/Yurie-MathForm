
(* MFString-V2-fraction.wlt *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-V2-fraction.wlt"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-V2-fraction.wlt"
]

VerificationTest[
    SetOptions[{MFString}, "LinebreakThreshold" -> 2, "Method" -> "V2"]
    ,
    {{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 2, "LinebreakIgnore" -> {}, "Method" -> "V2"}}
    ,
    TestID->"[2] MFString-V2-fraction.wlt"
]


(* --- The reported bug: parens in denominator must be preserved --- *)
(* Legacy misses the parens around (a b+f(x)). V2 keeps them. *)

VerificationTest[
    MFString[1/((a*b + f[x])*d)]
    ,
    "\\frac{1}{d\n    (\n        a b\n        +f(x)\n)}"
    ,
    TestID->"[3] MFString-V2-fraction.wlt"
]


(* --- Basic fraction --- *)

VerificationTest[
    MFString[(-a + b)/(c + d)]
    ,
    "\\frac{b-a}{c+d}"
    ,
    TestID->"[4] MFString-V2-fraction.wlt"
]


(* --- Complex numerator and denominator --- *)

VerificationTest[
    MFString[(a + b + c)/((d + e)*f)]
    ,
    "\\frac{a+b+c}{(d+e) f}"
    ,
    TestID->"[5] MFString-V2-fraction.wlt"
]


(* --- Fraction with product numerator --- *)

VerificationTest[
    MFString[(a*b)/(c*d)]
    ,
    "\\frac{a b}{c d}"
    ,
    TestID->"[6] MFString-V2-fraction.wlt"
]


(* --- Power with negative exponent: V2 renders base with parens --- *)

VerificationTest[
    MFString[(a*b + c)^(-2)]
    ,
    "\\frac{1}{(\n        a b\n        +c\n)^2}"
    ,
    TestID->"[7] MFString-V2-fraction.wlt"
]


(* --- Reset options --- *)

VerificationTest[
    SetOptions[{MFString}, "LinebreakThreshold" -> 6, "Method" -> "Legacy"]
    ,
    {{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 6, "LinebreakIgnore" -> {}, "Method" -> "Legacy"}}
    ,
    TestID->"[8] MFString-V2-fraction.wlt"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-V2-fraction.wlt"
]
