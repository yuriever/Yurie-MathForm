

(* MFString-derivative.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-derivative.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-derivative.nb"
]

VerificationTest[
    MFClear[]
    ,
    Null
    ,
    TestID->"[2] MFString-derivative.nb"
]

VerificationTest[
    MFString[D[f[x], x]]
    ,
    "f'(x)"
    ,
    TestID->"[3] MFString-derivative.nb"
]

VerificationTest[
    MFString[D[f[x], {x, n}]]
    ,
    "f^{(n)}(x)"
    ,
    TestID->"[4] MFString-derivative.nb"
]

VerificationTest[
    MFString[D[f[x, y], x, y]]
    ,
    "f^{(1,1)}(x,y)"
    ,
    TestID->"[5] MFString-derivative.nb"
]

VerificationTest[
    MFString[D[f[x, y], {x, n}, {y, m}]]
    ,
    "f^{(n,m)}(x,y)"
    ,
    TestID->"[6] MFString-derivative.nb"
]

VerificationTest[
    MFString[DiracDelta[x]]
    ,
    "\\delta (x)"
    ,
    TestID->"[7] MFString-derivative.nb"
]

VerificationTest[
    MFString[D[DiracDelta[x], {x, n}]]
    ,
    "\\delta^{(n)}(x)"
    ,
    TestID->"[8] MFString-derivative.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-derivative.nb"
]