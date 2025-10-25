(* ::Package:: *)

(* ::Subsection:: *)
(*Usage*)


(* ::Subsubsection:: *)
(*MFArgConvert.wl*)


MFArgConvert::usage =
    "define LaTeX macro for the symbol and store the rule into $MFAssoc.";


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