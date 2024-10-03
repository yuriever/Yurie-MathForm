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

* `#!wl texForm` - postprocess the string from TeXForm by the rules in $texAssoc.

* `#!wl texSetMacro` - set the symbol as a LaTeX macro and store the rule into $texAssoc.


<!-- TeXShow.wl -->

* `#!wl texShow` - texForm + MaTeX.

* `#!wl texCopy` - texForm + CopyToClipboard.

* `#!wl texCS` - texForm + CopyToClipboard + MaTeX.