<!-- Index.wl -->

* `#!wl indexize` - join the variable and index into a symbol.

* `#!wl indexJoin` - join indexed variables into symbols in the expression.

* `#!wl indexSplit` - split symbols into indexed variables in the expression.

* `#!wl indexToZero` - x1->0.

* `#!wl indexToEqual` - x1->x2.

* `#!wl indexToDiff` - x1->x12+x2.

* `#!wl indexToDiffZero` - x1->x12,x2->0.

* `#!wl indexToDiffBack` - x12->x1-x2.


<!-- MFArgConvert.wl -->

* `#!wl MFArgConvert` - define LaTeX macro for the symbol and store the rule into $MFAssoc.


<!-- MFClear.wl -->

* `#!wl MFClear` - clear format values and rules in $MFAssoc of the symbol, or all symbols under the context.


<!-- MFInterpret.wl -->

* `#!wl MFInterpret` - set interpretable format values.


<!-- MFString.wl -->

* `#!wl MFString` - refine the string from TeXForm.

* `#!wl MFCopy` - copy the string from MFString and return the original expression.


<!-- MF.wl -->

* `#!wl MF` - show the LaTeX of the expression.