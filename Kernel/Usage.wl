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


(* MFArgConvert.wl *)

MFArgConvert::usage =
	"define LaTeX macro for the symbol and store the rule into $MFAssoc.";


(* MFClear.wl *)

MFClear::usage =
	"clear format values and rules in $MFAssoc of the symbol, or all symbols under the context.";


(* MFInterpret.wl *)

MFInterpret::usage =
	"set interpretable format values.";


(* MF.wl *)

MFString::usage =
	"refine the string from TeXForm.";

MFCopy::usage =
	"copy the string from MFString and return the original expression.";

MF::usage =
	"show the LaTeX of the expression.";