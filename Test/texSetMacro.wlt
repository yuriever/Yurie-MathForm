

(*texSetMacro.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-texSetMacro.nb"
]

VerificationTest[
	Get["Yurie`MathForm`"]
	,
	Null
	,
	TestID->"1-texSetMacro.nb"
]

VerificationTest[
	texSetMacro[][head]; 
	texForm[head]
	,
	"\\head"
	,
	TestID->"2-texSetMacro.nb"
]

VerificationTest[
	texSetMacro[][fun[_]]; 
	texForm[fun[a]]
	,
	"\\fun{a}"
	,
	TestID->"3-texSetMacro.nb"
]

VerificationTest[
	texSetMacro[][funWithMultiArg[___]]; 
	texForm[funWithMultiArg[a, b]]
	,
	"\\funWithMultiArg{a}{b}"
	,
	TestID->"4-texSetMacro.nb"
]

VerificationTest[
	texSetMacro[][funWithListArg[_List]]; 
	texForm[funWithListArg[{a, b}]]
	,
	"\\funWithListArg{\n\ta,\n\tb\n}"
	,
	TestID->"5-texSetMacro.nb"
]

VerificationTest[
	texSetMacro[][funWithMultiListArg[___List]]; 
	texForm[funWithMultiListArg[{a, b}, {c, d}]]
	,
	"\\funWithMultiListArg{\n\ta,\n\tb\n}{\n\tc,\n\td\n}"
	,
	TestID->"6-texSetMacro.nb"
]

VerificationTest[
	texSetMacro["\\left{", "\\right}"][fun[_]]; 
	texForm[fun[a]]
	,
	"\\fun\\left{a\\right}"
	,
	TestID->"7-texSetMacro.nb"
]

VerificationTest[
	texSetMacro["\\left{", "\\right}"][funWithMultiArg[___]]; 
	texForm[funWithMultiArg[a, b]]
	,
	"\\funWithMultiArg\\left{a\\right}\\left{b\\right}"
	,
	TestID->"8-texSetMacro.nb"
]

VerificationTest[
	texSetMacro["{", "}", ";"][funWithListArg[_List]]; 
	texForm[funWithListArg[{a, b}]]
	,
	"\\funWithListArg{a;b}"
	,
	TestID->"9-texSetMacro.nb"
]

VerificationTest[
	texSetMacro["{", "}", ";"][funWithMultiListArg[___List]]; 
	texForm[funWithMultiListArg[{a, b}, {c, d}]]
	,
	"\\funWithMultiListArg{a;b}{c;d}"
	,
	TestID->"10-texSetMacro.nb"
]

VerificationTest[
	texSetMacro[][fun[_]]; 
	texSetMacro[][funWithMultiArg[___]]; 
	texSetMacro[][funWithListArg[_List]]; 
	texSetMacro[][funWithMultiListArg[___List]]
	,
	Null
	,
	TestID->"11-texSetMacro.nb"
]

VerificationTest[
	texForm[funWithListArg[{fun[a], fun[b]}]]
	,
	"\\funWithListArg{\n\t\\fun{a},\n\t\\fun{b}\n}"
	,
	TestID->"12-texSetMacro.nb"
]

VerificationTest[
	texForm[funWithMultiListArg[{fun[a], fun[b]}, {funWithMultiArg[c, d]}]]
	,
	"\\funWithMultiListArg{\n\t\\fun{a},\n\t\\fun{b}\n}{\n\t\\funWithMultiArg{c}{d}\n}"
	,
	TestID->"13-texSetMacro.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-texSetMacro.nb"
]