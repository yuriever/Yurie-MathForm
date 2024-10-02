<!-- Label.wl -->

* `#!wl labelJoin` - join the variable and label into a symbol.

* `#!wl labelSplit` - split the symbol into a labeled variable.

* `#!wl labelShiftToZero` - x1->0.

* `#!wl labelShiftToEqual` - x1->x2.

* `#!wl labelShiftToDiff` - x1->x12+x2.

* `#!wl labelShiftToDiffZero` - x1->x12,x2->0.

* `#!wl labelShiftToDiffBack` - x12->x1-x2.


<!-- TeXConvert.wl -->

* `#!wl texForm` - postprocess the string from TeXForm by the rules in $texAssoc.

* `#!wl texSetMacro` - set the symbol as a LaTeX macro and store the rule into $texAssoc.


<!-- TeXShow.wl -->

* `#!wl texShow` - texForm + MaTeX.

* `#!wl texCopy` - texForm + CopyToClipboard.

* `#!wl texCS` - texForm + CopyToClipboard + MaTeX.