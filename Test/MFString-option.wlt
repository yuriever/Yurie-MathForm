

(*MFString-option.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-MFString-option.nb"
]

VerificationTest[
	Get["Yurie`MathForm`"]
	,
	Null
	,
	TestID->"1-MFString-option.nb"
]

VerificationTest[
	MFClear[]
	,
	Null
	,
	TestID->"2-MFString-option.nb"
]

VerificationTest[
	MFArgConvert["{", "}"][Fpq[_]]
	,
	Null
	,
	TestID->"3-MFString-option.nb"
]

VerificationTest[
	(MFString[#1, "Linebreak" -> False] & )[Fpq[1/z]]
	,
	"\\Fpq{\\frac{1}{z}}"
	,
	TestID->"4-MFString-option.nb"
]

VerificationTest[
	(MFString[#1, "Linebreak" -> False, "RemoveLeftRightPair" -> False] & )[Fpq[1/z]]
	,
	"\\Fpq{\\frac{1}{z}}"
	,
	TestID->"5-MFString-option.nb"
]

VerificationTest[
	MFArgConvert["{", "}"][Fpq[___]]
	,
	Null
	,
	{Yurie`MathForm`MFArgConvert::clearformat}
	,
	TestID->"6-MFString-option.nb"
]

VerificationTest[
	(MFString[#1, "Linebreak" -> False] & )[Fpq[1/z]]
	,
	"\\Fpq{\\frac{1}{z}}"
	,
	TestID->"7-MFString-option.nb"
]

VerificationTest[
	(MFString[#1, "Linebreak" -> False, "RemoveLeftRightPair" -> False] & )[Fpq[1/z]]
	,
	"\\Fpq{\\frac{1}{z}}"
	,
	TestID->"8-MFString-option.nb"
]

VerificationTest[
	MFArgConvert["{", "}", ","][Fpq[_List]]
	,
	Null
	,
	{Yurie`MathForm`MFArgConvert::clearformat}
	,
	TestID->"9-MFString-option.nb"
]

VerificationTest[
	(MFString[#1, "Linebreak" -> False] & )[Fpq[{1/z}]]
	,
	"\\Fpq{\\frac{1}{z}}"
	,
	TestID->"10-MFString-option.nb"
]

VerificationTest[
	(MFString[#1, "Linebreak" -> False, "RemoveLeftRightPair" -> False] & )[Fpq[{1/z}]]
	,
	"\\Fpq{\\frac{1}{z}}"
	,
	TestID->"11-MFString-option.nb"
]

VerificationTest[
	MFArgConvert["{", "}", ","][Fpq[___List]]
	,
	Null
	,
	{Yurie`MathForm`MFArgConvert::clearformat}
	,
	TestID->"12-MFString-option.nb"
]

VerificationTest[
	(MFString[#1, "Linebreak" -> False] & )[Fpq[{1/z}]]
	,
	"\\Fpq{\\frac{1}{z}}"
	,
	TestID->"13-MFString-option.nb"
]

VerificationTest[
	(MFString[#1, "Linebreak" -> False, "RemoveLeftRightPair" -> False] & )[Fpq[{1/z}]]
	,
	"\\Fpq{\\frac{1}{z}}"
	,
	TestID->"14-MFString-option.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-MFString-option.nb"
]