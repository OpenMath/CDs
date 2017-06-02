# The OpenMath Content Dictionaries

This repository contains the [OpenMath](http://openmath.org) content dictionaries

* `cd` contains the actual content dictionaries, there are two kinds official and experimental ones. 
* `cdgroups` contains the CD groups specifications. 
* `sts` contains the small type system (STS) libraries.
* `contrib` contains the contributed CDs and and STS libraries. 
* `build.xml` allows to run the html generation for [the OpenMath Web Site](http://www.openmath.org/cd), the other `*.xml` will probably be moved to the web site repository.
* `lib` contains resources for the build

To build the web site just run `make install` in the top dir, assuming that the
[OpenMath.github.io](https://github.com/OpenMath/OpenMath.github.io) repository is cloned
as a sibling to the [CDs](https://github.com/OpenMath/CDs) repository. It only needs to be
committed there. This wil probably be automated with travis in the near future.

# Contributing Content Dictionaries

The [OpenMath Society](society) is actively soliciting CD submissions in all fields of mathematics. To submit a CD make a pull request:

1. [Fork this repository](https://github.com/OpenMath/CDs/compare#fork-destination-box)
1. develop your CDs in the fork (i.e. a file with name `*.ocd` in the `cd/contrib` directory)
1. make a pull request on your fork (via the "new pull request" button under the magenta line and on this page via the green "create pull request" button. 
1. add the following information in the comment
  * 'authors': who is responsible (other than the person submitting the pull request) 
  * 'purpose': why do we need these CDs
  * 'description': in a nutshell, what is in the new CDs

# Commenting on Content Dictionaries

We use the [GitHub issue system](issues) to discuss and plan changes to the CDs. 

# Admin: publishing CDs on the OpenMath Web Site

The new CDs state can be published on the OpenMath Web site in a manual process
(automation via travis pending): Assuming that the
[OpenMath.github.io](http:://github.com/OpenMath/OpenMath.github.io) repository and the
[CDs](http:://github.com/OpenMath/CDs) repositories are cloned as siblings on file system,
a `make install` in the `CDs` repository followed by a `git push` in the
`OpenMath.github.io` repository suffices. 

# Version History

This repository contains a fresh copy of the current CDs. The development history of the
OpenMath CDs has been retained as part of the repository https://github.com/OpenMath/OMSVN
(warning there are copies of the CDs in various places).
<!--  LocalWords:  sts ocd contrib
 -->
