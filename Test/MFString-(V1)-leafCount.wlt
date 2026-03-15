

(* MFString-(V1)-leafCount.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    ClearAll[leafCount]; 
    Attributes[leafCount] = {HoldFirst}; 
    leafCount[expr_] := Yurie`MathForm`MFString`Private`leafCount[expr, Alternatives[]]; 
    (leafCount[expr_, ignoredP_] := Yurie`MathForm`MFString`Private`leafCount[expr, ignoredP]; )
    ,
    Null
    ,
    TestID->"[2] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[a]
    ,
    1
    ,
    TestID->"[3] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[-a]
    ,
    1
    ,
    TestID->"[4] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1/a]
    ,
    1
    ,
    TestID->"[5] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[Plus[a]]
    ,
    2
    ,
    TestID->"[6] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[Times[a]]
    ,
    2
    ,
    TestID->"[7] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[a + b]
    ,
    3
    ,
    TestID->"[8] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[a - b]
    ,
    3
    ,
    TestID->"[9] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[a*b]
    ,
    3
    ,
    TestID->"[10] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[a/b]
    ,
    3
    ,
    TestID->"[11] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[f[g[a]]]
    ,
    3
    ,
    TestID->"[12] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[(f + g)[a]]
    ,
    4
    ,
    TestID->"[13] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[(a + b)/c]
    ,
    5
    ,
    TestID->"[14] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1 + 1]
    ,
    3
    ,
    TestID->"[15] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1 - 1]
    ,
    3
    ,
    TestID->"[16] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1*1]
    ,
    3
    ,
    TestID->"[17] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1 + I]
    ,
    3
    ,
    TestID->"[18] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1/1]
    ,
    1
    ,
    TestID->"[19] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1/2]
    ,
    1
    ,
    TestID->"[20] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[2*a]
    ,
    3
    ,
    TestID->"[21] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[-2*a]
    ,
    3
    ,
    TestID->"[22] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[2/a]
    ,
    3
    ,
    TestID->"[23] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[2*(1/a)]
    ,
    3
    ,
    TestID->"[24] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[-(2/a)]
    ,
    3
    ,
    TestID->"[25] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[-2/a]
    ,
    3
    ,
    TestID->"[26] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1 + a + b]
    ,
    4
    ,
    TestID->"[27] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1 + a - b]
    ,
    4
    ,
    TestID->"[28] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1 - 1 + a - b, HoldPattern[Plus[__]]]
    ,
    1
    ,
    TestID->"[29] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    leafCount[1 - 1, HoldPattern[Plus[__]]]
    ,
    1
    ,
    TestID->"[30] MFString-(V1)-leafCount.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-(V1)-leafCount.nb"
]