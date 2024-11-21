

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
	{"Preamble" -> {"\\usepackage{amsmath,amssymb}"}, "FontSize" -> 12, "LineSpacing" -> {1.2, 0}, "Magnification" -> 1.5, "RemoveLeftRightPair" -> True, "BreakPlusTimes" -> True, "BreakPlusTimesThreshold" -> 10, "CopyToClipboard" -> True, "ClearCache" -> False, "Listable" -> False}
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
	{"Preamble" -> {"\\usepackage{amsmath,amssymb}"}, "FontSize" -> 10, "LineSpacing" -> {1.2, 0}, "Magnification" -> 1.5, "RemoveLeftRightPair" -> True, "BreakPlusTimes" -> True, "BreakPlusTimesThreshold" -> 10, "CopyToClipboard" -> True, "ClearCache" -> False, "Listable" -> False}
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
	MFString[((-a)*b)^n, "BreakPlusTimesThreshold" -> 2]
	,
	"(\n-a\nb\n)^n"
	,
	TestID->"16-MF.nb"
]

VerificationTest[
	MFString[a - b + c, "BreakPlusTimesThreshold" -> 2]
	,
	"(\na\n+\nc\n-\nb\n)"
	,
	TestID->"17-MF.nb"
]

VerificationTest[
	MFString[-a - b, "BreakPlusTimesThreshold" -> 2]
	,
	"(\n-a\n-\nb\n)"
	,
	TestID->"18-MF.nb"
]

VerificationTest[
	MFString[1 - a*b, "BreakPlusTimesThreshold" -> 2]
	,
	"(\n1\n-\na\nb\n)"
	,
	TestID->"19-MF.nb"
]

VerificationTest[
	MFString[(-(a + b + c + d + e + f + g)^2)*(c*d)^n + e*f + h, "BreakPlusTimesThreshold" -> 10]
	,
	"(\n-(c d)^n\n(a+b+c+d+e+f+g)^2\n)+e f+h"
	,
	TestID->"20-MF.nb"
]

VerificationTest[
	MFString[(-(a + b - c + d + e + f + g)^2)*(c*d)^n + e*f + h, "BreakPlusTimesThreshold" -> 20]
	,
	"(\ne f\n-\n(c d)^n (a+b-c+d+e+f+g)^2\n+\nh\n)"
	,
	TestID->"21-MF.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-MF.nb"
]