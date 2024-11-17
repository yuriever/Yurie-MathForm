<!-- Format.wl -->

* `#!wl interpretize` - make format definitions interpretable.


<!-- Index.wl -->

* `#!wl indexize` - join the variable and index into a symbol.

* `#!wl indexJoin` - join indexed variables into symbols in the expression.

* `#!wl indexSplit` - split symbols into indexed variables in the expression.

* `#!wl indexToZero` - x1->0.

* `#!wl indexToEqual` - x1->x2.

* `#!wl indexToDiff` - x1->x12+x2.

* `#!wl indexToDiffZero` - x1->x12,x2->0.

* `#!wl indexToDiffBack` - x12->x1-x2.


<!-- MFDefine.wl -->

* `#!wl MFDefine` - define LaTeX macro for the symbol and store the rule into $MFAssoc.


<!-- MF.wl -->

* `#!wl MFString` - refine the string from TeXForm.

* `#!wl MFStringCopy` - copy the string from MFString and return the expression.

* `#!wl MF` - show the LaTeX of the expression.