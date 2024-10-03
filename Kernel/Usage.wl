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

texForm::usage =
	"postprocess the string from TeXForm by the rules in $texAssoc.";

texSetMacro::usage =
	"set the symbol as a LaTeX macro and store the rule into $texAssoc.";


(* TeXShow.wl *)

texShow::usage =
	"texForm + MaTeX.";

texCopy::usage =
	"texForm + CopyToClipboard.";

texCS::usage =
	"texForm + CopyToClipboard + MaTeX.";