# The OpenMath Content Dictionaries

This repository contains the [OpenMath](http://openmath.org) content dictionaries

* `cd` and `cdgroups`  contain the actual content dictionaries,
* `sts` contains the small type system type annotations
* `build.xml` allows to run the html generation for [the OpenMath Web Site](http://www.openmath.org/cd), the other `*.xml` will probably be moved to the web site repository.
* `lib` contains resources for the build

To build the web site just run `ant` in the top dir, the web site is generated into the directory `target`.
