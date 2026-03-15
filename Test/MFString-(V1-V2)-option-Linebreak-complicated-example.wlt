

(* MFString-(V1-V2)-option-Linebreak-complicated-example.nb *)

VerificationTest[
    Begin["Global`"];
    ClearAll["`*"]
    ,
    Null
    ,
    TestID->"[0] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    Get["Yurie`MathForm`"]
    ,
    Null
    ,
    TestID->"[1] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    SetOptions[MFString, "LinebreakThreshold" -> 6]; 
    ,
    Null
    ,
    TestID->"[2] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    expr = {a^(1 - Δ[1]), Subscript[y, 1]^(-1 - d + Subscript[Δ, 1])*(Abs[Subscript[x, 2]]^2 + Subscript[y, 1]^2)^(1 - Subscript[Δ, 1]), 2^(-1 + h)*E^((υ*(2*Sqrt[α]*Subscript[ξ, 0] + χ*(-Subscript[ξ, 12] + Subscript[ξ, 34])))/(2*(1 - χ)*χ)), Sqrt[1 + (χ^2*(Subscript[ξ, 12] + Subscript[ξ, 34])^2)/(4*Subscript[ξ, 0]^2) - χ*(1 + (Subscript[ξ, 12]*Subscript[ξ, 34])/Subscript[ξ, 0]^2)], 2^(1 - Subscript[h, 1] - Subscript[h, 2] - Subscript[h, 3] - Subscript[h, 4])*E^((I*υ*Subscript[ω, 0])/(Sqrt[-1 + χ]*χ))*(-1 + χ)^((1/2)*(-1 + Subscript[h, 1] - Subscript[h, 2] - Subscript[h, 3] + Subscript[h, 4]))*χ*Subscript[ω, 0]^(-4 + Subscript[h, 1] + Subscript[h, 2] + Subscript[h, 3] + Subscript[h, 4])}; 
    ,
    Null
    ,
    TestID->"[3] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    Null
    ,
    Null
    ,
    TestID->"[4] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    MFString[a^(1 - Δ[1]), "Method" -> "V1"]
    ,
    "a^{1-\\Delta (1)}"
    ,
    TestID->"[5] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    MFString[Subscript[y, 1]^(-1 - d + Subscript[Δ, 1])*(Abs[Subscript[x, 2]]^2 + Subscript[y, 1]^2)^(1 - Subscript[Δ, 1]), "Method" -> "V1"]
    ,
    "y_1^{-d+\\Delta_1-1}\n(\n    | x_2| {}^2\n    +y_1^2\n){}^{1-\\Delta_1}"
    ,
    TestID->"[6] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    MFString[2^(-1 + h)*E^((υ*(2*Sqrt[α]*Subscript[ξ, 0] + χ*(-Subscript[ξ, 12] + Subscript[ξ, 34])))/(2*(1 - χ)*χ)), "Method" -> "V1"]
    ,
    "2^{h-1}\n\\exp (\\frac{\n        \\upsilon\n        (\n            \\chi\n            (\\xi_{34}-\\xi_{12})\n            +2 \\sqrt{\\alpha } \\xi_0\n        )\n    }{2 (1-\\chi ) \\chi }\n)"
    ,
    TestID->"[7] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    MFString[Sqrt[1 + (χ^2*(Subscript[ξ, 12] + Subscript[ξ, 34])^2)/(4*Subscript[ξ, 0]^2) - χ*(1 + (Subscript[ξ, 12]*Subscript[ξ, 34])/Subscript[ξ, 0]^2)], "Method" -> "V1"]
    ,
    "\\sqrt{\n    -\\chi\n    (\n        \\frac{\\xi_{12} \\xi_{34}}{\\xi_0^2}\n        +1\n    )\n    +\\frac{\n        \\chi^2\n        (\\xi_{12}+\\xi_{34}){}^2\n    }{4 \\xi_0^2}\n    +1\n}"
    ,
    TestID->"[8] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    MFString[2^(1 - Subscript[h, 1] - Subscript[h, 2] - Subscript[h, 3] - Subscript[h, 4])*E^((I*υ*Subscript[ω, 0])/(Sqrt[-1 + χ]*χ))*(-1 + χ)^((1/2)*(-1 + Subscript[h, 1] - Subscript[h, 2] - Subscript[h, 3] + Subscript[h, 4]))*χ*Subscript[ω, 0]^(-4 + Subscript[h, 1] + Subscript[h, 2] + Subscript[h, 3] + Subscript[h, 4]), "Method" -> "V1"]
    ,
    "\\chi\n2^{-h_1-h_2-h_3-h_4+1}\n\\omega_0^{h_1+h_2+h_3+h_4-4}\ne^{\\frac{i \\upsilon  \\omega_0}{\\sqrt{\\chi -1} \\chi }}\n(\\chi -1)^{\n    \\frac{1}{2}\n    (h_1-h_2-h_3+h_4-1)\n}"
    ,
    TestID->"[9] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    MFString[a^(1 - Δ[1]), "Method" -> "V2"]
    ,
    "a^{1-\\Delta (1)}"
    ,
    TestID->"[10] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    MFString[Subscript[y, 1]^(-1 - d + Subscript[Δ, 1])*(Abs[Subscript[x, 2]]^2 + Subscript[y, 1]^2)^(1 - Subscript[Δ, 1]), "Method" -> "V2"]
    ,
    "y_1^{-d+\\Delta_1-1}\n(\n    | x_2|^2\n    +y_1^2\n)^{1-\\Delta_1}"
    ,
    TestID->"[11] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    MFString[2^(-1 + h)*E^((υ*(2*Sqrt[α]*Subscript[ξ, 0] + χ*(-Subscript[ξ, 12] + Subscript[ξ, 34])))/(2*(1 - χ)*χ)), "Method" -> "V2"]
    ,
    "2^{h-1}\ne^{\\frac{\n        \\frac{1}{2} \\upsilon\n        (\n            2 \\sqrt{\\alpha } \\xi_0\n            +\\chi\n            (\\xi_{34}-\\xi_{12})\n        )\n}{(1-\\chi) \\chi}}"
    ,
    TestID->"[12] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    MFString[Sqrt[1 + (χ^2*(Subscript[ξ, 12] + Subscript[ξ, 34])^2)/(4*Subscript[ξ, 0]^2) - χ*(1 + (Subscript[ξ, 12]*Subscript[ξ, 34])/Subscript[ξ, 0]^2)], "Method" -> "V2"]
    ,
    "(\n    1\n    +\\frac{\n        \\frac{1}{4} \\chi^2 \\xi_0^2\n        (\\xi_{12}+\\xi_{34})^2\n    }{\\xi_0}\n    -\\chi\n    (\n        1\n        +\\frac{\\xi_{12} \\xi_{34}}{\\xi_0^2}\n    )\n)^{\\frac{1}{2}}"
    ,
    TestID->"[13] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    MFString[2^(1 - Subscript[h, 1] - Subscript[h, 2] - Subscript[h, 3] - Subscript[h, 4])*E^((I*υ*Subscript[ω, 0])/(Sqrt[-1 + χ]*χ))*(-1 + χ)^((1/2)*(-1 + Subscript[h, 1] - Subscript[h, 2] - Subscript[h, 3] + Subscript[h, 4]))*χ*Subscript[ω, 0]^(-4 + Subscript[h, 1] + Subscript[h, 2] + Subscript[h, 3] + Subscript[h, 4]), "Method" -> "V2"]
    ,
    "2^{-h_1-h_2-h_3-h_4+1}\ne^{\\frac{i \\upsilon  \\omega_0}{\\sqrt{\\chi -1} \\chi }}\n(\\chi -1)^{\\frac{1}{2} (h_1-h_2-h_3+h_4-1)} \\chi\n\\omega_0^{h_1+h_2+h_3+h_4-4}"
    ,
    TestID->"[14] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]

VerificationTest[
    ClearAll["`*"];
    End[]
    ,
    "Global`"
    ,
    TestID->"[∞] MFString-(V1-V2)-option-Linebreak-complicated-example.nb"
]