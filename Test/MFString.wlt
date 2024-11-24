

(*MFString.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-MFString.nb"
]

VerificationTest[
	Get["Yurie`MathForm`"]
	,
	Null
	,
	TestID->"1-MFString.nb"
]

VerificationTest[
	Yurie`MathForm`MFString`Private`leafCount[{Plus[__]}, 1 - 1]
	,
	1
	,
	TestID->"2-MFString.nb"
]

VerificationTest[
	Yurie`MathForm`MFString`Private`leafCount[{}, 1 - 1]
	,
	3
	,
	TestID->"3-MFString.nb"
]

VerificationTest[
	Yurie`MathForm`MFString`Private`leafCount[{}, a + b]
	,
	3
	,
	TestID->"4-MFString.nb"
]

VerificationTest[
	Yurie`MathForm`MFString`Private`leafCount[{}, a - b]
	,
	4
	,
	TestID->"5-MFString.nb"
]

VerificationTest[
	Yurie`MathForm`MFString`Private`leafCount[{}, 1 - 1 + a - b]
	,
	6
	,
	TestID->"6-MFString.nb"
]

VerificationTest[
	Yurie`MathForm`MFString`Private`leafCount[{HoldPattern[Plus[__]]}, 1 - 1 + a - b]
	,
	1
	,
	TestID->"7-MFString.nb"
]

VerificationTest[
	SetOptions[{MFString}, "LinebreakThreshold" -> 2]
	,
	{{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 2, "LinebreakIgnore" -> {}}}
	,
	TestID->"8-MFString.nb"
]

VerificationTest[
	MFString[-a]
	,
	"-a"
	,
	TestID->"9-MFString.nb"
]

VerificationTest[
	MFString[a - b + c]
	,
	"a\n-b\n+c"
	,
	TestID->"10-MFString.nb"
]

VerificationTest[
	MFString[-a - b]
	,
	"-a\n-b"
	,
	TestID->"11-MFString.nb"
]

VerificationTest[
	MFString[1 - a*b]
	,
	"1\n-a b"
	,
	TestID->"12-MFString.nb"
]

VerificationTest[
	MFString[(-a + b)/2]
	,
	"\\frac{1}{2}\n(\n    -a\n    +b\n)"
	,
	TestID->"13-MFString.nb"
]

VerificationTest[
	MFString[(-a + b)/(c + d)]
	,
	"\\frac{\n    -a\n    +b\n}{c+d}"
	,
	TestID->"14-MFString.nb"
]

VerificationTest[
	MFString[((-a)*b)^n]
	,
	"(-a b)^n"
	,
	TestID->"15-MFString.nb"
]

VerificationTest[
	MFString[(-(a + b + c + d + e + f + g)^2)*(c*d)^n + e*f + h]
	,
	"e f\n-(c d)^n\n(a+b+c+d+e+f+g)^2\n+h"
	,
	TestID->"16-MFString.nb"
]

VerificationTest[
	MFString[((-b^2)*a[x, y])/(m[1]*m[2])]
	,
	"\\frac{\n    -b^2\n    a(x,y)\n}{m(1) m(2)}"
	,
	TestID->"17-MFString.nb"
]

VerificationTest[
	MFString[a^n*b^n*((c*d)^n/(e*f))]
	,
	"\\frac{\n    a^n\n    b^n\n    (c d)^n\n}{e f}"
	,
	TestID->"18-MFString.nb"
]

VerificationTest[
	MFString[(a + b*c + d)/(a + b*c + d + 1)]
	,
	"\\frac{\n    a\n    +b c\n    +d\n}{\n    1+a\n    +b c\n    +d\n}"
	,
	TestID->"19-MFString.nb"
]

VerificationTest[
	MFString[a*(b + c)*d, "LinebreakIgnore" -> {HoldPattern[Plus[___]]}]
	,
	"a d (b+c)"
	,
	TestID->"20-MFString.nb"
]

VerificationTest[
	MFString[a*(b + c)*d, "LinebreakIgnore" :> {HoldPattern[Times[___]]}]
	,
	"a\n(b+c)\nd"
	,
	TestID->"21-MFString.nb"
]

VerificationTest[
	MFString[(-s)*t*f[a*b*c] - s*u*f[a*c*d]]
	,
	"-s t\nf(a b c)\n-s u\nf(a c d)"
	,
	TestID->"22-MFString.nb"
]

VerificationTest[
	MFString[(-s)*t*f[a*b*c] - 2*s*u*f[a*c*d]]
	,
	"-s t\nf(a b c)\n-2 s u\nf(a c d)"
	,
	TestID->"23-MFString.nb"
]

VerificationTest[
	expr = -1 - (a/3)*s*t*f[a*b*c] - 2*s*u*f[a*c*d] - (-1)^a*s*t*f[a*b*c*d] - (1/2)*s*u*f[a*c*d, 2] + (-1)^a*s*f[a*b*c*d] + (1/2)*s*u*t*f[a*c*d, 2] - s*u*f[a]
	,
	-1 - s*u*f[a] - (1/3)*a*s*t*f[a*b*c] - 2*s*u*f[a*c*d] + (-1)^a*s*f[a*b*c*d] - (-1)^a*s*t*f[a*b*c*d] - (1/2)*s*u*f[a*c*d, 2] + (1/2)*s*t*u*f[a*c*d, 2]
	,
	TestID->"24-MFString.nb"
]

VerificationTest[
	MFString[expr]
	,
	"-1\n-s u\nf(a)\n-\\frac{1}{3} a s t\nf(a b c)\n-2 s u\nf(a c d)\n+(-1)^a\ns\nf(a b c d)\n-(-1)^a\ns t\nf(a b c d)\n-\\frac{1}{2} s u\nf(a c d,2)\n+\\frac{1}{2} s t u\nf(a c d,2)"
	,
	TestID->"25-MFString.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-MFString.nb"
]