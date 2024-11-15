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


<!-- TeXConvert.wl -->

* `#!wl texSetMacro` - set the symbol as LaTeX macro and store the rule into $texAssoc.


<!-- TeXShow.wl -->

* `#!wl texForm` - refine the string from TeXForm.

* `#!wl texCopy` - copy the string from texForm and return the expression.

* `#!wl texShow` - show the LaTeX of the expression.