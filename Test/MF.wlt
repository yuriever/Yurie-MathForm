

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
	SetOptions[MF, "Listable" -> False]
	,
	{"Preamble" -> {"\\usepackage{amsmath,amssymb}"}, "FontSize" -> 12, "LineSpacing" -> {1.2, 0}, "Magnification" -> 1.5, "RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 5, "LinebreakIgnore" -> {}, "CopyToClipboard" -> True, "ClearCache" -> False, "Listable" -> False}
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
	SetOptions[MF, "FontSize" -> 10]
	,
	{"Preamble" -> {"\\usepackage{amsmath,amssymb}"}, "FontSize" -> 10, "LineSpacing" -> {1.2, 0}, "Magnification" -> 1.5, "RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 5, "LinebreakIgnore" -> {}, "CopyToClipboard" -> True, "ClearCache" -> False, "Listable" -> False}
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
	SetOptions[{MFString}, "LinebreakThreshold" -> 4]
	,
	{{"RemoveLeftRightPair" -> True, "Linebreak" -> True, "LinebreakThreshold" -> 4, "LinebreakIgnore" -> {}}}
	,
	TestID->"16-MF.nb"
]

VerificationTest[
	MFString[-a]
	,
	"-a"
	,
	TestID->"17-MF.nb"
]

VerificationTest[
	MFString[a - b + c]
	,
	"(\na\n-b\n+c\n)"
	,
	TestID->"18-MF.nb"
]

VerificationTest[
	MFString[-a - b]
	,
	"-a-b"
	,
	TestID->"19-MF.nb"
]

VerificationTest[
	MFString[1 - a*b]
	,
	"(\n1\n-a b\n)"
	,
	TestID->"20-MF.nb"
]

VerificationTest[
	MFString[(-a + b)/2]
	,
	"\\frac{1}{2}\n(\nb-a\n)"
	,
	TestID->"21-MF.nb"
]

VerificationTest[
	MFString[(-a + b)/(c + d)]
	,
	"\\frac{\nb-a\n}{\nc+d\n}"
	,
	TestID->"22-MF.nb"
]

VerificationTest[
	MFString[((-a)*b)^n]
	,
	"(-a b)^n"
	,
	TestID->"23-MF.nb"
]

VerificationTest[
	MFString[(-(a + b + c + d + e + f + g)^2)*(c*d)^n + e*f + h]
	,
	"(\ne f\n+h\n-(c d)^n\n(\na\n+b\n+c\n+d\n+e\n+f\n+g\n)^2\n)"
	,
	TestID->"24-MF.nb"
]

VerificationTest[
	MFString[((-b^2)*a[x, y])/(m[1]*m[2])]
	,
	"\\frac{\n-b^2\na(x,y)\n}{\nm(1)\nm(2)\n}"
	,
	TestID->"25-MF.nb"
]

VerificationTest[
	MFString[(-(a + b - c + d + e + f + g)^2)*(c*d)^n + e*f + h]
	,
	"(\ne f\n+h\n-(c d)^n\n(\na\n+b\n-c\n+d\n+e\n+f\n+g\n)^2\n)"
	,
	TestID->"26-MF.nb"
]

VerificationTest[
	MFString[a^n*b^n*((c*d)^n/(e*f))]
	,
	"\\frac{\na^n\nb^n\n(c d)^n\n}{\ne\nf\n}"
	,
	TestID->"27-MF.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-MF.nb"
]