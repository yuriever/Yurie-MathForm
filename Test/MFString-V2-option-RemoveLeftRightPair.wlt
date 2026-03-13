

(* MFString-V2-option-RemoveLeftRightPair.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-V2-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-V2-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFClear[]
    ,
    Null
    ,
    TestID->"[2] MFString-V2-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    SetOptions[MFString, "LinebreakThreshold" -> 2, "RemoveLeftRightPair" -> False, "Method" -> "V2"]
    ,
    {"RemoveLeftRightPair" -> False, "Linebreak" -> True, "LinebreakThreshold" -> 2, "LinebreakIgnore" -> {}, "Method" -> "V2"}
    ,
    TestID->"[3] MFString-V2-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[-1 - (1/3)*s*t*f[a]]
    ,
    "-1\n+-\\frac{1}{3} s t f(a)"
    ,
    TestID->"[4] MFString-V2-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[(x + z^2)^Δ]
    ,
    "(\n    x\n    +z^2\n)^{\\Delta}"
    ,
    TestID->"[5] MFString-V2-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[((x - y) . (x - y) + z[1]^2)^Δ]
    ,
    "(\n    (x-y).(x-y)\n    +z(1)^2\n)^{\\Delta}"
    ,
    TestID->"[6] MFString-V2-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[Subscript[y, 1]^(-1 - d + Subscript[Δ, 1])/(Abs[Subscript[x, 2]]^2 + Subscript[y, 1]^2)^Subscript[Δ, 1]]
    ,
    "y_1^{-d+\\Delta_1-1}\n(\n    \\left| x_2\\right|^2\n    +y_1^2\n)^{-\\Delta_1}"
    ,
    TestID->"[7] MFString-V2-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-V2-option-RemoveLeftRightPair.nb"
]