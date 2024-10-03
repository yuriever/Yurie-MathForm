

(*Index.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-Index.nb"
]

VerificationTest[
	Get["Yurie`MathForm`"]
	,
	Null
	,
	TestID->"1-Index.nb"
]

VerificationTest[
	indexize[x, Null]
	,
	x
	,
	TestID->"2-Index.nb"
]

VerificationTest[
	indexize[{x, Null}]
	,
	x
	,
	TestID->"3-Index.nb"
]

VerificationTest[
	indexize[x, a]
	,
	xa
	,
	TestID->"4-Index.nb"
]

VerificationTest[
	indexize[{x, a}]
	,
	xa
	,
	TestID->"5-Index.nb"
]

VerificationTest[
	indexJoin[x][x[] + x[a] + x[b] + x[a + b] + y[0]]
	,
	xa + xb + x[] + x[a + b] + y[0]
	,
	TestID->"6-Index.nb"
]

VerificationTest[
	indexJoin[x, "IndexPosition" -> Subscript][Subscript[x, a] + Subscript[x, b]]
	,
	xa + xb
	,
	TestID->"7-Index.nb"
]

VerificationTest[
	indexJoin[x, "IndexPosition" -> Superscript][Superscript[x, a] + Superscript[x, b]]
	,
	xa + xb
	,
	TestID->"8-Index.nb"
]

VerificationTest[
	expr = x + xa + xb + x[] + y[0]
	,
	x + xa + xb + x[] + y[0]
	,
	TestID->"9-Index.nb"
]

VerificationTest[
	indexSplit[x][expr]
	,
	x + x[] + x[a] + x[b] + y[0]
	,
	TestID->"10-Index.nb"
]

VerificationTest[
	indexSplit[x, "IndexPosition" -> Subscript][expr]
	,
	x + Subscript[x, a] + Subscript[x, b] + x[] + y[0]
	,
	TestID->"11-Index.nb"
]

VerificationTest[
	indexSplit[x, "IndexPosition" -> Superscript][expr]
	,
	x + Superscript[x, a] + Superscript[x, b] + x[] + y[0]
	,
	TestID->"12-Index.nb"
]

VerificationTest[
	indexSplit[x, "IndexPosition" -> f][expr]
	,
	Quiet[x + xa + xb + x[] + y[0]]
	,
	{Yurie`MathForm`indexSplit::optnotmatch}
	,
	TestID->"13-Index.nb"
]

VerificationTest[
	list = {z, zb, z1, zb1}; 
	,
	Null
	,
	TestID->"14-Index.nb"
]

VerificationTest[
	indexSplit[z, zb][list]
	,
	{z, z[b], z[1], z[b1]}
	,
	TestID->"15-Index.nb"
]

VerificationTest[
	indexSplit[zb, z][list]
	,
	{z, z[b], z[1], z[b1]}
	,
	TestID->"16-Index.nb"
]

VerificationTest[
	indexSplit[z, zb, "IndexType" -> "PositiveInteger"][list]
	,
	{z, zb, z[1], zb[1]}
	,
	TestID->"17-Index.nb"
]

VerificationTest[
	indexSplit[zb, z, "IndexType" -> "PositiveInteger"][list]
	,
	{z, zb, z[1], zb[1]}
	,
	TestID->"18-Index.nb"
]

VerificationTest[
	indexToZero[x][1][x1]
	,
	0
	,
	TestID->"19-Index.nb"
]

VerificationTest[
	indexToEqual[x][1 -> 2][x1]
	,
	x2
	,
	TestID->"20-Index.nb"
]

VerificationTest[
	indexToDiff[x][1 -> 2][x1 - x2]
	,
	x12
	,
	TestID->"21-Index.nb"
]

VerificationTest[
	indexToDiffBack[x][1 -> 2][x12]
	,
	x1 - x2
	,
	TestID->"22-Index.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-Index.nb"
]