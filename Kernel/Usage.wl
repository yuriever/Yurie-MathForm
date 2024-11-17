(* Format.wl *)

interpretize::usage =
	"make format definitions interpretable.";


(* Index.wl *)

indexize::usage =
	"join the variable and index into a symbol.";

indexJoin::usage =
	"join indexed variables into symbols in the expression.";

indexSplit::usage =
	"split symbols into indexed variables in the expression.";

indexToZero::usage =
	"x1->0.";

indexToEqual::usage =
	"x1->x2.";

indexToDiff::usage =
	"x1->x12+x2.";

indexToDiffZero::usage =
	"x1->x12,x2->0.";

indexToDiffBack::usage =
	"x12->x1-x2.";


(* MFDefine.wl *)

MFDefine::usage =
	"define LaTeX macro for the symbol and store the rule into $MFAssoc.";


(* MF.wl *)

MFString::usage =
	"refine the string from TeXForm.";

MFCopy::usage =
	"copy the string from MFString and return the original expression.";

MF::usage =
	"show the LaTeX of the expression.";