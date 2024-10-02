(* Label.wl *)

labelJoin::usage =
	"join the variable and label into a symbol.";

labelSplit::usage =
	"split the symbol into a labeled variable.";

labelShiftToZero::usage =
	"x1->0.";

labelShiftToEqual::usage =
	"x1->x2.";

labelShiftToDiff::usage =
	"x1->x12+x2.";

labelShiftToDiffZero::usage =
	"x1->x12,x2->0.";

labelShiftToDiffBack::usage =
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