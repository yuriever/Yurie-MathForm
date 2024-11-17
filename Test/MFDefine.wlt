

(*MFDefine.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-MFDefine.nb"
]

VerificationTest[
	Get["Yurie`MathForm`"]
	,
	Null
	,
	TestID->"1-MFDefine.nb"
]

VerificationTest[
	ClearAll["`*"]
	,
	Null
	,
	TestID->"2-MFDefine.nb"
]

VerificationTest[
	Yurie`MathForm`MFDefine`Private`stripFunPattern[f]
	,
	"f"
	,
	TestID->"3-MFDefine.nb"
]

VerificationTest[
	Yurie`MathForm`MFDefine`Private`stripFunPattern[f[_]]
	,
	"f"
	,
	TestID->"4-MFDefine.nb"
]

VerificationTest[
	Yurie`MathForm`MFDefine`Private`stripFunPattern[f[___]]
	,
	"f"
	,
	TestID->"5-MFDefine.nb"
]

VerificationTest[
	Yurie`MathForm`MFDefine`Private`stripFunPattern[f[_List]]
	,
	"f"
	,
	TestID->"6-MFDefine.nb"
]

VerificationTest[
	Yurie`MathForm`MFDefine`Private`stripFunPattern[f[___List]]
	,
	"f"
	,
	TestID->"7-MFDefine.nb"
]

VerificationTest[
	MFDefine[][{head}]; 
	MFString[head]
	,
	"\\head"
	,
	TestID->"8-MFDefine.nb"
]

VerificationTest[
	MFDefine[][{fun[_]}]; 
	MFString[fun[a]]
	,
	"\\fun{a}"
	,
	TestID->"9-MFDefine.nb"
]

VerificationTest[
	MFDefine[][{funWithMultiArg[___]}]; 
	MFString[funWithMultiArg[a, b]]
	,
	"\\funWithMultiArg{a}{b}"
	,
	TestID->"10-MFDefine.nb"
]

VerificationTest[
	MFDefine[][{funWithListArg[_List]}]; 
	MFString[funWithListArg[{a, b}]]
	,
	"\\funWithListArg{\n\ta,\n\tb\n}"
	,
	TestID->"11-MFDefine.nb"
]

VerificationTest[
	MFDefine[][{funWithMultiListArg[___List]}]; 
	MFString[funWithMultiListArg[{a, b}, {c, d}]]
	,
	"\\funWithMultiListArg{\n\ta,\n\tb\n}{\n\tc,\n\td\n}"
	,
	TestID->"12-MFDefine.nb"
]

VerificationTest[
	ClearAll["`*"]
	,
	Null
	,
	TestID->"13-MFDefine.nb"
]

VerificationTest[
	MFDefine["\\left{", "\\right}"][{fun[_]}]; 
	MFString[fun[a]]
	,
	"\\fun\\left{a\\right}"
	,
	TestID->"14-MFDefine.nb"
]

VerificationTest[
	MFDefine["\\left{", "\\right}"][{funWithMultiArg[___]}]; 
	MFString[funWithMultiArg[a, b]]
	,
	"\\funWithMultiArg\\left{a\\right}\\left{b\\right}"
	,
	TestID->"15-MFDefine.nb"
]

VerificationTest[
	MFDefine["{", "}", ";"][{funWithListArg[_List]}]; 
	MFString[funWithListArg[{a, b}]]
	,
	"\\funWithListArg{a;b}"
	,
	TestID->"16-MFDefine.nb"
]

VerificationTest[
	MFDefine["{", "}", ";"][{funWithMultiListArg[___List]}]; 
	MFString[funWithMultiListArg[{a, b}, {c, d}]]
	,
	"\\funWithMultiListArg{a;b}{c;d}"
	,
	TestID->"17-MFDefine.nb"
]

VerificationTest[
	ClearAll["`*"]
	,
	Null
	,
	TestID->"18-MFDefine.nb"
]

VerificationTest[
	MFDefine[][{fun[_], funWithMultiArg[___], funWithListArg[_List], funWithMultiListArg[___List]}]
	,
	Null
	,
	TestID->"19-MFDefine.nb"
]

VerificationTest[
	MFString[funWithListArg[{fun[a], fun[b]}]]
	,
	"\\funWithListArg{\n\t\\fun{a},\n\t\\fun{b}\n}"
	,
	TestID->"20-MFDefine.nb"
]

VerificationTest[
	MFString[funWithMultiListArg[{fun[a], fun[b]}, {funWithMultiArg[c, d]}]]
	,
	"\\funWithMultiListArg{\n\t\\fun{a},\n\t\\fun{b}\n}{\n\t\\funWithMultiArg{c}{d}\n}"
	,
	TestID->"21-MFDefine.nb"
]

VerificationTest[
	ClearAll["`*"]
	,
	Null
	,
	TestID->"22-MFDefine.nb"
]

VerificationTest[
	MFDefine[][{fun[_] -> "f", funWithMultiArg[___] -> "g", funWithListArg[_List] -> "h", funWithMultiListArg[___List] -> "k"}]
	,
	Null
	,
	TestID->"23-MFDefine.nb"
]

VerificationTest[
	MFString[funWithListArg[{fun[a], fun[b]}]]
	,
	"\\h{\n\t\\f{a},\n\t\\f{b}\n}"
	,
	TestID->"24-MFDefine.nb"
]

VerificationTest[
	MFString[funWithMultiListArg[{fun[a], fun[b]}, {funWithMultiArg[c, d]}]]
	,
	"\\k{\n\t\\f{a},\n\t\\f{b}\n}{\n\t\\g{c}{d}\n}"
	,
	TestID->"25-MFDefine.nb"
]

VerificationTest[
	ClearAll[g]; 
	ToExpression["Format[g[x_]]:=Subscript[g,x];"]
	,
	Null
	,
	TestID->"26-MFDefine.nb"
]

VerificationTest[
	MFDefine[][{g[_List]}]
	,
	Null
	,
	{Yurie`MathForm`MFDefine::clearformat}
	,
	TestID->"27-MFDefine.nb"
]

VerificationTest[
	MFDefine[][{g[b]}]
	,
	Null
	,
	{Yurie`MathForm`MFDefine::notsupported}
	,
	TestID->"28-MFDefine.nb"
]

VerificationTest[
	MFString[g[{a, b}]]
	,
	"g{\n\ta,\n\tb\n}"
	,
	TestID->"29-MFDefine.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-MFDefine.nb"
]