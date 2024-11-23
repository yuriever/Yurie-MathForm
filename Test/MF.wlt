

(*MF.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-MF.nb"
]

VerificationTest[
	Get["Yurie`MathForm`"]
	,
	Null
	,
	TestID->"1-MF.nb"
]

VerificationTest[
	MFBlockGraphics[args___] := (StringDrop[#1, 1] & )[StringDelete[DatePattern[{"Year", "Month", "Day"}, "-"]][Catch[Block[{Yurie`MathForm`MF`Private`importPDF}, Yurie`MathForm`MF`Private`importPDF[id_] := Throw[id]; MF[args]]]]]; 
	,
	Null
	,
	TestID->"2-MF.nb"
]

VerificationTest[
	expr = {a, b}
	,
	{a, b}
	,
	TestID->"3-MF.nb"
]

VerificationTest[
	MFString[expr]
	,
	"\\{a,b\\}"
	,
	TestID->"4-MF.nb"
]

VerificationTest[
	string = MFString[expr]
	,
	"\\{a,b\\}"
	,
	TestID->"5-MF.nb"
]

VerificationTest[
	MFBlockGraphics[expr]
	,
	"7741539260952591760-Multiple"
	,
	TestID->"6-MF.nb"
]

VerificationTest[
	MFBlockGraphics[string]
	,
	"5096232467966650635-Single"
	,
	TestID->"7-MF.nb"
]

VerificationTest[
	MFBlockGraphics[""]
	,
	"7711654075342081847-Single"
	,
	TestID->"8-MF.nb"
]

VerificationTest[
	MFBlockGraphics[{}, "Listable" -> True]
	,
	{}
	,
	TestID->"9-MF.nb"
]

VerificationTest[
	MFBlockGraphics[{}, "Listable" -> False]
	,
	"7171960276681927965-Single"
	,
	TestID->"10-MF.nb"
]

VerificationTest[
	SetOptions[MF, "Listable" -> False]; 
	,
	Null
	,
	TestID->"11-MF.nb"
]

VerificationTest[
	MFBlockGraphics[expr]
	,
	"5096232467966650635-Single"
	,
	TestID->"12-MF.nb"
]

VerificationTest[
	MFBlockGraphics[string]
	,
	"5096232467966650635-Single"
	,
	TestID->"13-MF.nb"
]

VerificationTest[
	SetOptions[MF, "FontSize" -> 10]; 
	,
	Null
	,
	TestID->"14-MF.nb"
]

VerificationTest[
	MFBlockGraphics[a]
	,
	"9181961723921148291-Single"
	,
	TestID->"15-MF.nb"
]

VerificationTest[
	Yurie`MathForm`MF`Private`leafCount[{Plus[__]}, 1 - 1]
	,
	1
	,
	TestID->"16-MF.nb"
]

VerificationTest[
	Yurie`MathForm`MF`Private`leafCount[{}, 1 - 1]
	,
	3
	,
	TestID->"17-MF.nb"
]

VerificationTest[
	Yurie`MathForm`MF`Private`leafCount[{}, a + b]
	,
	3
	,
	TestID->"18-MF.nb"
]

VerificationTest[
	Yurie`MathForm`MF`Private`leafCount[{}, a - b]
	,
	3
	,
	TestID->"19-MF.nb"
]

VerificationTest[
	Yurie`MathForm`MF`Private`leafCount[{}, 1 - 1 + a - b]
	,
	5
	,
	TestID->"20-MF.nb"
]

VerificationTest[
	Yurie`MathForm`MF`Private`leafCount[{HoldPattern[Plus[__]]}, 1 - 1 + a - b]
	,
	1
	,
	TestID->"21-MF.nb"
]

VerificationTest[
	SetOptions[{MFString}, "LinebreakThreshold" -> 2]
	,
	{{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 2, "LinebreakIgnore" -> {}}}
	,
	TestID->"22-MF.nb"
]

VerificationTest[
	MFString[-a]
	,
	"-a"
	,
	TestID->"23-MF.nb"
]

VerificationTest[
	MFString[a - b + c]
	,
	"a-b+c"
	,
	TestID->"24-MF.nb"
]

VerificationTest[
	MFString[-a - b]
	,
	"-a-b"
	,
	TestID->"25-MF.nb"
]

VerificationTest[
	MFString[1 - a*b]
	,
	"1\n-a b"
	,
	TestID->"26-MF.nb"
]

VerificationTest[
	MFString[(-a + b)/2]
	,
	"\\frac{1}{2} \n (-a+b)"
	,
	TestID->"27-MF.nb"
]

VerificationTest[
	MFString[(-a + b)/(c + d)]
	,
	"\\frac{\n-a+b\n}{c+d}"
	,
	TestID->"28-MF.nb"
]

VerificationTest[
	MFString[((-a)*b)^n]
	,
	"(-a b)^n"
	,
	TestID->"29-MF.nb"
]

VerificationTest[
	MFString[(-(a + b + c + d + e + f + g)^2)*(c*d)^n + e*f + h]
	,
	"e f\n- \n (c d)^n \n (a+b+c+d+e+f+g)^2 \n+h"
	,
	TestID->"30-MF.nb"
]

VerificationTest[
	MFString[((-b^2)*a[x, y])/(m[1]*m[2])]
	,
	"\\frac{\n (-1) \n b^2 \n a(x,y) \n}{m(1) m(2)}"
	,
	TestID->"31-MF.nb"
]

VerificationTest[
	MFString[a^n*b^n*((c*d)^n/(e*f))]
	,
	"\\frac{\n a^n \n b^n \n (c d)^n \n}{e f}"
	,
	TestID->"32-MF.nb"
]

VerificationTest[
	MFString[(a + b*c + d)/(a + b*c + d + 1)]
	,
	"\\frac{\na\n+b c\n+d\n}{\n1+a\n+b c\n+d\n}"
	,
	TestID->"33-MF.nb"
]

VerificationTest[
	MFString[a*(b + c)*d, "LinebreakIgnore" -> {HoldPattern[Plus[___]]}]
	,
	"a d (b+c)"
	,
	TestID->"34-MF.nb"
]

VerificationTest[
	MFString[a*(b + c)*d, "LinebreakIgnore" :> {HoldPattern[Times[___]]}]
	,
	"a \n (b+c) \n d"
	,
	TestID->"35-MF.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-MF.nb"
]