<!-- Label.wl -->

* `#!wl labelJoin` - {x,1}->x1.

* `#!wl labelSplit` - x1->f[x,1].

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