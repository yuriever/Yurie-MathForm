(* ::Package:: *)

PacletObject[
  <|
    "Name" -> "Yurie/MathForm",
    "Description" -> "A Mathematica paclet for improving LaTeX conversion",
    "Creator" -> "Yurie",
    "SourceControlURL" -> "https://github.com/yuriever/Yurie-MathForm",
    "License" -> "MIT",
    "PublisherID" -> "Yurie",
    "Version" -> "2.0.0",
    "WolframVersion" -> "14.1+",
    "PrimaryContext" -> "Yurie`MathForm`",
    "Dependencies" -> {
      "MaTeX" -> ">=1.7.9"
    },
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
          "Yurie`MathForm`Info`"
        }
      },
      {
        "Asset",
        "Root" -> ".",
        "Assets" -> {
          {"License", "LICENSE"},
          {"ReadMe", "README.md"},
          {"Source", "Source"},
          {"Test", "Test"},
          {"TestSource", "TestSource"}
        }
      }
    }
  |>
]
