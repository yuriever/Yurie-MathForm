(* TeXConvert.wl *)

texSetMacro::usage =
	"set the symbol as a LaTeX macro and store the rule into $texAssoc.";


(* TeXShow_Old.wl *)

texShow::usage =
	"texForm + MaTeX.";

texCopy::usage =
	"texForm + CopyToClipboard.";

texCS::usage =
	"texForm + CopyToClipboard + MaTeX.";


(* TeXShow.wl *)

texForm::usage =
	"refine the string from TeXForm.";

texCopy::usage =
	"copy the string from texForm and return the expression.";

texShow::usage =
	"show the LaTeX of the expression.";