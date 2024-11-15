(* ::Package:: *)

PacletObject[
  <|
    "Name" -> "Yurie/MathForm",
    "Description" -> "A Mathematica paclet for improving math layout",
    "Creator" -> "Yurie",
    "SourceControlURL" -> "https://github.com/yuriever/Yurie-MathForm",
    "License" -> "MIT",
    "PublisherID" -> "Yurie",
    "Version" -> "3.0.0",
    "WolframVersion" -> "14.1+",
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
