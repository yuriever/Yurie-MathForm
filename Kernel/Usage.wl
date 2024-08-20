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