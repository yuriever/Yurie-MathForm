(* ::Package:: *)

PacletObject[
  <|
    "Name" -> "Yurie/MathForm",
    "Description" -> "A Mathematica paclet for improving math layout",
    "Creator" -> "Yurie",
    "SourceControlURL" -> "https://github.com/yuriever/Yurie-MathForm",
    "License" -> "MIT",
    "PublisherID" -> "Yurie",
    "Version" -> "5.2",
    "WolframVersion" -> "14.2+",
    "PrimaryContext" -> "Yurie`MathForm`",
    "Extensions" -> {
      {
        "Kernel",
        "Root" -> "Kernel",
        "Context" -> {
          "Yurie`MathForm`"
        }
      },
      {
        "Kernel",
        "Root" -> "Utility",
        "Context" -> {
          "Yurie`MathForm`Info`",
          "Yurie`MathForm`Library`"
        }
      },
      {
        "AutoCompletionData",
        "Root" -> "AutoCompletionData"
      },
      {
        "Asset",
        "Root" -> ".",
        "Assets" -> {
          {"License", "LICENSE"},
          {"ReadMe", "README.md"},
          {"Library", "Library"},
          {"Source", "Source"},
          {"Test", "Test"},
          {"TestSource", "TestSource"}
        }
      }
    }
  |>
]
