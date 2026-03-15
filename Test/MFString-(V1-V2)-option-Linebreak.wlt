

(* MFString-(V1-V2)-option-Linebreak.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    SetOptions[MFString, "LinebreakThreshold" -> 2]; 
    ,
    Null
    ,
    TestID->"[2] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    expr = {-a, a - b + c, -a - b, 1 - a*b, (-a + b)*(c + d), 1/((-a + b)*(c + d)), (-a + b)/2, (-a + b)/(c + d), ((-a)*b)^n, ((-b^2)*a[x, y])/(m[1]*m[2]), a^n*b^n*((c*d)^n/(e*f)), (a + b*c + d)/(a + b*c + d + 1), (-(a + b + c + d)^2)*(c*d)^n + e*f + h, (-s)*t*f[a*b*c] - s*u*f[a*c*d], (-s)*t*f[a*b*c] - 2*s*u*f[a*c*d], 1 - (-1)^a*s*t*f[a*b*c*d]}; 
    ,
    Null
    ,
    TestID->"[3] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    Null
    ,
    Null
    ,
    TestID->"[4] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[-a, "Method" -> "V1"]
    ,
    "-a"
    ,
    TestID->"[5] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[a - b + c, "Method" -> "V1"]
    ,
    "a-b+c"
    ,
    TestID->"[6] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[-a - b, "Method" -> "V1"]
    ,
    "-a-b"
    ,
    TestID->"[7] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[1 - a*b, "Method" -> "V1"]
    ,
    "-a b\n+1"
    ,
    TestID->"[8] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-a + b)*(c + d), "Method" -> "V1"]
    ,
    "(b-a)\n(c+d)"
    ,
    TestID->"[9] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[1/((-a + b)*(c + d)), "Method" -> "V1"]
    ,
    "\\frac{1}{\n    b-a\n    c+d\n}"
    ,
    TestID->"[10] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(1/2)*(-a + b), "Method" -> "V1"]
    ,
    "\\frac{1}{2}\n(b-a)"
    ,
    TestID->"[11] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-a + b)/(c + d), "Method" -> "V1"]
    ,
    "\\frac{\n    b-a\n}{\n    c+d\n}"
    ,
    TestID->"[12] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[((-a)*b)^n, "Method" -> "V1"]
    ,
    "(-a b)^n"
    ,
    TestID->"[13] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[-((b^2*a[x, y])/(m[1]*m[2])), "Method" -> "V1"]
    ,
    "-\\frac{\n    b^2\n    a(x,y)\n}{\n    m(1)\n    m(2)\n}"
    ,
    TestID->"[14] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(a^n*b^n*(c*d)^n)/(e*f), "Method" -> "V1"]
    ,
    "\\frac{\n    a^n\n    b^n\n    (c d)^n\n}{e f}"
    ,
    TestID->"[15] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(a + b*c + d)/(1 + a + b*c + d), "Method" -> "V1"]
    ,
    "\\frac{\n    a\n    +b c\n    +d\n}{\n    a\n    +b c\n    +d+1\n}"
    ,
    TestID->"[16] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-(c*d)^n)*(a + b + c + d)^2 + e*f + h, "Method" -> "V1"]
    ,
    "-(c d)^n\n(a+b+c+d)^2\n+e f\n+h"
    ,
    TestID->"[17] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-s)*t*f[a*b*c] - s*u*f[a*c*d], "Method" -> "V1"]
    ,
    "-s t\nf(a b c)\n-s u\nf(a c d)"
    ,
    TestID->"[18] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-s)*t*f[a*b*c] - 2*s*u*f[a*c*d], "Method" -> "V1"]
    ,
    "-s t\nf(a b c)\n-2 s u\nf(a c d)"
    ,
    TestID->"[19] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[1 - (-1)^a*s*t*f[a*b*c*d], "Method" -> "V1"]
    ,
    "s t (\n    -(-1)^a\n)\nf(a b c d)\n+1"
    ,
    TestID->"[20] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[-a, "Method" -> "V2"]
    ,
    "-a"
    ,
    TestID->"[21] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[a - b + c, "Method" -> "V2"]
    ,
    "a-b+c"
    ,
    TestID->"[22] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[-a - b, "Method" -> "V2"]
    ,
    "-a-b"
    ,
    TestID->"[23] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[1 - a*b, "Method" -> "V2"]
    ,
    "1\n-a b"
    ,
    TestID->"[24] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-a + b)*(c + d), "Method" -> "V2"]
    ,
    "(b-a)\n(c+d)"
    ,
    TestID->"[25] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[1/((-a + b)*(c + d)), "Method" -> "V2"]
    ,
    "\\frac{1}{\n    (b-a)\n    (c+d)\n}"
    ,
    TestID->"[26] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(1/2)*(-a + b), "Method" -> "V2"]
    ,
    "\\frac{1}{2}\n(b-a)"
    ,
    TestID->"[27] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-a + b)/(c + d), "Method" -> "V2"]
    ,
    "\\frac{b-a}{c+d}"
    ,
    TestID->"[28] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[((-a)*b)^n, "Method" -> "V2"]
    ,
    "(-a b)^n"
    ,
    TestID->"[29] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[-((b^2*a[x, y])/(m[1]*m[2])), "Method" -> "V2"]
    ,
    "-\\frac{\n    b^2\n    a(x,y)\n}{\n    m(1)\n    m(2)\n}"
    ,
    TestID->"[30] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(a^n*b^n*(c*d)^n)/(e*f), "Method" -> "V2"]
    ,
    "\\frac{\n    a^n\n    b^n\n    (c d)^n\n}{e f}"
    ,
    TestID->"[31] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(a + b*c + d)/(1 + a + b*c + d), "Method" -> "V2"]
    ,
    "\\frac{\n    a\n    +b c\n    +d\n}{\n    1\n    +a\n    +b c\n    +d\n}"
    ,
    TestID->"[32] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-(c*d)^n)*(a + b + c + d)^2 + e*f + h, "Method" -> "V2"]
    ,
    "-(c d)^n\n(a+b+c+d)^2\n+e f\n+h"
    ,
    TestID->"[33] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-s)*t*f[a*b*c] - s*u*f[a*c*d], "Method" -> "V2"]
    ,
    "-s t\nf(a b c)\n-s u\nf(a c d)"
    ,
    TestID->"[34] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[(-s)*t*f[a*b*c] - 2*s*u*f[a*c*d], "Method" -> "V2"]
    ,
    "-s t\nf(a b c)\n-2 s u\nf(a c d)"
    ,
    TestID->"[35] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    MFString[1 - (-1)^a*s*t*f[a*b*c*d], "Method" -> "V2"]
    ,
    "1\n-(-1)^a s t\nf(a b c d)"
    ,
    TestID->"[36] MFString-(V1-V2)-option-Linebreak.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-(V1-V2)-option-Linebreak.nb"
]