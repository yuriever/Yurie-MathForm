

(* MFString-option-Linebreak.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-option-Linebreak.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-option-Linebreak.nb"
]

VerificationTest[
    SetOptions[{MFString}, "LinebreakThreshold" -> 2]
    ,
    {{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 2, "LinebreakIgnore" -> {}}}
    ,
    TestID->"[2] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[-a]
    ,
    "-a"
    ,
    TestID->"[3] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[a - b + c]
    ,
    "a-b+c"
    ,
    TestID->"[4] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[-a - b]
    ,
    "-a-b"
    ,
    TestID->"[5] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[1 - a*b]
    ,
    "-a b\n+1"
    ,
    TestID->"[6] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-a + b)/2]
    ,
    "\\frac{1}{2}\n(b-a)"
    ,
    TestID->"[7] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-a + b)/(c + d)]
    ,
    "\\frac{\n    b-a\n}{\n    c+d\n}"
    ,
    TestID->"[8] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[((-a)*b)^n]
    ,
    "(-a b)^n"
    ,
    TestID->"[9] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-(a + b + c + d + e + f + g)^2)*(c*d)^n + e*f + h]
    ,
    "-(c d)^n\n(a+b+c+d+e+f+g)^2\n+e f\n+h"
    ,
    TestID->"[10] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[((-b^2)*a[x, y])/(m[1]*m[2])]
    ,
    "-\\frac{\n    b^2\n    a(x,y)\n}{\n    m(1)\n    m(2)\n}"
    ,
    TestID->"[11] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[a^n*b^n*((c*d)^n/(e*f))]
    ,
    "\\frac{\n    a^n\n    b^n\n    (c d)^n\n}{e f}"
    ,
    TestID->"[12] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(a + b*c + d)/(a + b*c + d + 1)]
    ,
    "\\frac{\n    a\n    +b c\n    +d\n}{\n    a\n    +b c\n    +d+1\n}"
    ,
    TestID->"[13] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[a*(b + c)*d, "LinebreakIgnore" -> {HoldPattern[Plus[___]]}]
    ,
    "a d\n(b+c)"
    ,
    TestID->"[14] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[a*(b + c)*d, "LinebreakIgnore" :> {HoldPattern[Times[___]]}]
    ,
    "a d\n(b+c)"
    ,
    TestID->"[15] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-s)*t*f[a*b*c] - s*u*f[a*c*d]]
    ,
    "-s t\nf(a b c)\n-s u\nf(a c d)"
    ,
    TestID->"[16] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-s)*t*f[a*b*c] - 2*s*u*f[a*c*d]]
    ,
    "-s t\nf(a b c)\n-2 s u\nf(a c d)"
    ,
    TestID->"[17] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[1 - (-1)^a*s*t*f[a*b*c*d]]
    ,
    "s t (\n    -(-1)^a\n)\nf(a b c d)\n+1"
    ,
    TestID->"[18] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[-1 - (1/3)*a*s*t*f[a*b*c] - 2*s*u*f[a*c*d] - (-1)^a*s*t*f[a*b*c*d] - (1/2)*s*u*f[a*c*d, 2] + (-1)^a*s*f[a*b*c*d] + (1/2)*s*u*t*f[a*c*d, 2] - s*u*f[a]]
    ,
    "\\frac{1}{2} s t u\nf(a c d,2)\n-\\frac{1}{2} s u\nf(a c d,2)\n+s t (\n    -(-1)^a\n)\nf(a b c d)\n+s\n(-1)^a\nf(a b c d)\n-\\frac{1}{3} a s t\nf(a b c)\n-2 s u\nf(a c d)\n-s u\nf(a)\n-1"
    ,
    TestID->"[19] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[a^(1 - Δ[1])]
    ,
    "a^{\n    -\\Delta (1)\n    +1\n}"
    ,
    TestID->"[20] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[Subscript[y, 1]^(-1 - d + Subscript[Δ, 1])*(Abs[Subscript[x, 2]]^2 + Subscript[y, 1]^2)^(1 - Subscript[Δ, 1])]
    ,
    "y_1^{\n    -d\n    +\\Delta_1\n    -1\n}\n(\n    | x_2| {}^2\n    +y_1^2\n){}^{\n    -\\Delta_1\n    +1\n}"
    ,
    TestID->"[21] MFString-option-Linebreak.nb"
]

VerificationTest[
    MFString[2^(1 - Subscript[h, 1] - Subscript[h, 2] - Subscript[h, 3] - Subscript[h, 4])*E^((I*υ*Subscript[ω, 0])/(Sqrt[-1 + χ]*χ))*(-1 + χ)^((1/2)*(-1 + Subscript[h, 1] - Subscript[h, 2] - Subscript[h, 3] + Subscript[h, 4]))*χ*cT[Subscript[ω, 0]^2, -(Subscript[ω, 0]^2/χ)]*Subscript[ω, 0]^(-4 + Subscript[h, 1] + Subscript[h, 2] + Subscript[h, 3] + Subscript[h, 4])]
    ,
    "\\chi\n2^{\n    -h_1\n    -h_2\n    -h_3\n    -h_4\n    +1\n}\n(\\chi -1)^{\n    \\frac{1}{2}\n    -h_2\n    -h_3\n    +h_1\n    +h_4\n    -1\n}\n\\omega_0^{\n    h_1\n    +h_2\n    +h_3\n    +h_4\n    -4\n}\ne^{\\frac{\n        i \\upsilon\n        \\omega_0\n    }{\\chi  \\sqrt{\n            \\chi -1\n}}}\n\\text{cT}(\n    \\omega_0^2,-\\frac{\n        \\omega_0^2\n    }{\\chi }\n)"
    ,
    TestID->"[22] MFString-option-Linebreak.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-option-Linebreak.nb"
]