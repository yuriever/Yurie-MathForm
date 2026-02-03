(* ::Package:: *)

(* ::Subsection:: *)
(*Usage*)


(* ::Subsubsection:: *)
(*MFArgConvert.wl*)


MFArgConvert::usage =
    StringJoin["MFArgConvert[left, right, sep][f->\"f\", ...]: define LaTeX macro for the symbol.", "\n", "f[x] \[LongRightArrow] \\f{x} \[LongRightArrow] {, }", "\n", "f[x, y, ...] \[LongRightArrow] \\f{x}{y}... \[LongRightArrow] {, }", "\n", "f[{x, y, ...}] \[LongRightArrow] \\f{x, y, ...} \[LongRightArrow] {\\n\\t, \\n}, \\n\\t", "\n", "f[{x, ...}, {y, ...}, ...] \[LongRightArrow] \\f{x, ...}{y, ...}... \[LongRightArrow] {\\n\\t, \\n}, \\n\\t"];


(* ::Subsubsection:: *)
(*MFClear.wl*)


MFClear::usage =
    "clear format values and rules in $MFAssoc of the symbol, or all symbols under the context.";


(* ::Subsubsection:: *)
(*MFMakeBox.wl*)


MFMakeBox::usage =
    StringJoin["MFMakeBox[{pattern, format}..., opts]: automatically inject interpretation (and tooltip) into format value.", "\n", "Value[\"Tooltip\"]: None, Automatic, Full, _."];


(* ::Subsubsection:: *)
(*MFString.wl*)


MFString::usage =
    "refine the string from TeXForm.";


(* ::Subsubsection:: *)
(*MF.wl*)


MF::usage =
    "show the LaTeX of the expression.";