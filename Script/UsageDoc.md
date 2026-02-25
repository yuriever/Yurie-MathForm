# Usage Documentation Guidelines

This document establishes comprehensive guidelines for writing clear and consistent `Usage` messages for functions in Mathematica paclets.

## Example

```wl
fun::usage =
    "fun[argument]: compute the function value with the given argument."<>
    "\n"<>
    "Hint: may produce unexpected results in edge cases."<>
    "\n"<>
    "Example: fun[{1, 2}] -> {2, 4}."<>
    "\n"<>
    "Default[argument]: {}.";
```

## Doc Rules

All `Usage` messages must adhere to the following rules:

* **Declaration**: Begin with `functionName::usage =` on the first line.

* **Indentation**: Indent all message content with four spaces starting from the second line.

* **String format**: Write each content line as a quoted string `"..."` containing one of the supported field types (detailed below).

* **Multi-line syntax**: For messages spanning multiple lines:
    * End each line except the last with `<>`
    * Connect lines using `"\n"<>`
    * Terminate the final line with `;`

* **Punctuation**: End all field content after the colon with periods.

* **Field order**: Fields may be listed in any order based on logical flow.

* **Optional fields**: All fields are optional, though including the function signature is strongly recommended for clarity.

* **Preservation rule**: When updating existing usage messages, do not add new field types that were not previously included.

    * **This rule must be respected when updating usage!**

## Supported Field Types

The following field types are available for documenting function behavior:

* **`signature: description`** — Function signature paired with a description of typical usage patterns and behavior.

* **`Info[argument]: description`** — Brief description of a specific function argument.

* **`Value[argument]: values`** — Enumeration of allowed values for a specific function argument.

* **`Default[argument]: value`** — Default value assigned to a function argument.

* **`Sketch: definition`** — Brief function definition (e.g., `fun1 + fun2` where `fun1` and `fun2` are other functions).

* **`Hint: explanation`** — Additional guidance, warnings, or best practices for function usage.

* **`Example: demonstration`** — Brief code example showing typical usage with expected output.
