# Yurie/MathForm

A Mathematica paclet for improving LaTeX conversion.

## Documentation

<https://yuriever.github.io/symbolic/Yurie__MathForm/doc/>

## Install

Install from this repository:

1. download the built paclet `build/*.paclet`;

2. install the paclet:

    ``` wl
    PacletInstall@File["the/path/of/paclet"]
    ```

Install manually:

1. download this repository, and move it to the paclet directory `$UserBasePacletsDirectory`;

2. rebuild the internal paclet data:

    ``` wl
    PacletDataRebuild[]
    ```

## Load

``` wl
Needs["Yurie`MathForm`"]
```

## Upgrade

``` wl
PacletInstall["Yurie/MathForm"]
```

## Uninstall

``` wl
PacletUninstall["Yurie/MathForm"]
```
