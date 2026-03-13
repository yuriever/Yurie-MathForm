

(* MFString-V2-option-Linebreak.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    SetOptions[MFString, "LinebreakThreshold" -> 2, "Method" -> "V2"]
    ,
    {"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 2, "LinebreakIgnore" -> {}, "Method" -> "V2"}
    ,
    TestID->"[2] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[-a]
    ,
    "-a"
    ,
    TestID->"[3] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[a - b + c]
    ,
    "a-b+c"
    ,
    TestID->"[4] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[-a - b]
    ,
    "-a-b"
    ,
    TestID->"[5] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[1 - a*b]
    ,
    "1\n-a b"
    ,
    TestID->"[6] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-a + b)/2]
    ,
    "\\frac{1}{2} (b-a)"
    ,
    TestID->"[7] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-a + b)/(c + d)]
    ,
    "\\frac{b-a}{c+d}"
    ,
    TestID->"[8] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[((-a)*b)^n]
    ,
    "(-a b)^n"
    ,
    TestID->"[9] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-(a + b + c + d + e + f + g)^2)*(c*d)^n + e*f + h]
    ,
    "e f\n-(c d)^n (a+b+c+d+e+f+g)^2\n+h"
    ,
    TestID->"[10] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[((-b^2)*a[x, y])/(m[1]*m[2])]
    ,
    "-\\frac{b^2 a(x,y)}{m(1) m(2)}"
    ,
    TestID->"[11] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[a^n*b^n*((c*d)^n/(e*f))]
    ,
    "\\frac{a^n b^n (c d)^n}{e f}"
    ,
    TestID->"[12] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[(a + b*c + d)/(a + b*c + d + 1)]
    ,
    "\\frac{a\n    +b c\n+d}{1\n    +a\n    +b c\n+d}"
    ,
    TestID->"[13] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[a*(b + c)*d, "LinebreakIgnore" -> {HoldPattern[Plus[___]]}]
    ,
    "a (b+c) d"
    ,
    TestID->"[14] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[a*(b + c)*d, "LinebreakIgnore" :> {HoldPattern[Times[___]]}]
    ,
    "a (b+c) d"
    ,
    TestID->"[15] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-s)*t*f[a*b*c] - s*u*f[a*c*d]]
    ,
    "-s t f(a b c)\n-s u f(a c d)"
    ,
    TestID->"[16] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-s)*t*f[a*b*c] - 2*s*u*f[a*c*d]]
    ,
    "-s t f(a b c)\n+-2 s u f(a c d)"
    ,
    TestID->"[17] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[1 - (-1)^a*s*t*f[a*b*c*d]]
    ,
    "1\n--1^a s t f(a b c d)"
    ,
    TestID->"[18] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[-1 - (1/3)*a*s*t*f[a*b*c] - 2*s*u*f[a*c*d] - (-1)^a*s*t*f[a*b*c*d] - (1/2)*s*u*f[a*c*d, 2] + (-1)^a*s*f[a*b*c*d] + (1/2)*s*u*t*f[a*c*d, 2] - s*u*f[a]]
    ,
    "-1\n-s u f(a)\n+-\\frac{1}{3} a s t f(a b c)\n+-2 s u f(a c d)\n+-1^a s f(a b c d)\n--1^a s t f(a b c d)\n+-\\frac{1}{2} s u f(a c d,2)\n+\\frac{1}{2} s t u f(a c d,2)"
    ,
    TestID->"[19] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    SetOptions[MFString, "LinebreakThreshold" -> 6, "Method" -> "V2"]
    ,
    {"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 6, "LinebreakIgnore" -> {}, "Method" -> "V2"}
    ,
    TestID->"[20] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[a^(1 - Δ[1])]
    ,
    "a^{1-\\Delta (1)}"
    ,
    TestID->"[21] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[Subscript[y, 1]^(-1 - d + Subscript[Δ, 1])*(Abs[Subscript[x, 2]]^2 + Subscript[y, 1]^2)^(1 - Subscript[Δ, 1])]
    ,
    "y_1^{-d+\\Delta_1-1}\n(\n    | x_2|^2\n    +y_1^2\n)^{1-\\Delta_1}"
    ,
    TestID->"[22] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[2^(1 - Subscript[h, 1] - Subscript[h, 2] - Subscript[h, 3] - Subscript[h, 4])*E^((I*υ*Subscript[ω, 0])/(Sqrt[-1 + χ]*χ))*(-1 + χ)^((1/2)*(-1 + Subscript[h, 1] - Subscript[h, 2] - Subscript[h, 3] + Subscript[h, 4]))*χ*cT[Subscript[ω, 0]^2, -(Subscript[ω, 0]^2/χ)]*Subscript[ω, 0]^(-4 + Subscript[h, 1] + Subscript[h, 2] + Subscript[h, 3] + Subscript[h, 4])]
    ,
    "2^{-h_1-h_2-h_3-h_4+1} e^{\\frac{i \\upsilon  \\omega_0}{\\sqrt{\\chi -1} \\chi }} (\\chi -1)^{\\frac{1}{2} (h_1-h_2-h_3+h_4-1)} \\chi \\text{cT}(\\omega_0^2,-\\frac{\\omega_0^2}{\\chi }) \\omega_0^{h_1+h_2+h_3+h_4-4}"
    ,
    TestID->"[23] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[2^(-1 + h)*E^((υ*(2*Sqrt[α]*Subscript[ξ, 0] + χ*(-Subscript[ξ, 12] + Subscript[ξ, 34])))/(2*(1 - χ)*χ))]
    ,
    "2^{h-1} e^{\\frac{\\upsilon  (2 \\sqrt{\\alpha } \\xi_0+(\\xi_{34}-\\xi_{12}) \\chi )}{2 (1-\\chi ) \\chi }}"
    ,
    TestID->"[24] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    MFString[Sqrt[1 + (χ^2*(Subscript[ξ, 12] + Subscript[ξ, 34])^2)/(4*Subscript[ξ, 0]^2) - χ*(1 + (Subscript[ξ, 12]*Subscript[ξ, 34])/Subscript[ξ, 0]^2)]]
    ,
    "(\n    1\n    +\\frac{\\frac{1}{4} \\chi^2 \\xi_0^2 (\\xi_{12}+\\xi_{34})^2}{\\xi_0}\n    -\\chi\n    (\n        1\n        +\\frac{\\xi_{12} \\xi_{34}}{\\xi_0^2}\n    )\n)^{\\frac{1}{2}}"
    ,
    TestID->"[25] MFString-V2-option-Linebreak.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-V2-option-Linebreak.nb"
]