

(*MFString-option-RemoveLeftRightPair.nb*)

VerificationTest[
    Begin["Global`"];
	ClearAll["`*"]
    ,
    Null
    ,
    TestID->"0-MFString-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"1-MFString-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFClear[]
    ,
    Null
    ,
    TestID->"2-MFString-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    SetOptions[{MFString}, "LinebreakThreshold" -> 2, "RemoveLeftRightPair" -> False]
    ,
    {{"RemoveLeftRightPair" -> False, "Linebreak" -> True, "LinebreakThreshold" -> 2, "LinebreakIgnore" -> {}}}
    ,
    TestID->"3-MFString-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    Null
    ,
    Null
    ,
    TestID->"4-MFString-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[(x + z^2)^Δ]
    ,
    "\\left(\n    x\n    +z^2\n\\right)^{\\Delta }"
    ,
    TestID->"5-MFString-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[((x - y) . (x - y) + z[1]^2)^Δ]
    ,
    "\\left(\n    (x-y).(x-y)\n    +z(1)^2\n\\right)^{\\Delta }"
    ,
    TestID->"6-MFString-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    MFString[Subscript[y, 1]^(-1 - d + Subscript[Δ, 1])/(Abs[Subscript[x, 2]]^2 + Subscript[y, 1]^2)^Subscript[Δ, 1]]
    ,
    "y_1^{\n    -1-d\n    +\\Delta_1\n}\n\\left(\n    \\left| x_2\\right| {}^2\n    +y_1^2\n\\right){}^{\n    -\\Delta_1\n}"
    ,
    TestID->"7-MFString-option-RemoveLeftRightPair.nb"
]

VerificationTest[
    ClearAll["`*"];
	End[]
    ,
    "Global`"
    ,
    TestID->"∞-MFString-option-RemoveLeftRightPair.nb"
]