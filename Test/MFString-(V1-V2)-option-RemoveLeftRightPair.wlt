

(* MFString-(V1-V2)-option-RemoveLeftRightPair.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    SetOptions[MFString, "LinebreakThreshold" -> 2, "RemoveLeftRightPair" -> False]; 
    ,
    Null
    ,
    TestID->"[2] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    expr = {-1 - (1/3)*s*t*f[a], (x + z^2)^Δ, ((x - y) . (x - y) + z[1]^2)^Δ, Subscript[y, 1]^(-1 - d + Subscript[Δ, 1])/(Abs[Subscript[x, 2]]^2 + Subscript[y, 1]^2)^Subscript[Δ, 1]}; 
    ,
    Null
    ,
    TestID->"[3] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    Null
    ,
    Null
    ,
    TestID->"[4] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[-1 - (1/3)*s*t*f[a], "Method" -> "V1"]
    ,
    "-\\frac{1}{3} s t\nf(a)\n-1"
    ,
    TestID->"[5] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[(x + z^2)^Δ, "Method" -> "V1"]
    ,
    "\\left(\n    z^2\n    +x\n\\right)^{\\Delta }"
    ,
    TestID->"[6] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[((x - y) . (x - y) + z[1]^2)^Δ, "Method" -> "V1"]
    ,
    "\\left(\n    (x-y).(x-y)\n    +z(1)^2\n\\right)^{\\Delta }"
    ,
    TestID->"[7] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[Subscript[y, 1]^(-1 - d + Subscript[Δ, 1])/(Abs[Subscript[x, 2]]^2 + Subscript[y, 1]^2)^Subscript[Δ, 1], "Method" -> "V1"]
    ,
    "y_1^{\n    -d\n    +\\Delta_1\n    -1\n}\n\\left(\n    \\left| x_2\\right| {}^2\n    +y_1^2\n\\right){}^{\n    -\\Delta_1\n}"
    ,
    TestID->"[8] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[-1 - (1/3)*s*t*f[a], "Method" -> "V2"]
    ,
    "-1\n-\\frac{1}{3} s t\nf(a)"
    ,
    TestID->"[9] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[(x + z^2)^Δ, "Method" -> "V2"]
    ,
    "\\left(\n    x\n    +z^2\n\\right)^{\\Delta}"
    ,
    TestID->"[10] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[((x - y) . (x - y) + z[1]^2)^Δ, "Method" -> "V2"]
    ,
    "\\left(\n    (x-y).(x-y)\n    +z(1)^2\n\\right)^{\\Delta}"
    ,
    TestID->"[11] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[Subscript[y, 1]^(-1 - d + Subscript[Δ, 1])/(Abs[Subscript[x, 2]]^2 + Subscript[y, 1]^2)^Subscript[Δ, 1], "Method" -> "V2"]
    ,
    "y_1^{-d+\\Delta_1-1}\n\\left(\n    \\left| x_2\\right|^2\n    +y_1^2\n\\right)^{-\\Delta_1}"
    ,
    TestID->"[12] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-(V1-V2)-option-RemoveLeftRightPair.nb"
]