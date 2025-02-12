

(*MFString-leafCount.nb*)

VerificationTest[
    Begin["Global`"];
	ClearAll["`*"]
    ,
    Null
    ,
    TestID->"0-MFString-leafCount.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"1-MFString-leafCount.nb"
]

VerificationTest[
    leafCount = Yurie`MathForm`MFString`Private`leafCount; 
    ,
    Null
    ,
    TestID->"2-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, a]
    ,
    1
    ,
    TestID->"3-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, -a]
    ,
    1
    ,
    TestID->"4-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 1/a]
    ,
    1
    ,
    TestID->"5-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, Plus[a]]
    ,
    2
    ,
    TestID->"6-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, Times[a]]
    ,
    2
    ,
    TestID->"7-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, a + b]
    ,
    3
    ,
    TestID->"8-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, a - b]
    ,
    3
    ,
    TestID->"9-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, a*b]
    ,
    3
    ,
    TestID->"10-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, a/b]
    ,
    3
    ,
    TestID->"11-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, f[g[a]]]
    ,
    3
    ,
    TestID->"12-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, (f + g)[a]]
    ,
    4
    ,
    TestID->"13-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, (a + b)/c]
    ,
    5
    ,
    TestID->"14-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 1 + 1]
    ,
    3
    ,
    TestID->"15-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 1 - 1]
    ,
    3
    ,
    TestID->"16-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 1*1]
    ,
    3
    ,
    TestID->"17-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 1 + I]
    ,
    3
    ,
    TestID->"18-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 1/1]
    ,
    1
    ,
    TestID->"19-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 1/2]
    ,
    1
    ,
    TestID->"20-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 2*a]
    ,
    3
    ,
    TestID->"21-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, -2*a]
    ,
    3
    ,
    TestID->"22-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 2/a]
    ,
    3
    ,
    TestID->"23-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 2*(1/a)]
    ,
    3
    ,
    TestID->"24-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, -(2/a)]
    ,
    3
    ,
    TestID->"25-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, -2/a]
    ,
    3
    ,
    TestID->"26-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 1 + a + b]
    ,
    4
    ,
    TestID->"27-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{}, 1 + a - b]
    ,
    4
    ,
    TestID->"28-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{HoldPattern[Plus[__]]}, 1 - 1 + a - b]
    ,
    1
    ,
    TestID->"29-MFString-leafCount.nb"
]

VerificationTest[
    leafCount[{Plus[__]}, 1 - 1]
    ,
    1
    ,
    TestID->"30-MFString-leafCount.nb"
]

VerificationTest[
    ClearAll["`*"];
	End[]
    ,
    "Global`"
    ,
    TestID->"∞-MFString-leafCount.nb"
]