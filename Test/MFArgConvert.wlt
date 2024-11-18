

(*MFArgConvert.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-MFArgConvert.nb"
]

VerificationTest[
	Get["Yurie`MathForm`"]
	,
	Null
	,
	TestID->"1-MFArgConvert.nb"
]

VerificationTest[
	ClearAll["`*"]
	,
	Null
	,
	TestID->"2-MFArgConvert.nb"
]

VerificationTest[
	Yurie`MathForm`MFArgConvert`Private`stripFunPattern[f]
	,
	"f"
	,
	TestID->"3-MFArgConvert.nb"
]

VerificationTest[
	Yurie`MathForm`MFArgConvert`Private`stripFunPattern[f[_]]
	,
	"f"
	,
	TestID->"4-MFArgConvert.nb"
]

VerificationTest[
	Yurie`MathForm`MFArgConvert`Private`stripFunPattern[f[___]]
	,
	"f"
	,
	TestID->"5-MFArgConvert.nb"
]

VerificationTest[
	Yurie`MathForm`MFArgConvert`Private`stripFunPattern[f[_List]]
	,
	"f"
	,
	TestID->"6-MFArgConvert.nb"
]

VerificationTest[
	Yurie`MathForm`MFArgConvert`Private`stripFunPattern[f[___List]]
	,
	"f"
	,
	TestID->"7-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert[][{head}]; 
	MFString[head]
	,
	"\\head"
	,
	TestID->"8-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert[][{fun[_]}]; 
	MFString[fun[a]]
	,
	"\\fun{a}"
	,
	TestID->"9-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert[][{funWithMultiArg[___]}]; 
	MFString[funWithMultiArg[a, b]]
	,
	"\\funWithMultiArg{a}{b}"
	,
	TestID->"10-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert[][{funWithListArg[_List]}]; 
	MFString[funWithListArg[{a, b}]]
	,
	"\\funWithListArg{\n\ta,\n\tb\n}"
	,
	TestID->"11-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert[][{funWithMultiListArg[___List]}]; 
	MFString[funWithMultiListArg[{a, b}, {c, d}]]
	,
	"\\funWithMultiListArg{\n\ta,\n\tb\n}{\n\tc,\n\td\n}"
	,
	TestID->"12-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert["\\left{", "\\right}"][{fun[_]}]; 
	MFString[fun[a]]
	,
	"\\fun\\left{a\\right}"
	,
	TestID->"13-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert["\\left{", "\\right}"][{funWithMultiArg[___]}]; 
	MFString[funWithMultiArg[a, b]]
	,
	"\\funWithMultiArg\\left{a\\right}\\left{b\\right}"
	,
	TestID->"14-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert["{", "}", ";"][{funWithListArg[_List]}]; 
	MFString[funWithListArg[{a, b}]]
	,
	"\\funWithListArg{a;b}"
	,
	TestID->"15-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert["{", "}", ";"][{funWithMultiListArg[___List]}]; 
	MFString[funWithMultiListArg[{a, b}, {c, d}]]
	,
	"\\funWithMultiListArg{a;b}{c;d}"
	,
	TestID->"16-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert[][{fun[_], funWithMultiArg[___], funWithListArg[_List], funWithMultiListArg[___List]}]
	,
	Null
	,
	TestID->"17-MFArgConvert.nb"
]

VerificationTest[
	MFString[funWithListArg[{fun[a], fun[b]}]]
	,
	"\\funWithListArg{\n\t\\fun{a},\n\t\\fun{b}\n}"
	,
	TestID->"18-MFArgConvert.nb"
]

VerificationTest[
	MFString[funWithMultiListArg[{fun[a], fun[b]}, {funWithMultiArg[c, d]}]]
	,
	"\\funWithMultiListArg{\n\t\\fun{a},\n\t\\fun{b}\n}{\n\t\\funWithMultiArg{c}{d}\n}"
	,
	TestID->"19-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert[][{fun[_] -> "f", funWithMultiArg[___] -> "g", funWithListArg[_List] -> "h", funWithMultiListArg[___List] -> "k"}]
	,
	Null
	,
	TestID->"20-MFArgConvert.nb"
]

VerificationTest[
	MFString[funWithListArg[{fun[a], fun[b]}]]
	,
	"\\h{\n\t\\f{a},\n\t\\f{b}\n}"
	,
	TestID->"21-MFArgConvert.nb"
]

VerificationTest[
	MFString[funWithMultiListArg[{fun[a], fun[b]}, {funWithMultiArg[c, d]}]]
	,
	"\\k{\n\t\\f{a},\n\t\\f{b}\n}{\n\t\\g{c}{d}\n}"
	,
	TestID->"22-MFArgConvert.nb"
]

VerificationTest[
	ToExpression["Format[g[x_]]:=Subscript[g,x];"]
	,
	Null
	,
	TestID->"23-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert[][{g[_List]}]
	,
	Null
	,
	{Yurie`MathForm`MFArgConvert::clearformat}
	,
	TestID->"24-MFArgConvert.nb"
]

VerificationTest[
	MFArgConvert[][{g[b]}]
	,
	Null
	,
	{Yurie`MathForm`MFArgConvert::notsupported}
	,
	TestID->"25-MFArgConvert.nb"
]

VerificationTest[
	MFString[g[{a, b}]]
	,
	"g{\n\ta,\n\tb\n}"
	,
	TestID->"26-MFArgConvert.nb"
]

VerificationTest[
	MFClear[fun]
	,
	Null
	,
	TestID->"27-MFArgConvert.nb"
]

VerificationTest[
	MFString[funWithListArg[{fun[a], fun[b]}]]
	,
	"\\h{\n\t\\text{fun}(a),\n\t\\text{fun}(b)\n}"
	,
	TestID->"28-MFArgConvert.nb"
]

VerificationTest[
	MFClear[]
	,
	Null
	,
	TestID->"29-MFArgConvert.nb"
]

VerificationTest[
	MFString[fun]
	,
	"\\text{fun}"
	,
	TestID->"30-MFArgConvert.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-MFArgConvert.nb"
]