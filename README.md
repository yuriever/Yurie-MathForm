# [Yurie/MathForm](https://github.com/yuriever/Yurie-MathForm)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Wolfram Language](https://img.shields.io/badge/Wolfram%20Language-14.3%2B-red.svg)](https://www.wolfram.com/language/)

A Mathematica paclet for improving math layout.

* The LaTeX template file `Source/template` is from [MaTeX](http://szhorvat.net/mathematica/MaTeX).

* The exported LaTeX strings will be formatted by [tex-fmt](https://github.com/WGUNDERWOOD/tex-fmt).


## [Documentation](https://yuriever.github.io/symbolic/Yurie-MathForm/doc/)


## Usage

1. Clone or download this repository

2. Move the entire folder to the user paclet directory:

   ```wl
   $UserBasePacletsDirectory
   ```

3. Rebuild the paclet data:

   ```wl
   PacletDataRebuild[]
   ```

4. Load the paclet

    ```wl
    Needs["Yurie`MathForm`"]
    ```


### Uninstallation

```wl
PacletUninstall["Yurie/MathForm"]
```


### Installation checking

```wl
PacletFind["Yurie/MathForm"]
```