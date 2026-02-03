# Usage

## MFArgConvert.wl

* `#!wl MFArgConvert` - MFArgConvert[left, right, sep][f->"f", ...]: define LaTeX macro for the symbol.

    * f[x] ⟶ \f{x} ⟶ {, }

    * f[x, y, ...] ⟶ \f{x}{y}... ⟶ {, }

    * f[{x, y, ...}] ⟶ \f{x, y, ...} ⟶ {\n\t, \n}, \n\t

    * f[{x, ...}, {y, ...}, ...] ⟶ \f{x, ...}{y, ...}... ⟶ {\n\t, \n}, \n\t

## MFClear.wl

* `#!wl MFClear` - clear format values and rules in $MFAssoc of the symbol, or all symbols under the context.

## MFMakeBox.wl

* `#!wl MFMakeBox` - MFMakeBox[{pattern, format}..., opts]: automatically inject interpretation (and tooltip) into format value.

    * Value["Tooltip"]: None, Automatic, Full, \_.

## MFString.wl

* `#!wl MFString` - refine the string from TeXForm.

## MF.wl

* `#!wl MF` - show the LaTeX of the expression.