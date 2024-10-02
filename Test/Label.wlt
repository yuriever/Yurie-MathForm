

(*Label.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-Label.nb"
]

VerificationTest[
	Get["Yurie`Math`"]
	,
	Null
	,
	TestID->"1-Label.nb"
]

VerificationTest[
	labelJoin[x]
	,
	x
	,
	TestID->"2-Label.nb"
]

VerificationTest[
	labelJoin[{x}]
	,
	x
	,
	TestID->"3-Label.nb"
]

VerificationTest[
	labelJoin[x, Null]
	,
	x
	,
	TestID->"4-Label.nb"
]

VerificationTest[
	labelJoin[{x, Null}]
	,
	x
	,
	TestID->"5-Label.nb"
]

VerificationTest[
	labelJoin[x, a]
	,
	xa
	,
	TestID->"6-Label.nb"
]

VerificationTest[
	labelJoin[{x, a}]
	,
	xa
	,
	TestID->"7-Label.nb"
]

VerificationTest[
	labelJoin[x, 1, 2]
	,
	x12
	,
	TestID->"8-Label.nb"
]

VerificationTest[
	labelJoin[{x, 1, 2}]
	,
	x12
	,
	TestID->"9-Label.nb"
]

VerificationTest[
	labelSplit[x][xa + xb]
	,
	Subscript[x, a] + Subscript[x, b]
	,
	TestID->"10-Label.nb"
]

VerificationTest[
	labelSplit[x, "LabelPosition" -> Superscript][xa + xb]
	,
	Superscript[x, a] + Superscript[x, b]
	,
	TestID->"11-Label.nb"
]

VerificationTest[
	labelSplit[x, "LabelPosition" -> Construct][xa + xb]
	,
	x[a] + x[b]
	,
	TestID->"12-Label.nb"
]

VerificationTest[
	labelSplit[x, "LabelPosition" -> f][xa + xb]
	,
	f[x, a] + f[x, b]
	,
	TestID->"13-Label.nb"
]

VerificationTest[
	list = {z, zb, z1, zb1}; 
	labelSplit[z, zb][list]
	,
	{z, Subscript[z, b], Subscript[z, 1], Subscript[z, b1]}
	,
	TestID->"14-Label.nb"
]

VerificationTest[
	labelSplit[zb, z][list]
	,
	{z, Subscript[z, b], Subscript[z, 1], Subscript[z, b1]}
	,
	TestID->"15-Label.nb"
]

VerificationTest[
	labelSplit[z, zb, "LabelType" -> "PositiveInteger"][list]
	,
	{z, zb, Subscript[z, 1], Subscript[zb, 1]}
	,
	TestID->"16-Label.nb"
]

VerificationTest[
	labelSplit[zb, z, "LabelType" -> "PositiveInteger"][list]
	,
	{z, zb, Subscript[z, 1], Subscript[zb, 1]}
	,
	TestID->"17-Label.nb"
]

VerificationTest[
	labelShiftToZero[x][1][x1]
	,
	0
	,
	TestID->"18-Label.nb"
]

VerificationTest[
	labelShiftToEqual[x][1 -> 2][x1]
	,
	x2
	,
	TestID->"19-Label.nb"
]

VerificationTest[
	labelShiftToDiff[x][1 -> 2][x1 - x2]
	,
	x12
	,
	TestID->"20-Label.nb"
]

VerificationTest[
	labelShiftToDiffBack[x][1 -> 2][x12]
	,
	x1 - x2
	,
	TestID->"21-Label.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-Label.nb"
]