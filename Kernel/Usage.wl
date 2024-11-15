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


(* TeXConvert.wl *)

texSetMacro::usage =
	"set the symbol as LaTeX macro and store the rule into $texAssoc.";


(* TeXShow.wl *)

texForm::usage =
	"refine the string from TeXForm.";

texCopy::usage =
	"copy the string from texForm and return the expression.";

texShow::usage =
	"show the LaTeX of the expression.";