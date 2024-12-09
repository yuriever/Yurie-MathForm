

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
	indexSplit[z, zb, "IndexType" -> "NaturalNumber"][{z0, zb0, zb}]
	,
	{z[0], zb[0], zb}
	,
	TestID->"19-Index.nb"
]

VerificationTest[
	indexSplit[z, zb, "IndexType" -> "NaturalNumberOrSingleLetter"][{z0, zb0, zb}]
	,
	{z[0], zb[0], z[b]}
	,
	TestID->"20-Index.nb"
]

VerificationTest[
	indexJoin[x][Hold[x[1] + x[2]]]
	,
	Hold[x1 + x2]
	,
	TestID->"21-Index.nb"
]

VerificationTest[
	indexJoin[x][HoldComplete[x[1]]]
	,
	HoldComplete[x1]
	,
	TestID->"22-Index.nb"
]

VerificationTest[
	indexJoin[x][Inactive[f][x[1]]]
	,
	Inactive[f][x1]
	,
	TestID->"23-Index.nb"
]

VerificationTest[
	indexSplit[x][Hold[x1 + x2]]
	,
	Hold[x[1] + x[2]]
	,
	TestID->"24-Index.nb"
]

VerificationTest[
	indexSplit[x][HoldComplete[x1]]
	,
	HoldComplete[x[1]]
	,
	TestID->"25-Index.nb"
]

VerificationTest[
	indexSplit[x][Inactive[f][x1]]
	,
	Inactive[f][x[1]]
	,
	TestID->"26-Index.nb"
]

VerificationTest[
	indexToZero[x][1][x1]
	,
	0
	,
	TestID->"27-Index.nb"
]

VerificationTest[
	indexToEqual[x][1 -> 2][x1]
	,
	x2
	,
	TestID->"28-Index.nb"
]

VerificationTest[
	indexToDiff[x][1 -> 2][x1 - x2]
	,
	x12
	,
	TestID->"29-Index.nb"
]

VerificationTest[
	indexToDiffBack[x][1 -> 2][x12]
	,
	x1 - x2
	,
	TestID->"30-Index.nb"
]

VerificationTest[
	ToExpression["Format[phat]:=OverHat[p]"]
	,
	Null
	,
	TestID->"31-Index.nb"
]

VerificationTest[
	FullForm[indexize[phat, 1]]
	,
	FullForm[phat1]
	,
	TestID->"32-Index.nb"
]

VerificationTest[
	FullForm[indexSplit[phat, "IndexPosition" -> Subscript][phat1]]
	,
	FullForm[Subscript[phat, 1]]
	,
	TestID->"33-Index.nb"
]

VerificationTest[
	ClearAll[phat]
	,
	Null
	,
	TestID->"34-Index.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-Index.nb"
]