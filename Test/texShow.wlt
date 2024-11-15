

(*texShow.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-texShow.nb"
]

VerificationTest[
	Get["Yurie`MathForm`"]
	,
	Null
	,
	TestID->"1-texShow.nb"
]

VerificationTest[
	texShowBlockGraphics[args___] := (StringDrop[#1, 1] & )[StringDelete[DatePattern[{"Year", "Month", "Day"}, "-"]][Catch[Block[{Yurie`MathForm`TeXShow`Private`importPDF}, Yurie`MathForm`TeXShow`Private`importPDF[id_] := Throw[id]; texShow[args]]]]]; 
	,
	Null
	,
	TestID->"2-texShow.nb"
]

VerificationTest[
	expr = {a, b}
	,
	{a, b}
	,
	TestID->"3-texShow.nb"
]

VerificationTest[
	texForm[expr]
	,
	"\\{a,b\\}"
	,
	TestID->"4-texShow.nb"
]

VerificationTest[
	string = texForm[expr]
	,
	"\\{a,b\\}"
	,
	TestID->"5-texShow.nb"
]

VerificationTest[
	texShowBlockGraphics[expr]
	,
	"7741539260952591760-Multiple"
	,
	TestID->"6-texShow.nb"
]

VerificationTest[
	texShowBlockGraphics[string]
	,
	"5096232467966650635-Single"
	,
	TestID->"7-texShow.nb"
]

VerificationTest[
	texShowBlockGraphics[""]
	,
	"7711654075342081847-Single"
	,
	TestID->"8-texShow.nb"
]

VerificationTest[
	texShowBlockGraphics[{}, "Listable" -> True]
	,
	{}
	,
	TestID->"9-texShow.nb"
]

VerificationTest[
	texShowBlockGraphics[{}, "Listable" -> False]
	,
	"7171960276681927965-Single"
	,
	TestID->"10-texShow.nb"
]

VerificationTest[
	SetOptions[texShow, "Listable" -> False]
	,
	{"Preamble" -> {"\\usepackage{amsmath,amssymb}"}, "FontSize" -> 12, "LineSpacing" -> {1.2, 0}, "Magnification" -> 1.5, "CopyToClipboard" -> True, "ClearCache" -> False, "Listable" -> False}
	,
	TestID->"11-texShow.nb"
]

VerificationTest[
	texShowBlockGraphics[expr]
	,
	"5096232467966650635-Single"
	,
	TestID->"12-texShow.nb"
]

VerificationTest[
	texShowBlockGraphics[string]
	,
	"5096232467966650635-Single"
	,
	TestID->"13-texShow.nb"
]

VerificationTest[
	SetOptions[texShow, "FontSize" -> 10]
	,
	{"Preamble" -> {"\\usepackage{amsmath,amssymb}"}, "FontSize" -> 10, "LineSpacing" -> {1.2, 0}, "Magnification" -> 1.5, "CopyToClipboard" -> True, "ClearCache" -> False, "Listable" -> False}
	,
	TestID->"14-texShow.nb"
]

VerificationTest[
	texShowBlockGraphics[a]
	,
	"9181961723921148291-Single"
	,
	TestID->"15-texShow.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-texShow.nb"
]