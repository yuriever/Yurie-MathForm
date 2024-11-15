

(*Format.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-Format.nb"
]

VerificationTest[
	Get["Yurie`MathForm`"]
	,
	Null
	,
	TestID->"1-Format.nb"
]

VerificationTest[
	f /: MakeBoxes[f[x_], format_] := interpretize[SubscriptBox["f", MakeBoxes[x]], f[x]]
	,
	Null
	,
	TestID->"2-Format.nb"
]

VerificationTest[
	g /: MakeBoxes[g[x_, y_], format_] := interpretize[SubscriptBox["g", RowBox[{MakeBoxes[x], ",", MakeBoxes[y]}]]]
	,
	Null
	,
	TestID->"3-Format.nb"
]

VerificationTest[
	ff[x_] := interpretize[Superscript["ff", x], ff[x]]
	,
	Null
	,
	TestID->"4-Format.nb"
]

VerificationTest[
	gg[x_, y_] := interpretize[Superscript["gg", {x, y}]]
	,
	Null
	,
	TestID->"5-Format.nb"
]

VerificationTest[
	FullForm[MakeBoxes[f[a]]]
	,
	FullForm[InterpretationBox[SubscriptBox["f", "a"], f[a]]]
	,
	TestID->"6-Format.nb"
]

VerificationTest[
	FullForm[MakeBoxes[g[a, b]]]
	,
	FullForm[InterpretationBox[SubscriptBox["g", RowBox[{"a", ",", "b"}]], g[a, b]]]
	,
	TestID->"7-Format.nb"
]

VerificationTest[
	ClearAll[f, g, ff, gg]
	,
	Null
	,
	TestID->"8-Format.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-Format.nb"
]