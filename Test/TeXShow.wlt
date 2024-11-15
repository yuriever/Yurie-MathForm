

(*TeXShow.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-TeXShow.nb"
]

VerificationTest[
	Get["Yurie`MathForm`"]
	,
	Null
	,
	TestID->"1-TeXShow.nb"
]

VerificationTest[
	texShowBlockGraphics[args___] := (StringDrop[#1, 1] & )[StringDelete[DatePattern[{"Year", "Month", "Day"}, "-"]][Catch[Block[{Yurie`MathForm`TeXShow`Private`importPDF}, Yurie`MathForm`TeXShow`Private`importPDF[id_] := Throw[id]; texShow[args]]]]]; 
	,
	Null
	,
	TestID->"2-TeXShow.nb"
]

VerificationTest[
	expr = {a, b}
	,
	{a, b}
	,
	TestID->"3-TeXShow.nb"
]

VerificationTest[
	texForm[expr]
	,
	"\\{a,b\\}"
	,
	TestID->"4-TeXShow.nb"
]

VerificationTest[
	string = texForm[expr]
	,
	"\\{a,b\\}"
	,
	TestID->"5-TeXShow.nb"
]

VerificationTest[
	texShowBlockGraphics[expr]
	,
	"7741539260952591760-Multiple"
	,
	TestID->"6-TeXShow.nb"
]

VerificationTest[
	texShowBlockGraphics[string]
	,
	"5096232467966650635-Single"
	,
	TestID->"7-TeXShow.nb"
]

VerificationTest[
	SetOptions[texShow, "Listable" -> False]
	,
	{"Preamble" -> {"\\usepackage{amsmath,amssymb}"}, "FontSize" -> 12, "LineSpacing" -> {1.2, 0}, "Magnification" -> 1.5, "CopyToClipboard" -> True, "ClearCache" -> False, "Listable" -> False}
	,
	TestID->"8-TeXShow.nb"
]

VerificationTest[
	texShowBlockGraphics[expr]
	,
	"5096232467966650635-Single"
	,
	TestID->"9-TeXShow.nb"
]

VerificationTest[
	texShowBlockGraphics[string]
	,
	"5096232467966650635-Single"
	,
	TestID->"10-TeXShow.nb"
]

VerificationTest[
	SetOptions[texShow, "CopyToClipboard" -> False]
	,
	{"Preamble" -> {"\\usepackage{amsmath,amssymb}"}, "FontSize" -> 12, "LineSpacing" -> {1.2, 0}, "Magnification" -> 1.5, "CopyToClipboard" -> False, "ClearCache" -> False, "Listable" -> False}
	,
	TestID->"11-TeXShow.nb"
]

VerificationTest[
	texShowBlockGraphics[a]
	,
	"3827774349118199498-Single"
	,
	TestID->"12-TeXShow.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-TeXShow.nb"
]