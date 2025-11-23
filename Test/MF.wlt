

(* MF.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MF.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MF.nb"
]

VerificationTest[
    MFBlockGraphics[args___] := (StringDrop[#1, 1] & )[StringDelete[DatePattern[{"Year", "Month", "Day"}, "-"]][Catch[Block[{Yurie`MathForm`MF`Private`importPDF}, Yurie`MathForm`MF`Private`importPDF[id_] := Throw[id]; MF[args]]]]]; 
    ,
    Null
    ,
    TestID->"[2] MF.nb"
]

VerificationTest[
    Null
    ,
    Null
    ,
    TestID->"[3] MF.nb"
]

VerificationTest[
    expr = {a, b}
    ,
    {a, b}
    ,
    TestID->"[4] MF.nb"
]

VerificationTest[
    MFString[expr]
    ,
    "(a, b)"
    ,
    TestID->"[5] MF.nb"
]

VerificationTest[
    string = MFString[expr]
    ,
    "(a, b)"
    ,
    TestID->"[6] MF.nb"
]

VerificationTest[
    MFBlockGraphics[expr]
    ,
    "8829776013302237911-Multiple"
    ,
    TestID->"[7] MF.nb"
]

VerificationTest[
    MFBlockGraphics[string]
    ,
    "3157679636659493011-Single"
    ,
    TestID->"[8] MF.nb"
]

VerificationTest[
    MFBlockGraphics[""]
    ,
    "143570300399556146-Single"
    ,
    TestID->"[9] MF.nb"
]

VerificationTest[
    MFBlockGraphics[{}, "Listable" -> True]
    ,
    {}
    ,
    TestID->"[10] MF.nb"
]

VerificationTest[
    MFBlockGraphics[{}, "Listable" -> False]
    ,
    "2812765363706704525-Single"
    ,
    TestID->"[11] MF.nb"
]

VerificationTest[
    SetOptions[MF, "Listable" -> False]; 
    ,
    Null
    ,
    TestID->"[12] MF.nb"
]

VerificationTest[
    MFBlockGraphics[expr]
    ,
    "3157679636659493011-Single"
    ,
    TestID->"[13] MF.nb"
]

VerificationTest[
    MFBlockGraphics[string]
    ,
    "3157679636659493011-Single"
    ,
    TestID->"[14] MF.nb"
]

VerificationTest[
    SetOptions[MF, "FontSize" -> 16]; 
    ,
    Null
    ,
    TestID->"[15] MF.nb"
]

VerificationTest[
    MFBlockGraphics[a]
    ,
    "204892333196205843-Single"
    ,
    TestID->"[16] MF.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MF.nb"
]