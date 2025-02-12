

(*MFString-option-Linebreak.nb*)

VerificationTest[
    Begin["Global`"];
	ClearAll["`*"]
    ,
    Null
    ,
    TestID->"0-MFString-option-Linebreak.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"1-MFString-option-Linebreak.nb"
]

VerificationTest[
    SetOptions[{MFString}, "LinebreakThreshold" -> 2]
    ,
    {{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 2, "LinebreakIgnore" -> {}}}
    ,
    TestID->"2-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[-a]
    ,
    "-a"
    ,
    TestID->"3-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[a - b + c]
    ,
    "a-b+c"
    ,
    TestID->"4-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[-a - b]
    ,
    "-a-b"
    ,
    TestID->"5-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[1 - a*b]
    ,
    "1\n-a b"
    ,
    TestID->"6-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-a + b)/2]
    ,
    "\\frac{1}{2}\n(-a+b)"
    ,
    TestID->"7-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-a + b)/(c + d)]
    ,
    "\\frac{\n    -a+b\n}{c+d}"
    ,
    TestID->"8-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[((-a)*b)^n]
    ,
    "(-a b)^n"
    ,
    TestID->"9-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-(a + b + c + d + e + f + g)^2)*(c*d)^n + e*f + h]
    ,
    "e f\n-(c d)^n\n(a+b+c+d+e+f+g)^2\n+h"
    ,
    TestID->"10-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[((-b^2)*a[x, y])/(m[1]*m[2])]
    ,
    "\\frac{\n    -b^2\n    a(x,y)\n}{m(1) m(2)}"
    ,
    TestID->"11-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[a^n*b^n*((c*d)^n/(e*f))]
    ,
    "\\frac{\n    a^n\n    b^n\n    (c d)^n\n}{e f}"
    ,
    TestID->"12-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(a + b*c + d)/(a + b*c + d + 1)]
    ,
    "\\frac{\n    a\n    +b c\n    +d\n}{\n    1+a\n    +b c\n    +d\n}"
    ,
    TestID->"13-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[a*(b + c)*d, "LinebreakIgnore" -> {HoldPattern[Plus[___]]}]
    ,
    "a d (b+c)"
    ,
    TestID->"14-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[a*(b + c)*d, "LinebreakIgnore" :> {HoldPattern[Times[___]]}]
    ,
    "a\n(b+c)\nd"
    ,
    TestID->"15-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-s)*t*f[a*b*c] - s*u*f[a*c*d]]
    ,
    "-s t\nf(a b c)\n-s u\nf(a c d)"
    ,
    TestID->"16-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-s)*t*f[a*b*c] - 2*s*u*f[a*c*d]]
    ,
    "-s t\nf(a b c)\n-2 s u\nf(a c d)"
    ,
    TestID->"17-MFString-option-Linebreak.nb"
]

VerificationTest[
    expr = -1 - (a/3)*s*t*f[a*b*c] - 2*s*u*f[a*c*d] - (-1)^a*s*t*f[a*b*c*d] - (1/2)*s*u*f[a*c*d, 2] + (-1)^a*s*f[a*b*c*d] + (1/2)*s*u*t*f[a*c*d, 2] - s*u*f[a]
    ,
    -1 - s*u*f[a] - (1/3)*a*s*t*f[a*b*c] - 2*s*u*f[a*c*d] + (-1)^a*s*f[a*b*c*d] - (-1)^a*s*t*f[a*b*c*d] - (1/2)*s*u*f[a*c*d, 2] + (1/2)*s*t*u*f[a*c*d, 2]
    ,
    TestID->"18-MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[expr]
    ,
    "-1\n-s u\nf(a)\n-\\frac{1}{3} a s t\nf(a b c)\n-2 s u\nf(a c d)\n+(-1)^a\ns\nf(a b c d)\n-(-1)^a\ns t\nf(a b c d)\n-\\frac{1}{2} s u\nf(a c d,2)\n+\\frac{1}{2} s t u\nf(a c d,2)"
    ,
    TestID->"19-MFString-option-Linebreak.nb"
]

VerificationTest[
    ClearAll["`*"];
	End[]
    ,
    "Global`"
    ,
    TestID->"∞-MFString-option-Linebreak.nb"
]